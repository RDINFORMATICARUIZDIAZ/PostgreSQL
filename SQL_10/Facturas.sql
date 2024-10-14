insert into factura
(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
values
('F000002', 5.1, 0, 1.02, 6.12, '2022-09-24', false, 1);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(5, 3, 1, 2.1, 0.0, 0.42, 20.0, 2.52);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(5, 4, 1, 3.0, 0.0, 0.6, 20.0, 3.6);

update cliente set
	numerocompras = numerocompras + 1,
	montocompras = montocompras + '6,12'::money,
	ultimacompra = '2022-09-24',
	ultimamodificacion = '2022-09-24'
where idcliente = 1;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = '2,1'::money,
	ultimaventa = '2022-09-24',
	ultimamodificacion = '2022-09-24'
where idproducto = 3;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = '3,0'::money,
	ultimaventa = '2022-09-24',
	ultimamodificacion = '2022-09-24'
where idproducto = 4;

----------------------------------------------------------------------------------------------------------------

insert into factura
(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
values
('F000003', 8.5, 0, 1.7, 10.2, '2022-09-24', false, 2);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(6, 5, 1, 2.5, 0.0, 0.5, 20.0, 3.0);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(6, 6, 2, 6.0, 0.0, 1.2, 20.0, 7.2);

update cliente set
	numerocompras = numerocompras + 1,
	montocompras = montocompras + '10,2'::money,
	ultimacompra = '2022-09-24',
	ultimamodificacion = '2022-09-24'
where idcliente = 2;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = '2,5'::money,
	ultimaventa = '2022-09-24',
	ultimamodificacion = '2022-09-24'
where idproducto = 5;

update producto set
	inventario = inventario - 2,
	unidadesvendidas = unidadesvendidas + 2,
	montovendido = '6,0'::money,
	ultimaventa = '2022-09-24',
	ultimamodificacion = '2022-09-24'
where idproducto = 6;

----------------------------------------------------------------------------------------------------------------

insert into factura
(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
values
('F000004', 10.0, 0, 2.0, 12.0, '2022-09-24', false, 4);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(7, 7, 1, 8.0, 0.0, 1.6, 20.0, 9.6);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(7, 8, 1, 2.0, 0.0, 0.4, 20.0, 2.4);

update cliente set
	numerocompras = numerocompras + 1,
	montocompras = montocompras + '12,0'::money,
	ultimacompra = '2022-09-24',
	ultimamodificacion = '2022-09-24'
where idcliente = 4;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = '8,0'::money,
	ultimaventa = '2022-09-24',
	ultimamodificacion = '2022-09-24'
where idproducto = 7;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = '2,0'::money,
	ultimaventa = '2022-09-24',
	ultimamodificacion = '2022-09-24'
where idproducto = 8;

----------------------------------------------------------------------------------------------------------------

insert into factura
(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
values
('F000005', 2.0, 0, 0.4, 2.4, '2022-09-25', false, 3);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(8, 9, 1, 2.0, 0.0, 0.4, 20.0, 2.4);

update cliente set
	numerocompras = numerocompras + 1,
	montocompras = montocompras + '2,4'::money,
	ultimacompra = '2022-09-25',
	ultimamodificacion = '2022-09-25'
where idcliente = 3;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = '2,4'::money,
	ultimaventa = '2022-09-25',
	ultimamodificacion = '2022-09-25'
where idproducto = 9;

----------------------------------------------------------------------------------------------------------------

insert into factura
(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
values
('F000006', 2.0, 0, 0.4, 2.4, '2022-09-26', false, 5);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(9, 10, 1, 2.0, 0.0, 0.4, 20.0, 2.4);

update cliente set
	numerocompras = numerocompras + 1,
	montocompras = montocompras + '2,4'::money,
	ultimacompra = '2022-09-26',
	ultimamodificacion = '2022-09-26'
where idcliente = 5;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = '2,4'::money,
	ultimaventa = '2022-09-26',
	ultimamodificacion = '2022-09-26'
where idproducto = 10;

----------------------------------------------------------------------------------------------------------------

insert into factura
(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
values
('F000007', 2.0, 0, 0.4, 2.4, '2022-09-27', false, 6);

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(10, 11, 1, 6.0, 0.0, 1.2, 20.0, 7.2);

update cliente set
	numerocompras = numerocompras + 1,
	montocompras = montocompras + '7,2'::money,
	ultimacompra = '2022-09-27',
	ultimamodificacion = '2022-09-27'
where idcliente = 6;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = '6,0'::money,
	ultimaventa = '2022-09-27',
	ultimamodificacion = '2022-09-27'
where idproducto = 11;