-- Cursor con lazo de repetición FOR
DO
$$
declare
	reg_cliente cliente%ROWTYPE;
	cur_clientes CURSOR FOR SELECT * FROM cliente where direccion = 'Madrid';

begin
    raise notice 'Inicio del proceso';
    
	for reg_cliente in cur_clientes loop  
	    raise notice 'El nombre del cliente es: %', reg_cliente.nombre;
    end loop;	
    
    raise notice 'Fin del proceso';
end
$$ LANGUAGE plpgsql;


-- Cursor implícito
DO
$$
declare
	reg_cliente cliente%ROWTYPE;

begin
    raise notice 'Inicio del proceso';
    
	for reg_cliente in SELECT * FROM cliente where direccion = 'Madrid' loop  
	    raise notice 'El nombre del cliente es: %', reg_cliente.nombre;
    end loop;	
    
    raise notice 'Fin del proceso';
end
$$ LANGUAGE plpgsql;


-- Cursor explícito
DO
$$
declare
	reg_cliente cliente%ROWTYPE;
	cur_clientes cursor (filtro varchar) FOR SELECT * FROM cliente where direccion = filtro;

begin
    raise notice 'Inicio del proceso';
    
	raise notice 'Usando el filtro Madrid';
	for reg_cliente in cur_clientes (filtro := 'Madrid') loop  
	    raise notice 'El nombre del cliente es: %', reg_cliente.nombre;
    end loop;
   
	raise notice 'Usando el filtro Barcelona';
	for reg_cliente in cur_clientes (filtro := 'Barcelona') loop  
	    raise notice 'El nombre del cliente es: %', reg_cliente.nombre;
    end loop;
    
    raise notice 'Fin del proceso';
end
$$ LANGUAGE plpgsql;