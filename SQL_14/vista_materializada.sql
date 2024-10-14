create materialized view ultimascompras as
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
with data;

insert into factura
(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
values
('F000008', 2.0, 0, 0.4, 2.4, '2022-10-30', false, 7);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(12, 11, 1, 6.0, 0.0, 1.2, 20.0, 7.2);

update cliente set
	numerocompras = numerocompras + 1,
	montocompras = montocompras + '7,2'::money,
	ultimacompra = '2022-10-30',
	ultimamodificacion = '2022-10-30'
where idcliente = 7;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = '6,0'::money,
	ultimaventa = '2022-10-30',
	ultimamodificacion = '2022-10-30'
where idproducto = 11;


select *
	from ultimascompras
	where montoneto > '5'::money;
	
refresh materialized view ultimascompras
with data;