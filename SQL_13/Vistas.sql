create view vistacompras as
(
	select c.idcliente,
		c.nombre,
		c.telefono ,
		c.numerocompras ,
		f.numerofactura ,
		f.montoneto,
		f.fechaventa 
		from cliente c inner join factura f on
			c.idcliente = f.idcliente 
		where f.anulada = false 
);


select *
	from vistacompras;
	
select *
	from vistacompras
	where montoneto > '5'::money;

select *
	from vistacompras
	where nombre = 'Luis';

select *
	from vistacompras
	where numerofactura = 'F000004';