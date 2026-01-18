using System;
using System.Collections;
using System.Data;
using System.Web.UI.WebControls;
using PerfilesSA_WebApp.Datos;

namespace PerfilesSA_WebApp
{
    public partial class Reporte : System.Web.UI.Page
    {
        private DepartamentoDAL departamentoDAL = new DepartamentoDAL();
        private EmpleadosService webService = new EmpleadosService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDepartamentos();
                CargarReporte();
            }
        }

        private void CargarDepartamentos()
        {
            ddlDepartamento.DataSource = departamentoDAL.ObtenerDepartamentos();
            ddlDepartamento.DataTextField = "NombreDepartamento";
            ddlDepartamento.DataValueField = "IdDepartamento";
            ddlDepartamento.DataBind();
            ddlDepartamento.Items.Insert(0, new ListItem("Todos", "0"));
        }

        private void CargarReporte()
        {
            var empleados = webService.ObtenerEmpleados();
            ArrayList empleadosFiltrados = new ArrayList();

            // Parsear fechas con manejo de errores
            DateTime? fechaDesde = null;
            DateTime? fechaHasta = null;

            if (!string.IsNullOrEmpty(txtFechaDesde.Text))
            {
                DateTime tempDesde;
                if (DateTime.TryParse(txtFechaDesde.Text, out tempDesde))
                {
                    fechaDesde = tempDesde.Date; // Solo la fecha sin hora
                }
            }

            if (!string.IsNullOrEmpty(txtFechaHasta.Text))
            {
                DateTime tempHasta;
                if (DateTime.TryParse(txtFechaHasta.Text, out tempHasta))
                {
                    fechaHasta = tempHasta.Date.AddDays(1).AddSeconds(-1); // Hasta las 23:59:59
                }
            }

            foreach (var emp in empleados)
            {
                bool incluir = true;
                DateTime fechaIngreso = ((DateTime)emp.GetType().GetProperty("FechaIngreso").GetValue(emp)).Date;

                // Filtro por fecha desde
                if (fechaDesde.HasValue)
                {
                    if (fechaIngreso < fechaDesde.Value)
                    {
                        incluir = false;
                    }
                }

                // Filtro por fecha hasta
                if (incluir && fechaHasta.HasValue)
                {
                    if (fechaIngreso > fechaHasta.Value)
                    {
                        incluir = false;
                    }
                }

                // Filtro por departamento
                if (incluir && ddlDepartamento.SelectedValue != "0")
                {
                    int idDepartamento = Convert.ToInt32(ddlDepartamento.SelectedValue);
                    int empIdDepartamento = (int)emp.GetType().GetProperty("IdDepartamento").GetValue(emp);

                    if (empIdDepartamento != idDepartamento)
                        incluir = false;
                }

                if (incluir)
                {
                    // Crear un objeto con la edad calculada
                    var empleadoConEdad = new
                    {
                        IdEmpleado = emp.GetType().GetProperty("IdEmpleado").GetValue(emp),
                        Nombres = emp.GetType().GetProperty("Nombres").GetValue(emp),
                        DPI = emp.GetType().GetProperty("DPI").GetValue(emp),
                        FechaNacimiento = emp.GetType().GetProperty("FechaNacimiento").GetValue(emp),
                        Sexo = emp.GetType().GetProperty("Sexo").GetValue(emp),
                        FechaIngreso = emp.GetType().GetProperty("FechaIngreso").GetValue(emp),
                        Direccion = emp.GetType().GetProperty("Direccion").GetValue(emp),
                        NIT = emp.GetType().GetProperty("NIT").GetValue(emp),
                        IdDepartamento = emp.GetType().GetProperty("IdDepartamento").GetValue(emp),
                        NombreDepartamento = emp.GetType().GetProperty("NombreDepartamento").GetValue(emp),
                        Activo = emp.GetType().GetProperty("Activo").GetValue(emp),
                        Edad = CalcularEdadNumero(emp.GetType().GetProperty("FechaNacimiento").GetValue(emp))
                    };

                    empleadosFiltrados.Add(empleadoConEdad);
                }
            }

            ActualizarEstadisticas(empleadosFiltrados);

            gvReporte.DataSource = empleadosFiltrados;
            gvReporte.DataBind();
        }

        private void ActualizarEstadisticas(ArrayList empleados)
        {
            int total = empleados.Count;
            int activos = 0;
            int inactivos = 0;

            foreach (var empleado in empleados)
            {
                var activo = empleado.GetType().GetProperty("Activo").GetValue(empleado);
                if (Convert.ToBoolean(activo))
                    activos++;
                else
                    inactivos++;
            }

            lblTotalEmpleados.Text = total.ToString();
            lblActivos.Text = activos.ToString();
            lblInactivos.Text = inactivos.ToString();
        }

        protected string FormatDPI(string dpi)
        {
            if (string.IsNullOrEmpty(dpi) || dpi.Length != 13)
                return dpi;

            return $"{dpi.Substring(0, 4)} {dpi.Substring(4, 5)} {dpi.Substring(9, 4)}";
        }

        private int CalcularEdadNumero(object fechaNacimiento)
        {
            if (fechaNacimiento == null || fechaNacimiento == DBNull.Value)
                return 0;

            DateTime fechaNac = Convert.ToDateTime(fechaNacimiento);
            int edad = DateTime.Now.Year - fechaNac.Year;

            if (DateTime.Now.DayOfYear < fechaNac.DayOfYear)
                edad--;

            return edad;
        }

        protected string CalcularAntiguedad(object fechaIngreso)
        {
            if (fechaIngreso == null || fechaIngreso == DBNull.Value)
                return "0 años, 0 meses";

            DateTime fecha = Convert.ToDateTime(fechaIngreso);
            DateTime hoy = DateTime.Now;

            int años = hoy.Year - fecha.Year;
            int meses = hoy.Month - fecha.Month;

            if (meses < 0)
            {
                años--;
                meses += 12;
            }

            return $"{años} años, {meses} meses";
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            // DEBUG: Ver qué valores llegan (puedes comentar o eliminar después)
            string debug = $"Desde: '{txtFechaDesde.Text}' | Hasta: '{txtFechaHasta.Text}' | Dept: '{ddlDepartamento.SelectedValue}'";
            System.Diagnostics.Debug.WriteLine(debug);

            CargarReporte();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtFechaDesde.Text = string.Empty;
            txtFechaHasta.Text = string.Empty;
            ddlDepartamento.SelectedIndex = 0;
            CargarReporte();
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            var empleados = webService.ObtenerEmpleados();
            ArrayList empleadosFiltrados = new ArrayList();

            // Parsear fechas con manejo de errores
            DateTime? fechaDesde = null;
            DateTime? fechaHasta = null;

            if (!string.IsNullOrEmpty(txtFechaDesde.Text))
            {
                DateTime tempDesde;
                if (DateTime.TryParse(txtFechaDesde.Text, out tempDesde))
                {
                    fechaDesde = tempDesde.Date;
                }
            }

            if (!string.IsNullOrEmpty(txtFechaHasta.Text))
            {
                DateTime tempHasta;
                if (DateTime.TryParse(txtFechaHasta.Text, out tempHasta))
                {
                    fechaHasta = tempHasta.Date.AddDays(1).AddSeconds(-1);
                }
            }

            foreach (var emp in empleados)
            {
                bool incluir = true;
                DateTime fechaIngreso = ((DateTime)emp.GetType().GetProperty("FechaIngreso").GetValue(emp)).Date;

                // Filtro por fecha desde
                if (fechaDesde.HasValue && fechaIngreso < fechaDesde.Value)
                {
                    incluir = false;
                }

                // Filtro por fecha hasta
                if (incluir && fechaHasta.HasValue && fechaIngreso > fechaHasta.Value)
                {
                    incluir = false;
                }

                // Filtro por departamento
                if (incluir && ddlDepartamento.SelectedValue != "0")
                {
                    int idDepartamento = Convert.ToInt32(ddlDepartamento.SelectedValue);
                    int empIdDepartamento = (int)emp.GetType().GetProperty("IdDepartamento").GetValue(emp);
                    if (empIdDepartamento != idDepartamento) incluir = false;
                }

                if (incluir) empleadosFiltrados.Add(emp);
            }

            System.Text.StringBuilder csv = new System.Text.StringBuilder();
            csv.AppendLine("Nombre,DPI,Edad,Sexo,Departamento,Fecha Ingreso,Antigüedad,Estado");

            foreach (var empleado in empleadosFiltrados)
            {
                var nombres = empleado.GetType().GetProperty("Nombres").GetValue(empleado).ToString();
                var dpi = empleado.GetType().GetProperty("DPI").GetValue(empleado).ToString();
                var fechaNac = (DateTime)empleado.GetType().GetProperty("FechaNacimiento").GetValue(empleado);
                var sexo = empleado.GetType().GetProperty("Sexo").GetValue(empleado).ToString();
                var departamento = empleado.GetType().GetProperty("NombreDepartamento").GetValue(empleado).ToString();
                var fechaIngreso = (DateTime)empleado.GetType().GetProperty("FechaIngreso").GetValue(empleado);
                var activo = Convert.ToBoolean(empleado.GetType().GetProperty("Activo").GetValue(empleado));

                int edad = CalcularEdadNumero(fechaNac);
                string sexoTexto = sexo == "M" ? "Masculino" : "Femenino";
                string estado = activo ? "Activo" : "Inactivo";
                string antiguedad = CalcularAntiguedad(fechaIngreso);

                csv.AppendLine($"\"{nombres}\",\"{FormatDPI(dpi)}\",{edad},{sexoTexto},\"{departamento}\",{fechaIngreso:dd/MM/yyyy},\"{antiguedad}\",{estado}");
            }

            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", $"attachment;filename=Reporte_Empleados_{DateTime.Now:yyyyMMdd_HHmmss}.csv");
            Response.Write(csv.ToString());
            Response.End();
        }
    }
}