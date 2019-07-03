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
  constraint ch_tipo check (tipo in ('pa', 'de','ci')),
  constraint fk_lugarsuperior foreign key (lugar_superior) references lugares (codigo)
);


/*pregunta 2*/
CREATE INDEX fk_lugarsuperior ON lugares(lugar_superior);


/*pregunta 3 */
Create Table auditoria_lugar
( 
  codigo number (6),
	tipoevento varchar (20),
	usuario varchar(50),
	fecha_hora date
);

/*pregunta 4*/

/*insert*/
CREATE OR REPLACE TRIGGER alinsertarlugares
AFTER INSERT
   ON lugares
   FOR EACH ROW

DECLARE
   evento varchar2(20):='insert';

BEGIN

   SELECT user INTO v_username
   FROM dual;

   INSERT INTO auditoria_lugar
   ( codigo,
	   tipoevento,
	   usuario,
	   fecha_hora)
   VALUES
   ( :new.codigo,
     :new.tipoevento,
      v_username,
      current_date);
END;

/*update*/

CREATE OR REPLACE TRIGGER alactualizarlugares
AFTER UPDATE
   ON lugares
   FOR EACH ROW

DECLARE
   evento varchar2(20):='update';

BEGIN

   SELECT user INTO v_username
   FROM dual;

   INSERT INTO auditoria_lugar
   ( codigo,
	   tipoevento,
	   usuario,
	   fecha_hora)
   VALUES
   ( :new.codigo,
     :new.tipoevento,
      v_username,
      current_date);
END;

/*delete*/

CREATE OR REPLACE TRIGGER alborrarlugares
AFTER delete
   ON lugares
   FOR EACH ROW

DECLARE
   evento varchar2(20):='delete';

BEGIN

   SELECT user INTO v_username
   FROM dual;

   INSERT INTO auditoria_lugar
   ( codigo,
	   tipoevento,
	   usuario,
	   fecha_hora)
   VALUES
   ( :old.codigo,
     :old.tipoevento,
      v_username,
      current_date);
END;

/*trigger junto*/

CREATE OR REPLACE TRIGGER auditorioalugares
AFTER DELETE OR UPDATE OR INSERT
   ON lugares
   FOR EACH ROW

DECLARE
   evento varchar2(20);
   codigoevento varchar2(20);
   
BEGIN
IF INSERTING THEN evento := 'insert'; codigoevento:= ':new.codigo';END IF;
IF DELETING THEN evento := 'delete';codigoevento:= ':old.codigo';END IF;
IF UPDATING THEN evento := 'update';codigoevento:= ':new.codigo';END IF;

   SELECT user INTO v_username
   FROM dual;
   
    INSERT INTO auditoria_lugar
    (codigo,
	   tipoevento,
	   usuario,
	   fecha_hora)
     
    VALUES
    ( codigoevento,
      evento,
      v_username,    
      current_date);
      
END;

/*CREATE OR REPLACE PROCEDURE llenar_auditoria (p_name IN VARCHAR2) 
IS
BEGIN



End;



EXEC llenar_auditoria ('llenar_auditoria');*/


/*pregunta 5*/

shutdown immediate;
startup mount;
alter  database archivelog;
alter database open;

