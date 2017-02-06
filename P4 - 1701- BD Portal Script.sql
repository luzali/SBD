use portal
go

drop table sucursal_tipo_servicio --ok
drop table tipo_servicio --ok

	drop table detalle_pedido -- Falta
	drop table preferencia -- Falta
drop table promocion --ok
	drop table cliente_preferencia -- Falta

	drop table reserva -- con proced. almacenado
	drop table pedido -- con proced. almacenado
	drop table producto -- Falta

drop table cliente --ok
drop table sucursal --ok
	drop table restaurante_preferencia -- Falta 
drop table restaurante --ok

drop table zona --ok
drop table localidad --ok
drop table provincia --ok

go

--ok
create table provincia
(
 idProvincia		integer			not null	identity(1,1),
 nombre				varchar(100)	not null,
 primary key (idProvincia)
)
go

insert into dbo.provincia(nombre)
values('CORDOBA'),('SANTA FE')
go

select * from dbo.provincia

--ok
create table localidad
(
 idLocalidad		integer			not null	identity(1,1),
 idProvincia		integer			not null,
 nombre				varchar(100)	not null,
 primary key (idLocalidad),
 foreign key (idProvincia) references provincia
)
go

insert into dbo.localidad(idProvincia, nombre)
values(1, 'ALTA GRACIA'),(1, 'VILLA CARLOS PAZ'),(2, 'AREQUITO')
go

select * from dbo.localidad
--where idProvincia = 1

--ok
create table zona
(
 idZona				integer			not null	identity(1,1),
 idLocalidad		integer			not null,
 nombre				varchar(100)	not null,
 primary key (idZona),
 foreign key (idLocalidad) references localidad
)
go

insert into dbo.zona(idLocalidad, nombre)
values(1, 'ZONA 1'),(2, 'ZONA NORTE'),(2, 'ZONA SUR')
go

select * 
from dbo.zona z join dbo.localidad l
on z.idLocalidad = l.idLocalidad

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

insert into dbo.restaurante(tecnologia, urlTecnologia, nombre, confirmacionEmail)
values('REST', NULL, 'BETOS', 'S'),('JAX-WS', NULL, 'MARIACHI', 'N')
go

select * from dbo.restaurante

--ok
create table sucursal
(
 idSucursal			integer			not null	identity(1,1),
 idSucursalResto	integer			not null,
 idRestaurante		integer			not null,
 idZona				integer			not null,
 nombre				varchar(100)	not null,
 primary key (idSucursal),
 unique (idSucursalResto),
 foreign key (idRestaurante) references restaurante,
 foreign key (idZona) references zona
)
go

insert into dbo.sucursal(idSucursalResto, idRestaurante, idZona, nombre)
values(11, 1, 2,'BetosVCPNorte'),(22, 1, 3,'BetosVCPSur')
go

select * from dbo.sucursal

--ok
create table tipo_servicio
(
 idTipoServicio			tinyint			not null	identity(1,1),
 descripcion			varchar(50)		not null,
 primary key (idTipoServicio)
)
go

insert into dbo.tipo_servicio(descripcion)
values('RESERVA'),('PEDIDO')
go

select * from dbo.tipo_servicio

--ok
create table sucursal_tipo_servicio
(
 idSucursal			integer			not null,
 idTipoServicio		tinyint			not null,
 primary key (idSucursal, idTipoServicio),
 foreign key (idSucursal) references sucursal,
 foreign key (idTipoServicio) references tipo_servicio
)
go

insert into dbo.sucursal_tipo_servicio(idSucursal, idTipoServicio)
values(1, 1),(1, 2),(2,1)
go

select * from dbo.sucursal_tipo_servicio

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
 unique (email)
)
go

insert into dbo.cliente(nombre, email, contraseña, direccion, telefono)
values('Cele', 'celeamato@gmail.com', 'qwerty', 'direccion cele', 'telefono cele'),
      ('Luz', 'mluzaliaga@gmail.com', 'qwerty', 'direccion luz', 'telefono luz')
go

select * from dbo.cliente

--ok
create table promocion
(
 idPromocion			integer			not null	identity(1,1),
 idSucursal				integer			not null,
 idPromocionResto		integer			not null,
 nombre					varchar(100)	not null,
 descripcion			varchar(100)	not null,
 vigente				char(1)			not null,
 primary key (idPromocion),
 unique (idPromocionResto),
 foreign key (idSucursal) references sucursal,
 check (vigente IN ('S', 'N'))
)
go
-- agregué el unique!
-- puse en idPromocionResto la R de Resto en mayúscula

insert into dbo.promocion(idSucursal, idPromocionResto, nombre, descripcion, vigente)
values(1, 111, 'promo 1', '2x1', 's'),
      (1, 222, 'promo 2', 'after hours', 's')
go

select * from dbo.promocion

--ok
create table reserva
(
 idReserva			integer			not null	identity(1,1),
 idReservaResto		integer			not null,
 idCliente			integer			not null,
 idSucursal			integer			not null,
 idPromocion		integer			null,
 fecha				date			not null,
 horario			time			not null,
 fechaRegistro		datetime		not null,
 comensales			tinyint			not null,
 confirmacionEmail	char(1)			not null,
 anulado			char(1)			not null,
 primary key (idReserva),
 unique (idReservaResto),
 foreign key (idCliente) references cliente,
 foreign key (idSucursal) references sucursal,
 foreign key (idPromocion) references promocion,
 check (confirmacionEmail in ('S','N')),
 check (anulado in ('S','N'))
)
go

select * from dbo.reserva

--ok
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
 importeTotal			decimal(4,2)	not null,
 primary key (idPedido),
 unique (idPedidoResto),
 foreign key (idCliente) references cliente,
 foreign key (idSucursal) references sucursal,
 check (retira in ('S','N')),
 check (anulado in ('S','N')),
 check (importeTotal > 0)
)
go
-- agregué idPedidoResto + el unique!

select * from dbo.pedido

create table producto
(
 idProducto				integer				not null	identity(1,1),
 idProductoResto		integer				not null,
 descripcion			varchar(100)		not null,
 idRestaurante			integer				not null,
 precio					decimal(4,2)		not null,
 primary key (idProducto),
 unique (idProductoResto),
 foreign key (idRestaurante) references restaurante,
 check (precio > 0)
)
go
-- agregué el unique!

--ok
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
create table restaurante_preferencia
(
 idPreferencia				integer			not null	identity(1,1),
 idRestaurante				integer			not null,
 --idSucursalResto			tinyint			not null,
 --idOfertaResto				integer			not null,
 primary key (idPreferencia, idRestaurante),
 foreign key (idPreferencia) references preferencia,
 foreign key (idRestaurante) references restaurante,
 --unique(idSucursalResto),
 --unique(idOfertaResto)
)
go
-- Saque el idSucursalResto y el idOfertaResto

select * from dbo.restaurante_preferencia
