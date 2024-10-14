do $body$


declare
	numfactura varchar(20);
	codcliente integer;
	productos jsonb;
	
begin

	numfactura := 'F00000022';
	codcliente := 5;
	productos := '[{"idproducto": 9, "cantidad": 2}, {"idproducto": 1, "cantidad": 4}, {"idproducto": 10, "cantidad": 1}]';

	CALL crear_factura_JSON(numfactura, codcliente, productos);

end;
$body$;