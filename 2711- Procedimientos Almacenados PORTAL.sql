--HOLAAA


--Procedimientos almacenados PORTAL 

create procedure dbo.registrar_cliente
(
 @nombre		varchar(255),
 @email      	varchar(255),
 @contrasenia	varchar(50),
 @direccion		varchar(255),
 @telefono		varchar(20)
) 
as
begin

  set @email = ltrim(rtrim(@email))
  set @contrasenia = ltrim(rtrim(@contrasenia))
  if @direccion = ''
     set @direccion = null 

  if not exists(select * 
                  from dbo.cliente (nolock)
                 where email = @email)
     insert into dbo.cliente(nombre, email, contraseña, direccion, telefono)
     values(@nombre, @email, @contrasenia, @direccion, @telefono)
 
end
go

execute dbo.registrar_cliente 'Luz Aliaga', 'mluzaliaga@gmail.com', 'AIOed', 'jk', '0378'


create procedure dbo.registrar_preferencia_cliente
(
 @idCliente			integer,
 @idPreferencia    	integer
) 
as
begin

  if not exists(select * 
                  from dbo.cliente_preferencia (nolock)
                 where idCliente = @idCliente
                 and idPreferencia =@idPreferencia)
     insert into dbo.cliente_preferencia(idCliente, idPreferencia)
     values(@idCliente, @idPreferencia)
 
end
go

execute dbo.registrar_preferencia_cliente  2, 1

