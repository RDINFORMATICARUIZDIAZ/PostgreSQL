select 	*
	from cliente c 
	where c.idcliente in (
		select f.idcliente 
			from factura f 
			where f.fechaventa = '2022-09-24'
	);

select 	*
	from 	producto p
	where	p.idproducto in (
		select lf.idproducto 
			from lineafactura lf inner join factura f on
					lf.idfactura = f.idfactura 
			where f.fechaventa = '2022-09-24'
	);
	
select 	f.numerofactura,
		f.montoneto,
		(select		c.nombre 
			from	cliente c
			where 	c.idcliente = f.idcliente) as cliente 
	from factura f ;

update cliente set
	ultimacompra = '2022-09-24'
where idcliente in (
	select f.idcliente 
			from factura f 
			where f.fechaventa = '2022-09-24'
);