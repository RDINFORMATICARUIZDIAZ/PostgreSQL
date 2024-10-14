CREATE OR REPLACE PROCEDURE agregar_producto (codproducto integer, cant integer) as $$
declare 
	transito integer;
	existencia integer;
	yaencarro integer;
	total integer;

begin
	
	if (select count(*)
			from producto p
			where p.idproducto = codproducto) = 0 then
		RAISE EXCEPTION NO_DATA_FOUND USING MESSAGE = 'Error: el producto no existe';
	end if;

	select p.inventario into existencia
		from producto p
		where p.idproducto = codproducto;
	
	if (select count(*)
			from carrito c
			where c.idproducto = codproducto) > 0 then

		select sum(c.cantidad) into transito
			from carrito c
			where c.idproducto = codproducto;
		
	else
		transito := 0;
	end if;
	
	if (existencia - transito < cant) then
		RAISE EXCEPTION 'No hay suficientes existencias para el producto indicado';
	end if;
	
	if (select count(*)
			from carrito c
			where c.idconexion = pg_backend_pid()
			and	c.idproducto = codproducto) > 0 then
		
		select cantidad into yaencarro
			from carrito c
			where c.idconexion = pg_backend_pid()
			and	c.idproducto = codproducto;

		delete
			from carrito c
			where c.idconexion = pg_backend_pid()
			and	c.idproducto = codproducto;
	
	else
		yaencarro := 0;
	end if;

	total := yaencarro + cant;

	insert into carrito
		(idconexion, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
		select	pg_backend_pid(),
				p.idproducto,
				total,
				p.precioventa * total,
				((p.descuento / 100) * p.precioventa) * total,
				((p.tasaimpuesto / 100) * (1 - p.descuento / 100 ) * p.precioventa) * total,
				p.tasaimpuesto,
				((1  + p.tasaimpuesto / 100) * (1 - p.descuento / 100 ) * p.precioventa) * total
				from producto p
				where p.idproducto = codproducto;
	

	exception
		when UNIQUE_VIOLATION then
			rollback;
			RAISE NOTICE 'Error: producto ya existente en el carrito';
		when NO_DATA_FOUND then
			rollback;
			RAISE NOTICE 'Error: el producto no existe';
		when others then
			rollback;
			RAISE NOTICE 'Error: No hay suficientes existencias para el producto indicado';

end;
$$ LANGUAGE plpgsql;


call agregar_producto(12, 1);

call crear_factura('F000011', 13);

call vaciar_carrito();
