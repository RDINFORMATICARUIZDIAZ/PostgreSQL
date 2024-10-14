CREATE OR REPLACE PROCEDURE crear_factura(numfactura varchar(20), codcliente integer) AS $$
declare 
	m_bruto money;
	m_descuento money;
	m_impuesto money;
	m_neto money;
	codfactura integer;
	cur_carrito CURSOR FOR SELECT * FROM carrito where idconexion = pg_backend_pid();
	prod carrito%ROWTYPE;

begin
	if (select count(*)
			from carrito c
			where c.idconexion = pg_backend_pid()) = 0 then

			RAISE EXCEPTION 'Carrito de compra vacío';

	end if;
	
	select	sum(c.precionormal), sum(c.descuento), sum(c.impuesto), sum(c.precioaplicado)
			into m_bruto, m_descuento, m_impuesto, m_neto
		from	carrito c
		where	c.idconexion = pg_backend_pid();
	
	insert into factura
		(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
		values
		(numfactura, m_bruto, m_descuento, m_impuesto, m_neto, now(), false, codcliente);
	
	select currval('factura_idfactura_seq') into codfactura;

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

	update cliente set
		numerocompras = numerocompras + 1,
		montocompras = montocompras + m_neto,
		ultimacompra = now(),
		ultimamodificacion = now()
	where idcliente = codcliente;

	for prod in cur_carrito loop  
	    update producto set
			inventario = inventario - prod.cantidad,
			unidadesvendidas = unidadesvendidas + prod.cantidad,
			montovendido = montovendido + prod.precionormal-prod.descuento,
			ultimaventa = now(),
			ultimamodificacion = now()
		where idproducto = prod.idproducto;
    end loop;	
	
	exception
		when UNIQUE_VIOLATION then
			rollback;
			RAISE NOTICE 'Error: el número de factura indicado ya ha sido usado';
		when FOREIGN_KEY_VIOLATION then
			rollback;
			RAISE NOTICE 'Error: el cliente indicado no existe';
		when others then
			rollback;
			RAISE NOTICE 'Error: Carrito de compra vacío';
end;
$$ LANGUAGE plpgsql;