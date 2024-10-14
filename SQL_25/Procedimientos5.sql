-- Cursor simple 1
DO
$$
declare
	reg_cliente cliente%ROWTYPE;
	cur_clientes CURSOR FOR SELECT * FROM cliente where direccion = 'Madrid';

begin
	open cur_clientes;
	fetch cur_clientes into reg_cliente;
	raise notice 'El nombre del cliente es: %', reg_cliente.nombre;
	fetch cur_clientes into reg_cliente;
	raise notice 'El nombre del cliente es: %', reg_cliente.nombre;
	close cur_clientes;
end
$$ LANGUAGE plpgsql;

-- Cursor simple 2
DO
$$
declare
	reg_cliente cliente%ROWTYPE;
	cur_clientes refcursor;

begin
	open cur_clientes FOR SELECT * FROM cliente where direccion = 'Madrid';
	fetch cur_clientes into reg_cliente;
	raise notice 'El nombre del cliente es: %', reg_cliente.nombre;
	fetch cur_clientes into reg_cliente;
	raise notice 'El nombre del cliente es: %', reg_cliente.nombre;
	close cur_clientes;
end
$$ LANGUAGE plpgsql;

-- Cursor con lazo de repetición
DO
$$
declare
	reg_cliente cliente%ROWTYPE;
	cur_clientes CURSOR FOR SELECT * FROM cliente where direccion = 'Madrid';

begin
    raise notice 'Inicio del proceso';
    
	open cur_clientes;
	fetch cur_clientes into reg_cliente;
    while (FOUND) loop
	    raise notice 'El nombre del cliente es: %', reg_cliente.nombre;
        fetch cur_clientes into reg_cliente;
    end loop;	
    
    close cur_clientes;
    
    raise notice 'Fin del proceso';
end
$$ LANGUAGE plpgsql;