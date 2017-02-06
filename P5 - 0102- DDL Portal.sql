drop table detalle_pedido
drop table pedido
drop table reserva
drop table promocion
drop table sucursal_tipo_servicio
drop table tipo_servicio
drop table producto
drop table restaurante_preferencia
drop table sucursal
drop table restaurante
drop table zona
drop table localidad
drop table provincia
drop table cliente_preferencia
drop table cliente
drop table preferencia

create table provincia
(
 idProvincia		integer			not null	identity(1,1),
 nombre				varchar(40)	not null,
 primary key (idProvincia)
)
go

create table localidad
(
 idLocalidad		integer			not null	identity(1,1),
 idProvincia		integer			not null,
 nombre				varchar(40)	not null,
 primary key (idLocalidad),
 foreign key (idProvincia) references provincia
)
go

create table zona
(
 idZona				integer			not null	identity(1,1),
 idLocalidad		integer			not null,
 nombre				varchar(40)	not null,
 primary key (idZona),
 foreign key (idLocalidad) references localidad
)
go

create table restaurante
(
 idRestaurante		integer			not null	identity(1,1),
 tecnologia			varchar(10)	not null,
 urlTecnologia		varchar(255)	null,
 nombre				varchar(40)	not null,
 confirmacionEmail	char(1)			not null,
 primary key (idRestaurante),
 check (confirmacionEmail in ('S','N')),
 check(tecnologia in ('JAX-WS','AXIS','REST'))
)
go

create table sucursal
(
 idSucursal			integer			not null	identity(1,1),
 idSucursalResto	integer			not null,
 idRestaurante		integer			not null,
 idZona				integer			not null,
 nombre				varchar(40)	not null,
 primary key (idSucursal),
 unique (idSucursalResto, idRestaurante),
 foreign key (idRestaurante) references restaurante,
 foreign key (idZona) references zona
)
go

create table tipo_servicio
(
 idTipoServicio			tinyint			not null	identity(1,1),
 descripcion			varchar(10)		not null,
 primary key (idTipoServicio)
)
go

create table sucursal_tipo_servicio
(
 idSucursal			integer			not null,
 idTipoServicio		tinyint			not null,
 primary key (idSucursal, idTipoServicio),
 foreign key (idSucursal) references sucursal,
 foreign key (idTipoServicio) references tipo_servicio
)
go

create table cliente
(
 idCliente				integer			not null	identity(1,1),
 nombre					varchar(40)		not null,
 email					varchar(255)	not null,
 contraseña				varchar(50)		not null,
 direccion				varchar(255)	not null,
 telefono				varchar(50)		not null,
 primary key (idCliente),
 unique (email)
)
go

create table preferencia
(
 idPreferencia				integer			not null	identity(1,1),
 descripcion				varchar(50)		not null,
 primary key (idPreferencia)
)
go

create table cliente_preferencia
(
 idCliente					integer			not null,
 idPreferencia				integer			not null,
 primary key (idCliente, idPreferencia),
 foreign key (idCliente) references cliente,
 foreign key (idPreferencia) references preferencia
)
go

create table restaurante_preferencia
(
 idPreferencia				integer			not null,
 idRestaurante				integer			not null,
 primary key (idRestaurante, idPreferencia),
 foreign key (idPreferencia) references preferencia,
 foreign key (idRestaurante) references restaurante,
)
go

create table promocion
(
 idPromocion			integer			not null	identity(1,1),
 idSucursal				integer			not null,
 idPromocionResto		integer			not null,
 nombre					varchar(40)		not null,
 descripcion			varchar(255)	not null,
 vigente				char(1)			not null,
 primary key (idPromocion),
 unique (idPromocionResto, idSucursal),
 foreign key (idSucursal) references sucursal,
 check (vigente IN ('S', 'N'))
)
go

create table reserva
(
 idReserva			integer			not null	identity(1,1),
 idReservaResto		integer			not null,
 idCliente			integer			not null,
 idSucursal			integer			not null,
 idPromocion		integer			null,
 fecha				date			not null,
 horario			time			not null,
 fechaRegistro		smalldatetime	not null,
 comensales			tinyint			not null,
 confirmacionEmail	char(1)			not null,
 anulado			char(1)			not null,
 primary key (idReserva),
 unique (idReservaResto, idSucursal),
 foreign key (idCliente) references cliente,
 foreign key (idSucursal) references sucursal,
 foreign key (idPromocion) references promocion,
 check (confirmacionEmail in ('S','N')),
 check (anulado in ('S','N'))
)
go

create table producto
(
 idProducto				integer				not null	identity(1,1),
 idProductoResto		integer				not null,
 nombre					varchar(40)		not null,
 descripcion			varchar(255)		not null,
 idRestaurante			integer				not null,
 precio					decimal(6,2)		not null,
 primary key (idProducto),
 unique (idProductoResto, idRestaurante),
 foreign key (idRestaurante) references restaurante,
 check (precio > 0)
)
go

create table pedido
(
 idPedido				integer			not null	identity(1,1),
 idPedidoResto			integer			not null,
 idCliente				integer			not null,
 idSucursal				integer			not null,
 fecha					date			not null,
 horarioEntrega			time			not null,
 fechaRegistro			datetime		null,
 retira					char(1)			not null,
 anulado				char(1)			not null,
 importeTotal			decimal(6,2)	not null,
 primary key (idPedido),
 unique (idPedidoResto, idSucursal),
 foreign key (idCliente) references cliente,
 foreign key (idSucursal) references sucursal,
 check (retira in ('S','N')),
 check (anulado in ('S','N')),
 check (importeTotal > 0)
)
go

create table detalle_pedido
(
 idProducto				integer				not null,
 idPedido				integer				not null,
 cantidad				tinyint				not null,
 primary key (idProducto, idPedido),
 foreign key (idProducto) references producto,
 foreign key (idPedido) references pedido,
 check (cantidad > 0)
 )
go

