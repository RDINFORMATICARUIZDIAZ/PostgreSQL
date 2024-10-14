CREATE TABLE ComprasCliente (
	idCliente int4 NOT NULL,
	Nombre varchar(50) NOT NULL,
	Telefono varchar(25),
	NumeroCompras int4 NOT NULL,
	NumeroFactura varchar(20) NOT NULL,
	MontoNeto money NOT NULL,
	FechaVenta timestamp NOT NULL
);
ALTER TABLE ComprasCliente ADD CONSTRAINT ComprasCliente_PK PRIMARY KEY(idCliente,NumeroFactura);