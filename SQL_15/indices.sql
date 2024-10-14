create index nombre_cliente_idx on cliente (
	nombre
);

create index numero_factura_idx on factura (
	numerofactura
);

create index descripcion_producto_idx on producto (
	descripcioncorta
);