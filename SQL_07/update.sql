insert into comercio.factura
(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
values
('F000001', 11.5, 0, 2.3, 13.8, '2022-09-10', false, 6);

insert into comercio.lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(5, 1, 2, 2.0, 0.0, 0.4, 2.0, 4.8);

insert into comercio.lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(5, 2, 3, 2.5, 0.0, 0.5, 20.0, 9.0);

update comercio.cliente set
	numerocompras = numerocompras + 1,
	montocompras = montocompras + '13,8'::money,
	ultimacompra = '2022-09-10',
	ultimamodificacion = '2022-09-10'
where idcliente = 6;

update comercio.producto set
	inventario = inventario - 2,
	unidadesvendidas = unidadesvendidas + 2,
	montovendido = '4,0'::money,
	ultimaventa = '2022-09-10',
	ultimamodificacion = '2022-09-10'
where idproducto = 1;

update comercio.producto set
	inventario = inventario - 3,
	unidadesvendidas = unidadesvendidas + 3,
	montovendido = '7,5'::money,
	ultimaventa = '2022-09-10',
	ultimamodificacion = '2022-09-10'
where idproducto = 2;