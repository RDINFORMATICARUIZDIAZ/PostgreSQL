CREATE OR REPLACE PROCEDURE delete_factura(codfactura integer) AS
$$
begin
	delete
		from	lineafactura
		where 	idfactura = codfactura;
	
	delete
		from 	factura
		where 	idfactura = codfactura;

	RAISE NOTICE 'La factura ha sido eliminada correctamente';
	
	exception
		when others then
			rollback;
			RAISE NOTICE 'No se pudo eliminar la factura';

END;
$$ LANGUAGE plpgsql;


call delete_factura(38);