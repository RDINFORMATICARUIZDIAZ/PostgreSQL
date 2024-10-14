delete
	from lineafactura 
	where idfactura = 2;

delete
	from factura
	where idfactura = 2;
	
update cliente set
	numerocompras = numerocompras - 1,
	montocompras = montocompras - '13,8'::money,
	ultimamodificacion = '2022-09-11'
where idcliente = 3;

update producto set
	inventario = inventario + 2,
	unidadesvendidas = unidadesvendidas - 2,
	montovendido = montovendido - '4,0'::money,
	ultimamodificacion = '2022-09-11'
where idproducto = 1;

update producto set
	inventario = inventario + 3,
	unidadesvendidas = unidadesvendidas - 3,
	montovendido = montovendido - '7,5'::money,
	ultimamodificacion = '2022-09-11'
where idproducto = 2;