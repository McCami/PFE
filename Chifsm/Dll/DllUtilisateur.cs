using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace ASPNETCRUD
{
    public class DllUtilisateur
    {
        private string StrCnn;
        private SqlConnection Cnn;

        public DllUtilisateur()
        {
            StrCnn = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
            Cnn = new SqlConnection(StrCnn);
            Cnn.Open();
        }
        public SqlCommand SelectRechercherUtilisateur(string go)
        {
            SqlCommand cmd = new SqlCommand
            {
                Connection = Cnn,
                CommandType = CommandType.StoredProcedure,
                CommandText = "SelectRechercherUtilisateur"
            };
            cmd.Parameters.AddWithValue("@go", go);
            
            return cmd;
        }
    }
}