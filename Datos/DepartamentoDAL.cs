using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PerfilesSA_WebApp.Datos
{
    public class DepartamentoDAL
    {
        private readonly string _connectionString;

        public DepartamentoDAL()
        {
            _connectionString = ConfigurationManager.ConnectionStrings["PerfilesSAConnection"].ConnectionString;
        }

        public DataTable ObtenerDepartamentos()
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SP_ObtenerDepartamentos", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable ObtenerDepartamentosActivos()
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SP_ObtenerDepartamentosActivos", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }

            return dt;
        }

        public bool InsertarDepartamento(string nombre, string descripcion, bool activo)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_InsertarDepartamento", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@NombreDepartamento", nombre);
                        cmd.Parameters.AddWithValue("@Descripcion", descripcion ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Activo", activo);

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

        public DataTable ObtenerEstadisticas()
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                string query = @"
            SELECT 
                COUNT(*) as Total,
                SUM(CASE WHEN Activo = 1 THEN 1 ELSE 0 END) as Activos,
                SUM(CASE WHEN Activo = 0 THEN 1 ELSE 0 END) as Inactivos
            FROM Departamentos";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    adapter.Fill(dt);
                }
            }

            return dt;
        }

        public bool CambiarEstado(int idDepartamento)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    string query = @"
                UPDATE Departamentos 
                SET Activo = CASE WHEN Activo = 1 THEN 0 ELSE 1 END 
                WHERE IdDepartamento = @IdDepartamento";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
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


        public bool ActualizarDepartamento(int id, string nombre, string descripcion, bool activo)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_ActualizarDepartamento", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IdDepartamento", id);
                        cmd.Parameters.AddWithValue("@NombreDepartamento", nombre);
                        cmd.Parameters.AddWithValue("@Descripcion", descripcion ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Activo", activo);

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
    }
}
