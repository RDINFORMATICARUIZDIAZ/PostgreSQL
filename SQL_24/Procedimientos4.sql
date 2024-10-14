-- Demostración de la estructura CASE

CREATE OR REPLACE PROCEDURE ejemplo_case(codigo integer)
AS $$
declare 
	regcliente cliente%ROWTYPE;

begin
	
	select	* into regcliente
		from cliente c
		where c.idcliente = codigo;
	
	case regcliente.direccion
		when 'Madrid' then
			raise notice 'La dirección de nuestra tienda en Madrid es...';
		when 'Barcelona' then
			raise notice 'La dirección de nuestra tienda en Barcelona es...';
		when 'Valencia' then
			raise notice 'La dirección de nuestra tienda en Valencia es...';
		when 'Sevilla' then
			raise notice 'La dirección de nuestra tienda en Sevilla es...';
	else
		raise notice 'Lo siento. No tenemos tienda en esa ciudad.';
	end case;

end;
$$ LANGUAGE plpgsql;


call ejemplo_case(8);
call ejemplo_case(10);
call ejemplo_case(13);
call ejemplo_case(4);
call ejemplo_case(5);


-- Demostración de la estructura LOOP

CREATE OR REPLACE PROCEDURE ejemplo_loop(limite integer)
AS $$
declare 
	contador integer;

begin
	contador := 0;

	loop
		contador := contador + 1;
		raise notice 'El valor del contador es: %', contador;
		if (contador >= limite) then
			raise notice 'Se va a finalizar el ciclo de repetición';
			exit;
		end if;
	end loop;
	raise notice 'Ha finalizado el ciclo de repetición';
end;
$$ LANGUAGE plpgsql;


call ejemplo_loop(8);


-- Demostración de la estructura WHILE

CREATE OR REPLACE PROCEDURE ejemplo_while(limite integer)
AS $$
declare 
	contador integer;

begin
	contador := 0;

	while (contador < limite) loop
		contador := contador + 1;
		raise notice 'El valor del contador es: %', contador;
	end loop;
	raise notice 'Ha finalizado el ciclo de repetición';
end;
$$ LANGUAGE plpgsql;


call ejemplo_while(8);


-- Demostración de la estructura FOR

CREATE OR REPLACE PROCEDURE ejemplo_for(limite integer)
AS $$
begin
	for contador in 1..limite  loop
		raise notice 'El valor del contador es: %', contador;
	end loop;
	raise notice 'Ha finalizado el ciclo de repetición';
end;
$$ LANGUAGE plpgsql;


call ejemplo_for(8);


-- Demostración de la estructura FOREACH

CREATE OR REPLACE PROCEDURE ejemplo_foreach(int[])
AS $$
declare
	suma int;
	indice int;
	contador int;
begin
	contador := 0;
	suma := 0;
	foreach indice in array $1 loop
		contador := contador + 1;
		raise notice 'El valor del contador es: %', contador;
		suma := suma + indice;
		raise notice 'El valor de la suma es: %', suma;
	end loop;
	raise notice 'Ha finalizado el ciclo de repetición';
end;
$$ LANGUAGE plpgsql;


call ejemplo_foreach(array[1,2,3,4,5,6]);