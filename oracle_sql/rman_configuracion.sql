create user usuario2 IDENTIFIED by usuario2;

GRANT CONNECT,resource,unlimited tablespace to usuario2;

/*alteral el archivelog */

archive log list;
show parameter log_archive;
alter system set log_archive_dest_1='location=/home/oracle/oracle_rman/' scope=spfile;


/*en el rman para activar el archivelog y haga el backup */

shutdown immediate;
startup mount;
alter  database archivelog;
alter database open;

/*rman> backup database,*/

/*para desactivar*/


shutdown immediate;
startup mount;
alter  database no archivelog;
alter database open;

