CREATE TABLE Cliente (
	idCliente serial NOT NULL,
	Nombre varchar(50) NOT NULL,
	TipoDocumento int2,
	NumeroDocumento varchar(20),
	Telefono varchar(25),
	Direccion varchar(150),
	NumeroCompras int4 NOT NULL,
	MontoCompras money NOT NULL,
	FechaRegistro timestamp NOT NULL,
	UltimaCompra timestamp,
	UltimaModificacion timestamp NOT NULL
);

CREATE TABLE Producto (
	idProducto serial NOT NULL,
	DescripcionCorta varchar(80) NOT NULL,
	DescripcionLarga varchar(250),
	Inventario int4 NOT NULL,
	PrecioCompra money NOT NULL,
	PrecioVenta money NOT NULL,
	TasaImpuesto numeric(5, 2) NOT NULL,
	Descuento numeric(5, 2) NOT NULL,
	UnidadesVendidas int4 NOT NULL,
	MontoVendido money NOT NULL,
	FechaCreacion timestamp NOT NULL,
	UltimaVenta timestamp,
	UltimaModificacion timestamp NOT NULL
);

CREATE TABLE Factura (
	idFactura serial NOT NULL,
	NumeroFactura varchar(20) NOT NULL,
	MontoBruto money NOT NULL,
	Descuento money NOT NULL,
	Impuesto money NOT NULL,
	MontoNeto money NOT NULL,
	FechaVenta timestamp NOT NULL,
	Anulada boolean NOT NULL,
	idCliente serial NOT NULL
);

CREATE TABLE LineaFactura (
	Cantidad int4 NOT NULL,
	PrecioNormal money NOT NULL,
	Descuento money NOT NULL,
	Impuesto money NOT NULL,
	TasaImpuesto numeric(5, 2) NOT NULL,
	PrecioAplicado money NOT NULL,
	idFactura serial NOT NULL,
	idProducto serial NOT NULL
);

ALTER TABLE Cliente ADD CONSTRAINT cliente_pk PRIMARY KEY(idCliente);

ALTER TABLE Producto ADD CONSTRAINT producto_pk PRIMARY KEY(idProducto);

ALTER TABLE Factura ADD CONSTRAINT factura_pk PRIMARY KEY(idFactura);

ALTER TABLE Factura ADD CONSTRAINT facturas_cliente_fk FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE LineaFactura ADD CONSTRAINT lineafactura_pk PRIMARY KEY(idFactura,idProducto);

ALTER TABLE LineaFactura ADD CONSTRAINT lineas_factura_fk FOREIGN KEY (idFactura) REFERENCES Factura(idFactura) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE LineaFactura ADD CONSTRAINT producto_lineafactura_pk FOREIGN KEY (idProducto) REFERENCES Producto(idProducto) ON DELETE NO ACTION ON UPDATE NO ACTION;
