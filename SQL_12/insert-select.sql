insert into comprascliente 
(idcliente, nombre, telefono, numerocompras, numerofactura, montoneto, fechaventa)
select	c.idcliente,
		c.nombre,
		c.telefono,
		c.numerocompras,
		f.numerofactura,
		f.montoneto,
		f.fechaventa 
	from cliente c inner join factura f on
			c.idcliente = f.idcliente
	where f.anulada = false ;