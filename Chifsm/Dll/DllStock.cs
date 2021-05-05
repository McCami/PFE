using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace ASPNETCRUD
{
    public class DllStock
    {
        private string StrCnn;
        private SqlConnection Cnn;
        private SqlCommand DelCmd;
        private SqlCommand SelCmd;
        public DllStock()
        {
            StrCnn = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
            Cnn = new SqlConnection(StrCnn);
            Cnn.Open();
        }
        public void DeleteStock(int id)
        {
            DelCmd = new SqlCommand 
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "DeleteStock",
                Connection = Cnn
            };

            DelCmd.Parameters.AddWithValue("@Id", id);          
            DelCmd.ExecuteNonQuery();         
            

        }
        public SqlCommand SelectSearchStock(string CAS,string label)
        {
            SelCmd = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "SelectSearchStock",
                Connection = Cnn
            };
            SelCmd.Parameters.AddWithValue("@CAS", CAS);
            SelCmd.Parameters.AddWithValue("@Label", label);
            return SelCmd;
        }
        public SqlCommand SelectQuantityStock(float Qte,int Mag, int IdLot)
        {
            SelCmd = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "SelectQuantityStock",
                Connection = Cnn
            };
            SelCmd.Parameters.AddWithValue("@Qte", Qte);
            SelCmd.Parameters.AddWithValue("@Mag", Mag);
            SelCmd.Parameters.AddWithValue("@IdLot", IdLot);
            return SelCmd;
        }
        public int RetournerID(int _id)
        {
            string id="";
            SqlCommand SelCmdId = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "RetournerID",
                Connection = Cnn
            };
            SelCmdId.Parameters.AddWithValue("@_id", _id);
            SqlDataReader dataReadr = SelCmdId.ExecuteReader();
            if (dataReadr != null)
            {
                while (dataReadr.Read())
                {
                    id = Convert.ToString(dataReadr["Id"]);
                }
            }
            dataReadr.Close();
            if (id == string.Empty)
            {
                return Convert.ToInt32(id);
            }
            else
            {
                 return Convert.ToInt32(id);
            }
        }
        public SqlCommand SelectStockTotal()
        {
            SelCmd = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "SelectStockTotal",
                Connection = Cnn
            };
            
            return SelCmd;
        }
        public void Disconnect()
        {
            Cnn.Close();
        }
        public void SommationLot()
        {
            int max = 100;
            int[] Tab = new int[max];
            string[] quant = new string[max];
            string[] mag = new string[max];
            string[] lot = new string[max];

            SelCmd = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "SelectStockTotal",
                Connection = Cnn
            };
           
                    SelCmd = new SqlCommand
                    {
                        CommandType = CommandType.StoredProcedure,
                        CommandText = "SommationQuantityStock",
                        Connection = Cnn
                    };
                    SqlDataReader reader = SelCmd.ExecuteReader();
                    if (reader != null)
                    {
                        int i = 0;
                        while (reader.Read())
                        {
                            Tab[i] = Convert.ToInt32(reader["nbr_doublon"]);
                            quant[i] = Convert.ToString(reader["Quantite"]);
                            mag[i] = Convert.ToString(reader["IdMagasin"]);
                            lot[i] = Convert.ToString(reader["IdLot"]);
                            i++;
                        }
                        reader.Close();
                        int j = 0;
                        while (j < i)
                        {
                            while (Tab[j] > 0)
                            {
                                SqlCommand DelCmd = new SqlCommand
                                {
                                    CommandType = CommandType.StoredProcedure,
                                    CommandText = "DeleteStockId",
                                    Connection = Cnn
                                };

                                DelCmd.Parameters.AddWithValue("@lot", lot[j]);
                                DelCmd.Parameters.AddWithValue("@mag", mag[j]);

                       
                                DelCmd.ExecuteNonQuery();
                                Tab[j]--;

                            }
                            Addupdate("", lot[j], mag[j], quant[j]);
                            j++;
                        }
                    }


            
            Tab = null;
            quant = null;
            mag = null;
            lot = null;
            Cnn.Close();

        }
        public void Addupdate(string Stock, string Lot, string Mag, string quantite)
        {
            
                    Cnn.Open();
                    SqlCommand cmmd = new SqlCommand();
                    cmmd.CommandType = CommandType.StoredProcedure;                   
                    cmmd.CommandText = "AddUpdateStock";
                    cmmd.Connection = Cnn;
                    cmmd.Parameters.AddWithValue("@Id", Stock);//find id
                    cmmd.Parameters.AddWithValue("@IdLot", Convert.ToInt32(Lot));//idlot
                    cmmd.Parameters.AddWithValue("@IdMagasin", Convert.ToInt32(Mag));//idmagasin
                    cmmd.Parameters.AddWithValue("@Quantite", Convert.ToInt32(quantite));//quanité
                    cmmd.ExecuteNonQuery();
                    Cnn.Close();             

        }
        public void Supprimer(string id)
        {
            Cnn.Open();
            SqlCommand cmmd = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "DeleteStock",
                Connection = Cnn
            };//SqlCommand("Delete From " + table + " Where Id ='" + id + "';", connection);
            cmmd.Parameters.AddWithValue("@Id", Convert.ToInt32(id));
            cmmd.ExecuteNonQuery();
            Cnn.Close();
        }
        public string DateExpirationMessage()
        {
            string []message = new string[12];
            string concat = string.Empty;
          
                    int x = DateTime.Now.Month;
                    DateTime time = new DateTime(DateTime.Now.Year, x + 1, DateTime.Now.Day);
                    Cnn.Open();
            SelCmd = new SqlCommand
            {
                Connection = Cnn,
                CommandType = CommandType.StoredProcedure,
                CommandText = "DatePreemptioMessage"

            };
            SelCmd.Parameters.AddWithValue("@time", time);
            SqlDataReader sqlDataReader = SelCmd.ExecuteReader();

                    if (sqlDataReader != null)
                    {
                        int i = 0;
                        while (sqlDataReader.Read())
                        {

                            message[i] = Convert.ToString(sqlDataReader["Label"]) + " va bientôt expirer le " + Convert.ToDateTime(sqlDataReader["DatePreemption"]).ToShortDateString() + " " + "\n";
                            i++;
                        }



                    }
            return message[0];
        }
        public SqlCommand SommeQuantiteRechercher(int y)
        {
            SqlCommand command = new SqlCommand
            {
                Connection = Cnn,
                CommandType = CommandType.StoredProcedure,
                CommandText = "SommeQuantiteRecherche"
            };
            command.Parameters.AddWithValue("@y", y);
            return command;
        }
        public SqlCommand SommeQuantiteRechercherEmpla(int yy)
        {
            SqlCommand command = new SqlCommand
            {
                Connection = Cnn,
                CommandType = CommandType.StoredProcedure,
                CommandText = "SommeQuantiteRechercheEmpla"
            };
            command.Parameters.AddWithValue("@yy", yy);
            return command;
        }


    }
}