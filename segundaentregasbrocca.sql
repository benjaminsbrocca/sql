CREATE DATABASE tienda;

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(50),
    descripcion VARCHAR(200),
    precio DECIMAL(10,2),
    stock INT
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(50),
    email_cliente VARCHAR(50) UNIQUE,
    telefono_cliente VARCHAR(15),
    direccion_cliente VARCHAR(50)
);

CREATE TABLE metodos_pago (
    id_metodo INT AUTO_INCREMENT PRIMARY KEY,
    metodo_pago VARCHAR(50)
);

CREATE TABLE ordenes (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_metodo INT,
    fecha_orden DATETIME,
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_metodo) REFERENCES metodos_pago(id_metodo)
);

CREATE TABLE detalle_orden (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT,
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50)
);

CREATE TABLE producto_categoria (
    id_producto INT,
    id_categoria INT,
    PRIMARY KEY (id_producto, id_categoria),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

INSERT INTO productos (nombre_producto, descripcion, precio, stock) VALUES
('Camiseta Algodón', 'Camiseta de algodón blanca de alta calidad', 2500.00, 100),
('Jeans Slim Fit', 'Pantalón de jeans azul oscuro', 7500.00, 50),
('Camisa Cuadros', 'Camisa de cuadros rojos y negros', 4200.00, 30),
('Sweater Lana', 'Sweater gris de lana', 5500.00, 20),
('Pantalón Chino', 'Pantalón chino beige', 6200.00, 60),
('Zapatillas Deportivas', 'Zapatillas running negras', 8000.00, 40),
('Campera de Cuero', 'Campera negra de cuero', 12000.00, 10),
('Remera Estampada', 'Remera con diseño gráfico', 2800.00, 80),
('Bermuda Casual', 'Bermuda azul para el verano', 3500.00, 70),
('Chomba Piqué', 'Chomba de piqué celeste', 3900.00, 90);

INSERT INTO clientes (nombre_cliente, email_cliente, telefono_cliente, direccion_cliente) VALUES
('Lucas González', 'lucas.gonzalez@mail.com', '1134567890', 'Av. Santa Fe 1234, Buenos Aires'),
('Martina López', 'martina.lopez@mail.com', '1167890123', 'Calle Corrientes 5678, Buenos Aires'),
('Agustín Fernández', 'agustin.fernandez@mail.com', '1145678912', 'Mitre 123, Córdoba'),
('Sofía Rodríguez', 'sofia.rodriguez@mail.com', '1178901234', 'San Martín 456, Mendoza'),
('Juan Pérez', 'juan.perez@mail.com', '1123456789', 'Belgrano 789, Rosario'),
('Florencia Martínez', 'flor.martinez@mail.com', '1143210987', 'Alvear 987, La Plata'),
('Diego Romero', 'diego.romero@mail.com', '1165432109', 'Colón 654, Mar del Plata'),
('Valentina Torres', 'valentina.torres@mail.com', '1154321098', 'Rivadavia 432, Neuquén'),
('Gonzalo Sosa', 'gonzalo.sosa@mail.com', '1176543210', 'San Lorenzo 765, Salta'),
('Emilia Gómez', 'emilia.gomez@mail.com', '1198765432', '9 de Julio 987, San Juan');

INSERT INTO metodos_pago (metodo_pago) VALUES
('Tarjeta de Crédito'),
('Tarjeta de Débito'),
('Transferencia Bancaria'),
('MercadoPago'),
('Efectivo');

INSERT INTO ordenes (id_cliente, id_metodo, fecha_orden, total) VALUES
(1, 1, '2024-10-01 10:30:00', 10500.00),
(2, 2, '2024-10-02 11:00:00', 4500.00),
(3, 3, '2024-10-03 12:00:00', 2500.00),
(4, 4, '2024-10-04 14:30:00', 18000.00),
(5, 5, '2024-10-05 15:00:00', 6200.00),
(6, 1, '2024-10-06 16:00:00', 11200.00),
(7, 2, '2024-10-07 17:00:00', 7500.00),
(8, 3, '2024-10-08 18:00:00', 3900.00),
(9, 4, '2024-10-09 19:00:00', 27500.00),
(10, 5, '2024-10-10 20:00:00', 5500.00);

INSERT INTO detalle_orden (id_orden, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 2, 2500.00),
(1, 2, 1, 7500.00),
(2, 3, 1, 4200.00),
(2, 8, 1, 2800.00),
(3, 1, 1, 2500.00),
(4, 7, 1, 12000.00),
(4, 6, 2, 8000.00),
(5, 5, 1, 6200.00),
(6, 1, 2, 2500.00),
(6, 3, 1, 4200.00),
(7, 2, 1, 7500.00),
(8, 10, 1, 3900.00),
(9, 7, 1, 12000.00),
(9, 2, 1, 7500.00),
(9, 6, 2, 8000.00);

INSERT INTO categorias (nombre_categoria) VALUES
('Camisetas'),
('Pantalones'),
('Camisas'),
('Abrigos'),
('Calzado'),
('Accesorios');

INSERT INTO producto_categoria (id_producto, id_categoria) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 2),
(6, 5),
(7, 4),
(8, 1),
(9, 2),
(10, 1);

CREATE VIEW vista_ordenes_clientes AS
SELECT o.id_orden, c.nombre_cliente, c.email_cliente, o.fecha_orden, o.total
FROM ordenes o
JOIN clientes c ON o.id_cliente = c.id_cliente;

CREATE VIEW vista_productos_vendidos AS
SELECT p.nombre_producto, SUM(d.cantidad) AS cantidad_vendida, SUM(d.cantidad * d.precio_unitario) AS total_generado
FROM detalle_orden d
JOIN productos p ON d.id_producto = p.id_producto
GROUP BY p.nombre_producto;

DELIMITER //
CREATE FUNCTION calcular_total_orden(id_orden INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(cantidad * precio_unitario) INTO total
    FROM detalle_orden
    WHERE id_orden = id_orden;
    RETURN total;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION cantidad_ordenes_cliente(id_cliente INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) INTO cantidad
    FROM ordenes
    WHERE id_cliente = id_cliente;
    RETURN cantidad;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE agregar_producto(
    IN nombre VARCHAR(100),
    IN descripcion VARCHAR(200),
    IN precio DECIMAL(10,2),
    IN stock INT
)
BEGIN
    INSERT INTO productos (nombre_producto, descripcion, precio, stock)
    VALUES (nombre, descripcion, precio, stock);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE actualizar_stock_producto(
    IN id_producto INT,
    IN nuevo_stock INT
)
BEGIN
    UPDATE productos
    SET stock = nuevo_stock
    WHERE id_producto = id_producto;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER actualizar_stock_trigger
AFTER INSERT ON detalle_orden
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END //
DELIMITER ;

CREATE TABLE log_ordenes (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT,
    id_cliente INT,
    fecha_log DATETIME
);

DELIMITER //
CREATE TRIGGER log_nueva_orden_trigger
AFTER INSERT ON ordenes
FOR EACH ROW
BEGIN
    INSERT INTO log_ordenes (id_orden, id_cliente, fecha_log)
    VALUES (NEW.id_orden, NEW.id_cliente, NOW());
END //
DELIMITER ;

SELECT * FROM vista_ordenes_clientes;

SELECT * FROM vista_productos_vendidos;

SELECT calcular_total_orden(1);

SELECT cantidad_ordenes_cliente(1);

CALL agregar_producto('Campera de Invierno', 'Campera impermeable térmica', 15000.00, 30);

CALL actualizar_stock_producto(1, 120);





