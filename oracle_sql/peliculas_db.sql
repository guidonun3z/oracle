Create table Genero
	(gencodigo number (3),
	gennombre varchar (30) not null,
	constraint pk_gencodigo primary key (gencodigo),
	constraint un_gennombre unique (gennombre));

Create Table Pelicula
	(pelcodigo number (6),
	pelnombre varchar (50) not null,
	pelgenero number (3) not null,
	pelresumen varchar(200) ,
	pelano number (4),
	constraint pk_pelcodigo primary key (pelcodigo),
	constraint ch_pelano check (pelano > 1900),
        constraint fk_gencodigo foreign key (pelgenero) 
                   references genero (gencodigo));

Create table Pais
	(paiscodigo number (3),
	paisnombre varchar (30) not null,
	paisnacionalidad varchar (30) not null,
	constraint pk_paiscodigo primary key (paiscodigo),
	constraint un_paisnombre unique (paisnombre));

Create table Persona
	(percodigo number (5),
	pernombre varchar (30) not null,
	perapellido varchar (30) not null,
	pernacion number (3) not null,
	persexo varchar (1) not null,
	perfecnac date,
	perfecfal date,
	constraint pk_percodigo primary key (percodigo),
	constraint ch_persexo check (persexo in ('M', 'F')),
	constraint fk_pernacion foreign key (pernacion) 
                   references pais (paiscodigo));

Create table Participacion
	(percodigo number (5),
	pelcodigo number (6),
	partipo char (1) not null,
	constraint pk_participacion primary key
                   (percodigo, pelcodigo, partipo),
	constraint ch_partipo check (partipo in ('P', 'D', 'A')),
	constraint fk_percodigo foreign key (percodigo) 
                   references persona (percodigo),
	constraint fk_pelcodigo foreign key (pelcodigo) 
                   references pelicula (pelcodigo));


Create table idioma
	(idiocodigo number (2),
	idionombre varchar(30) not null,
	constraint pk_idiocodigo primary key (idiocodigo),
	constraint un_idionombre unique (idionombre));

Create table Ejemplar
	(pelcodigo number (6),
	ejemnumero number (3),
	ejemfecadq date  not null,
	ejemfecbaja date,
	ejemestado char (1) default 'B' not null,
	ejemidioma number (2) default 1,
	ejemsubtitu number (2),
	constraint pk_ejemplar primary key (pelcodigo, ejemnumero),
	constraint fk_pelcodigo2 foreign key (pelcodigo) 
                   references pelicula (pelcodigo),
	constraint ch_ejemestado check
                   (ejemestado in ('B', 'R', 'M')),
	constraint pk_ejemidioma foreign key (ejemidioma) 
                   references idioma (idiocodigo),
	constraint pk_ejemsubtitu foreign key (ejemsubtitu) 
                   references idioma (idiocodigo));


Create table Cliente
	(clicodigo number (6),
	cliapellido varchar (30) not null,
	clinombre varchar (30) not null,
        clidociden varchar (10),
	clidirecc varchar (50) not null,
	clitelfijo number (8),
	clitelmovil number (8),
	clititulo varchar (5) not null,
        clicredito number (4),
	clirelacio number (6),
	constraint pk_clicodigo primary key (clicodigo),
	constraint fk_clirelacio foreign key (clirelacio) 
                   references cliente (clicodigo),
	constraint ch_clititulo check 
                   (clititulo in ('Sr.','Sra.','Srta.','Sres.')));

Create table Prestamo_Cabecera
	(presnumero number (6),
	presfecha date not null,
	clicodigo number (6) not null,
	constraint pk_presnumero primary key (presnumero),
	constraint fk_clicodigo foreign key (clicodigo) 
                   references Cliente (clicodigo));


Create table Prestamo_detalle
	(presnumero number (6),
	presitem number (2),
	pelcodigo number (6) not null,
	ejemnumero number (3) not null,
	presfecdepac date,
	presfecdereal date,
	presimporte number (6,2),
	constraint pk_prestamo primary key (presnumero, presitem),
        constraint fk_presnumero foreign key (presnumero)
                   references prestamo_cabecera (presnumero)
                   on delete cascade,
	constraint fk_pelcodigo3 foreign key (pelcodigo, ejemnumero) 
                   references ejemplar (pelcodigo, ejemnumero));
                   
                   /*Poblar tablas */
                   
                   
                   insert into genero values (1, 'Drama');
insert into genero values (2, 'Comedia');
insert into genero values (3, 'Acción');
insert into genero values (4, 'Ciencia Ficción');
insert into genero values (5, 'Infantil');
insert into genero values (6, 'Suspenso');

insert into pais values (101, 'Perú', 'Peruana');
insert into pais values (102, 'Estados Unidos', 'Estadounidense');
insert into pais values (103, 'España', 'Española');
insert into pais values (104, 'Argentina', 'Argentina');
insert into pais values (105, 'Italia', 'Italiana');
insert into pais values (106, 'Mexico', 'Mexicana');
insert into pais values (107, 'Alemania', 'Alemana');

insert into idioma values (1, 'Español');
insert into idioma values (2, 'Ingles');
insert into idioma values (3, 'Frances');
insert into idioma values (4, 'Aleman');
insert into idioma values (5, 'Italiano');
insert into idioma values (6, 'Portugues');
insert into idioma values (7, 'Ruso');
insert into idioma values (8, 'Japones');

insert into persona values (6,'Diego','Arsuaga',104,'M','04-13-1966' ,null);
insert into persona values (35,'Tatiana','Astengo',101,'F','07-25-1977',null);
insert into persona values (17,'Javier','Bardem',102,'M','10-07-1962',null);
insert into persona values (28,'Michael','Bay',102,'M','07-27-1958', null);
insert into persona values (7,'Diego','Bertie',101,'M','12-30-1969', null);
insert into persona values (23,'Juan Diego','Botto',106,'M','11-05-1962',null);
insert into persona values (19,'John','Cusack',102,'M','06-09-1953', null);
insert into persona values (24,'Leonardo','D Caprio',102,'M','08-23-1974',null);
insert into persona values (3,'Catherine','Deneuve',102,'F','02-19-1954', null);
insert into persona values (14,'Hilary','Duff',102,'F','09-28-1968', null);
insert into persona values (4,'Christian','Duguay',107,'M','10-22-1969',null);
insert into persona values (38,'Hill','Ferrell',102,'M','04-18-1970', null);
insert into persona values (18,'Jeff','Gibs',107,'M','07-04-1967', null);
insert into persona values (12,'Gary','Gray',102,'M','06-17-1960', null);
insert into persona values (37,'Tom','Hanks',102,'M','10-16-1952', null);
insert into persona values (13,'Helen','Hunt',102,'F','05-27-1966',null);
insert into persona values (15,'Isabelle','Huppert',102,'F','03-22-1968',null);
insert into persona values (34,'Samuel','Jackson',102,'M','04-01-1955', null);
insert into persona values (27,'Martin','Lawrence',102,'M','12-29-1951', null);
insert into persona values (32,'Ray','Liotta',105,'M','06-24-1947', '08-16-1999' );
insert into persona values (10,'Francisco','Lombardi',101,'M','07-14-1946',null);
insert into persona values (9,'Federico','Luppi',104,'M','01-23-1954', null);
insert into persona values (20,'John','Malkovich',102,'M','03-06-1942', null);
insert into persona values (21,'John','Mc Tiernan',102,'M','08-26-1959', null);
insert into persona values (8,'Ewar','McGregor',102,'M','09-02-1962', null);
insert into persona values (29,'Michael','Moore',107,'M','12-09-1963', '03-29-2002' );
insert into persona values (16,'Jack','Nicholson',102,'M','10-12-1943', null);
insert into persona values (11,'Francois','Ozon',102,'M','10-31-1961', null);
insert into persona values (36,'Todd','Phillips',102,'M','06-15-1965', null);
insert into persona values (31,'Peyton','Reed',102,'M','04-23-1960', null);
insert into persona values (5,'Devon','Sawa',107,'M','08-05-1969', null);
insert into persona values (39,'Willi','Smith',102,'M','09-18-1959', null);
insert into persona values (22,'John','Travolta',102,'M','07-03-1959', null);
insert into persona values (30,'Paul','Vega',101,'M','02-28-1967', null);
insert into persona values (1,'Alvaro','Velarde',101,'M','06-21-1968', null);
insert into persona values (26,'Mark','Whalberg',102,'M','11-20-1964', null);
insert into persona values (25,'Luke','Wilson',102,'M','05-16-1958', null);
insert into persona values (2,'Bridgette','Wilson-Sampras',107,'F','11-11-1970', null);
insert into persona values (33,'Reneé','Zellweger',102,'F','03-10-1976', null);


insert into pelicula values (1001,'Aquellos viejos tiempos / Old scholl',2,null,2004);
insert into pelicula values (1002,'8 Mujeres / 8 femmes',6,null,2002);
insert into pelicula values (1003,'Basico y Letal / Basic',3,null,2003);
insert into pelicula values (1004,'Bad Boys 2 vuelven mas rebeldes',3,	null,2003);
insert into pelicula values (1005,'Abajo el amor',2,null,2003);
insert into pelicula values (1006,'Corazón de Fuego',1,null,2002);
insert into pelicula values (1007,'La estafa maestra',3,null,2004);
insert into pelicula values (1008,'Paloma de Papel',1,null,2004);
insert into pelicula values (1009,'Sendero de Sangre',3,null,2002);
insert into pelicula values (1010,'Lizzie Mcguire',2,null,2003);
insert into pelicula values (1011,'Identidad',6,null,2003);
insert into pelicula values (1012,'El destino no tiene favoritos',2,null,2004);
insert into pelicula values (1013,'Bowling For Columbine ',3,null,2002);
insert into pelicula values (1014,'Desafio extremo',3,null,2002);
insert into pelicula values (1015,'Mejor Imposible',1,null,1999);
insert into pelicula values (1016,'Atrápame si puedes',2,null,2001);
insert into pelicula values (1017,'Naufrago',1,null,1998);
insert into pelicula values (1018,'Filadelfia',1,null,1992);
insert into pelicula values (1019,'Apollo XIII',3,null,1993);
insert into pelicula values (1020,'Tornado',3,null,1998);

insert into participacion values (25,1001,'A');
insert into participacion values (38,1001,'A');
insert into participacion values (36,1001,'D');
insert into participacion values (3, 1002,'A');
insert into participacion values (15,1002,'A');
insert into participacion values (11,1002,'D');
insert into participacion values (22,1003,'A');
insert into participacion values (34,1003,'A');
insert into participacion values (21,1003,'D');
insert into participacion values (39,1004,'A');
insert into participacion values (27,1004,'A');
insert into participacion values (28,1004,'D');
insert into participacion values (33,1005,'A');
insert into participacion values (8, 1005,'A');
insert into participacion values (31,1005,'D');
insert into participacion values (9, 1006,'A');
insert into participacion values (6, 1006,'D');
insert into participacion values (26,1007,'A');
insert into participacion values (12,1007,'D');
insert into participacion values (7, 1008,'A');
insert into participacion values (35,1008,'A');
insert into participacion values (10,1008,'D');
insert into participacion values (17,1009,'A');
insert into participacion values (23,1009,'A');
insert into participacion values (20,1009,'D');
insert into participacion values (14,1010,'A');
insert into participacion values (21,1010,'D');
insert into participacion values (19,1011,'A');
insert into participacion values (32,1011,'A');
insert into participacion values (19,1011,'D');
insert into participacion values (30,1012,'A');
insert into participacion values (35,1012,'A');
insert into participacion values (1, 1012,'D');
insert into participacion values (18,1013,'A');
insert into participacion values (29,1013,'D');
insert into participacion values (5, 1014,'A');
insert into participacion values (2, 1014,'A');
insert into participacion values (4, 1014,'D');
insert into participacion values (13,1015,'A');
insert into participacion values (16,1015,'A');
insert into participacion values (28,1015,'D');
insert into participacion values (37,1016,'A');
insert into participacion values (24,1016,'A');
insert into participacion values (21,1016,'D');
insert into participacion values (37,1017,'A');
insert into participacion values (37,1017,'D');
insert into participacion values (37,1018,'A');
insert into participacion values (36,1018,'D');
insert into participacion values (37,1019,'A');
insert into participacion values (28,1019,'D');
insert into participacion values (13,1020,'A');
insert into participacion values (12,1020,'D');

insert into ejemplar values (1001,1,'05-16-2001',null,	 'B',1,null);
insert into ejemplar values (1001,2,'10-27-2002',null,	 'B',2,1);
insert into ejemplar values (1001,3,'01-03-2003',null,	 'B',2,1);
insert into ejemplar values (1002,1,'10-15-2003',null,	 'B',3,1);
insert into ejemplar values (1002,2,'10-27-2002',null,	 'B',1,null);
insert into ejemplar values (1003,1,'05-16-2001','05-05-2003','M',2,1);
insert into ejemplar values (1003,2,'05-16-2001',null,	 'B',2,1);
insert into ejemplar values (1003,3,'01-03-2003',null,	 'B',2,1);
insert into ejemplar values (1004,1,'10-27-2002',null,	 'B',2,1);
insert into ejemplar values (1004,2,'10-27-2002',null,	 'B',2,1);
insert into ejemplar values (1005,1,'10-15-2003',null,	 'B',2,1);
insert into ejemplar values (1005,2,'10-15-2003',null,	 'B',1,null);
insert into ejemplar values (1006,1,'05-16-2001',null,	 'B',1,null);
insert into ejemplar values (1006,2,'05-16-2001',null,	 'B',1,null);
insert into ejemplar values (1007,1,'05-16-2001',null,	 'B',2,1);
insert into ejemplar values (1007,2,'10-27-2002',null,	 'R',2,1);
insert into ejemplar values (1007,3,'10-27-2002',null,	 'B',2,1);
insert into ejemplar values (1007,4,'05-16-2001',null,	 'B',1,null);
insert into ejemplar values (1008,1,'05-16-2001',null,	 'B',1,null);
insert into ejemplar values (1008,2,'01-03-2003',null,	 'B',1,null);
insert into ejemplar values (1009,1,'10-15-2003',null,	 'B',2,1);
insert into ejemplar values (1010,1,'10-27-2002',null,	 'B',2,1);
insert into ejemplar values (1010,2,'10-27-2002',null,	 'B',2,1);
insert into ejemplar values (1011,1,'01-03-2003',null,	 'B',2,1);
insert into ejemplar values (1012,1,'05-16-2001',null,	 'B',1,null);
insert into ejemplar values (1012,2,'05-16-2001','07-16-2003','M',1,null);
insert into ejemplar values (1013,1,'05-16-2001',null,	 'B',4,null);
insert into ejemplar values (1013,2,'01-03-2003',null,	 'B',4,1);
insert into ejemplar values (1013,3,'10-27-2002',null,	 'B',1,null);
insert into ejemplar values (1014,1,'10-27-2002',null,	 'B',4,1);
insert into ejemplar values (1014,2,'10-15-2003',null,	 'B',1,null);
insert into ejemplar values (1015,1,'05-16-2001',null,	 'B',2,1);
insert into ejemplar values (1015,2,'05-16-2001',null,	 'B',2,1);
insert into ejemplar values (1016,1,'05-16-2001',null,	 'R',2,1);
insert into ejemplar values (1016,2,'01-03-2003',null,	 'B',1,null);
insert into ejemplar values (1016,3,'10-27-2002',null,	 'B',2,1);
insert into ejemplar values (1017,1,'10-27-2002',null,	 'B',2,1);
insert into ejemplar values (1017,2,'10-15-2003',null,	 'B',2,1);
insert into ejemplar values (1018,1,'05-16-2001',null,	 'B',1,null);
insert into ejemplar values (1019,1,'05-16-2001',null,	 'B',2,1);
insert into ejemplar values (1020,1,'10-15-2003',null,	 'B',2,1);

insert into cliente values (	100001,	'Vargas Mendoza',	'Rafael Honorio',	'40283056',	'Alfonso Ugarte 200',	428424,	null,	'Sr.',40,	null);
insert into cliente values (	100002,	'Delgado  Medina',	'Sandy  Fabiola',	null,	'Av. 13 de junio 408',	423327,	9563245,	'Srta.',34,	null);
insert into cliente values (	100003,	'Cornejo Valdivia',	'Shirely Beatriz',	'88032405',	'Av. Arequipa 1014',	265003,	null,	'Srta.',40,	null);
insert into cliente values (	100004,	'Martín Valdivia',	'Carolina',	'29676047',	'Av. Arequipa 917',	264834,	null,	'Sra.',15,	null);
insert into cliente values (	100005,	'Arias Padilla',	'Diego Fabián',	null,	'Av. Mariscal Castilla 104',	286472,	null,	'Sr.',20,	null);
insert into cliente values (	100006,	'Mamani  Hallasi',	'Luis  Herickson',	null,	'Calle Berlín 216',	452577,	9652487,	'Sr.',40,	null);
insert into cliente values (	100007,	'Apaza Llacsa',	'Gleny Sabrina',	'41048762',	'Calle San Camilo 303 Int.',	944236,	null,	'Srta.',15,	null);
insert into cliente values (	100008,	'Delgado Luna',	'Olinda Sujey',	'40392911',	'Coop. Universitaria C-12-A',	205375,	null,	'Sra.',20,	null);
insert into cliente values (	100009,	'Tello Baldarrago',	'Juan Manuel',	null,	'Chachapoyas 513',	436280,	null,	'Sr.',25,	null);
insert into cliente values (	100010,	'Cuadros Díaz',	 'Juan Carlos',	'40726286',	'Chullo 852',	257274,	9485263,	'Sr.',50,	null);
insert into cliente values (	100011,	'Valdivia Tejada',	'Roger Giancarlo',	null,	'Hipólito Unanue  102',	200904,	null,	'Sr.',35,	null);
insert into cliente values (	100012,	'Mérida Valdivia',	'Antonio Manuel',	'41247003',	'La Melgariana I-11  J',	426460,	null,	'Sr.',25,	null);
insert into cliente values (	100013,	'Mérida Carrasco',	'Lourdes',	null,	'La Melgariana I-11  J',	426460,	null,	'Srta.',40,	100012);
insert into cliente values (	100014,	'Mérida Carrasco',	'María Angélica',	null,	'La Melgariana I-11  J',	426460,	null,	'Srta.',15,	100012);
insert into cliente values (	100015,	'González Salazar',	'Juan Carlos',	'40213689',	'Las Dalias 111',	256692,	null,	'Sr.',25,	null);
insert into cliente values (	100016,	'Noboa Chirinos',	'Lucía',	'45684527',	'Los Cerezos 111',	251865,	null,	'Srta.',25,	null);
insert into cliente values (	100017,	'Noboa Chirinos',	'Andrea',	null,	'Los Cerezos 111',	251865,	null,	'Srta.',35,	100016);
insert into cliente values (	100018,	'Rodriguez Zambrano',	' Carmen',	'29710822',	'Los Laureles Ñ-36',	420064,	null,	'Srta.',null,	null);
insert into cliente values (	100019,	'Chávez Macedo',	'Jeesica Maribel',	'29619711',	'Malecón Socabaya 115',	205079,	null,	'Srta.',30,	null);
insert into cliente values (	100020,	'Zegarra Ordoñez',	'Olga Elvira',	'26251485',	'Pizarro 210',	460968,	null,	'Sra.',30,	null);
insert into cliente values (	100021,	'Huertas Zegarra',	 'Carlos Manuel',	null,	'Pizarro 210',	460968,	null,	'Sr.',	35,100020);
insert into cliente values (	100022,	'Huertas Zegarra',	'Lisandro',	null,	'Pizarro 210',	460968,	null,	'Sr.',25,	100020);
insert into cliente values (	100023,	'Huertas Zegarra',	'Adriana',	null,	'Pizarro 210',	460968,	null,	'Srta.',25,	100020);
insert into cliente values (	100024,	'Palacios Monje',	'Johanna Karina',	'41249282',	'Recidencial Nicolás de Pierola 2da. Etapa B4-16',	202845,	null,	'Sra.',null,	null);
insert into cliente values (	100025,	'Apaza Quispe',	'Luz Marina',	'41165443',	'San José de Tiabaya Comite 8 Lt.9 Mz.LL',	607341,	null,	'Srta.',25,	null);
insert into cliente values (	100026,	'Aguilar Zegarra',	'Cecilia Diana',	'29685823',	'Urb 15 de enero. Alto Buena Vista',	435330,	null,	'Srta.',40,	null);
insert into cliente values (	100027,	'Roller Rivera',	'Paola Karinna',	'29658280',	'Urb. ADEPA H-1',	426376,	9654125,	'Srta.',25,	null);
insert into cliente values (	100028,	'Quispe Pacheco',	'Amparo Consuelo',	'29618016',	'Urb. Campiña Dorada A-6',	202898,	9638521,	'Srta.',15,	null);
insert into cliente values (	100029,	'Meza Lovón',	'Graciela Lecireth',	'40222974',	'Urb. Cerro Colorado V-2',	259176,	null,	'Sra.',	25,null);
insert into cliente values (	100030,	'Benavides López',	'Sergio Fabrizio',	'41455724',	'Urb. Guardia Civil M-6',	697399,	null,	'Sr.',	null,null);
insert into cliente values (	100031,	'Quiroz Rodríguez',	'Larry Javier',	'29421573',	'Urb. Juventud Ferroviaria  N-19',	201636,	null,	'Sr.',35,	null);
insert into cliente values (	100032,	'Lizárraga Delgado',	'Victor Abel',	'41228996',	'Urb. Lambramani A-17',	283962,	null,	'Sr.',25,	null);
insert into cliente values (	100033,	'Jaramillo Odam',	'Jenny',	null,	'Urb. Las Casuarinas E-16',	253135,	9624586,	'Sra.',	15,null);
insert into cliente values (	100034,	'Núñez Ampuero',	'Dante Enrique',	'29714904',	'Urb. Los Independientes B-4',	251692,	null,	'Sr.',	25,null);
insert into cliente values (	100035,	'Alcázar Belaunde',	'Joaquín Alonso',	null,	'Urb. Santa Sofia A-2',	255634,	null,	'Sr.',35,	null);
insert into cliente values (	100036,	'Jalsovec  Sánchez',	'Ingrid Brusella',	'41085825',	'Urb. Señorial I-5',	254785,	null,	'Srta.',	40,null);
insert into cliente values (	100037,	'Calderón Aranibar',	'Mitchela Karin',	'40120646',	'Urb. Tahuaycani a-13',	251276,	9658741,	'Sra.',25,	null);
insert into cliente values (	100038,	'Valdivia Silva',	'Jessica',	'40136868',	'Urb. Victor Andrés Belaunde G-4',	272589,	null,	'Sra.',35,	null);

insert into prestamo_cabecera values (	501,	'03-21-2003',	100033);
insert into prestamo_cabecera values (	502,	'03-21-2003',	100022);
insert into prestamo_cabecera values (	503,	'03-21-2003',	100038);
insert into prestamo_cabecera values (	504,	'03-22-2003',	100016);
insert into prestamo_cabecera values (	505,	'03-22-2003',	100037);
insert into prestamo_cabecera values (	506,	'03-22-2003',	100010);
insert into prestamo_cabecera values (	507,	'03-22-2003',	100027);
insert into prestamo_cabecera values (	508,	'03-22-2003',	100036);
insert into prestamo_cabecera values (	509,	'03-23-2003',	100009);
insert into prestamo_cabecera values (	510,	'03-23-2003',	100038);
insert into prestamo_cabecera values (	511,	'03-23-2003',	100022);
insert into prestamo_cabecera values (	512,	'03-23-2003',	100012);
insert into prestamo_cabecera values (	513,	'03-24-2003',	100034);
insert into prestamo_cabecera values (	514,	'03-24-2003',	100007);
insert into prestamo_cabecera values (	515,	'03-24-2003',	100023);
insert into prestamo_cabecera values (	516,	'03-24-2003',	100031);
insert into prestamo_cabecera values (	517,	'03-24-2003',	100021);
insert into prestamo_cabecera values (	518,	'03-24-2003',	100036);
insert into prestamo_cabecera values (	519,	'03-25-2003',	100014);
insert into prestamo_cabecera values (	520,	'03-25-2003',	100010);
insert into prestamo_cabecera values (	521,	'03-25-2003',	100028);
insert into prestamo_cabecera values (	522,	'03-26-2003',	100031);
insert into prestamo_cabecera values (	523,	'03-26-2003',	100032);
insert into prestamo_cabecera values (	524,	'03-26-2003',	100013);
insert into prestamo_cabecera values (	525,	'03-26-2003',	100001);
insert into prestamo_cabecera values (	526,	'03-26-2003',	100021);
insert into prestamo_cabecera values (	527,	'03-27-2003',	100001);
insert into prestamo_cabecera values (	528,	'03-27-2003',	100013);
insert into prestamo_cabecera values (	529,	'03-27-2003',	100026);
insert into prestamo_cabecera values (	530,	'03-27-2003',	100022);
insert into prestamo_cabecera values (	531,	'03-28-2003',	100002);
insert into prestamo_cabecera values (	532,	'03-28-2003',	100002);
insert into prestamo_cabecera values (	533,	'03-28-2003',	100006);
insert into prestamo_cabecera values (	534,	'03-28-2003',	100028);
insert into prestamo_cabecera values (	535,	'03-28-2003',	100016);
insert into prestamo_cabecera values (	536,	'03-28-2003',	100022);
insert into prestamo_cabecera values (	537,	'03-29-2003',	100020);
insert into prestamo_cabecera values (	538,	'03-29-2003',	100006);
insert into prestamo_cabecera values (	539,	'03-29-2003',	100037);
insert into prestamo_cabecera values (	540,	'03-30-2003',	100017);
insert into prestamo_cabecera values (	541,	'03-30-2003',	100009);
insert into prestamo_cabecera values (	542,	'03-30-2003',	100031);
insert into prestamo_cabecera values (	543,	'03-30-2003',	100021);
insert into prestamo_cabecera values (	544,	'03-30-2003',	100036);
insert into prestamo_cabecera values (	545,	'03-30-2003',	100012);
insert into prestamo_cabecera values (	546,	'03-31-2003',	100014);
insert into prestamo_cabecera values (	547,	'03-31-2003',	100005);
insert into prestamo_cabecera values (	548,	'03-31-2003',	100038);
insert into prestamo_cabecera values (	549,	'03-31-2003',	100020);
insert into prestamo_cabecera values (	550,	'03-31-2003',	100034);
insert into prestamo_cabecera values (	551,	'04-01-2003',	100010);
insert into prestamo_cabecera values (	552,	'04-01-2003',	100028);
insert into prestamo_cabecera values (	553,	'04-01-2003',	100018);
insert into prestamo_cabecera values (	554,	'04-01-2003',	100020);
insert into prestamo_cabecera values (	555,	'04-01-2003',	100033);
insert into prestamo_cabecera values (	556,	'04-02-2003',	100037);
insert into prestamo_cabecera values (	557,	'04-02-2003',	100012);
insert into prestamo_cabecera values (	558,	'04-02-2003',	100018);
insert into prestamo_cabecera values (	559,	'04-02-2003',	100034);
insert into prestamo_cabecera values (	560,	'04-02-2003',	100026);
insert into prestamo_cabecera values (	561,	'04-02-2003',	100032);
insert into prestamo_cabecera values (	562,	'04-02-2003',	100010);
insert into prestamo_cabecera values (	563,	'04-03-2003',	100034);
insert into prestamo_cabecera values (	564,	'04-03-2003',	100013);
insert into prestamo_cabecera values (	565,	'04-03-2003',	100002);
insert into prestamo_cabecera values (	566,	'04-03-2003',	100017);
insert into prestamo_cabecera values (	567,	'04-04-2003',	100033);
insert into prestamo_cabecera values (	568,	'04-04-2003',	100031);
insert into prestamo_cabecera values (	569,	'04-04-2003',	100001);
insert into prestamo_cabecera values (	570,	'04-04-2003',	100012);
insert into prestamo_cabecera values (	571,	'04-04-2003',	100027);
insert into prestamo_cabecera values (	572,	'04-05-2003',	100006);
insert into prestamo_cabecera values (	573,	'04-05-2003',	100027);
insert into prestamo_cabecera values (	574,	'04-05-2003',	100023);
insert into prestamo_cabecera values (	575,	'04-05-2003',	100033);
insert into prestamo_cabecera values (	576,	'04-05-2003',	100023);
insert into prestamo_cabecera values (	577,	'04-05-2003',	100007);
insert into prestamo_cabecera values (	578,	'04-06-2003',	100021);
insert into prestamo_cabecera values (	579,	'04-06-2003',	100020);
insert into prestamo_cabecera values (	580,	'04-06-2003',	100007);
insert into prestamo_cabecera values (	581,	'04-06-2003',	100037);
insert into prestamo_cabecera values (	582,	'04-07-2003',	100002);
insert into prestamo_cabecera values (	583,	'04-07-2003',	100018);
insert into prestamo_cabecera values (	584,	'04-07-2003',	100014);
insert into prestamo_cabecera values (	585,	'04-08-2003',	100001);
insert into prestamo_cabecera values (	586,	'04-08-2003',	100037);
insert into prestamo_cabecera values (	587,	'04-08-2003',	100014);
insert into prestamo_cabecera values (	588,	'04-08-2003',	100009);
insert into prestamo_cabecera values (	589,	'04-08-2003',	100038);
insert into prestamo_cabecera values (	590,	'04-09-2003',	100012);
insert into prestamo_cabecera values (	591,	'04-09-2003',	100013);
insert into prestamo_cabecera values (	592,	'04-09-2003',	100023);
insert into prestamo_cabecera values (	593,	'04-09-2003',	100005);
insert into prestamo_cabecera values (	594,	'04-10-2003',	100026);
insert into prestamo_cabecera values (	595,	'04-10-2003',	100028);
insert into prestamo_cabecera values (	596,	'04-10-2003',	100032);
insert into prestamo_cabecera values (	597,	'04-10-2003',	100021);
insert into prestamo_cabecera values (	598,	'04-10-2003',	100005);
insert into prestamo_cabecera values (	599,	'04-11-2003',	100020);
insert into prestamo_cabecera values (	600,	'04-11-2003',	100016);
insert into prestamo_cabecera values (	601,	'04-12-2003',	100009);
insert into prestamo_cabecera values (	602,	'04-12-2003',	100016);
insert into prestamo_cabecera values (	603,	'04-12-2003',	100038);
insert into prestamo_cabecera values (	604,	'04-12-2003',	100017);


insert into prestamo_detalle values (	501,	1,	1002,	1,	'03-22-2003','03-22-2003',	4.5);
insert into prestamo_detalle values (	502,	1,	1005,	1,	'03-22-2003','03-22-2003',	4.5);
insert into prestamo_detalle values (	502,	2,	1019,	1,	'03-22-2003','03-22-2003',	4.5);
insert into prestamo_detalle values (	503,	1,	1001,	1,	'03-22-2003','03-22-2003',	4.5);
insert into prestamo_detalle values (	504,	1,	1004,	1,	'03-23-2003','03-23-2003',	4.5);
insert into prestamo_detalle values (	505,	1,	1003,	2,	'03-23-2003','03-24-2003',	9);
insert into prestamo_detalle values (	505,	2,	1013,	3,	'03-23-2003','03-23-2003',	4.5);
insert into prestamo_detalle values (	505,	3,	1006,	2,	'03-23-2003','03-23-2003',	4.5);
insert into prestamo_detalle values (	506,	1,	1016,	1,	'03-23-2003','03-23-2003',	4.5);
insert into prestamo_detalle values (	507,	1,	1014,	2,	'03-23-2003','03-23-2003',	4.5);
insert into prestamo_detalle values (	508,	1,	1012,	1,	'03-23-2003','03-23-2003',	4.5);
insert into prestamo_detalle values (	508,	2,	1018,	1,	'03-23-2003','03-23-2003',	4.5);
insert into prestamo_detalle values (	509,	1,	1011,	1,	'03-24-2003','03-25-2003',	9);
insert into prestamo_detalle values (	510,	1,	1007,	2,	'03-24-2003','03-24-2003',	4.5);
insert into prestamo_detalle values (	511,	1,	1010,	2,	'03-24-2003','03-24-2003',	4.5);
insert into prestamo_detalle values (	511,	2,	1015,	2,	'03-24-2003','03-24-2003',	4.5);
insert into prestamo_detalle values (	512,	1,	1017,	1,	'03-24-2003','03-24-2003',	4.5);
insert into prestamo_detalle values (	513,	1,	1008,	2,	'03-25-2003','03-26-2003',	9);
insert into prestamo_detalle values (	513,	2,	1009,	1,	'03-25-2003','03-26-2003',	9);
insert into prestamo_detalle values (	514,	1,	1020,	1,	'03-25-2003','03-26-2003',	9);
insert into prestamo_detalle values (	515,	1,	1005,	1,	'03-25-2003','03-25-2003',	4.5);
insert into prestamo_detalle values (	516,	1,	1019,	1,	'03-25-2003','03-25-2003',	4.5);
insert into prestamo_detalle values (	516,	2,	1003,	3,	'03-25-2003','03-25-2003',	4.5);
insert into prestamo_detalle values (	517,	1,	1013,	3,	'03-25-2003','03-25-2003',	4.5);
insert into prestamo_detalle values (	517,	2,	1006,	1,	'03-25-2003','03-25-2003',	4.5);
insert into prestamo_detalle values (	518,	1,	1016,	2,	'03-25-2003','03-25-2003',	4.5);
insert into prestamo_detalle values (	519,	1,	1014,	2,	'03-26-2003','03-26-2003',	4.5);
insert into prestamo_detalle values (	520,	1,	1012,	2,	'03-26-2003','03-27-2003',	9);
insert into prestamo_detalle values (	520,	2,	1018,	1,	'03-26-2003','03-26-2003',	4.5);
insert into prestamo_detalle values (	520,	3,	1011,	1,	'03-26-2003','03-26-2003',	4.5);
insert into prestamo_detalle values (	521,	1,	1007,	3,	'03-26-2003','03-26-2003',	4.5);
insert into prestamo_detalle values (	522,	1,	1010,	2,	'03-27-2003','03-27-2003',	4.5);
insert into prestamo_detalle values (	522,	2,	1008,	1,	'03-27-2003','03-28-2003',	9);
insert into prestamo_detalle values (	523,	1,	1009,	1,	'03-27-2003','03-27-2003',	4.5);
insert into prestamo_detalle values (	524,	1,	1020,	1,	'03-27-2003','03-27-2003',	4.5);
insert into prestamo_detalle values (	525,	1,	1002,	2,	'03-27-2003','03-27-2003',	4.5);
insert into prestamo_detalle values (	525,	2,	1005,	1,	'03-27-2003','03-27-2003',	4.5);
insert into prestamo_detalle values (	525,	3,	1019,	1,	'03-27-2003','03-29-2003',	13.5);
insert into prestamo_detalle values (	526,	1,	1001,	3,	'03-27-2003','03-27-2003',	4.5);
insert into prestamo_detalle values (	527,	1,	1004,	2,	'03-28-2003','03-28-2003',	4.5);
insert into prestamo_detalle values (	527,	2,	1003,	1,	'03-28-2003','03-28-2003',	4.5);
insert into prestamo_detalle values (	528,	1,	1016,	2,	'03-28-2003','03-29-2003',	9);
insert into prestamo_detalle values (	529,	1,	1014,	2,	'03-28-2003','03-28-2003',	4.5);
insert into prestamo_detalle values (	530,	1,	1012,	2,	'03-28-2003','03-28-2003',	4.5);
insert into prestamo_detalle values (	530,	2,	1018,	1,	'03-28-2003','03-28-2003',	4.5);
insert into prestamo_detalle values (	530,	3,	1007,	2,	'03-28-2003','03-28-2003',	4.5);
insert into prestamo_detalle values (	530,	4,	1010,	2,	'03-28-2003','03-28-2003',	4.5);
insert into prestamo_detalle values (	531,	1,	1015,	1,	'03-29-2003','03-30-2003',	9);
insert into prestamo_detalle values (	531,	2,	1017,	1,	'03-29-2003','03-30-2003',	9);
insert into prestamo_detalle values (	532,	1,	1008,	2,	'03-29-2003','03-29-2003',	4.5);
insert into prestamo_detalle values (	532,	2,	1009,	1,	'03-29-2003','03-29-2003',	4.5);
insert into prestamo_detalle values (	533,	1,	1002,	2,	'03-29-2003','03-29-2003',	4.5);
insert into prestamo_detalle values (	534,	1,	1005,	1,	'03-29-2003','03-29-2003',	4.5);
insert into prestamo_detalle values (	535,	1,	1001,	2,	'03-29-2003','03-29-2003',	4.5);
insert into prestamo_detalle values (	535,	2,	1004,	2,	'03-29-2003','03-29-2003',	4.5);
insert into prestamo_detalle values (	536,	1,	1003,	3,	'03-29-2003','03-29-2003',	4.5);
insert into prestamo_detalle values (	537,	1,	1006,	1,	'03-30-2003','03-30-2003',	4.5);
insert into prestamo_detalle values (	538,	1,	1016,	2,	'03-30-2003','03-30-2003',	4.5);
insert into prestamo_detalle values (	538,	2,	1012,	2,	'03-30-2003','03-31-2003',	9);
insert into prestamo_detalle values (	539,	1,	1018,	1,	'03-30-2003','03-30-2003',	4.5);
insert into prestamo_detalle values (	540,	1,	1011,	1,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	540,	2,	1010,	2,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	540,	3,	1015,	2,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	541,	1,	1009,	1,	'03-31-2003','04-01-2003',	9);
insert into prestamo_detalle values (	542,	1,	1020,	1,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	542,	2,	1005,	2,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	542,	3,	1019,	1,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	543,	1,	1003,	3,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	543,	2,	1013,	1,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	543,	3,	1006,	2,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	544,	1,	1016,	3,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	545,	1,	1012,	2,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	545,	2,	1018,	1,	'03-31-2003','03-31-2003',	4.5);
insert into prestamo_detalle values (	546,	1,	1011,	1,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	547,	1,	1007,	3,	'04-01-2003','04-02-2003',	9);
insert into prestamo_detalle values (	547,	2,	1010,	2,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	547,	3,	1015,	1,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	547,	4,	1017,	2,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	548,	1,	1009,	1,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	548,	2,	1020,	1,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	549,	1,	1005,	1,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	549,	2,	1019,	1,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	550,	1,	1001,	3,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	550,	2,	1003,	3,	'04-01-2003','04-01-2003',	4.5);
insert into prestamo_detalle values (	551,	1,	1016,	1,	'04-02-2003','04-02-2003',	4.5);
insert into prestamo_detalle values (	552,	1,	1014,	2,	'04-02-2003','04-02-2003',	4.5);
insert into prestamo_detalle values (	552,	2,	1012,	2,	'04-02-2003','04-02-2003',	4.5);
insert into prestamo_detalle values (	553,	1,	1018,	1,	'04-02-2003','04-02-2003',	4.5);
insert into prestamo_detalle values (	554,	1,	1011,	1,	'04-02-2003','04-02-2003',	4.5);
insert into prestamo_detalle values (	554,	2,	1007,	2,	'04-02-2003','04-03-2003',	9);
insert into prestamo_detalle values (	555,	1,	1010,	2,	'04-02-2003','04-02-2003',	4.5);
insert into prestamo_detalle values (	556,	1,	1017,	2,	'04-03-2003','04-03-2003',	4.5);
insert into prestamo_detalle values (	557,	1,	1008,	1,	'04-03-2003','04-03-2003',	4.5);
insert into prestamo_detalle values (	558,	1,	1009,	1,	'04-03-2003','04-03-2003',	4.5);
insert into prestamo_detalle values (	558,	2,	1002,	2,	'04-03-2003','04-05-2003',	13.5);
insert into prestamo_detalle values (	559,	1,	1005,	2,	'04-03-2003','04-03-2003',	4.5);
insert into prestamo_detalle values (	560,	1,	1001,	1,	'04-03-2003','04-03-2003',	4.5);
insert into prestamo_detalle values (	560,	2,	1004,	2,	'04-03-2003','04-03-2003',	4.5);
insert into prestamo_detalle values (	561,	1,	1013,	3,	'04-03-2003','04-03-2003',	4.5);
insert into prestamo_detalle values (	562,	1,	1006,	2,	'04-03-2003','04-03-2003',	4.5);
insert into prestamo_detalle values (	562,	2,	1014,	1,	'04-03-2003','04-03-2003',	4.5);
insert into prestamo_detalle values (	563,	1,	1012,	2,	'04-04-2003','04-04-2003',	4.5);
insert into prestamo_detalle values (	563,	2,	1011,	1,	'04-04-2003','04-04-2003',	4.5);
insert into prestamo_detalle values (	564,	1,	1007,	4,	'04-04-2003','04-05-2003',	9);
insert into prestamo_detalle values (	565,	1,	1010,	1,	'04-04-2003','04-04-2003',	4.5);
insert into prestamo_detalle values (	566,	1,	1017,	2,	'04-04-2003','04-04-2003',	4.5);
insert into prestamo_detalle values (	567,	1,	1002,	2,	'04-05-2003','04-05-2003',	4.5);
insert into prestamo_detalle values (	567,	2,	1005,	2,	'04-05-2003','04-05-2003',	4.5);
insert into prestamo_detalle values (	568,	1,	1019,	1,	'04-05-2003','04-05-2003',	4.5);
insert into prestamo_detalle values (	569,	1,	1001,	2,	'04-05-2003','04-05-2003',	4.5);
insert into prestamo_detalle values (	569,	2,	1004,	2,	'04-05-2003','04-05-2003',	4.5);
insert into prestamo_detalle values (	569,	3,	1003,	3,	'04-05-2003','04-05-2003',	4.5);
insert into prestamo_detalle values (	570,	1,	1013,	1,	'04-05-2003','04-05-2003',	4.5);
insert into prestamo_detalle values (	571,	1,	1006,	2,	'04-05-2003','04-06-2003',	9);
insert into prestamo_detalle values (	571,	2,	1016,	3,	'04-05-2003','04-05-2003',	4.5);
insert into prestamo_detalle values (	572,	1,	1014,	2,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	572,	2,	1012,	1,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	573,	1,	1018,	1,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	574,	1,	1011,	1,	'04-06-2003','04-07-2003',	9);
insert into prestamo_detalle values (	574,	2,	1007,	4,	'04-06-2003','04-07-2003',	9);
insert into prestamo_detalle values (	574,	3,	1010,	1,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	575,	1,	1015,	2,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	576,	1,	1017,	2,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	576,	2,	1008,	2,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	576,	3,	1009,	1,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	577,	1,	1020,	1,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	577,	2,	1005,	2,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	577,	3,	1019,	1,	'04-06-2003','04-06-2003',	4.5);
insert into prestamo_detalle values (	578,	1,	1003,	1,	'04-07-2003','04-07-2003',	4.5);
insert into prestamo_detalle values (	579,	1,	1013,	2,	'04-07-2003','04-07-2003',	4.5);
insert into prestamo_detalle values (	580,	1,	1006,	2,	'04-07-2003','04-07-2003',	4.5);
insert into prestamo_detalle values (	580,	2,	1016,	3,	'04-07-2003','04-07-2003',	4.5);
insert into prestamo_detalle values (	581,	1,	1014,	1,	'04-07-2003','04-08-2003',	9);
insert into prestamo_detalle values (	582,	1,	1012,	2,	'04-08-2003','04-08-2003',	4.5);
insert into prestamo_detalle values (	583,	1,	1018,	1,	'04-08-2003','04-08-2003',	4.5);
insert into prestamo_detalle values (	583,	2,	1011,	1,	'04-08-2003','04-08-2003',	4.5);
insert into prestamo_detalle values (	584,	1,	1007,	1,	'04-08-2003','04-08-2003',	4.5);
insert into prestamo_detalle values (	584,	2,	1010,	2,	'04-08-2003','04-08-2003',	4.5);
insert into prestamo_detalle values (	585,	1,	1008,	1,	'04-09-2003','04-09-2003',	4.5);
insert into prestamo_detalle values (	586,	1,	1009,	1,	'04-09-2003','04-09-2003',	4.5);
insert into prestamo_detalle values (	587,	1,	1020,	1,	'04-09-2003','04-09-2003',	4.5);
insert into prestamo_detalle values (	587,	2,	1002,	2,	'04-09-2003','04-09-2003',	4.5);
insert into prestamo_detalle values (	588,	1,	1005,	2,	'04-09-2003','04-09-2003',	4.5);
insert into prestamo_detalle values (	589,	1,	1019,	1,	'04-09-2003','04-09-2003',	4.5);
insert into prestamo_detalle values (	589,	2,	1001,	1,	'04-09-2003','04-09-2003',	4.5);
insert into prestamo_detalle values (	590,	1,	1004,	2,	'04-10-2003','04-10-2003',	4.5);
insert into prestamo_detalle values (	591,	1,	1003,	3,	'04-10-2003','04-10-2003',	4.5);
insert into prestamo_detalle values (	591,	2,	1016,	3,	'04-10-2003','04-10-2003',	4.5);
insert into prestamo_detalle values (	591,	3,	1014,	1,	'04-10-2003','04-11-2003',	9);
insert into prestamo_detalle values (	592,	1,	1012,	2,	'04-10-2003','04-10-2003',	4.5);
insert into prestamo_detalle values (	593,	1,	1018,	1,	'04-10-2003','04-10-2003',	4.5);
insert into prestamo_detalle values (	594,	1,	1007,	4,	'04-11-2003','04-11-2003',	4.5);
insert into prestamo_detalle values (	594,	2,	1010,	1,	'04-11-2003','04-11-2003',	4.5);
insert into prestamo_detalle values (	594,	3,	1015,	2,	'04-11-2003','04-11-2003',	4.5);
insert into prestamo_detalle values (	595,	1,	1017,	2,	'04-11-2003','04-11-2003',	4.5);
insert into prestamo_detalle values (	596,	1,	1008,	2,	'04-11-2003','04-11-2003',	4.5);
insert into prestamo_detalle values (	597,	1,	1009,	1,	'04-11-2003','04-11-2003',	4.5);
insert into prestamo_detalle values (	597,	2,	1002,	2,	'04-11-2003','04-12-2003',	9);
insert into prestamo_detalle values (	598,	1,	1005,	2,	'04-11-2003','04-11-2003',	4.5);
insert into prestamo_detalle values (	599,	1,	1001,	3,	'04-12-2003','04-12-2003',	4.5);
insert into prestamo_detalle values (	600,	1,	1004,	1,	'04-12-2003','04-12-2003',	4.5);
insert into prestamo_detalle values (	600,	2,	1003,	2,	'04-12-2003','04-12-2003',	4.5);
insert into prestamo_detalle values (	601,	1,	1006,	2,	'04-13-2003',	null,null);
insert into prestamo_detalle values (	602,	1,	1016,	3,	'04-13-2003','04-13-2003',	4.5);
insert into prestamo_detalle values (	602,	2,	1012,	1,	'04-13-2003','04-14-2003',	9);
insert into prestamo_detalle values (	603,	1,	1018,	1,	'04-13-2003',null,null);
insert into prestamo_detalle values (	604,	1,	1011,	1,	'04-13-2003','04-13-2003',	4.5);

/*fk indexes*/


CREATE INDEX fk_gencodigo ON pelicula(pelgenero);

CREATE INDEX fk_pernacion ON persona(pernacion);

CREATE INDEX fk_percodigo ON Participacion(percodigo);
CREATE INDEX fk_pelcodigo ON Participacion(pelcodigo);
CREATE INDEX fk_clirelacio ON Cliente(clirelacio);
CREATE INDEX fk_clicodigo ON Prestamo_cabecera(clicodigo);
CREATE INDEX fk_presnumero ON Prestamo_detalle(presnumero);
CREATE INDEX fk_pelcodigo3 ON Prestamos_detalle(presnumero, presitem);