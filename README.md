\# Corporación ACME — Business Intelligence



Proyecto de Business Intelligence desarrollado para la gestión, transformación y análisis de información empresarial mediante un ecosistema de tecnologías Microsoft.



La solución integra una base de datos transaccional, un proceso ETL, un Data Warehouse, un cubo OLAP, reportes empresariales y un dashboard interactivo, permitiendo transformar datos operacionales en información útil para el análisis y la toma de decisiones. Tomando en cuenta que solo se encuentran 3 meses con datos ya que fue un proyecto pequeño.



\## Tecnologías utilizadas



\* \*\*Microsoft SQL Server\*\* — Base de datos y Data Warehouse

\* \*\*SQL\*\* — Consultas, creación y transformación de datos

\* \*\*SQL Server Integration Services (SSIS)\*\* — Procesos ETL

\* \*\*SQL Server Analysis Services (SSAS)\*\* — Modelo multidimensional y cubo OLAP

\* \*\*SQL Server Reporting Services (SSRS)\*\* — Reportes empresariales

\* \*\*Microsoft Power BI\*\* — Visualización y análisis de datos

\* \*\*Visual Studio\*\* — Desarrollo de los proyectos SSIS y SSAS



\## Arquitectura de la solución



El proyecto sigue un flujo de procesamiento de datos compuesto por las siguientes etapas:





Base de datos transaccional

&#x20;         │

&#x20;         ▼

&#x20;       SSIS

&#x20;      ETL

&#x20;         │

&#x20;         ▼

&#x20;  Data Warehouse

&#x20;         │

&#x20;         ├──────────────► SSRS   y    Power BI Dashboard

&#x20;         │                Reportes

&#x20;         │

&#x20;         ▼

&#x20;      SSAS

&#x20;    Cubo OLAP

&#x20;         

&#x20;  





\## Componentes del proyecto



\### 1. Base de datos transaccional



Archivo:



DB\_CorporacionACME.sql



Contiene el script de creación y configuración de la base de datos operacional utilizada como fuente de información para el proceso de integración de datos.



\### 2. Data Warehouse



Archivo:



DW\_CorporacionACME.sql





Contiene la estructura del Data Warehouse utilizado para almacenar la información preparada para análisis.



El Data Warehouse permite separar los procesos analíticos de la operación transaccional y facilita la generación de consultas y reportes orientados al análisis histórico.



\### 3. Proceso ETL — SSIS



Carpeta:



ETL\_CorporacionACME/





Contiene el proyecto desarrollado con SQL Server Integration Services.



El proceso ETL se encarga de:



\* Extraer información desde la base de datos operacional.

\* Transformar los datos.

\* Cargar la información en el Data Warehouse.

\* Automatizar el flujo de integración de datos.



Archivo principal del paquete:



Package.dtsx



\### 4. Cubo OLAP — SSAS



Carpeta:



CuboDwCorporacionACME/



Contiene el proyecto desarrollado con SQL Server Analysis Services.



El modelo multidimensional incluye dimensiones relacionadas con:



\* Cliente

\* Condición de pago

\* Descuento

\* Empleado

\* Fecha

\* Forma de pago

\* Producto



El cubo permite realizar análisis multidimensional de la información almacenada en el Data Warehouse.



\### 5. Reportes — SSRS



Carpeta:



ReportesACME/



Contiene los reportes desarrollados utilizando SQL Server Reporting Services.



Entre los reportes incluidos se encuentran:



\* Cantidad vendida por día

\* Condición de pago de clientes

\* Desempeño de empleados

\* Impacto de descuentos



Los reportes permiten consultar y presentar información empresarial de forma estructurada.



\### 6. Dashboard — Power BI



Archivo:



PowerBi CoorporacionAcme (DW).pbix



Contiene el dashboard desarrollado en Power BI utilizando información proveniente del Data Warehouse.



Power BI permite complementar los reportes tradicionales mediante visualizaciones interactivas y análisis de indicadores.



\## Estructura del repositorio



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

├── ETL\_CorporacionACME/

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

├── DB\_CorporacionACME.sql

├── DW\_CorporacionACME.sql

├── PowerBi CoorporacionAcme (DW).pbix

├── .gitignore

└── README.md

```



\## Flujo de datos



El flujo general de la solución es:



\*\*1. Fuente de datos\*\*



La información se encuentra inicialmente en la base de datos transaccional de Corporación ACME.



\*\*2. Extracción\*\*



SSIS obtiene los datos necesarios desde la base de datos operacional.



\*\*3. Transformación\*\*



Los datos son procesados y preparados para su utilización en el entorno analítico.



\*\*4. Carga\*\*



La información transformada es almacenada en el Data Warehouse.



\*\*5. Modelado analítico\*\*



SSAS utiliza el Data Warehouse como fuente para construir el modelo multidimensional y el cubo OLAP.



\*\*6. Consumo de información\*\*



La información puede ser utilizada mediante:



\* Reportes SSRS.

\* Cubo OLAP.

\* Dashboard de Power BI.



\## Requisitos



Para trabajar con el proyecto se requiere un entorno compatible con las tecnologías utilizadas, incluyendo:



\* Windows

\* SQL Server

\* Visual Studio con las extensiones necesarias para SSIS y SSAS

\* SQL Server Integration Services

\* SQL Server Analysis Services

\* SQL Server Reporting Services

\* Power BI Desktop



\## Configuración de conexiones



Los proyectos utilizan conexiones mediante autenticación integrada de Windows.



Las conexiones incluidas en los archivos del proyecto apuntan a una instancia local de SQL Server.



Por ejemplo:



MSI\\SQLMULTI



Al clonar el repositorio en otro equipo, las conexiones deberán adaptarse a la instancia de SQL Server disponible en ese entorno.



\## Ejecución general



Para reproducir el proyecto:



1\. Crear/restaurar la base de datos operacional utilizando `DB\_CorporacionACME.sql`.

2\. Crear el Data Warehouse utilizando `DW\_CorporacionACME.sql`.

3\. Configurar las conexiones de SQL Server según el entorno local.

4\. Abrir el proyecto `ETL\_CorporacionACME` y ejecutar el proceso ETL.

5\. Abrir el proyecto `CuboDwCorporacionACME` para trabajar con el modelo multidimensional.

6\. Abrir el proyecto `ReportesACME` para trabajar con los reportes SSRS.

7\. Abrir el archivo `.pbix` con Power BI Desktop para visualizar el dashboard.



> \*\*Nota:\*\* La configuración de conexiones puede requerir ajustes dependiendo de la instancia de SQL Server y de los servicios disponibles en el equipo donde se clone el proyecto.



\## Objetivo



El objetivo del proyecto es demostrar la implementación de una solución integral de Business Intelligence capaz de transformar datos operacionales en información estructurada para facilitar el análisis empresarial y la toma de decisiones.



\## Estado del proyecto



Proyecto académico finalizado y documentado como parte del portafolio de proyectos de Business Intelligence.



\## Autor



\*\*Carla Duluc\*\*



Estudiante de Ingeniería de Software.



