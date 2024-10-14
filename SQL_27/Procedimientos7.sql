-- Manejo de la excepción UNIQUE_VIOLATION 
DO
$$
declare
	resultado float;
	valor1 float;
	valor2 float;

BEGIN

	insert into cliente
	(nombre, tipodocumento, numerodocumento, telefono, direccion, numerocompras, montocompras, fecharegistro, ultimamodificacion)
	values
	('Jorge', 1, '12345755', '234561', 'Barcelona', 0, 0, '2022-09-03', '2022-09-03');

	valor1 := 5;
	valor2 := 0;
	resultado := valor1 / valor2;

exception
	when UNIQUE_VIOLATION then
		rollback;
		RAISE NOTICE 'Error: el número de documento del cliente ya existe';
	when others then
		rollback;
		RAISE NOTICE 'Error: se ha producido un error inesperado';
	
END
$$ LANGUAGE plpgsql;



-- Manejo de la excepción FOREIGN_KEY_VIOLATION 
DO
$$
BEGIN

	insert into lineafactura 
	(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
	values
	(150, 11, 1, 6.0, 0.0, 1.2, 20.0, 7.2);

exception
	when FOREIGN_KEY_VIOLATION then
		rollback;
		RAISE NOTICE 'Error: se ha intentado asociar un producto a una factura inexistente';
	when others then
		rollback;
		RAISE NOTICE 'Error: se ha producido un error inesperado';
	
END
$$ LANGUAGE plpgsql;


-- Manejo de la excepción NO_DATA_FOUND 
DO
$$
declare 
	regcliente cliente%ROWTYPE;

BEGIN

	select * into regcliente
		from cliente c
		where c.idcliente > 100;
	
	IF NOT FOUND THEN
    	RAISE EXCEPTION NO_DATA_FOUND USING MESSAGE = 'No se encontró el cliente con ID dado';
  	END IF;

exception
	when NO_DATA_FOUND then
		rollback;
		RAISE NOTICE 'No se encontró el cliente con ID dado';
	when others then
		rollback;
		RAISE NOTICE 'Error: se ha producido un error inesperado';

	
END
$$ LANGUAGE plpgsql;


-- Manejo de la excepción TOO_MANY_ROWS 
DO
$$
declare 
	nombre varchar(50);

BEGIN

	if (select count(*) from cliente c where c.direccion = 'Madrid') > 1 then
		RAISE EXCEPTION TOO_MANY_ROWS USING MESSAGE = 'Hay más de un cliente con esas características';
	end if;

	select c.nombre into nombre
		from cliente c
		where c.direccion = 'Madrid';
	
	RAISE NOTICE 'El nombre del cliente es %', nombre;
	
exception
	when TOO_MANY_ROWS then
		rollback;
		RAISE NOTICE 'Hay más de un cliente con esas características';
	when others then
		rollback;
		RAISE NOTICE 'Error: se ha producido un error inesperado';

	
END
$$ LANGUAGE plpgsql;