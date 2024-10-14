select *
	from cliente c, factura f 
	where c.idcliente = f.idcliente ;
	
select	c.idcliente,
		c.nombre,
		c.numerocompras,
		c.montocompras,
		f.idfactura,
		f.numerofactura 
	from cliente c, factura f 
	where c.idcliente = f.idcliente ;

select	c.idcliente,
		c.nombre,
		c.numerocompras,
		c.montocompras,
		f.idfactura,
		f.numerofactura 
	from cliente c
	inner join factura f on c.idcliente = f.idcliente
	where c.montocompras >= '10'::money;
	
select	c.idcliente,
		c.nombre,
		c.numerocompras,
		c.montocompras,
		f.idfactura,
		f.numerofactura 
	from cliente c
	left outer join factura f on c.idcliente = f.idcliente;

select 	p.idproducto,
		p.descripcioncorta,
		p.inventario,
		lf.cantidad,
		lf.precioaplicado 
	from lineafactura lf
	right outer join producto p on lf.idproducto = p.idproducto;
	
select	idcliente,
		nombre,
		numerocompras,
		montocompras,
		'consulta 1' as origen
	from cliente
	where direccion = 'Madrid'
union
select	idcliente,
		nombre,
		numerocompras,
		montocompras,
		'consulta 2' as origen
	from cliente
	where direccion = 'Barcelona'
order by nombre;