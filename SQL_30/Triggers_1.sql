CREATE OR REPLACE FUNCTION antes_insertar_producto() RETURNS trigger AS
$$
BEGIN
	RAISE NOTICE 'Se va a agregar un producto al carrito';
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION despues_insertar_producto() RETURNS trigger AS
$$
BEGIN
	RAISE NOTICE 'Se ha agregado un producto al carrito';
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER antes_insertar_producto
	BEFORE INSERT
	ON carrito
	FOR EACH ROW
	EXECUTE PROCEDURE antes_insertar_producto();
	
CREATE TRIGGER despues_insertar_producto
	AFTER INSERT
	ON carrito
	FOR EACH ROW
	EXECUTE PROCEDURE despues_insertar_producto();