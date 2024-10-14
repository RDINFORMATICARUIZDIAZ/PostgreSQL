-- Imprimir valores
CREATE OR REPLACE FUNCTION imprimir_valores(parametro integer) RETURNS integer AS $$
DECLARE
    variable integer := 30;
BEGIN
	RAISE NOTICE 'El valor de la variable es %', variable;
	RAISE NOTICE 'El valor del parámetro es %', parametro;

    RETURN variable;
END;
$$ LANGUAGE plpgsql;

select imprimir_valores(20);


-- Procedimiento con valores de entrada y salida
CREATE OR REPLACE FUNCTION operaciones1(valor1 integer, valor2 integer, out suma int, out resta int) AS $$
BEGIN
	suma := valor1 + valor2;
	resta := valor1 - valor2;
END;
$$ LANGUAGE plpgsql;

select operaciones1(25, 13);

CREATE OR REPLACE PROCEDURE operaciones2(valor1 integer, valor2 integer, out suma int, out resta int) AS $$
BEGIN
	suma := valor1 + valor2;
	resta := valor1 - valor2;
END;
$$ LANGUAGE plpgsql;

CALL operaciones2(2, 4, NULL, NULL);

-- Retorno de valores concatenados
CREATE OR REPLACE function concatenar(datos cliente)
returns text
as $$
begin
	return datos.idcliente || ' ' || datos.nombre || ' ' || datos.telefono || ' ' ||  datos.direccion;
end;
$$ LANGUAGE plpgsql;

select concatenar(c.*) from cliente c ;


-- Retorno de contenido de una tabla
CREATE OR REPLACE function consulta() returns
	table (
		id int,
		nombre varchar
	)
AS $$
begin	
	return query
		select	s.idcliente,
				s.nombre
		from	cliente s
		where	s.numerocompras > 0;
end;
$$ LANGUAGE plpgsql;

select consulta();
select * from consulta();