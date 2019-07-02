/*Pregunta 1*/
create user ultimo_control IDENTIFIED by ultimo_control;

GRANT CONNECT,resource,unlimited tablespace to ultimo_control;



Create Table lugares
( 
  codigo number (6) not null,
	nombre varchar (50) null,
	tipo varchar(2) not null,
	lugar_superior number (6) not null,
  
	constraint pk_codigo primary key (codigo),
  constraint ch_tipo check (persexo in ('pa', 'de','ci')),
  constraint fk_lugarsuperior foreign key (lugar_superior) references lugares (codigo)
);


/*pregunta 2*/
CREATE INDEX fk_lugarsuperior ON lugares(codigo);

/*pregunta 3 */
Create Table auditoria_lugar
( 
  codigo number (6),
	tipoevento varchar (20),
	usuario varchar(50),
	fecha_hora date
);

/*pregunta 4*/

CREATE OR REPLACE PROCEDURE llenar_auditoria (p_name IN VARCHAR2) 
IS
BEGIN

End;

EXEC llenar_auditoria ('llenar_auditoria');


/*pregunta 5*/

shutdown immediate;
startup mount;
alter  database archivelog;
alter database open;

