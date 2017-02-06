-- Ubicacion configurada para que muestre 5 sucursales
INSERT INTO provincia(nombre)
VALUES('CORDOBA'),('BUENOS AIRES')
INSERT INTO localidad(idProvincia, nombre)
VALUES(1, 'CORDOBA')
INSERT INTO localidad(idProvincia, nombre)
VALUES(2, 'CAPITAL FEDERAL')
INSERT INTO zona(idLocalidad, nombre)
VALUES(1, 'CENTRO'),(1, 'ZONA NORTE'),(1, 'ZONA SUR')
INSERT INTO zona(idLocalidad, nombre)
VALUES(2, 'MICROCENTRO'),(2, 'BARRIO NORTE')

SELECT p.idProvincia, p.nombre as provincia, l.idLocalidad, l.nombre as localidad, z.idZona, z.nombre AS zona
FROM provincia p
JOIN localidad l
ON p.idProvincia = l.idProvincia 
JOIN zona z
ON l.idLocalidad = z.idLocalidad

-- Los restaurantes (y tecnologias) según la consigna
INSERT INTO restaurante(tecnologia, urlTecnologia, nombre, confirmacionEmail)
VALUES('JAX-WS', NULL, 'BETOS', 'S')
INSERT INTO restaurante(tecnologia, urlTecnologia, nombre, confirmacionEmail)
VALUES('REST', NULL, 'SUSHI CLUB', 'N')
INSERT INTO restaurante(tecnologia, urlTecnologia, nombre, confirmacionEmail)
VALUES('AXIS', NULL, 'EL PAPAGAYO', 'S')

-- Las 5 sucursales
INSERT INTO sucursal(idSucursalResto, idRestaurante, idZona, nombre)
VALUES(1, 1, 2,'BetosCBANorte'),(2, 1, 4,'BetosGBAMicrocentro')
INSERT INTO sucursal(idSucursalResto, idRestaurante, idZona, nombre)
VALUES(1, 2, 3,'SC-CBASur'),(2, 2, 5,'SC-GBABarrioNorte')
INSERT INTO sucursal(idSucursalResto, idRestaurante, idZona, nombre)
VALUES(1, 3, 1,'Papagayo-Centro')

SELECT r.idRestaurante, r.nombre restaurante, s.idSucursal, s.idSucursalResto, s.nombre sucursal, s.idZona
FROM sucursal s
JOIN restaurante r
ON r.idRestaurante = s.idRestaurante

--Configuracion de los tipo de servicio por sucursal
INSERT INTO tipo_servicio(descripcion)
VALUES('RESERVA'),('PEDIDO')
INSERT INTO sucursal_tipo_servicio(idSucursal, idTipoServicio)
VALUES(1, 1),(1, 2),(2, 1),(2, 2),(3,1),(3,2), (4, 1),(5,1)

SELECT  s.idSucursal, s.nombre sucursal, ts.idTipoServicio, ts.descripcion TipoDeServicio
FROM sucursal_tipo_servicio sts
JOIN tipo_servicio ts
ON ts.idTipoServicio = sts.idTipoServicio
JOIN sucursal s
ON s.idSucursal = sts.idSucursal

--Clientes
INSERT INTO cliente(nombre, email, contraseña, direccion, telefono)
VALUES('Celeste Amato', 'celeamato@gmail.com', 'qwerty', 'Colon 50 ', '351708099'),
      ('Luz Aliaga', 'mluzaliaga@gmail.com', 'qwerty', 'Figueroa Alcorta 900', '351719187'), 
      ('Tomas Funes', 'tomas@gmail.com', 'qwerty', 'Av Gauss 5000', '3515013096'), 
      ('Juan Perez', 'juanperez@gmail.com', 'qwerty', 'Ricardo Rojas 760', '117649889'), 
      ('Maria Esper', 'maria@gmail.com', 'qwerty', 'Dean Funes 1100', '54357448')
SELECT * FROM cliente

--Configuracion de las preferencias
INSERT INTO preferencia (descripcion)
VALUES('Carnes'), ('Comida Japonesa'), ('Lomitos'), ('Pastas'), ('Pizzas'), ('Sushi')
INSERT INTO restaurante_preferencia (idRestaurante, idPreferencia)
VALUES (1, 1), (1,3), (2,2),(2,6),(3,1),(3,4), (3,5)

SELECT r.idRestaurante, r.nombre restaurante, p.idPreferencia, p.descripcion preferencia
FROM restaurante r
JOIN restaurante_preferencia rp
ON r.idRestaurante = rp.idRestaurante
JOIN preferencia p
ON rp.idPreferencia = p.idPreferencia

INSERT INTO cliente_preferencia (idCliente, idPreferencia)
VALUES(1,1), (1,3),(1,6),(2,4),(2,2),(3,6),(4,1),(5,4), (5,5)

SELECT c.idCliente, c.nombre cliente, p.idPreferencia, p.descripcion preferencia
FROM cliente c
JOIN cliente_preferencia cp
ON c.idCliente = cp.idCliente
JOIN preferencia p
ON cp.idPreferencia = p.idPreferencia

--Promociones
INSERT INTO promocion(idSucursal, idPromocionResto, nombre, descripcion, vigente)
VALUES(1, 1, '20% Descuento ', 'Todos los días 20% Off con tu tarjeta del Club la Nación. Imperdible!', 'S'),
      (3, 1, 'Tragos 2x1 ', 'After hours de 19.00 a 22.00', 'S'),  
      (4, 1, '#LadiesNight', '%50 off en el total del ticket en mesas de mujeres', 'S')

SELECT s.idSucursal, s.nombre sucursal, p.idPromocion, p.idPromocionResto, p.nombre, p.descripcion, p.vigente
FROM promocion p
JOIN sucursal s
ON s.idSucursal = p.idSucursal

-- Reservas 
INSERT INTO reserva(idReservaResto, idCliente, idSucursal, idPromocion, fecha, horario, fechaRegistro, comensales, confirmacionEmail,anulado)
VALUES(1, 5, 1, null, '2017-03-21', '12:00', '2017-03-19 10:00', 4, 'S', 'N'),
(2, 1, 1, null, '2017-03-21', '12:00', '2017-03-19 10:00', 4, 'S', 'N'),
(3, 3, 1, 1, '2017-03-21', '13:00', '2017-03-19 10:00', 2, 'S', 'N'),
(4, 4, 2, null, '2017-03-21', '13:00', '2017-03-19 10:00', 4, 'S', 'N'),
(5, 2, 2, null, '2017-03-21', '15:00', '2017-03-19 10:00', 2, 'S', 'N'),
(1, 5, 3, 2, '2017-03-21', '14:00', '2017-03-19 10:00', 6, 'S', 'N'),
(2, 1, 3, null, '2017-03-21', '12:00', '2017-03-19 10:00', 4, 'S', 'N'),
(45, 2, 4, 2, '2017-03-21', '21:00', '2017-03-19 10:00', 4, 'S', 'N'),
(49, 3, 4, null, '2017-03-21', '22:00', '2017-03-19 10:00', 8, 'S', 'N'),
(55, 1, 5, null, '2017-03-21', '13:00', '2017-03-19 10:00', 2, 'S', 'N'),
(58, 2, 5, 3, '2017-03-21', '21:00', '2017-03-19 10:00', 4, 'S', 'N')

SELECT r.idReserva, r.idReservaResto, c.idCliente, c.nombre cliente, s.idSucursal, s.nombre sucursal, r.idPromocion, 
		r.fecha, r.horario, r.fechaRegistro, r.comensales, r.confirmacionEmail, r.anulado 
FROM reserva r
JOIN cliente c
ON c.idCliente = r.idCliente
JOIN sucursal s
ON r.idSucursal =  s.idSucursal

--Productos Restaurante 1 (Betos)
INSERT INTO producto (idProductoResto, nombre, descripcion, idRestaurante, precio)
VALUES(1, 'Betos Lomo', 'Lomo, queso, huevo, tomate, lechuga, mayonesa, jamón', 1, 80),
(2, 'Betos Chimi', 'Lomo, tomate, lechuga, queso, aji, mayonesa, huevo, morrón, chimi', 1, 100),
(3, 'Betos Americano', 'Lomo, cebolla, salteada, queso, huevo, revuelto, panceta, mayonesa, salsa bbq', 1,100),
(4, 'Betos Vegetal', 'Berenjena, tomate, lechuga, huevo, queso, mayonesa', 1, 85)

--Productos Restaurante 2 (Sushi Club)
INSERT INTO producto (idProductoResto, nombre, descripcion, idRestaurante, precio)
VALUES
(1, 'Sushi Club 15 Unidades', 'Placer Real: 3 Piezas Ulala: 3 Piezas Feel World: 3 Piezas Futurama: 3 Piezas SPF: 3 Piezas', 2, 160),
(2, 'Sushi Club 30 Unidades', 'Placer Real: 6 Piezas Ulala: 6 Piezas Feel World: 6 Piezas Futurama: 6 Piezas SPF: 6 Piezas', 2, 300),
(3, 'Sushi Club 45 Unidades', 'Placer Real: 9 Piezas Ulala: 9 Piezas Feel World: 9 Piezas Futurama: 9 Piezas SPF: 9 Piezas', 2, 430),
(4, 'Sushi Club 60 Unidades', 'Placer Real: 12 Piezas Ulala: 12 Piezas Feel World: 12 Piezas Futurama: 12 Piezas SPF: 12 Piezas', 2, 540),
(5, 'Sushi Smile 15 Unidades', 'Honey: 3 Piezas Buenos Aires: 3 Piezas Tartar: 3 Piezas Ulala: 3 Piezas Ebi Furai: 3 Piezas', 2, 170),
(6, 'Sushi Smile 30 Unidades', 'Honey: 6 Piezas Buenos Aires: 6 Piezas Tartar: 3 Piezas Ulala: 6 Piezas Ebi Furai: 6 Piezas', 2, 310),
(7, 'Sushi Smile 45 Unidades', 'Honey: 9 Piezas Buenos Aires: 9 Piezas Tartar: 3 Piezas Ulala: 9 Piezas Ebi Furai: 9 Piezas', 2, 440),
(8, 'Sushi Smile 60 Unidades', 'Honey: 12 Piezas Buenos Aires: 12 Piezas Tartar: 3 Piezas Ulala: 12 Piezas Ebi Furai: 12 Piezas', 2, 560)

--Productos Restaurante 3 (El Papagayo)
INSERT INTO producto (idProductoResto, nombre, descripcion, idRestaurante, precio)
VALUES
(1, 'Entrecot (porción)', 'Con ensalada mixta', 3, 120.00),
(2, 'Tira de asado (porción)', 'Con papas fritas', 3, 150),
(3, 'Matambre de cerdo (porción)', 'Con ensalada mixta', 3, 120),
(4, 'Sorrentinos Caseros', 'Con salsa Bolognesa', 3, 100),
(5, 'Ravioles caseros', 'Con salsa Bolognesa', 3, 100),
(6, 'Pizza muzzarella', 'Masa casera artesanal, salsa de tomate, queso muzzarella, orégano y aceitunas.', 3, 100),
(7, 'Pizza muzzarella especial', 'Muzzarella con morrones.', 3, 130),
(8, 'Pizza provenzal', 'Muzzarella con provenzal (ajo y perejil).', 3, 140),
(9, 'Pizza de palmitos', 'Muzzarella con palmitos, jamón, morrones y salsa golf.', 3, 130),
(10, 'Pizza rúcula', 'Muzzarella con rúcula, jamón crudo, queso parmesano.', 3, 150)

SELECT r.idRestaurante, r.nombre restaurante, p.idProducto, p.idProductoResto, p.nombre producto, p.descripcion,  p.precio
FROM producto p
JOIN restaurante r
ON p.idRestaurante = r.idRestaurante

--Pedidos Sucursal 1 (BetosCBANorte)
INSERT INTO pedido (idPedidoResto, idCliente, idSucursal, fecha, horarioEntrega, fechaRegistro, retira, anulado, importeTotal)
VALUES
(1, 1, 1, '2017-03-21', '22:00', '2017-03-19 10:00', 'S', 'N', 180)
--Detalle Pedido pedido 1
INSERT INTO detalle_pedido (idProducto, idPedido, cantidad)
VALUES
(1, 1, 1), (2, 1, 1)

SELECT *
FROM pedido p
JOIN detalle_pedido dp
ON p.idPedido = dp.idPedido