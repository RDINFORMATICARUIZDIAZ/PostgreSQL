CREATE OR REPLACE FUNCTION post_anular_factura() RETURNS trigger AS
$$
declare
	fec_ult_compra timestamp;
	cur_lineafactura CURSOR FOR SELECT * FROM lineafactura where idfactura  = new.idfactura;
	linea lineafactura%ROWTYPE;
	fec_ult_venta timestamp;
begin
	-- Si se trata de una anulación de factura
	IF ((old.anulada = false) and (new.anulada = true)) then
		-- Se recupera la fecha de la última factura del mismo cliente
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
		
		-- Se actualizan los productos incluidos en la factura
		for linea in cur_lineafactura loop
			select		max(f.fechaventa) into fec_ult_venta
				from factura f
				inner join lineafactura l on f.idfactura = l.idfactura
				where	f.idfactura <> old.idfactura
				and 	l.idproducto = linea.idproducto
				and 	f.anulada = false;
			
			IF NOT FOUND THEN
		    	fec_ult_venta := null;
		  	END IF;
		  
		  	if fec_ult_venta is null then
				RAISE NOTICE 'La fecha de la última fecha es nula';
			else 
				RAISE NOTICE 'IDfactura %', old.idfactura;
			end if;
		
		    update producto set
				inventario = inventario + linea.cantidad,
				unidadesvendidas = unidadesvendidas - linea.cantidad,
				montovendido = montovendido - (linea.precionormal-linea.descuento),
				ultimaventa = fec_ult_venta,
				ultimamodificacion = now()
			where idproducto = linea.idproducto;
	    end loop;
	   
	   RAISE NOTICE 'La factura se ha anulado correctamente';
	  
	   return new;
	  
	else
		if ((old.anulada = true) and (new.anulada = false)) then
			RAISE NOTICE 'La anulación es un proceso irreversible. Operación cancelada.';
			return null;
		else
			RAISE NOTICE 'Se trata de una modificación de datos de factura';
			return new;
		end if;
	
	end if;

	exception
		when others then
			RAISE NOTICE 'No se pudieron actualizar las estadísticas';
			RETURN NULL;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER post_anular_factura
	BEFORE update 
	ON factura
	FOR EACH ROW
	EXECUTE PROCEDURE post_anular_factura();
	

call vaciar_carrito();

call agregar_producto(16, 2);

call crear_factura('F000019', 35);

update factura set
	anulada = true
where idfactura = 37;