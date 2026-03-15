# PerfilesSA WebApp

Aplicación web ASP.NET Web Forms para la gestión de empleados y departamentos.

## Requisitos

- Visual Studio 2017 o superior
- .NET Framework 4.7.2
- IIS Express o IIS

## Estructura del Proyecto

- **Empleados.aspx** - Gestión de empleados
- **Departamentos.aspx** - Gestión de departamentos
- **Reporte.aspx** - Generación de reportes
- **EmpleadosService.asmx** - Servicio web para operaciones de empleados
- **Datos/** - Capa de acceso a datos (DAL)

## Cómo ejecutar el proyecto

1. Clonar el repositorio:
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   ```

2. Abrir la solución en Visual Studio:
   - Abrir `PerfilesSA_WebApp.sln`

3. Restaurar paquetes NuGet (si es necesario):
   - Clic derecho en la solución > Restaurar paquetes NuGet

4. Configurar la cadena de conexión:
   - Revisar y actualizar la cadena de conexión en `Web.config` según tu entorno

5. Compilar el proyecto:
   - Presionar `Ctrl+Shift+B` o ir a Build > Build Solution

6. Ejecutar la aplicación:
   - Presionar `F5` o clic en el botón de inicio

## Tecnologías Utilizadas

- ASP.NET Web Forms
- .NET Framework 4.7.2
- C#
- ADO.NET para acceso a datos

## Autor

Desarrollador Jocias 
