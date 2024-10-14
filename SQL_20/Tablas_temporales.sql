/* Tipos de tablas temporales */

CREATE TEMPORARY TABLE tabla1 (
campo1 int,
campo2 varchar(10)
) ON COMMIT DELETE ROWS ;

CREATE TEMPORARY TABLE tabla2 (
	campo1 int,
	campo2 varchar(10)
) ON COMMIT PRESERVE ROWS;


begin;

CREATE TEMPORARY TABLE tabla3 (
	campo1 int,
	campo2 varchar(10)
) ON COMMIT DROP;

insert into tabla1
(campo1, campo2)
values (1, 'texto 1');

insert into tabla1
(campo1, campo2)
values (2, 'texto 2');

insert into tabla2
(campo1, campo2)
values (1, 'texto 1');

insert into tabla2
(campo1, campo2)
values (2, 'texto 2');

insert into tabla3
(campo1, campo2)
values (1, 'texto 1');

insert into tabla3
(campo1, campo2)
values (2, 'texto 2');


select *
	from  tabla1;

select *
	from  tabla2;

select *
	from  tabla3;

commit;


select *
	from  tabla1;

select *
	from  tabla2;
	
select *
	from  tabla3;
	

/* Tablas temporal a partir de una consulta */

CREATE TEMPORARY TABLE tabla4
ON COMMIT PRESERVE rows
as
select	c.idcliente,
		c.nombre		
	from	cliente c
with data;

CREATE TEMPORARY TABLE tabla5
ON COMMIT PRESERVE rows
as
select	c.idcliente,
		c.nombre		
	from	cliente c
with no data;

select *
	from  tabla4;
	
select *
	from  tabla5;