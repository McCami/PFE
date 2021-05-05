using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace ASPNETCRUD
{
    public class DllLogin
    {
        private string StrCnn;
        private SqlConnection Cnn;
        
        public DllLogin()
        {
            StrCnn = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
            Cnn = new SqlConnection(StrCnn);
            Cnn.Open();
        }
        public bool VerificationEmail(string Mail)
        {
            SqlCommand cmd = new SqlCommand
            {
                Connection = Cnn,
                CommandType = CommandType.StoredProcedure,
                CommandText = "[VerificationEmail]"
            };
            cmd.Parameters.AddWithValue("@Email", Mail);
            return (int)cmd.ExecuteScalar()>0;
        }
        public bool Authentification(string Mail, string Pwd)
        {
            SqlCommand cmd = new SqlCommand
            {
                Connection = Cnn,
                CommandType = CommandType.StoredProcedure,
                CommandText = "[Authentification]"
            };
            cmd.Parameters.AddWithValue("@Email", Mail);
            cmd.Parameters.AddWithValue("@Pwd", Pwd);
            return (int)cmd.ExecuteScalar() > 0;
        }
    }
}