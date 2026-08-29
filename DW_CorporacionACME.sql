Create database DW_CorporacionACME;

USE DW_CorporacionACME;
GO

CREATE TABLE dbo.dimCliente (
    id_cliente INT PRIMARY KEY,        
    nombre NVARCHAR(100),
    direccion NVARCHAR(255),
    celular NVARCHAR(20),
    tipo_cliente NVARCHAR(20),
    nif NVARCHAR(50)
);
GO

CREATE TABLE dbo.dimEmpleado (
    id_empleado INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    cargo NVARCHAR(50),
    correo NVARCHAR(100)
);
GO


CREATE TABLE dbo.dimProducto (
    id_producto INT PRIMARY KEY,
    descripcion NVARCHAR(255),
    precio_unitario DECIMAL(10,2),
    categoria NVARCHAR(100),
    marca NVARCHAR(100),
    proveedor NVARCHAR(100),
    ubicacion_almacen NVARCHAR(255),
    fecha_vencimiento DATE
);
GO

CREATE TABLE dimFormaPago (
    id_forma_pago INT PRIMARY KEY,
    descripcion NVARCHAR(30)
);
GO

CREATE TABLE dimCondicionPago (
    id_condicion_pago INT PRIMARY KEY,
    descripcion NVARCHAR(50)
);
GO

CREATE TABLE dimDescuento (
    id_descuento INT PRIMARY KEY,
    tipo_descuento NVARCHAR(20),
    valor DECIMAL(10,2),
    descripcion NVARCHAR(255)
);
GO

CREATE TABLE dbo.dimFecha (
  TiempoId INT PRIMARY KEY,        
  Fecha DATE NOT NULL,
  Anio INT,
  MesId INT,
  Mes NVARCHAR(20),
  TrimestreId INT,
  Trimestre NVARCHAR(30),
  DiaId INT,                   
  Dia NVARCHAR(20)
);
GO

CREATE TABLE fact_Ventas (
    id_DetalleFactura INT PRIMARY KEY,      
    id_Factura INT NOT NULL,
	id_producto INT NOT NULL,
    TiempoId INT NOT NULL,           
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
	id_forma_pago INT NULL,
    id_condicion_pago INT NULL,
    id_descuento INT NULL,
	cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
	subtotal DECIMAL(10,2) NOT NULL,
    total_factura DECIMAL(10,2) NULL,
    totalConDescuento DECIMAL(10,2) NULL


	CONSTRAINT FK_factV_producto        FOREIGN KEY (id_producto)       REFERENCES dbo.dimProducto(id_producto),
    CONSTRAINT FK_factV_fecha          FOREIGN KEY (TiempoId)         REFERENCES dbo.dimFecha(TiempoId),
    CONSTRAINT FK_factV_cliente        FOREIGN KEY (id_cliente)       REFERENCES dbo.dimCliente(id_cliente),
    CONSTRAINT FK_factV_empleado       FOREIGN KEY (id_empleado)      REFERENCES dbo.dimEmpleado(id_empleado),
    CONSTRAINT FK_factV_formaPago      FOREIGN KEY (id_forma_pago)    REFERENCES dbo.dimFormaPago(id_forma_pago),
    CONSTRAINT FK_factV_condicionPago  FOREIGN KEY (id_condicion_pago) REFERENCES dbo.dimCondicionPago(id_condicion_pago),
    CONSTRAINT FK_factV_descuento      FOREIGN KEY (id_descuento)     REFERENCES dbo.dimDescuento(id_descuento)
);


Select * from dimCliente
Select * from dimEmpleado
Select * from dimProducto
Select * from dimFecha
Select * from dimDescuento
Select * from dimFormaPago
Select * from dimCondicionPago
select * from fact_Ventas