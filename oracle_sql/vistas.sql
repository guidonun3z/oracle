 
  set linesize 1000;
  select * from  PRESTAMO_CABECERA;
  
  select * from pelicula;
  select * from genero;
  select * from idioma;
  
  set linesize 1000;
  select p.PELCODIGO,p.PELNOMBRE,g.GENNOMBRE,p.PELANO
  from pelicula p 
  INNER JOIN genero g on p.PELGENERO = g.GENCODIGO;
  
  
  CREATE VIEW peliculas_y_genero AS
  select p.PELCODIGO,p.PELNOMBRE,g.GENNOMBRE,p.PELANO
  from pelicula p 
  INNER JOIN genero g on p.PELGENERO = g.GENCODIGO;
 
 select * from peliculas_y_genero;
 
 
 CREATE VIEW prestamocab_cliente AS
  select c.CLICODIGO,c.CLINOMBRE ,c.CLIAPELLIDO,p.PRESNUMERO,p.PRESFECHA
  from PRESTAMO_CABECERA p
  INNER JOIN CLIENTE c on c.CLICODIGO = p.CLICODIGO;
  
  
  select * from prestamocab_cliente;
  
  /*materialized views*/
  
  select * 
  from PRESTAMO_CABECERA  pc
  inner join PRESTAMO_DETALLE pd
  on pc.PRESNUMERO = pd.PRESNUMERO;
  
  
  CREATE MATERIALIZED VIEW cabecera_detalle
  FOR UPDATE
   AS select pc.CLICODIGO,pc.PRESNUMERO,pc.PRESFECHA
  from PRESTAMO_CABECERA  pc;
  
  CREATE MATERIALIZED VIEW vista_presta_detalle
  FOR UPDATE
   AS select *from PRESTAMO_DETALLE pd;
  
/*Funciones*/


CREATE OR REPLACE FUNCTION desc_pel( pelicula IN NUMBER) 
   RETURN VARCHAR2
   IS pelicula_detalles VARCHAR2(130);

BEGIN 
      select 'Pelicula'||p.PELCODIGO||' '||p.PELNOMBRE||' '||g.GENNOMBRE||' '||p.PELANO
      into pelicula_detalles
      from pelicula p 
      INNER JOIN genero g on p.PELGENERO = g.GENCODIGO
      where pelicula =  p.PELCODIGO;

      RETURN(pelicula_detalles); 
      
END desc_pel;

select desc_pel(1012) from dual;

/*procedimientos*/



CREATE OR REPLACE PROCEDURE welcome_msg (p_name IN VARCHAR2) 
IS
BEGIN
dbms_output.put_line ('Welcome'|| p_name);
End;

EXEC welcome_msg ('Guru99');


select name from v$database;

/* sacar el bck -> exp  USERID=usuario/usuario FULL=y FILE=myfull.dmp */





















 
 (