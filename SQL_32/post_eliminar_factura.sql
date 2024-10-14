CREATE OR REPLACE FUNCTION post_delete_lineafactura() RETURNS trigger AS
$$
declare
	fact_anulada boolean;
	fec_ult_venta timestamp;

begin
	-- Se verifica que la factura no se encuentre anulada
	select f.anulada into fact_anulada
		from	factura f
		where	f.idfactura = old.idfactura;
	
	if not(fact_anulada) then
		-- Se busca la fecha de la última venta del producto
		select		max(f.fechaventa) into fec_ult_venta
			from factura f
			inner join lineafactura l on f.idfactura = l.idfactura
			where	f.idfactura <> old.idfactura
			and 	l.idproducto = old.idproducto
			and 	f.anulada = false;
		
		IF NOT FOUND THEN
	    	fec_ult_venta := null;
	  	END IF;
		
	    update producto set
			inventario = inventario + old.cantidad,
			unidadesvendidas = unidadesvendidas - old.cantidad,
			montovendido = montovendido - (old.precionormal-old.descuento),
			ultimaventa = fec_ult_venta,
			ultimamodificacion = now()
		where idproducto = old.idproducto;

	else
		RAISE NOTICE 'La factura está anulada, no es necesario actualizar las estadísticas';
	end if;
	   
   RAISE NOTICE 'La línea de factura ha sido eliminada correctamente';
   return old;
	  
	exception
		when others then
			RAISE NOTICE 'No se pudieron actualizar las estadísticas del cliente';
			RETURN null;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER post_delete_lineafactura
	BEFORE delete
	ON lineafactura
	FOR EACH ROW
	EXECUTE PROCEDURE post_delete_lineafactura();


CREATE OR REPLACE FUNCTION post_delete_factura() RETURNS trigger AS
$$
declare
	fec_ult_compra timestamp;

begin
	
	if (old.anulada <> true) then
		-- Se recupera la fecha de la última factura anterior
		select	max(f.fechaventa) into fec_ult_compra
			from	factura f
			where 	f.idfactura  <> old.idfactura
			and 	f.anulada = false
			and		f.idcliente = old.idcliente;
		
		IF NOT FOUND THEN
			fec_ult_compra := null;
		END IF;
		
		-- Se actualiza la información del cliente
		update cliente set
			numerocompras = numerocompras - 1,
			montocompras = montocompras - old.montoneto,
			ultimacompra = fec_ult_compra,
			ultimamodificacion = now()
		where idcliente  = old.idcliente;

	else
		RAISE NOTICE 'La factura está anulada, no es necesario actualizar las estadísticas';
	end if;

	RAISE NOTICE 'La factura se ha eliminado correctamente';
	return old;
   
	exception
		when others then
			RAISE NOTICE 'No se pudieron actualizar las estadísticas';
			RETURN null;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER post_delete_factura
	BEFORE delete 
	ON factura
	FOR EACH ROW
	EXECUTE PROCEDURE post_delete_factura();