-- Actualizar inventario statement-level
CREATE OR REPLACE FUNCTION actualizar_producto1() RETURNS trigger AS
$$
begin
	
	RAISE NOTICE 'Tipo de operación: %', TG_OP;
	
	RAISE NOTICE 'Momento de la operación: %', TG_WHEN;

	RAISE NOTICE 'Tabla de la operación: %', TG_TABLE_NAME;

	RAISE NOTICE 'Se ha aumentado el inventario';
	
	RETURN NULL;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER modificacion_producto
	BEFORE UPDATE
	ON producto
	FOR EACH STATEMENT
	EXECUTE PROCEDURE actualizar_producto1();
	
update Producto set
	inventario = inventario + 1 
where idproducto <= 5;


-- Actualizar inventario statement-level
CREATE OR REPLACE FUNCTION actualizar_producto2() RETURNS trigger AS
$$
begin
	
	RAISE NOTICE 'IDProducto nuevo: %', new.idproducto;
	RAISE NOTICE 'Nombre producto nuevo: %', new.descripcioncorta;
	RAISE NOTICE 'Inventario nuevo: %', new.inventario;

	RAISE NOTICE 'IDProducto anterior: %', old.idproducto;
	RAISE NOTICE 'Nombre producto anterior: %', old.descripcioncorta;
	RAISE NOTICE 'Inventario anterior: %', old.inventario;

	RAISE NOTICE 'Se ha aumentado el inventario';
	
	RETURN NEW;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER modificacion_producto
	BEFORE UPDATE
	ON producto
	FOR EACH ROW
	EXECUTE PROCEDURE actualizar_producto2();
	
update Producto set
	inventario = inventario + 1 
where idproducto <= 5;


-- Control de inserción de cliente
CREATE OR REPLACE FUNCTION control_direccion_cliente() RETURNS trigger AS
$$
begin
	
	if new.direccion = 'Madrid' then
		return new;
	end if;
	
	if new.direccion = 'Barcelona' then
		return new;
	end if;
	
	if new.direccion = 'Valencia' then
		return new;
	end if;

	if new.direccion = 'Sevilla' then
		return new;
	end if;

	RAISE NOTICE 'No hay tiendas en la dirección indicada. Se rechaza la inserción del cliente';
	return null;

end;
$$ LANGUAGE plpgsql;


CREATE TRIGGER control_cliente
	BEFORE INSERT
	ON cliente
	FOR EACH ROW
	EXECUTE PROCEDURE control_direccion_cliente();
	

insert into cliente
(nombre, tipodocumento, numerodocumento, telefono, direccion, numerocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Álvaro', 1, '283457', '234545', 'Barcelona', 0, 0, now(), now());

insert into cliente
(nombre, tipodocumento, numerodocumento, telefono, direccion, numerocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Patricia', 1, '323467', '444561', 'Alicante', 0, 0, now(), now());

insert into cliente
(nombre, tipodocumento, numerodocumento, telefono, direccion, numerocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Patricia', 1, '323467', '444561', 'Valencia', 0, 0, now(), now());

insert into cliente
(nombre, tipodocumento, numerodocumento, telefono, direccion, numerocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Andrés', 1, '653457', '777561', 'Segovia', 0, 0, now(), now());