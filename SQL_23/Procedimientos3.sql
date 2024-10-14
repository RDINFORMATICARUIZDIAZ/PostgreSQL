-- Procedimeinto que selecciona un cliente y muestra alguno de sus valores

CREATE OR REPLACE PROCEDURE datos_cliente (codigo integer) as $$
declare 
	regcliente cliente%ROWTYPE;
	nombre varchar;
	fecha timestamp;
	retorno integer;

begin
	
	select	* into regcliente
		from cliente c
		where c.idcliente = codigo;
	
	raise notice 'El id del cliente es: %', regcliente.idcliente;

	nombre := regcliente.nombre;
	raise notice 'El nombre del cliente es: %', nombre;

	if (regcliente.direccion = 'Madrid') then
		raise notice 'El cliente es de Madrid';
	else
		raise notice 'El cliente no es de Madrid';
	end if;

	fecha = regcliente.ultimacompra;
	raise notice 'La fecha de la última compra del cliente % fue el: %', nombre, fecha;

	retorno := imprimir_valores(45);
	raise notice 'El valor retornado por la función es: %', retorno;

	perform imprimir_valores(55);
	
end;
$$ LANGUAGE plpgsql;

call datos_cliente(1);