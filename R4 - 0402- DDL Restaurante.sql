drop table reserva
drop table horario_mesa
drop table horario
drop table mesa
drop table promocion
drop table detalle_pedido
drop table pedido
drop table producto
drop table sucursal

create table sucursal
(
 idSucursal			integer			not null	identity(1,1),
 nombre				varchar(40)	not null,
 primary key (idSucursal),
 unique(nombre)
)
go

create table horario
(
 idHorario			integer			not null	identity(1,1),
 horario			time			not null,
 primary key(idHorario), 
 unique(horario)
)
go
--Elimine la fecha

create table mesa
(
 idMesa				integer			not null identity(1, 1), 
 idSucursal			integer			not null,
 comensales			tinyint			not null,
 primary key(idMesa, idSucursal),
 foreign key(idSucursal) references sucursal,
 check (comensales > 0)
)
go

create table horario_mesa
(
 idHorario			integer			not null,
 idMesa				integer			not null,
 idSucursal			integer			not null,
 primary key(idHorario, idMesa,  idSucursal),
 foreign key (idHorario) references horario,
 foreign key (idMesa, idSucursal) references mesa
)
go
--
create table promocion
(
 idPromocion		integer			not null	identity(1,1),
 idSucursal			integer			not null,
 nombre				varchar(40)		not null,
 descripcion		varchar(255)	not null,
 vigente			char(1)			not null,
 primary key(idPromocion),
 foreign key(idSucursal) references sucursal,
 check (vigente in('S','N'))
)
go

create table reserva
(
 idReserva			integer			not null	identity(1,1),
 idSucursal			integer			not null,
 idPromocion		integer			null,
 fecha				date			not null,
 idHorario			integer			not null,
 idMesa				integer			not null, 
 fechaRegistro		datetime		not null,
 nombreCliente		varchar(40)		not null,
 emailCliente		varchar(255)	not null,
 telefonoCliente	varchar(50)		not null,
 confirmado			char(1)			not null,
 anulado			char(1)			not null,
 primary key (idReserva),
 foreign key (idHorario, idMesa,  idSucursal) references horario_mesa,
 foreign key (idPromocion) references promocion,
 check (confirmado in ('S','N')),
 check (anulado in ('S','N')),
)
go

create table pedido
(
 idPedido				integer			not null	identity(1,1),
 nombreCliente			varchar(40)		not null,
 emailCliente			varchar(255)	not null,
 direccionCliente		varchar(255)	not null,
 idSucursal				integer			not null,
 fecha					date			not null,
 horarioEntrega			time			not null,
 fechaRegistro			datetime		null,
 retira					char(1)			not null,
 anulado				char(1)			not null,
 importeTotal			decimal(4,2)	not null,
 primary key (idPedido),
 foreign key (idSucursal) references sucursal,
 check (retira in ('S','N')),
 check (anulado in ('S','N')),
 check (importeTotal > 0),
)
go


create table producto
(
 idProducto				integer				not null	identity(1,1),
 nombre					varchar(40)			not null,
 descripcion			varchar(255)		not null,
 precio					decimal(6,2)		not null,
 primary key (idProducto),
 check (precio > 0)
)
go

create table detalle_pedido
(
 idProducto				integer				not null,
 idPedido				integer				not null,
 cantidad				tinyint				not null,
 precio					decimal(4,2)		not null,
 primary key (idProducto, idPedido),
 foreign key (idProducto) references producto,
 foreign key (idPedido) references pedido,
 check (cantidad > 0),
 check (precio > 0)
 )
go

