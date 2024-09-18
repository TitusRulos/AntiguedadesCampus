###############################
############INSERTS############
###############################

INSERT INTO usuario (nombre, rol, contrasena) VALUES 
('Juan Pérez', 'Vendedor', 'password123'),
('Ana Gómez', 'Comprador', 'mypassword456'),
('Carlos Ruiz', 'Administrador', 'adminpassword789');

INSERT INTO categoria (nombre) VALUES 
('Muebles'),
('Joyería'),
('Arte'),
('Coleccionables');

INSERT INTO pago (metodo_pago) VALUES 
('Tarjeta de crédito'),
('Transferencia bancaria'),
('PayPal');

INSERT INTO entrega (fecha, direccion) VALUES 
('2024-09-20', 'Calle Falsa 123, Ciudad, País'),
('2024-09-22', 'Avenida Siempre Viva 742, Ciudad, País');

INSERT INTO pieza (nombre, descripcion, precio, estatus, estado_conservacion, categoria_id, usuario_id) VALUES 
('Reloj de bolsillo antiguo', 'Reloj de bolsillo de oro de finales del siglo XIX.', 1500.00, 'En venta', 'Excelente', 2, 1),
('Cuadro de Van Gogh', 'Reproducción de una obra de Van Gogh.', 2000.00, 'En venta', 'Buena', 3, 1),
('Escultura de bronce', 'Escultura moderna de bronce.', 800.00, 'Retirado', 'Muy buena', 4, 1);

INSERT INTO transaccion (precio, fecha, pieza_id, usuario_id, pago_id, entrega_id) VALUES 
(1500.00, '2024-09-21 14:30:00', 1, 2, 1, 1),
(2000.00, '2024-09-23 10:00:00', 2, 2, 2, 2);

INSERT INTO inventario (cantidad, pieza_id) VALUES 
(10, 1),
(5, 2),
(0, 3);

#################################
############CONSULTAS############
#################################

#1. Listar todas las antigüedades disponibles para la venta
SELECT 
    p.nombre AS Nombre_Pieza,
    c.nombre AS Categoria,
    p.precio AS Precio,
    p.estado_conservacion AS Estado_Conservacion
FROM 
    pieza p
JOIN 
    categoria c ON p.categoria_id = c.id
WHERE 
    p.estatus = 'En venta';

#2. Buscar antigüedades por categoría y rango de precio
SELECT 
    p.nombre AS Nombre_Pieza,
    p.descripcion AS Descripcion,
    p.precio AS Precio,
    p.estado_conservacion AS Estado_Conservacion
FROM 
    pieza p
JOIN 
    categoria c ON p.categoria_id = c.id
WHERE 
    c.nombre = 'Joyería' AND
    p.precio BETWEEN 500 AND 2000;
   
#3. Mostrar el historial de ventas de un cliente específico
SELECT 
    p.nombre AS Nombre_Pieza,
    t.fecha AS Fecha_Venta,
    t.precio AS Precio_Venta,
    u.nombre AS Comprador
FROM 
    transaccion t
JOIN 
    pieza p ON t.pieza_id = p.id
JOIN 
    usuario u ON t.usuario_id = u.id
WHERE 
    u.nombre = 'Ana Gómez';

#4. Obtener el total de ventas realizadas en un periodo de tiempo
SELECT 
    SUM(t.precio) AS Total_Ventas
FROM 
    transaccion t
WHERE 
    t.fecha BETWEEN '2024-01-21' AND '2024-10-21';
 
#5.Encontrar los clientes más activos
SELECT 
    u.nombre AS Cliente,
    COUNT(t.id) AS Numero_Compras
FROM 
    transaccion t
JOIN 
    usuario u ON t.usuario_id = u.id
WHERE 
    u.rol = 'Comprador'
GROUP BY 
    u.nombre
ORDER BY 
    Numero_Compras DESC;

#7.Listar las antigüedades vendidas en un rango de fechas específico
SELECT 
    p.nombre AS Nombre_Pieza,
    t.fecha AS Fecha_Venta,
    t.precio AS Precio_Venta,
    u_vendedor.nombre AS Vendedor,
    u_comprador.nombre AS Comprador
FROM 
    transaccion t
JOIN 
    pieza p ON t.pieza_id = p.id
JOIN 
    usuario u_vendedor ON p.usuario_id = u_vendedor.id
JOIN 
    usuario u_comprador ON t.usuario_id = u_comprador.id
WHERE 
    t.fecha BETWEEN '2024-09-01' AND '2024-09-30';
   
#8. Obtener un informe de inventario actual
SELECT 
    c.nombre AS Categoria,
    SUM(i.cantidad) AS Total_Cantidad
FROM 
    inventario i
JOIN 
    pieza p ON i.pieza_id = p.id
JOIN 
    categoria c ON p.categoria_id = c.id
GROUP BY 
    c.nombre;



