CREATE OR REPLACE PROCEDURE crear_factura_JSON(numfactura varchar(20), codcliente integer, productos jsonb) AS $$
declare
	fila				record;
	existencia			integer;
	prodsininventario	integer;
	m_bruto 			money;
	m_descuento 		money;
	m_impuesto 			money;
	m_neto				money;
	codfactura			integer;

begin
	
	-- Vaciamos el carrito
	delete
			from 	carrito
			where	idconexion =pg_backend_pid();
	
	for fila in (
		select idproducto, cantidad
			from	jsonb_to_recordset(productos) as producto(idproducto int, cantidad int)
	)
	loop
		RAISE NOTICE 'Procesando producto: %', fila.idproducto;
	
		-- Se verifica la existencia del producto
		if (select count(*)
				from producto p
				where p.idproducto = fila.idproducto) = 0 then
			raise exception NO_DATA_FOUND;
		end if;
	
		-- Se valida que haya suficiente cantidad en el inventario
		select p.inventario into existencia
			from producto p
			where p.idproducto = fila.idproducto;
		
		if (existencia < fila.cantidad) then
			prodsininventario := fila.idproducto;
			raise exception 'ERR001';
		end if; 
	
		-- Insertamos el producto en el carrito
		insert into carrito
			(idconexion, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
			select	pg_backend_pid(),
					fila.idproducto,
					fila.cantidad,
					p.precioventa * fila.cantidad,
					((p.descuento / 100) * p.precioventa) * fila.cantidad,
					((p.tasaimpuesto / 100) * (1 - p.descuento / 100 ) * p.precioventa) * fila.cantidad,
					p.tasaimpuesto,
					((1  + p.tasaimpuesto / 100) * (1 - p.descuento / 100 ) * p.precioventa) * fila.cantidad
					from producto p
					where p.idproducto = fila.idproducto;
		
		RAISE NOTICE 'Se va a actualizar las estadísticas del producto: %', fila.idproducto;
	
		-- Se actualiza el inventario y las estadísticas del producto
		update producto set
			inventario = inventario - fila.cantidad,
			unidadesvendidas = unidadesvendidas + fila.cantidad,
			montovendido = montovendido + (precioventa * (1 - descuento) * fila.cantidad),
			ultimaventa = now(),
			ultimamodificacion = now()
		where idproducto = fila.idproducto;
	
	RAISE NOTICE 'Se ha actualizado las estadísticas del producto: %', fila.idproducto;

	end loop;

	-- Se valida que haya productos en el carrito
	if (select count(*)
		from carrito c
		where c.idconexion = pg_backend_pid()) = 0 then
		
		RAISE EXCEPTION 'ERR002';
	end if;

	-- Se totaliza el contenido del carrito
	select	sum(c.precionormal), sum(c.descuento), sum(c.impuesto), sum(c.precioaplicado)
			into m_bruto, m_descuento, m_impuesto, m_neto
		from	carrito c
		where	c.idconexion = pg_backend_pid();
	
	RAISE NOTICE 'Se va a crear una nueva factura con m_bruto: %, m_descuento: %, m_impuesto: %, m_neto: %', m_bruto, m_descuento, m_impuesto, m_neto;
	
	-- Insertamos la factura
	insert into factura 
		(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
		values
		(numfactura, m_bruto, m_descuento, m_impuesto, m_neto, now(), false, codcliente);
	
	select currval('factura_idfactura_seq') into codfactura;
	
	RAISE NOTICE 'Se insertó la factura : %', codfactura;

	-- Almacenamos el detalle de la factura
	insert into lineafactura
		(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
		select	codfactura,
				c.idproducto,
				c.cantidad,
				c.precionormal,
				c.descuento,
				c.impuesto,
				c.tasaimpuesto,
				c.precioaplicado
			from	carrito c
			where	c.idconexion = pg_backend_pid();

	-- Se actualizan las estadísticas del cliente
	update cliente set
		numerocompras = numerocompras + 1,
		montocompras = montocompras + m_neto,
		ultimacompra = now(),
		ultimamodificacion = now()
	where idcliente = codcliente;		

	exception
		when NO_DATA_FOUND then
			rollback;
			RAISE NOTICE 'Error: el producto no existe';
		when UNIQUE_VIOLATION then
			rollback;
			RAISE NOTICE 'Error: el n�mero de factura indicado ya ha sido usado';
		when FOREIGN_KEY_VIOLATION then
			rollback;
			RAISE NOTICE 'Error: el cliente indicado no existe';
		when others then
			rollback;
			if (SQLERRM = 'ERR001') then
				RAISE NOTICE 'Error: No hay suficientes existencias para el producto %', prodsininventario;
			elseif (SQLERRM = 'ERR002') then
				RAISE NOTICE 'Error: Carrito de compra vacío';		
			else
				RAISE NOTICE 'Se ha producido un error inesperado';
			end if;

end;
$$ LANGUAGE plpgsql;
