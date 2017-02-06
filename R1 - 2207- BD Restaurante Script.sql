--drop table producto_preferencia
--drop table preferencia
--drop table detalle_producto
--drop table producto
--drop table horario_sucursal
--drop table horario
--drop table mesa
--drop table detalle_reserva
--drop table reserva
--drop table pedido
--drop table cliente
--drop table sucursal

--go

--ok
create table cliente
(
 idCliente				integer			not null	identity(1,1),
 nombre					varchar(100)	not null,
 email					varchar(100)	not null,
 direccion				varchar(100)	not null,
 telefono				varchar(50)		not null,
 primary key (idCliente),
 unique (email),
)
go

--ok
create table sucursal
(
 idSucursal			integer			not null	identity(1,1),
 nombre				varchar(100)	not null,
 primary key (idSucursal),
)
go

--ok
create table horario
(
 idHorario			integer			not null	identity(1,1),
 horarioInicio		time			not null,
 horarioFin			time			not null,
 primary key(idHorario)
)
go

-- VER!
create table horario_sucursal
(
 idHorario			integer			not null,
 idSucursal			integer			not null,
 primary key(idHorario, idSucursal),
 foreign key (idSucursal) references sucursal,
 foreign key (idHorario) references horario
)
go

--ok
create table mesa
(
 idMesa				integer			not null,
 idSucursal			integer			not null,
 comensales			tinyint			not null,
 primary key(idMesa, idSucursal),
 foreign key(idSucursal) references sucursal,
 check (comensales > 0)
)
go

--ok
create table reserva
(
 idReserva			integer			not null	identity(1,1),
 idCliente			integer			not null,
 idSucursal			integer			not null,
 fecha				date			not null,
 horario			time			not null,
 fechaRegistro		datetime		null,
 confirmado			char(1)			not null,
 anulado			char(1)			not null,
 primary key (idReserva),
 foreign key (idCliente) references cliente,
 foreign key (idSucursal) references sucursal,
 check (confirmado in ('S','N')),
 check (anulado in ('S','N')),
)
go

--ok
create table detalle_reserva(
 idMesa				integer			not null,
 idSucursal			integer			not null,
 idReserva			integer			not null,
 primary key (idMesa, idSucursal, idReserva), 
 foreign key (idMesa, idSucursal) references mesa,
 foreign key (idReserva) references reserva
)
go

--ok
create table pedido
(
 idPedido				integer			not null	identity(1,1),
 idCliente				integer			not null,
 idSucursal				integer			not null,
 fecha					date			not null,
 horarioEntrega			time			not null,
 fechaRegistro			datetime		null,
 retira					char(1)			not null,
 anulado				char(1)			not null,
 importeTotal			decimal(4,2)	not null,
 primary key (idPedido),
 foreign key (idCliente) references cliente,
 foreign key (idSucursal) references sucursal,
 check (retira in ('S','N')),
 check (anulado in ('S','N')),
 check (importeTotal > 0),
)
go

-- ver or exclusivo
create table producto
(
 idProducto				integer				not null	identity(1,1),
 descripcion			varchar(100)		not null,
 precio					decimal(4,2)		not null,
 primary key (idProducto),
 check (precio > 0),
)
go

--ok
create table detalle_pedido
(
 idProducto				integer				not null,
 idPedido				integer				not null,
 cantidad				tinyint				not null,
 primary key (idProducto, idPedido),
 foreign key (idProducto) references producto,
 foreign key (idPedido) references pedido,
 check (cantidad > 0),
 )
go

--ok
create table preferencia
(
 idPreferencia				tinyint			not null	identity(1,1),
 descripcion				varchar(50)		not null,
 primary key (idPreferencia),
)
go

--ok
create table producto_preferencia
(
 idProducto					integer			not null,
 idPreferencia				tinyint			not null,
 primary key (idProducto, idPreferencia),
 foreign key (idProducto) references producto,
 foreign key (idPreferencia) references preferencia,
)
go



