using PerfilesSA_WebApp.Datos;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PerfilesSA_WebApp
{
    public partial class Departamentos : System.Web.UI.Page
    {
        private DepartamentoDAL departamentoDAL = new DepartamentoDAL();
        private EmpleadoDAL empleadoDAL = new EmpleadoDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDepartamentos();
                ActualizarEstadisticas();
            }
        }

        private void CargarDepartamentos()
        {
            DataTable dt = departamentoDAL.ObtenerDepartamentos();
            gvDepartamentos.DataSource = dt;
            gvDepartamentos.DataBind();
        }

        private void ActualizarEstadisticas()
        {
            DataTable dt = departamentoDAL.ObtenerEstadisticas();

            if (dt.Rows.Count > 0)
            {
                lblTotalDepartamentos.Text = dt.Rows[0]["Total"].ToString();
                lblActivos.Text = dt.Rows[0]["Activos"].ToString();
                lblInactivos.Text = dt.Rows[0]["Inactivos"].ToString();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int idDepartamento = Convert.ToInt32(hfIdDepartamento.Value);
                string nombre = txtNombre.Text.Trim();
                string descripcion = txtDescripcion.Text.Trim();
                bool activo = true;

                bool resultado;

                if (idDepartamento == 0)
                {
                    resultado = departamentoDAL.InsertarDepartamento(nombre, descripcion, activo);
                    MostrarMensaje(resultado, "Departamento creado exitosamente", "Error al crear departamento");
                }
                else
                {
                    resultado = departamentoDAL.ActualizarDepartamento(idDepartamento, nombre, descripcion, activo);
                    MostrarMensaje(resultado, "Departamento actualizado exitosamente", "Error al actualizar departamento");
                }

                if (resultado)
                {
                    LimpiarFormulario();
                    CargarDepartamentos();
                    ActualizarEstadisticas();
                    ScriptManager.RegisterStartupScript(this, GetType(), "CerrarModal", "setTimeout(function(){ cerrarModal(); }, 1500);", true);
                }
            }
        }

        protected void gvDepartamentos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int idDepartamento = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                DataTable dt = departamentoDAL.ObtenerDepartamentos();
                DataRow[] rows = dt.Select($"IdDepartamento = {idDepartamento}");

                if (rows.Length > 0)
                {
                    hfIdDepartamento.Value = idDepartamento.ToString();
                    txtNombre.Text = rows[0]["NombreDepartamento"].ToString();
                    txtDescripcion.Text = rows[0]["Descripcion"].ToString();

                    litTituloModal.Text = "Editar Departamento";
                    ScriptManager.RegisterStartupScript(this, GetType(), "AbrirModal", "abrirModal();", true);
                }
            }
            else if (e.CommandName == "ToggleEstado")
            {
                // Obtener el estado actual del departamento
                DataTable dt = departamentoDAL.ObtenerDepartamentos();
                DataRow[] rows = dt.Select($"IdDepartamento = {idDepartamento}");

                if (rows.Length > 0)
                {
                    bool estadoActual = Convert.ToBoolean(rows[0]["Activo"]);
                    int cantidadEmpleados = empleadoDAL.ContarEmpleadosPorDepartamento(idDepartamento);
                    string nombreDepartamento = rows[0]["NombreDepartamento"].ToString();

                    // Guardar datos en HiddenFields
                    hfIdDepartamentoConfirm.Value = idDepartamento.ToString();
                    hfEstadoActual.Value = estadoActual.ToString();
                    hfCantidadEmpleados.Value = cantidadEmpleados.ToString();
                    hfNombreDepartamento.Value = nombreDepartamento;

                    // Configurar el modal de confirmación
                    if (estadoActual) // Está activo, va a desactivar
                    {
                        litTituloConfirm.Text = "¿Deshabilitar departamento?";
                        litMensajeConfirm.Text = $"Al deshabilitar este departamento, todos los empleados asignados ({cantidadEmpleados}) serán marcados como inactivos.";
                        btnConfirmarAccion.Text = "Deshabilitar";
                        btnConfirmarAccion.CssClass = "btn-modal-danger";
                    }
                    else // Está inactivo, va a activar
                    {
                        litTituloConfirm.Text = "¿Habilitar departamento?";
                        litMensajeConfirm.Text = $"Al habilitar este departamento, todos los empleados asignados ({cantidadEmpleados}) serán marcados como activos.";
                        btnConfirmarAccion.Text = "Habilitar";
                        btnConfirmarAccion.CssClass = "btn-modal-success";
                    }

                    // Mostrar modal de confirmación
                    ScriptManager.RegisterStartupScript(this, GetType(), "AbrirModalConfirm", "abrirModalConfirm();", true);
                }
            }
        }

        protected void btnConfirmarAccion_Click(object sender, EventArgs e)
        {
            int idDepartamento = Convert.ToInt32(hfIdDepartamentoConfirm.Value);
            bool estadoActual = Convert.ToBoolean(hfEstadoActual.Value);

            // Cambiar el estado del departamento
            bool resultado = departamentoDAL.CambiarEstado(idDepartamento);

            if (resultado)
            {
                // Si el departamento se inactivó, inactivar también sus empleados
                if (estadoActual == true) // Desactivar
                {
                    empleadoDAL.InactivarEmpleadosPorDepartamento(idDepartamento);
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowToast",
                        "showToast('error', 'Departamento desactivado correctamente');",
                        true);
                }
                else // Activar
                {
                    empleadoDAL.ActivarEmpleadosPorDepartamento(idDepartamento);
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowToast",
                        "showToast('success', 'Departamento activado correctamente');",
                        true);
                }

                CargarDepartamentos();
                ActualizarEstadisticas();

                // Cerrar modal de confirmación
                ScriptManager.RegisterStartupScript(this, GetType(), "CerrarModalConfirm", "cerrarModalConfirm();", true);
            }
            else
            {
                MostrarMensaje(false, "", "Error al cambiar el estado");
            }
        }

        private void LimpiarFormulario()
        {
            hfIdDepartamento.Value = "0";
            txtNombre.Text = string.Empty;
            txtDescripcion.Text = string.Empty;
            lblMensaje.Visible = false;
            litTituloModal.Text = "Nuevo Departamento";
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
