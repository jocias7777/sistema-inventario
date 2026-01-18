using System;
using System.Data;
using System.Data.SqlClient;

namespace PerfilesSA_WebApp.Datos
{
    public class EmpleadoDAL
    {
        public DataTable ObtenerEmpleados()
        {
            using (SqlConnection conn = ConexionDB.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("SP_ObtenerEmpleados", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    return dt;
                }
            }
        }

        public bool InsertarEmpleado(string nombres, string dpi, DateTime fechaNacimiento,
            string sexo, DateTime fechaIngreso, string direccion, string nit, int idDepartamento)
        {
            try
            {
                using (SqlConnection conn = ConexionDB.ObtenerConexion())
                {
                    using (SqlCommand cmd = new SqlCommand("SP_InsertarEmpleado", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Nombres", nombres);
                        cmd.Parameters.AddWithValue("@DPI", dpi);
                        cmd.Parameters.AddWithValue("@FechaNacimiento", fechaNacimiento);
                        cmd.Parameters.AddWithValue("@Sexo", sexo);
                        cmd.Parameters.AddWithValue("@FechaIngreso", fechaIngreso);
                        cmd.Parameters.AddWithValue("@Direccion", string.IsNullOrEmpty(direccion) ? (object)DBNull.Value : direccion);
                        cmd.Parameters.AddWithValue("@NIT", string.IsNullOrEmpty(nit) ? (object)DBNull.Value : nit);
                        cmd.Parameters.AddWithValue("@IdDepartamento", idDepartamento);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        return true;
                    }
                }
            }
            catch
            {
                return false;
            }
        }

        public bool ActualizarEmpleado(int idEmpleado, string nombres, string dpi, DateTime fechaNacimiento,
            string sexo, DateTime fechaIngreso, string direccion, string nit, int idDepartamento)
        {
            try
            {
                using (SqlConnection conn = ConexionDB.ObtenerConexion())
                {
                    using (SqlCommand cmd = new SqlCommand("SP_ActualizarEmpleado", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IdEmpleado", idEmpleado);
                        cmd.Parameters.AddWithValue("@Nombres", nombres);
                        cmd.Parameters.AddWithValue("@DPI", dpi);
                        cmd.Parameters.AddWithValue("@FechaNacimiento", fechaNacimiento);
                        cmd.Parameters.AddWithValue("@Sexo", sexo);
                        cmd.Parameters.AddWithValue("@FechaIngreso", fechaIngreso);
                        cmd.Parameters.AddWithValue("@Direccion", string.IsNullOrEmpty(direccion) ? (object)DBNull.Value : direccion);
                        cmd.Parameters.AddWithValue("@NIT", string.IsNullOrEmpty(nit) ? (object)DBNull.Value : nit);
                        cmd.Parameters.AddWithValue("@IdDepartamento", idDepartamento);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        return true;
                    }
                }
            }
            catch
            {
                return false;
            }
        }

        public bool InactivarEmpleadosPorDepartamento(int idDepartamento)
        {
            try
            {
                using (SqlConnection conn = ConexionDB.ObtenerConexion())
                {
                    string query = "UPDATE Empleados SET Activo = 0 WHERE IdDepartamento = @IdDepartamento AND Activo = 1";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@IdDepartamento", idDepartamento);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool ActivarEmpleadosPorDepartamento(int idDepartamento)
        {
            try
            {
                using (SqlConnection conn = ConexionDB.ObtenerConexion())
                {
                    string query = "UPDATE Empleados SET Activo = 1 WHERE IdDepartamento = @IdDepartamento AND Activo = 0";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@IdDepartamento", idDepartamento);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public int ContarEmpleadosPorDepartamento(int idDepartamento)
        {
            try
            {
                using (SqlConnection conn = ConexionDB.ObtenerConexion())
                {
                    string query = "SELECT COUNT(*) FROM Empleados WHERE IdDepartamento = @IdDepartamento";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@IdDepartamento", idDepartamento);

                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count;
                }
            }
            catch (Exception)
            {
                return 0;
            }
        }


        public DataTable ObtenerReporteEmpleados(DateTime? fechaInicio, DateTime? fechaFin, int? idDepartamento)
        {
            using (SqlConnection conn = ConexionDB.ObtenerConexion())
            {
                using (SqlCommand cmd = new SqlCommand("SP_ReporteEmpleados", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FechaIngresoInicio", fechaInicio.HasValue ? (object)fechaInicio.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@FechaIngresoFin", fechaFin.HasValue ? (object)fechaFin.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@IdDepartamento", idDepartamento.HasValue && idDepartamento.Value > 0 ? (object)idDepartamento.Value : DBNull.Value);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    return dt;
                }
            }
        }
    }
}
