begin;

select *
	from factura;

insert into factura
(NumeroFactura, montobruto, descuento, impuesto, montoneto, fechaventa, anulada, idcliente)
values
('F000009', 2.0, 0, 0.4, 2.4, '2022-12-24', false, 7);

select *
	from factura;

select *
	from lineafactura;

insert into lineafactura 
(idfactura, idproducto, cantidad, precionormal, descuento, impuesto, tasaimpuesto, precioaplicado)
values
(20, 11, 1, 6.0, 0.0, 1.2, 20.0, 7.2);

select *
	from lineafactura;

select *
	from cliente
	where idcliente = 7;

update cliente set
	numerocompras = numerocompras + 1,
	montocompras = montocompras + '7,2'::money,
	ultimacompra = '2022-12-24',
	ultimamodificacion = '2022-12-24'
where idcliente = 7;

select *
	from cliente
	where idcliente = 7;

select *
	from producto
	where idproducto  = 11;

update producto set
	inventario = inventario - 1,
	unidadesvendidas = unidadesvendidas + 1,
	montovendido = montovendido + '6,0'::money,
	ultimaventa = '2022-12-24',
	ultimamodificacion = '2022-12-24'
where idproducto = 11;

select *
	from producto
	where idproducto  = 11;


rollback;

commit;