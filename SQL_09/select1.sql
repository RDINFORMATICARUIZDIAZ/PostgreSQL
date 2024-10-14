select *
	from cliente;
	
select *
	from producto;
	
select *
	from producto
	order by idproducto;

select *
	from cliente
	order by nombre desc;

select	idproducto,
		descripcioncorta,
		inventario 
	from producto
	where inventario < 10;
	
select *
	from cliente
	order by tipodocumento, nombre;

select *
	from cliente
	where tipodocumento = 1
	order by nombre;

select *
	from cliente
	where tipodocumento = 1
		and direccion = 'Barcelona';
	
select *
	from cliente
	where direccion = 'Barcelona'
		or direccion = 'Madrid';

select	idproducto,
		descripcioncorta,
		inventario 
	from producto
	where inventario < 10;

select	idproducto,
		descripcioncorta,
		preciocompra 
	from producto
	where preciocompra  >= '2'::money 
			and preciocompra <= '4'::money;