using PerfilesSA_WebApp.Datos;
using System;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PerfilesSA_WebApp
{
    public partial class Empleados : System.Web.UI.Page
    {
        private DepartamentoDAL departamentoDAL = new DepartamentoDAL();
        private EmpleadosService webService = new EmpleadosService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Deshabilitar caché de la página
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();
            Response.AppendHeader("Pragma", "no-cache");

            if (!IsPostBack)
            {
                CargarDepartamentos();
                CargarDepartamentosFiltro();
                CargarEmpleados();
                ActualizarEstadisticas();
            }
        }

        private void CargarDepartamentos()
        {
            ddlDepartamento.DataSource = departamentoDAL.ObtenerDepartamentosActivos();
            ddlDepartamento.DataTextField = "NombreDepartamento";
            ddlDepartamento.DataValueField = "IdDepartamento";
            ddlDepartamento.DataBind();
            ddlDepartamento.Items.Insert(0, new ListItem("Seleccione...", "0"));
        }

        private void CargarDepartamentosFiltro()
        {
            ddlFiltroDepartamento.DataSource = departamentoDAL.ObtenerDepartamentosActivos();
            ddlFiltroDepartamento.DataTextField = "NombreDepartamento";
            ddlFiltroDepartamento.DataValueField = "IdDepartamento";
            ddlFiltroDepartamento.DataBind();
            ddlFiltroDepartamento.Items.Insert(0, new ListItem("Todos los departamentos", "0"));
        }

        private void CargarEmpleados(int idDepartamento = 0)
        {
            // Limpiar caché del GridView
            gvEmpleados.DataSource = null;
            gvEmpleados.DataBind();

            var empleados = webService.ObtenerEmpleados();

            if (idDepartamento > 0)
            {
                var empleadosFiltrados = new System.Collections.ArrayList();
                foreach (var emp in empleados)
                {
                    var propIdDep = emp.GetType().GetProperty("IdDepartamento");
                    if (propIdDep != null)
                    {
                        int empIdDep = (int)propIdDep.GetValue(emp);
                        if (empIdDep == idDepartamento)
                        {
                            empleadosFiltrados.Add(emp);
                        }
                    }
                }
                gvEmpleados.DataSource = empleadosFiltrados;
            }
            else
            {
                gvEmpleados.DataSource = empleados;
            }

            gvEmpleados.DataBind();
        }

        private void ActualizarEstadisticas()
        {
            var stats = webService.ObtenerEstadisticas();

            lblTotalEmpleados.Text = stats.Total.ToString();
            lblActivos.Text = stats.Activos.ToString();
            lblInactivos.Text = stats.Inactivos.ToString();
        }

        protected void ddlFiltroDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idDepartamento = Convert.ToInt32(ddlFiltroDepartamento.SelectedValue);
            CargarEmpleados(idDepartamento);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    int idEmpleado = Convert.ToInt32(hfIdEmpleado.Value);
                    string nombres = txtNombres.Text.Trim();
                    string dpi = txtDPI.Text.Trim();
                    string nit = txtNIT.Text.Trim();
                    string direccion = txtDireccion.Text.Trim();
                    string sexo = ddlSexo.SelectedValue;
                    int idDepartamento = Convert.ToInt32(ddlDepartamento.SelectedValue);

                    if (string.IsNullOrEmpty(txtFechaNacimiento.Text))
                    {
                        MostrarMensaje(false, "", "Debe ingresar la fecha de nacimiento");
                        return;
                    }

                    if (string.IsNullOrEmpty(txtFechaIngreso.Text))
                    {
                        MostrarMensaje(false, "", "Debe ingresar la fecha de ingreso");
                        return;
                    }

                    if (!DateTime.TryParse(txtFechaNacimiento.Text, out DateTime fechaNacimiento))
                    {
                        MostrarMensaje(false, "", "La fecha de nacimiento no es válida");
                        return;
                    }

                    if (!DateTime.TryParse(txtFechaIngreso.Text, out DateTime fechaIngreso))
                    {
                        MostrarMensaje(false, "", "La fecha de ingreso no es válida");
                        return;
                    }

                    bool resultado;

                    if (idEmpleado == 0)
                    {
                        resultado = webService.InsertarEmpleado(nombres, dpi, fechaNacimiento, sexo,
                            fechaIngreso, direccion, nit, idDepartamento);

                        if (resultado)
                        {
                            MostrarMensaje(true, "Empleado creado exitosamente", "");
                        }
                        else
                        {
                            MostrarMensaje(false, "", "Error al crear empleado");
                        }
                    }
                    else
                    {
                        resultado = webService.ActualizarEmpleado(idEmpleado, nombres, dpi, fechaNacimiento,
                            sexo, fechaIngreso, direccion, nit, idDepartamento);

                        if (resultado)
                        {
                            MostrarMensaje(true, "Empleado actualizado exitosamente", "");
                        }
                        else
                        {
                            MostrarMensaje(false, "", "Error al actualizar empleado");
                        }
                    }

                    if (resultado)
                    {
                        LimpiarFormulario();

                        // Forzar recarga completa de datos sin caché
                        int filtroActual = Convert.ToInt32(ddlFiltroDepartamento.SelectedValue);
                        CargarEmpleados(filtroActual);
                        ActualizarEstadisticas();

                        ClientScript.RegisterStartupScript(this.GetType(), "CerrarModal",
                            "setTimeout(function(){ cerrarModal(); }, 1500);", true);
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje(false, "", "Error inesperado: " + ex.Message);
                }
            }
        }

        protected string FormatDPI(string dpi)
        {
            if (string.IsNullOrEmpty(dpi) || dpi.Length != 13)
                return dpi;

            return $"{dpi.Substring(0, 4)} {dpi.Substring(4, 5)} {dpi.Substring(9, 4)}";
        }

        protected void gvEmpleados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                try
                {
                    int idEmpleado = Convert.ToInt32(e.CommandArgument);
                    var empleado = webService.ObtenerEmpleadoPorId(idEmpleado);

                    if (empleado != null)
                    {
                        CargarDepartamentos();

                        bool departamentoExiste = false;
                        foreach (ListItem item in ddlDepartamento.Items)
                        {
                            if (item.Value == empleado.IdDepartamento.ToString())
                            {
                                departamentoExiste = true;
                                break;
                            }
                        }

                        if (!departamentoExiste && empleado.IdDepartamento > 0)
                        {
                            DataTable todosLosDepartamentos = departamentoDAL.ObtenerDepartamentos();
                            DataRow[] departamentoInactivo = todosLosDepartamentos.Select($"IdDepartamento = {empleado.IdDepartamento}");

                            if (departamentoInactivo.Length > 0)
                            {
                                string nombreDept = departamentoInactivo[0]["NombreDepartamento"].ToString();
                                ListItem itemInactivo = new ListItem(
                                    nombreDept + " (Inactivo)",
                                    empleado.IdDepartamento.ToString()
                                );
                                itemInactivo.Attributes.Add("class", "dept-inactive");
                                ddlDepartamento.Items.Add(itemInactivo);
                            }
                        }

                        hfIdEmpleado.Value = empleado.IdEmpleado.ToString();
                        txtNombres.Text = empleado.Nombres;
                        txtDPI.Text = empleado.DPI;
                        txtFechaNacimiento.Text = empleado.FechaNacimiento.ToString("yyyy-MM-dd");
                        ddlSexo.SelectedValue = empleado.Sexo;
                        txtFechaIngreso.Text = empleado.FechaIngreso.ToString("yyyy-MM-dd");
                        txtDireccion.Text = empleado.Direccion;
                        txtNIT.Text = empleado.NIT;
                        ddlDepartamento.SelectedValue = empleado.IdDepartamento.ToString();

                        litTituloModal.Text = "Editar Empleado";

                        // Llamar a las funciones de cálculo después de abrir el modal
                        ClientScript.RegisterStartupScript(this.GetType(), "AbrirModal",
                            @"abrirModal(); 
                              setTimeout(function() { 
                                  calcularEdad(); 
                                  calcularTiempoLaboral(); 
                              }, 100);", true);
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje(false, "", "Error al cargar empleado: " + ex.Message);
                }
            }
        }

        private void LimpiarFormulario()
        {
            hfIdEmpleado.Value = "0";
            txtNombres.Text = string.Empty;
            txtDPI.Text = string.Empty;
            txtFechaNacimiento.Text = string.Empty;
            ddlSexo.SelectedIndex = 0;
            txtFechaIngreso.Text = string.Empty;
            txtDireccion.Text = string.Empty;
            txtNIT.Text = string.Empty;
            ddlDepartamento.SelectedIndex = 0;
            lblMensaje.Visible = false;
            litTituloModal.Text = "Nuevo Empleado";
        }

        private void MostrarMensaje(bool exito, string mensajeExito, string mensajeError)
        {
            lblMensaje.Visible = true;
            if (exito)
            {
                lblMensaje.Text = mensajeExito;
                lblMensaje.CssClass = "message message-success";
            }
            else
            {
                lblMensaje.Text = mensajeError;
                lblMensaje.CssClass = "message message-error";
            }
        }
    }
}