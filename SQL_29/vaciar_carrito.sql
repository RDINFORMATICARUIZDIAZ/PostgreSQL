CREATE OR REPLACE PROCEDURE vaciar_carrito() AS $$

begin
	
	delete
		from carrito
		where idconexion = pg_backend_pid();
	
	exception
		when others then
			rollback;
			RAISE NOTICE 'Error: ha ocurrido un error inesperado';
end;
$$ LANGUAGE plpgsql;