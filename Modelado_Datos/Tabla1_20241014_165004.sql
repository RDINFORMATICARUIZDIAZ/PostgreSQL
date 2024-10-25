CREATE TABLE tabla1 (
	id integer NOT NULL,
	nombres character(100) NOT NULL,
	fecha date NOT NULL,
	valor money NOT NULL
);
ALTER TABLE tabla1 ADD CONSTRAINT tabla1_pk PRIMARY KEY(id);
