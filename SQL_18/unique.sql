alter table cliente 
	add constraint documento_cliente unique (tipodocumento, numerodocumento);
	
insert into cliente
(nombre, tipodocumento, numerodocumento, telefono, direccion, numerocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Alberto', 1, '123456', '', 'Madrid', 0, 0, '2022-12-03', '2022-12-03');


alter table cliente 
	add constraint telefono_cliente unique (telefono);
	
insert into cliente
(nombre, tipodocumento, numerodocumento, telefono, direccion, numerocompras, montocompras, fecharegistro, ultimamodificacion)
values
('Pedro', 1, '1234561', '', 'Madrid', 0, 0, '2022-12-03', '2022-12-03');

alter table cliente 
	drop constraint telefono_cliente;