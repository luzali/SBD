drop table sucursal_tipo_servicio
drop table tipo_servicio
drop table detalle_producto
drop table cliente_preferencia
drop table producto_preferencia

drop table reserva
drop table pedido
drop table producto
drop table preferencia
drop table cliente
drop table sucursal
drop table restaurante

drop table zona
drop table localidad
drop table provincia

--go

--ok
create table provincia
(
 idProvincia		integer			not null	identity(1,1),
 nombre				varchar(100)	not null,
 primary key (idProvincia),
)
go

/*
create table ciudad
(
 idCiudad			integer			not null	identity(1,1),
 idProvincia		integer			not null,
 nombre				varchar(100)	not null,
 primary key (idCiudad),
 foreign key (idProvincia) references provincia,
)
go
*/

--ok
create table localidad
(
 idLocalidad		integer			not null	identity(1,1),
 idProvincia		integer			not null,
 nombre				varchar(100)	not null,
 primary key (idLocalidad),
 foreign key (idProvincia) references provincia,
)
go

--ok
create table zona
(
 idZona				integer			not null	identity(1,1),
 idLocalidad		integer			not null,
 nombre				varchar(100)	not null,
 primary key (idZona),
 foreign key (idLocalidad) references localidad,
)
go

--ok
create table restaurante
(
 idRestaurante		integer			not null	identity(1,1),
 tecnologia			varchar(100)	not null,
 urlTecnologia		varchar(100)	null,
 nombre				varchar(100)	not null,
 confirmacionEmail	char(1)			not null,
 primary key (idRestaurante),
 check (confirmacionEmail in ('S','N')),
 check(tecnologia in ('JAX-WS','Axis','REST'))
)
go

--ok
create table sucursal
(
 idSucursal			integer			not null	identity(1,1),
 idSucursalResto	integer			not null,
 idRestaurante		integer			not null,
 idZona				integer			null,
 idLocalidad		integer			not null,
 nombre				varchar(100)	not null,
 primary key (idSucursal),
 unique (idSucursalResto),
 foreign key (idRestaurante) references restaurante,
 foreign key (idZona) references zona,
 foreign key (idLocalidad) references localidad
)
go

--ok
create table tipo_servicio
(
 idTipoServicio			tinyint			not null	identity(1,1),
 descripcion			varchar(50)		not null,
 primary key (idTipoServicio),
)
go

--ok
create table sucursal_tipo_servicio
(
 idSucursal			integer			not null,
 idTipoServicio		tinyint			not null,
 primary key (idSucursal, idTipoServicio),
 foreign key (idSucursal) references sucursal,
 foreign key (idTipoServicio) references tipo_servicio,
)
go

--ok
create table cliente
(
 idCliente				integer			not null	identity(1,1),
 nombre					varchar(100)	not null,
 email					varchar(100)	not null,
 contraseña				varchar(50)		not null,
 direccion				varchar(100)	not null,
 telefono				varchar(50)		not null,
 primary key (idCliente),
 unique (email),
)
go


--ok
create table promocion
(
 idPromocion			integer			not null	identity(1,1),
 idSucursal				integer			not null,
 idPromocionresto		integer			not null,
 nombre					varchar(100)	not null,
 descripcion			varchar(100)	not null,
 vigente				char(1)			not null,
 primary key (idPromocion),
 foreign key (idSucursal) references sucursal,
 check (vigente IN ('S', 'N'))
)
go

--ok
create table reserva
(
 idReserva			integer			not null	identity(1,1),
 idReservaResto		integer			not null,
 idCliente			integer			not null,
 idSucursal			integer			not null,
 fecha				date			not null,
 horario			time			not null,
 fechaRegistro		datetime		null,
 comensales			tinyint			not null,
 confirmacionEmail	char(1)			not null,
 anulado			char(1)			not null,
 primary key (idReserva),
 unique (idReservaResto),
 foreign key (idCliente) references cliente,
 foreign key (idSucursal) references sucursal,
 check (confirmacionEmail in ('S','N')),
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
 idProductoResto		integer				not null,
 descripcion			varchar(100)		not null,
 idSucursal				integer				not null,
 precio					decimal(4,2)		not null,
 primary key (idProducto),
 foreign key (idSucursal) references sucursal,
 check (precio > 0),
)
go

--ok
create table detalle_producto
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
 idPreferencia				integer			not null	identity(1,1),
 descripcion				varchar(50)		not null,
 primary key (idPreferencia)
)
go

--ok
create table cliente_preferencia
(
 idCliente					integer			not null,
 idPreferencia				integer			not null,
 primary key (idCliente, idPreferencia),
 foreign key (idCliente) references cliente,
 foreign key (idPreferencia) references preferencia
)
go

--ok
create table sucursal_preferencia
(
 idPreferencia				integer			not null	identity(1,1),
 idSucursal					integer			not null,
 idSucursalResto			tinyint			not null,
 idOfertaResto				integer			not null,
 primary key (idPreferencia, idSucursal),
 foreign key (idPreferencia) references preferencia,
 foreign key (idSucursal) references sucursal
)
go
