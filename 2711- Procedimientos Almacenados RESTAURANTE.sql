-- PROCEDIMIENTOS ALMACENADOS RESTAURANTE

/* ----------------------------------------------
   Procedimiento: Insertar Reserva
   Parámetross:
   - Datos del cliente:		nombre, email, telefono
   - Datos de la reserva:	idHorario, idMesa, idSucursal, idPromocion
   
   Valores por defecto:
   - fechaRegistro: GETDATE() 
   - confirmado: 'N'
   - anulado: 'N'
   ---------------------------------------------- */

create procedure ins_reserva
(
 @nombre			varchar(40),
 @email				varchar(255),
 @telefono			varchar(50),
 @idHorario			integer,
 @idMesa			integer,
 @idSucursal		integer,
 @idPromocion		integer	= 0
)
as
begin

  declare @nro_persona integer

  if ltrim(rtrim(@e_mail)) = ''
     set @e_mail = null
  if ltrim(rtrim(@url)) = ''
     set @url = null

  if exists(select *
              from dbo.personas
             where tipo_documento = @tipo_documento
               and nro_documento  = ltrim(rtrim(@nro_documento)))
     begin
       raiserror('El documento informa ya se registró para otra persona', 16, 1)
       return
     end
   
   select @nro_persona = isnull(max(nro_persona), 0) + 1
     from dbo.personas (tablockx)   
     
  insert into dbo.personas(nro_persona, apellido, nombre, tipo_documento, nro_documento, e_mail, url)
  values(@nro_persona, upper(ltrim(rtrim(@apellido))), upper(ltrim(rtrim(@nombre))), upper(@tipo_documento), upper(ltrim(rtrim(@nro_documento))), lower(ltrim(rtrim(@e_mail))), lower(ltrim(rtrim(@url))))
  
end
go
