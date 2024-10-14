CREATE OR REPLACE FUNCTION suma(numero1 integer, numero2 integer) RETURNS integer AS $$
DECLARE
 resultado INTEGER;

BEGIN
 resultado := numero1 + numero2;

 RETURN resultado;
END;
$$ LANGUAGE plpgsql;


select suma(2, 4);