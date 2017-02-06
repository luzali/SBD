--Sucursales
INSERT INTO sucursal(nombre)
VALUES ('BetosCBANorte'), ('BetosGBAMicrocentro')

SELECT *
FROM sucursal

--Horarios (De 12:00-15:00 y de 21:00-24:00)
INSERT INTO horario(horario)
VALUES 
('12:00'), ('13:00'), ('14:00'), ('21:00'), ('22:00'), ('23:00')

--Mesas sucursales 1 y 2
INSERT INTO mesa (idSucursal, comensales)
VALUES 
(1, 2), (1, 2),(1, 2),(1, 4),(1, 4),(1, 4),(1, 4),(1, 8), (1, 8),
(2, 2), (2, 2), (2, 2), (2, 2), (2, 4), (2, 4), (2, 4), (2, 6), (2, 6), (2, 6)

--Sucursal 1
INSERT INTO horario_mesa(idHorario, idMesa, idSucursal)
VALUES
(1, 1, 1), (2, 1, 1),(3, 1, 1),(4, 1, 1),(5, 1, 1),(6, 1, 1),
(1, 2, 1), (2, 2, 1),(3, 2, 1),(4, 2, 1),(5, 2, 1),(6, 2, 1),
(1, 3, 1), (2, 3, 1),(3, 3, 1),(4, 3, 1),(5, 3, 1),(6, 3, 1),
(1, 4, 1), (2, 4, 1),(3, 4, 1),(4, 4, 1),(5, 4, 1),(6, 4, 1),
(1, 5, 1), (2, 5, 1),(3, 5, 1),(4, 5, 1),(5, 5, 1),(6, 5, 1),
(1, 6, 1), (2, 6, 1),(3, 6, 1),(4, 6, 1),(5, 6, 1),(6, 6, 1),
(1, 7, 1), (2, 7, 1),(3, 7, 1),(4, 7, 1),(5, 7, 1),(6, 7, 1),
(1, 8, 1), (2, 8, 1),(3, 8, 1),(4, 8, 1),(5, 8, 1),(6, 8, 1),
(1, 9, 1), (2, 9, 1),(3, 9, 1),(4, 9, 1),(5, 9, 1),(6, 9, 1)

--Sucursal 2
INSERT INTO horario_mesa(idHorario, idMesa, idSucursal)
VALUES
(1, 10, 2), (2, 10, 2),(3, 10, 2),(4, 10, 2),(5, 10, 2),(6, 10, 2),
(1, 11, 2), (2, 11, 2),(3, 11, 2),(4, 11, 2),(5, 11, 2),(6, 11, 2),
(1, 12, 2), (2, 12, 2),(3, 12, 2),(4, 12, 2),(5, 12, 2),(6, 12, 2),
(1, 13, 2), (2, 13, 2),(3, 13, 2),(4, 13, 2),(5, 13, 2),(6, 13, 2),
(1, 14, 2), (2, 14, 2),(3, 14, 2),(4, 14, 2),(5, 14, 2),(6, 14, 2),
(1, 15, 2), (2, 15, 2),(3, 15, 2),(4, 15, 2),(5, 15, 2),(6, 15, 2),
(1, 16, 2), (2, 16, 2),(3, 16, 2),(4, 16, 2),(5, 16, 2),(6, 16, 2),
(1, 17, 2), (2, 17, 2),(3, 17, 2),(4, 17, 2),(5, 17, 2),(6, 17, 2),
(1, 18, 2), (2, 18, 2),(3, 18, 2),(4, 18, 2),(5, 18, 2),(6, 18, 2),
(1, 19, 2), (2, 19, 2),(3, 19, 2),(4, 19, 2),(5, 19, 2),(6, 19, 2)

SELECT hm.idSucursal,s.nombre sucursal,  h.horario, hm.idMesa, m.comensales 
FROM horario_mesa hm
JOIN mesa m
ON hm.idSucursal = m.idSucursal
AND hm.idMesa = m.idMesa
JOIN horario h
ON h.idHorario = hm.idHorario
JOIN sucursal s
ON s.idSucursal = m.idSucursal


--Promocion
INSERT INTO promocion(idSucursal, nombre, descripcion, vigente)
VALUES(1, '20% Descuento ', 'Todos los días 20% Off con tu tarjeta del Club la Nación. Imperdible!', 'S')

INSERT INTO reserva(idSucursal, idPromocion, fecha, idHorario, idMesa, fechaRegistro, comensales, confirmacionEmail,anulado)
VALUES
(1, null,	'2017-03-21', 1, 4,'2017-03-19 10:00',  'S', 'N'),
(1, null,	'2017-03-21', 1, 5,'2017-03-19 10:00', 'S', 'N'),
(1,   1,	'2017-03-21', 2, 1,'2017-03-19 10:00',  'S', 'N'),
(2, null,  	'2017-03-21', 2, 14,'2017-03-19 10:00', 'S', 'N'),
(2, null,	'2017-03-21', 3, 10,'2017-03-19 10:00', 'S', 'N')

VALUES(1, 5, 1, null, '2017-03-21', '12:00', '2017-03-19 10:00', 4, 'S', 'N'),
(2, 1, 1, null, '2017-03-21', '12:00', '2017-03-19 10:00', 4, 'S', 'N'),
(3, 3, 1, 1, '2017-03-21', '13:00', '2017-03-19 10:00', 2, 'S', 'N'),
(4, 4, 2, null, '2017-03-21', '13:00', '2017-03-19 10:00', 4, 'S', 'N'),
(5, 2, 2, null, '2017-03-21', '15:00', '2017-03-19 10:00', 2, 'S', 'N'),