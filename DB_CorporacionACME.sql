CREATE DATABASE CorporacionACME;
GO

USE CorporacionACME;
GO

CREATE TABLE dbo.Categoria_Producto (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE dbo.Marca (
    id_marca INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE dbo.Almacen (
    id_almacen INT IDENTITY(1,1) PRIMARY KEY,
    ubicacion NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE dbo.Proveedor (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    direccion NVARCHAR(255) NULL,
    telefono NVARCHAR(20) NULL,
    correo NVARCHAR(100) NULL
);
GO

CREATE TABLE dbo.Cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    direccion NVARCHAR(255) NULL,
    celular NVARCHAR(20) NULL,
    tipo_cliente NVARCHAR(20) NOT NULL,
    nif NVARCHAR(50) NULL,
    CONSTRAINT chk_Cliente_tipo_cliente CHECK (tipo_cliente IN (N'mayorista',N'minorista'))
);
GO

CREATE TABLE dbo.Empleado (
    id_empleado INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido NVARCHAR(100) NOT NULL,
    cargo NVARCHAR(50) NULL,
    correo NVARCHAR(100) NULL
);
GO

CREATE TABLE dbo.Producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    descripcion NVARCHAR(255) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    id_categoria INT NULL,
    id_marca INT NULL,
    id_proveedor INT NULL,
    id_almacen INT NULL,
    fecha_vencimiento DATE NULL,
    CONSTRAINT FK_Producto_Categoria FOREIGN KEY (id_categoria) REFERENCES dbo.Categoria_Producto(id_categoria),
    CONSTRAINT FK_Producto_Marca FOREIGN KEY (id_marca) REFERENCES dbo.Marca(id_marca),
    CONSTRAINT FK_Producto_Proveedor FOREIGN KEY (id_proveedor) REFERENCES dbo.Proveedor(id_proveedor),
    CONSTRAINT FK_Producto_Almacen FOREIGN KEY (id_almacen) REFERENCES dbo.Almacen(id_almacen)
);
GO

CREATE TABLE dbo.Forma_Pago (
    id_forma_pago INT IDENTITY(1,1) PRIMARY KEY,
    descripcion NVARCHAR(30) NOT NULL,
    CONSTRAINT chk_FormaPago_descripcion CHECK (descripcion IN (N'Efectivo', N'Transferencia', N'Cheque', N'Tarjeta'))
);
GO

CREATE TABLE Condicion_Pago (
    id_condicion_pago INT PRIMARY KEY,
    descripcion NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE dbo.Descuento (
    id_descuento INT IDENTITY(1,1) PRIMARY KEY,
    tipo_descuento NVARCHAR(20) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    descripcion NVARCHAR(255) NULL,
    CONSTRAINT chk_Descuento_tipo CHECK (tipo_descuento IN (N'fijo', N'promo'))
);
GO


CREATE TABLE dbo.Factura (
    id_factura INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_emision DATE NOT NULL,
    total DECIMAL(10,2) NULL,
    numero_serie NVARCHAR(50) NULL,
    id_condicion_pago INT NOT NULL,
    notas NVARCHAR(MAX) NULL,
    id_forma_pago INT NULL,
    id_descuento INT NULL,
	totalConDescuento DECIMAL(10,2) NULL,
    CONSTRAINT FK_Factura_Cliente FOREIGN KEY (id_cliente) REFERENCES dbo.Cliente(id_cliente),
    CONSTRAINT FK_Factura_Empleado FOREIGN KEY (id_empleado) REFERENCES dbo.Empleado(id_empleado),
    CONSTRAINT FK_Factura_FormaPago FOREIGN KEY (id_forma_pago) REFERENCES dbo.Forma_Pago(id_forma_pago),
    CONSTRAINT FK_Factura_Descuento FOREIGN KEY (id_descuento) REFERENCES dbo.Descuento(id_descuento),
	 CONSTRAINT FK_Factura_CondicionPago FOREIGN KEY (id_condicion_pago) REFERENCES Condicion_Pago(id_condicion_pago)
);
GO

CREATE TABLE dbo.Detalle_Factura (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_factura INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NULL,
    CONSTRAINT FK_Detalle_Factura_Factura FOREIGN KEY (id_factura) REFERENCES dbo.Factura(id_factura),
    CONSTRAINT FK_Detalle_Factura_Producto FOREIGN KEY (id_producto) REFERENCES dbo.Producto(id_producto)
);
GO

-- Inserciones con literales Unicode (N'...')
INSERT INTO dbo.Categoria_Producto (nombre) VALUES
(N'Explosivos'),
(N'Artilugios'),
(N'Vehículos'),
(N'Químicos');
GO

INSERT INTO dbo.Marca (nombre) VALUES
(N'ACME Corporation'),
(N'Coyote Tools'),
(N'Trampas S.A.'),
(N'Innovaciones del Desierto');
GO

INSERT INTO dbo.Almacen (ubicacion) VALUES
(N'Bunker Central ACME'),
(N'Sucursal del Desierto'),
(N'Depósito Zona 51'),
(N'Cueva secreta del Coyote');
GO

INSERT INTO dbo.Proveedor (nombre, direccion, telefono, correo) VALUES
(N'ACME Global', N'Calle 123, Ciudad ACME', N'8095551111', N'contacto@acmeglobal.com'),
(N'Coyote Equipos', N'Barrio Trampa, Desierto ACME', N'8295552222', N'ventas@coyoteeq.com'),
(N'Explosivos del Sur', N'Autopista 666, Km 42', N'8495553333', N'info@explosur.com'),
(N'Distribuidora TNT', N'Zona Industrial, Capital', N'8495554444', N'tnt@distribuidora.com');
GO

INSERT INTO dbo.Empleado (nombre, apellido, cargo, correo) VALUES
(N'Carla', N'Duluc', N'Encargada de Ventas', N'carla.duluc@acme.com'),
(N'Roberto', N'Martínez', N'Almacenero', N'roberto@acme.com'),
(N'Yornadis', N'Jesus', N'Almacenero', N'yornadis@acme.com'),
(N'Juan', N'Castillo', N'Cajero/a', N'juan@acme.com'),
(N'Petronila', N'Dominguez', N'Cajero/a', N'petronila@acme.com'),
(N'Paco', N'Guzmán', N'Cajero/a', N'paco@acme.com'),
(N'Pedro', N'Enrrique', N'Cajero/a', N'pedro@acme.com'),
(N'Patricia', N'Hernández', N'Cajero/a', N'patricia@acme.com'),
(N'Juana', N'Valencia', N'Cajero/a', N'Juana@acme.com'),
(N'Valeria', N'Fernández', N'Cajero/a', N'valeria@acme.com');
GO

INSERT INTO dbo.Cliente (nombre, direccion, celular, tipo_cliente, nif) VALUES
(N'Wile Coyote', N'Desierto ACME ', N'8091111111',  N'mayorista', N'100919000001553'),
(N'Elmer Gruñón', N'Granja de conejos', N'8291112222',  N'minorista', N'100919000001554'),
(N'Bugs Bunny', N'Cueva Zanahoria', N'8091113333',  N'minorista', N'100919000001556'),
(N'Pato Lucas', N'Casa de Bugs', N'8491114444',  N'mayorista', N'100919000001557'),
(N'Sam Bigotes', N'Al lao casa Bugs', N'8291115555',  N'minorista', N'100919000001558'),
(N'Correcaminos', N'Carretera 66', N'8091116666',  N'minorista', N'100919000001559'),
(N'Speedy Gonzales', N'México', N'8491117777',  N'mayorista', N'100919000001550'),
(N'Pantera Rosa', N'Calle Rosita fresita', N'8491118888',  N'minorista', N'100919000001551'),
(N'Taz', N'Amazonas', N'8291119999',  N'mayorista', N'100919000001552'),
(N'Marvin el Marciano', N'Marte', N'8091120000', N'mayorista', N'100919000001510'),
(N'Piolin', N'Casa Abuelita', N'8491120410', N'minorista', N'100919000001512');
GO

INSERT INTO dbo.Producto (descripcion, precio_unitario, id_categoria, id_marca, id_proveedor, id_almacen, fecha_vencimiento) VALUES
(N'Bombas de prácticas ACME', 1500.00, 1, 1, 1, 1, NULL),
(N'Dinamita explosiva', 800.00, 2, 2, 2, 2, NULL),
(N'Kit de bombas por control remoto', 500.00, 2, 3, 2, 3, NULL),
(N'Kit de trampolín para supersaltos', 2000.00, 1, 1, 1, 1, NULL),
(N'Cañón magnético', 300.00, 3, 2, 1, 2, NULL),
(N'Radar con control remoto', 1000.00, 1, 4, 3, 3, NULL),
(N'Gas para dormir', 1200.00, 1, 1, 1, 4, '2028-09-30'),
(N'Raíles para crear vías de tren', 600.00, 3, 2, 4, 3, NULL),
(N'Patines de alta velocidad', 750.00, 3, 1, 3, 2, NULL),
(N'Cola pegalotodo', 1800.00, 1, 3, 1, 1, '2030-02-09'),
(N'Pintura invisible ACME', 100.00, 4, 1, 1, 2, '2054-05-12'),
(N'Palo propulsor saltador', 5000.00, 1, 4, 2, 3, NULL),
(N'Armadura de acero acorazada ACME', 400.00, 2, 2, 3, 1, NULL),
(N'Pesa de 10,000 LBS', 900.00, 2, 1, 4, 4, NULL),
(N'Cemento de secado rápido', 850.00, 2, 3, 2, 2, '2028-08-15');
GO


INSERT INTO dbo.Forma_Pago (descripcion) VALUES
(N'Efectivo'), (N'Tarjeta'), (N'Transferencia'), (N'Cheque');
GO

INSERT INTO Condicion_Pago (id_condicion_pago, descripcion) VALUES
(1, 'Cash'),
(2, 'Fiao');
GO


INSERT INTO dbo.Descuento (tipo_descuento, valor, descripcion) VALUES
(N'fijo', 0.10, N'Descuento por cliente frecuente'),
(N'promo', 0.20, N'Descuento especial por promoción');
GO



INSERT INTO dbo.Factura (id_cliente, id_empleado, fecha_emision, total, numero_serie, id_condicion_pago, notas, id_forma_pago, id_descuento, totalConDescuento) VALUES
(1, 4, '2025-10-25', 5300.00, N'F001', 1, N'Pa’ ayer, tengo al correcaminos cerquita', 1, 1, 4770.00),
(2, 5, '2025-10-25', 12600.00, N'F002', 2, N'Urgente pa’ un invento que no puede fallar', 2, 2, 10080.00),
(3, 6, '2025-10-25', 5850.00, N'F003', 1, N'Dame rápido que ya lo vi pasar', 3, NULL, 5850.00),
(4, 7, '2025-10-25', 10500.00, N'F004', 1, N'Esto es pa’ una trampa nueva, tú sabes', 1, NULL, 10500.00),
(5, 8, '2025-10-27', 10400.00, N'F005', 2, N'Urgente, muévelo', 2, NULL, 10400.00),
(6, 9, '2025-10-28', 4900.00, N'F006', 1, N'Esto es secreto, pero necesito que funcione', 1, 1, 4410.00),
(7, 10, '2025-10-28', 10700.00, N'F007', 1, N'Hoy se me escapa ese pájaro y me retiro', 3, NULL, 10700.00),
(8, 4, '2025-10-30', 5700.00, N'F008', 2, N'Es pa’ algo serio, confía', 2, 2, 4560.00),
(9, 5, '2025-10-30', 1800.00, N'F009', 1, N'Pa’ cuando aparezca ese loco en la curva', 1, 1, 1620.00),
(10,4, '2025-11-4', 10600.00, N'F010', 1, N'No me preguntes, tú solo mándalo', 4, NULL, 10600.00),
(1, 6, '2025-11-5', 1400.00, N'F011', 2, N'Pa’ una misión con dinamita y fe', 2, 1, 1260.00),
(2, 10, '2025-11-8', 8500.00, N'F012', 1, N'Esto es pa’ probar un truco', 1, 2, 6800.00),
(3, 7, '2025-11-10', 8600.00, N'F013', 1, N'Atento a mí, esto se va a poner bueno', 3, NULL, 8600.00),
(4, 8, '2025-11-15', 4650.00, N'F014', 2, N'Tengo un plan nuevo, top secret', 2, NULL, 4650.00),
(5, 5, '2025-11-15', 9600.00, N'F015', 1, N'Pa’ una emergencia... otra vez', 4, NULL, 9600.00),
(6, 4, '2025-11-15', 9500.00, N'F016', 1, N'Reenvíamelo con motor, porfa', 1, NULL, 9500.00),
(7, 9, '2025-11-20', 4400.00, N'F017', 2, N'No me juzgues, mándalo', 2, NULL, 4400.00),
(8, 10, '2025-11-22', 12700.00, N'F018', 1, N'Esto es el combo final, dique', 1, NULL, 12700.00),
(9, 10, '2025-11-30', 9300.00, N'F019', 1, N'No quiero hablar, solo mándalo', 3, 2, 7440.00),
(10,7, '2025-11-30', 4300.00, N'F020', 1, N'Es pa’ una broma, jeje', 1, NULL, 4300.00),
(1, 7, '2025-11-30', 4500.00, N'F021', 2, N'Hoy sí lo agarro, lo juro', 2, 1, 4050.00),
(2, 8, '2025-11-30', 4300.00, N'F022', 1, N'Esto es una prueba... tal vez', 1, NULL, 4300.00),
(3, 4, '2025-11-30', 8400.00, N'F023', 2, N'Mi último intento, jurao’', 3, NULL, 8400.00),
(4, 5, '2025-11-30', 6300.00, N'F024', 2, N'Resuélveme eso al favol', 2, NULL, 6300.00),
(5, 6, '2025-12-1', 6900.00, N'F025', 1, N'Tengo el correcaminos en la mira', 1, 2, 5520.00),
(11, 4, '2025-12-1', 2700.00, N'F026', 1, N'Compra de último minuto', 1, 1, 2430.00),
(1, 4, '2025-12-3', 22000.00, N'F027', 1, N'Una compra extra para mi', 1, 1, 19800.00),
(5, 5, '2025-12-3', 1800.00,  N'F028', 1, N'Ya sabes.. lo de siempre', 1, NULL, 1800.00),
(4, 6, '2025-12-4', 3200.00,  N'F029', 2, N'Unos cuantos juguetitos', 2, NULL, 3200.00),
(10, 7, '2025-12-5', 3050.00, N'F030', 1, N'Me la lleva´ a Marte', 1, NULL, 3050.00),
(9, 8, '2025-12-6', 2900.00,  N'F031', 1, N'GRRRRR', 1, NULL, 2900.00),
(2, 9, '2025-12-6', 3400.00,  N'F032', 1, N'Mandame eso', 2, 2, 2720.00);

GO

INSERT INTO dbo.Detalle_Factura (id_factura, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 3, 1500.00, 4500.00),
(1, 13, 2, 400.00, 800.00),
(2, 3, 4, 500.00, 2000.00),
(2, 12, 2, 5000.00, 10000.00),
(2, 5, 2, 300.00, 600.00),
(3, 5, 1, 300.00, 300.00),
(3, 9, 4, 750.00, 3000.00),
(3, 15, 3, 850.00, 2550.00),
(4, 3, 1, 500.00, 500.00),
(4, 12, 2, 5000.00, 10000.00),
(5, 5, 4, 300.00, 1200.00),
(5, 10, 2, 1800.00, 3600.00),
(5, 2, 2, 800.00, 1600.00),
(5, 6, 4, 1000.00, 4000.00),
(6, 6, 1, 1000.00, 1000.00),
(6, 11, 3, 100.00, 300.00),
(6, 10, 2, 1800.00, 3600.00),
(7, 8, 4, 600.00, 2400.00),
(7, 14, 1, 900.00, 900.00),
(7, 10, 3, 1800.00, 5400.00),
(7, 6, 2, 1000.00, 2000.00),
(8, 1, 2, 1500.00, 3000.00),
(8, 11, 3, 100.00, 300.00),
(8, 2, 3, 800.00, 2400.00),
(9, 2, 1, 800.00, 800.00),
(9, 3, 2, 500.00, 1000.00),
(10, 2, 1, 800.00, 800.00),
(10, 4, 4, 2000.00, 8000.00),
(10, 13, 2, 400.00, 800.00),
(10, 6, 1, 1000.00, 1000.00),
(11, 5, 2, 300.00, 600.00),
(11, 13, 2, 400.00, 800.00),
(12, 3, 2, 500.00, 1000.00),
(12, 10, 3, 1800.00, 5400.00),
(12, 5, 3, 300.00, 900.00),
(12, 8, 2, 600.00, 1200.00),
(13, 4, 2, 2000.00, 4000.00),
(13, 1, 2, 1500.00, 3000.00),
(13, 13, 4, 400.00, 1600.00),
(14, 7, 2, 1200.00, 2400.00),
(14, 9, 3, 750.00, 2250.00),
(15, 6, 3, 1000.00, 3000.00),
(15, 1, 4, 1500.00, 6000.00),
(15, 5, 2, 300.00, 600.00),
(16, 2, 3, 800.00, 2400.00),
(16, 11, 3, 100.00, 300.00),
(16, 8, 3, 600.00, 1800.00),
(16, 12, 1, 5000.00, 5000.00),
(17, 8, 4, 600.00, 2400.00),
(17, 2, 1, 800.00, 800.00),
(17, 5, 4, 300.00, 1200.00),
(18, 10, 1, 1800.00, 1800.00),
(18, 12, 2, 5000.00, 10000.00),
(18, 14, 1, 900.00, 900.00),
(19, 2, 2, 800.00, 1600.00),
(19, 13, 3, 400.00, 1200.00),
(19, 4, 1, 2000.00, 2000.00),
(19, 1, 3, 1500.00, 4500.00),
(20, 5, 2, 300.00, 600.00),
(20, 8, 4, 600.00, 2400.00),
(20, 11, 1, 100.00, 100.00),
(20, 7, 1, 1200.00, 1200.00),
(21, 1, 2, 1500.00, 3000.00),
(21, 9, 2, 750.00, 1500.00),
(22, 15, 2, 850.00, 1700.00),
(22, 13, 2, 400.00, 800.00),
(22, 10, 1, 1800.00, 1800.00),
(23, 10, 2, 1800.00, 3600.00),
(23, 14, 1, 900.00, 900.00),
(23, 3, 3, 500.00, 1500.00),
(23, 7, 2, 1200.00, 2400.00),
(24, 6, 3, 1000.00, 3000.00),
(24, 1, 2, 1500.00, 3000.00),
(24, 11, 3, 100.00, 300.00),
(25, 1, 1, 1500.00, 1500.00),
(25, 3, 2, 500.00, 1000.00),
(25, 2, 3, 800.00, 2400.00),
(25, 4, 1, 2000.00, 2000.00),
(26, 9, 2, 750.00, 1500.00),  
(26, 11, 4, 100.00, 400.00),   
(26, 2, 1, 800.00, 800.00),   
(27, 12, 2, 5000.00, 10000.00),  
(27, 4,  3, 2000.00,  6000.00),  
(27, 1,  4, 1500.00,  6000.00),  
(28, 9, 2,  750.00, 1500.00), 
(28, 5, 1,  300.00,  300.00), 
(29, 3, 4,  500.00, 2000.00), 
(29, 8, 2,  600.00, 1200.00), 
(30, 15, 3, 850.00, 2550.00), 
(30, 11, 5, 100.00,  500.00), 
(31, 2, 2,  800.00, 1600.00), 
(31, 13,1,  400.00,  400.00), 
(31, 14,1,  900.00,  900.00), 
(32, 6, 1, 1000.00, 1000.00), 
(32, 7, 2, 1200.00, 2400.00); 

GO









SELECT * FROM Cliente;
SELECT * FROM Proveedor;
SELECT * FROM Categoria_Producto;
SELECT * FROM Marca;
SELECT * FROM Almacen;
SELECT * FROM Empleado;
SELECT * FROM Producto;
SELECT * FROM Descuento;
SELECT * FROM Condicion_Pago;
SELECT * FROM Forma_Pago;
SELECT * FROM Factura;
SELECT * FROM Detalle_Factura;
