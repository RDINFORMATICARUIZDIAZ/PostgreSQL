CREATE OR REPLACE FUNCTION suma(integer, integer) RETURNS integer AS $$
DECLARE
 numero1 ALIAS FOR $1;
 numero2 ALIAS FOR $2;
 resultado INTEGER;

BEGIN
 resultado := numero1 + numero2;


 RETURN resultado;
END;
$$ LANGUAGE plpgsql;


select suma(1, 3);