select MAX(montoneto)
	from factura
	where fechaventa = '2022-09-24';

select MIN(montoneto)
	from factura;

select	MAX(montoneto),
		MIN(montoneto)
	from factura
	where fechaventa = '2022-09-24';

select	SUM(montobruto) as MontoBruto,
		sum(descuento) as Descuento,
		sum(impuesto) as Impuesto,
		SUM(montoneto) as MontoNeto
	from factura
	where fechaventa = '2022-09-24';

select count(*)
	from cliente
	where tipodocumento = 1;

select	SUM(unidadesvendidas ),
		AVG(unidadesvendidas)
	from producto
	where unidadesvendidas > 0;
	
select	direccion,
		count(*)
		from cliente
		group by direccion
		order by direccion ;
		
select	fechaventa,
		count(*),
		sum(montoneto)
		from factura
		group by fechaventa ;

select	fechaventa,
		count(*),
		sum(montoneto)
		from factura
		group by fechaventa
		having sum(montoneto) >= '10'::money;

select	fechaventa,
		count(*),
		sum(montoneto)
		from factura
		group by fechaventa
		having sum(montoneto) < '10'::money;
	
select	fechaventa,
		count(*),
		sum(montoneto)
		from factura
		group by fechaventa
		having count(*) > 1;