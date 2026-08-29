# Corporación ACME — Business Intelligence

Proyecto académico de **Business Intelligence** desarrollado para la gestión, transformación y análisis de información empresarial mediante un ecosistema de tecnologías Microsoft.

La solución integra una **base de datos transaccional, un proceso ETL, un Data Warehouse, un modelo multidimensional con cubo OLAP, reportes empresariales y un dashboard interactivo**, permitiendo transformar datos operacionales en información estructurada para el análisis y la toma de decisiones.

El conjunto de datos utilizado corresponde a un período de **tres meses**, debido al alcance definido para este proyecto académico.

## Tecnologías utilizadas

* **Microsoft SQL Server** — Base de datos transaccional y Data Warehouse
* **SQL** — Consultas, creación, transformación y manipulación de datos
* **SQL Server Integration Services (SSIS)** — Procesos ETL
* **SQL Server Analysis Services (SSAS)** — Modelo multidimensional y cubo OLAP
* **SQL Server Reporting Services (SSRS)** — Desarrollo de reportes empresariales
* **Microsoft Power BI** — Visualización y análisis interactivo de datos
* **Visual Studio** — Desarrollo y gestión de los proyectos SSIS y SSAS

## Arquitectura de la solución

El proyecto sigue un flujo de procesamiento de datos compuesto por las siguientes etapas:

```text
                 BD Transaccional
                       │
                       ▼
                     SSIS
                      ETL
                       │
                       ▼
                Data Warehouse
                       │
          ┌────────────┴────────────┐
          │                         │
          ▼                         ▼
      Power BI                    SSAS
     (origen: DW)              Cubo OLAP
                                    │
                                    ▼
                                  SSRS
                         (origen: DW y/o Cubo)
```

<img width="502" height="535" alt="Arquitectura de la solución" src="https://github.com/user-attachments/assets/e39fba04-c829-4491-a878-1ad799bfa49e" />

## Componentes del proyecto

### 1. Base de datos transaccional

**Archivo:**

`DB_CorporacionACME.sql`

Contiene el script de creación y configuración de la base de datos operacional utilizada como fuente de información para el proceso de integración de datos.

### 2. Data Warehouse

**Archivo:**

`DW_CorporacionACME.sql`

Contiene la estructura del **Data Warehouse** utilizado para almacenar la información preparada para el análisis.

El Data Warehouse permite separar los procesos analíticos de la operación transaccional y facilita la generación de consultas, reportes y análisis sobre la información almacenada.

### 3. Proceso ETL — SSIS

**Carpeta:**

`ETL_CorporacionACME/`

Contiene el proyecto desarrollado con **SQL Server Integration Services (SSIS)**.

El proceso ETL se encarga de:

* Extraer información desde la base de datos operacional.
* Transformar y preparar los datos.
* Cargar la información en el Data Warehouse.

**Archivo principal del paquete:**

`Package.dtsx`

### 4. Cubo OLAP — SSAS

**Carpeta:**

`CuboDwCorporacionACME/`

Contiene el proyecto desarrollado con **SQL Server Analysis Services (SSAS)**.

El modelo multidimensional incluye dimensiones relacionadas con:

* Cliente
* Condición de pago
* Descuento
* Empleado
* Fecha
* Forma de pago
* Producto

El cubo OLAP utiliza el Data Warehouse como fuente de información y permite realizar análisis multidimensionales sobre los datos empresariales.

### 5. Reportes — SSRS

**Carpeta:**

`ReportesACME/`

Contiene los reportes desarrollados utilizando **SQL Server Reporting Services (SSRS)**.

Entre los reportes incluidos se encuentran:

* Cantidad vendida por día
* Condición de pago de clientes

<img width="648" height="676" alt="Reporte de condición de pago de clientes" src="https://github.com/user-attachments/assets/b245e11d-5d40-4a3d-b3ea-dcc19f4c1319" />

* Desempeño de empleados
* Impacto de descuentos

<img width="1213" height="557" alt="Reporte de impacto de descuentos" src="https://github.com/user-attachments/assets/0d5ac416-0275-4a91-a5d5-2de2368a617d" />

Los reportes utilizan como origen de datos **el Data Warehouse y/o el cubo OLAP**, dependiendo del reporte, permitiendo presentar la información empresarial de forma estructurada.

### 6. Dashboard — Power BI

<img width="1022" height="572" alt="Dashboard de Power BI" src="https://github.com/user-attachments/assets/bef0f71f-3c40-47c8-9ba1-2cb6fefc2e68" />

**Archivo:**

`PowerBi CoorporacionAcme (DW).pbix`

Contiene el dashboard desarrollado en **Microsoft Power BI**, utilizando directamente el **Data Warehouse como origen de datos**.

Power BI permite complementar los reportes tradicionales mediante visualizaciones interactivas, indicadores y diferentes perspectivas de análisis sobre la información empresarial.

## Estructura del repositorio

```text
ACME/
│
├── CuboDwCorporacionACME/
│   ├── Dim Cliente.dim
│   ├── Dim Condicion Pago.dim
│   ├── Dim Descuento.dim
│   ├── Dim Empleado.dim
│   ├── Dim Fecha.dim
│   ├── Dim Forma Pago.dim
│   ├── Dim Producto.dim
│   ├── DW Corporacion ACME CUBO.cube
│   ├── DW Corporacion ACME CUBO.partitions
│   ├── DW Corporacion ACME Vista.dsv
│   └── ...
│
├── ETL_CorporacionACME/
│   ├── Package.dtsx
│   ├── Project.params
│   └── ...
│
├── ReportesACME/
│   ├── CantidadVendidaPorDia.rdl
│   ├── CondicionPagoClientes.rdl
│   ├── DesempeñoEmpleados.rdl
│   ├── ImpactoDescuentos.rdl
│   └── ...
│
├── DB_CorporacionACME.sql
├── DW_CorporacionACME.sql
├── PowerBi CoorporacionAcme (DW).pbix
├── .gitignore
└── README.md
```

## Flujo de datos

El flujo general de la solución es el siguiente:

### 1. Fuente de datos

La información se encuentra inicialmente en la **base de datos transaccional de Corporación ACME**.

### 2. Extracción

**SSIS** obtiene los datos necesarios desde la base de datos operacional.

### 3. Transformación

Los datos son procesados, transformados y preparados para su utilización en el entorno analítico.

### 4. Carga

La información transformada es almacenada en el **Data Warehouse**.

### 5. Modelado analítico

**SSAS** utiliza el Data Warehouse como fuente para construir el modelo multidimensional y el cubo OLAP.

### 6. Consumo de información

La información puede ser consultada mediante diferentes herramientas:

* **Power BI**, utilizando directamente el Data Warehouse como origen.
* **SSRS**, utilizando el Data Warehouse y/o el cubo OLAP como origen, según el reporte.
* **SSAS**, mediante el cubo OLAP para análisis multidimensional.

## Requisitos

Para trabajar con el proyecto se requiere un entorno compatible con las tecnologías utilizadas, incluyendo:

* Windows
* SQL Server
* Visual Studio con las extensiones necesarias para SSIS y SSAS
* SQL Server Integration Services
* SQL Server Analysis Services
* SQL Server Reporting Services
* Power BI Desktop

## Configuración de conexiones

Los proyectos utilizan conexiones mediante **autenticación integrada de Windows**.

Las conexiones incluidas en los archivos del proyecto apuntan a una instancia local de SQL Server.

Por ejemplo:

```text
MSI\SQLMULTI
```

Al clonar el repositorio en otro equipo, las conexiones deberán adaptarse a la instancia de SQL Server disponible en ese entorno.

## Ejecución general

Para reproducir el proyecto:

1. Crear la base de datos operacional utilizando `DB_CorporacionACME.sql`.
2. Crear el Data Warehouse utilizando `DW_CorporacionACME.sql`.
3. Configurar las conexiones de SQL Server según el entorno local.
4. Abrir el proyecto `ETL_CorporacionACME` y ejecutar el proceso ETL.
5. Abrir el proyecto `CuboDwCorporacionACME` para trabajar con el modelo multidimensional.
6. Abrir el proyecto `ReportesACME` para trabajar con los reportes SSRS.
7. Abrir el archivo `.pbix` con Power BI Desktop para visualizar el dashboard.

> **Nota:** La configuración de las conexiones puede requerir ajustes dependiendo de la instancia de SQL Server y de los servicios disponibles en el equipo donde se clone el proyecto.

## Objetivo

El objetivo del proyecto es demostrar la implementación de una solución integral de **Business Intelligence** capaz de transformar datos operacionales en información estructurada para facilitar el análisis empresarial y apoyar la toma de decisiones.

## Estado del proyecto

**Proyecto académico finalizado**, documentado como parte del portafolio de proyectos de Business Intelligence.

## Autor

**Carla Duluc**

Estudiante de Ingeniería de Software.


