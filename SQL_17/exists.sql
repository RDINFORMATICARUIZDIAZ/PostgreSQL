-- Clientes que han hecho alguna compra

select	*
	from 	cliente c 
	where 	exists (
		select 	*
			from 	factura f 
			where 	f.idcliente = c.idcliente
	);
	
select *
	from 	cliente c
	where 	numerocompras > 0;

select	c.*
	from 	cliente c inner join factura f on
		c.idcliente = f.idcliente ;
		
-- Clientes que no han hecho ninguna compra

select	*
	from 	cliente c 
	where 	not exists (
		select 	*
			from 	factura f 
			where 	f.idcliente = c.idcliente
	);
	
select *
	from 	cliente c
	where 	numerocompras = 0;
	
select	c.*
	from 	cliente c left join factura f on
		c.idcliente = f.idcliente 
	where f.idcliente is null;

-- Productos que se han vendido alguna vez
select 	*
	from 	producto p 
	where exists	(
		select 	*
			from 	lineafactura l 
			where 	l.idproducto = p.idproducto 
	);

-- Productos que no se han vendido ninguna vez
select 	*
	from 	producto p 
	where not exists	(
		select 	*
			from 	lineafactura l 
			where 	l.idproducto = p.idproducto 
	);