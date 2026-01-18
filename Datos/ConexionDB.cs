using System.Configuration;
using System.Data.SqlClient;

namespace PerfilesSA_WebApp.Datos
{
    public class ConexionDB
    {
        public static SqlConnection ObtenerConexion()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PerfilesSAConnection"].ConnectionString;
            return new SqlConnection(connectionString);
        }
    }
}
