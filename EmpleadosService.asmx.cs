using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace PerfilesSA_WebApp
{
    [WebService(Namespace = "http://perfilessa.com/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class EmpleadosService : System.Web.Services.WebService
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["PerfilesSAConnection"].ConnectionString;

        [WebMethod]
        public List<EmpleadoDTO> ObtenerEmpleados()
        {
            List<EmpleadoDTO> empleados = new List<EmpleadoDTO>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SP_ObtenerEmpleados", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            empleados.Add(new EmpleadoDTO
                            {
                                IdEmpleado = Convert.ToInt32(reader["IdEmpleado"]),
                                Nombres = reader["Nombres"].ToString(),
                                DPI = reader["DPI"].ToString(),
                                FechaNacimiento = Convert.ToDateTime(reader["FechaNacimiento"]),
                                Sexo = reader["Sexo"].ToString(),
                                FechaIngreso = Convert.ToDateTime(reader["FechaIngreso"]),
                                Direccion = reader["Direccion"] != DBNull.Value ? reader["Direccion"].ToString() : "",
                                NIT = reader["NIT"] != DBNull.Value ? reader["NIT"].ToString() : "",
                                IdDepartamento = Convert.ToInt32(reader["IdDepartamento"]),
                                NombreDepartamento = reader["NombreDepartamento"].ToString(),
                                Activo = Convert.ToBoolean(reader["Activo"])
                            });
                        }
                    }
                }
            }

            return empleados;
        }

        [WebMethod]
        public EmpleadoDTO ObtenerEmpleadoPorId(int idEmpleado)
        {
            EmpleadoDTO empleado = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SP_ObtenerEmpleadoPorId", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdEmpleado", idEmpleado);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            empleado = new EmpleadoDTO
                            {
                                IdEmpleado = Convert.ToInt32(reader["IdEmpleado"]),
                                Nombres = reader["Nombres"].ToString(),
                                DPI = reader["DPI"].ToString(),
                                FechaNacimiento = Convert.ToDateTime(reader["FechaNacimiento"]),
                                Sexo = reader["Sexo"].ToString(),
                                FechaIngreso = Convert.ToDateTime(reader["FechaIngreso"]),
                                Direccion = reader["Direccion"] != DBNull.Value ? reader["Direccion"].ToString() : "",
                                NIT = reader["NIT"] != DBNull.Value ? reader["NIT"].ToString() : "",
                                IdDepartamento = Convert.ToInt32(reader["IdDepartamento"]),
                                NombreDepartamento = reader["NombreDepartamento"].ToString(),
                                Activo = Convert.ToBoolean(reader["Activo"])
                            };
                        }
                    }
                }
            }

            return empleado;
        }

        [WebMethod]
        public bool InsertarEmpleado(string nombres, string dpi, DateTime fechaNacimiento, string sexo,
            DateTime fechaIngreso, string direccion, string nit, int idDepartamento)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
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

        [WebMethod]
        public bool ActualizarEmpleado(int idEmpleado, string nombres, string dpi, DateTime fechaNacimiento,
            string sexo, DateTime fechaIngreso, string direccion, string nit, int idDepartamento)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
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

        // AGREGUE 1/01/2026
        [WebMethod]
        public EmpleadoEstadisticas ObtenerEstadisticas()
        {
            EmpleadoEstadisticas stats = new EmpleadoEstadisticas();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT 
                COUNT(*) as Total,
                SUM(CASE WHEN Activo = 1 THEN 1 ELSE 0 END) as Activos,
                SUM(CASE WHEN Activo = 0 THEN 1 ELSE 0 END) as Inactivos
            FROM Empleados";

                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    stats.Total = Convert.ToInt32(reader["Total"]);
                    stats.Activos = Convert.ToInt32(reader["Activos"]);
                    stats.Inactivos = Convert.ToInt32(reader["Inactivos"]);
                }
            }

            return stats;
        }


        [WebMethod]
        public DataSet ObtenerReporteEmpleados(string fechaInicio, string fechaFin, int? idDepartamento)
        {
            DataSet ds = new DataSet();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SP_ReporteEmpleados", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (!string.IsNullOrEmpty(fechaInicio))
                        cmd.Parameters.AddWithValue("@FechaIngresoInicio", Convert.ToDateTime(fechaInicio));
                    else
                        cmd.Parameters.AddWithValue("@FechaIngresoInicio", DBNull.Value);

                    if (!string.IsNullOrEmpty(fechaFin))
                        cmd.Parameters.AddWithValue("@FechaIngresoFin", Convert.ToDateTime(fechaFin));
                    else
                        cmd.Parameters.AddWithValue("@FechaIngresoFin", DBNull.Value);

                    if (idDepartamento.HasValue && idDepartamento.Value > 0)
                        cmd.Parameters.AddWithValue("@IdDepartamento", idDepartamento.Value);
                    else
                        cmd.Parameters.AddWithValue("@IdDepartamento", DBNull.Value);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(ds);
                }
            }

            return ds;
        }
    }

    [Serializable]
    public class EmpleadoDTO
    {
        public int IdEmpleado { get; set; }
        public string Nombres { get; set; }
        public string DPI { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string Sexo { get; set; }
        public DateTime FechaIngreso { get; set; }
        public string Direccion { get; set; }
        public string NIT { get; set; }
        public int IdDepartamento { get; set; }
        public string NombreDepartamento { get; set; }
        public bool Activo { get; set; }
    }
}
//AGREGUE 1/01/2026

public class EmpleadoEstadisticas
{
    public int Total { get; set; }
    public int Activos { get; set; }
    public int Inactivos { get; set; }
}


