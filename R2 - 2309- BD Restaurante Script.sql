
--drop table preferencia
--drop table detalle_pedido

--drop table producto_preferencia
--drop table producto
--drop table horario_mesa
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
 fecha				date			not null,
 primary key(idHorario)
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


create table horario_mesa
(
 idHorario			integer			not null,
 idMesa				integer			not null,
 idSucursal			integer			not null,
 reservada			char(1)			not null,
 primary key(idHorario, idMesa,  idSucursal),
 foreign key (idHorario) references horario,
 foreign key (idMesa, idSucursal) references mesa,
 check (reservada in ('S','N'))
)
go

--ok
create table promocion
(
 idPromocion		integer			not null	identity(1,1),
 idSucursal			integer			not null,
 descripcion		varchar(100)	not null,
 vigente			char(1)			not null,
 primary key(idPromocion),
 foreign key(idSucursal) references sucursal,
 check (vigente in('S','N'))
)
go


--ok
create table reserva
(
 idReserva			integer			not null	identity(1,1),
 idCliente			integer			not null,
 idHorario			integer			not null,
 idMesa				integer			not null,
 idSucursal			integer			not null, 
 fechaRegistro		datetime		null,
 confirmado			char(1)			not null,
 anulado			char(1)			not null,
 primary key (idReserva),
 foreign key (idCliente) references cliente,
 foreign key (idHorario, idMesa,  idSucursal) references horario_mesa,
 check (confirmado in ('S','N')),
 check (anulado in ('S','N')),
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
create table oferta_gastronomica
(
 idOferta					tinyint			not null	identity(1,1),
 descripcion				varchar(50)		not null,
 primary key (idOferta)
)
go

--ok
create table oferta_scursal
(
 idSucursal					integer			not null,
 idOferta					tinyint			not null,
 primary key (idSucursal, idOferta),
 foreign key (idSucursal) references sucursal,
 foreign key (idOferta) references oferta_gastronomica
)
go

