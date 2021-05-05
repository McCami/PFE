using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

using System.Web.UI;
using System.Web.UI.WebControls;


namespace ASPNETCRUD
{
    public class DllProduit
    {
        private string StrCnn;
        private SqlConnection Cnn;

        public DllProduit()
        {
            StrCnn = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
            Cnn = new SqlConnection(StrCnn);
            Cnn.Open();
        }
        public SqlCommand SelectAllProduit()
        {
            SqlCommand cmd = new SqlCommand {
            CommandText= "[SelectAllProduit]",
            CommandType=CommandType.StoredProcedure,
            Connection=Cnn
            };
            return cmd;
        }
        public void DeleteProduitbyId(int id)
        {
            SqlCommand cmd = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "[DeleteProduitbyId]",
                Connection = Cnn
            };
            cmd.ExecuteNonQuery();
        }
        static public void DisplayMessage(Control page, string msg)
        {
            string myScript = String.Format("alert('{0}')", msg);
            ScriptManager.RegisterStartupScript(page, page.GetType(), "MyScript", myScript, true);
        }
    }
}