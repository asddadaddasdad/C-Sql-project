using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;

namespace PSE_desktop_app
{
    class DataBaseClass
    {
        public static string DS = "DESKTOP-FLSSCRR\\SQLEXPRESS", IC = "Test_Cargo2";
        public static string Users_ID = "null", Password = "null", App_Name = "Администратор - Продажа товара";
        public static string ConnectionStrig = string.Format("Data Source = {0}; Initial Catalog = {1}; Integrated Security = true;", DS, IC, "; Persist Security Info = true; User ID = sa; Password = 1234");
        public SqlConnection connection = new SqlConnection(ConnectionStrig);
        private SqlCommand command = new SqlCommand();
        public DataTable resultTable = new DataTable();
        public SqlDependency dependency = new SqlDependency();
        public enum act { select, manipulation };
        public void sqlExecute(string quety, act act)
        {
            command.Connection = connection;
            command.CommandText = quety;
            command.Notification = null;
            switch (act)
            {
                case act.select:
                    dependency.AddCommandDependency(command);
                    SqlDependency.Start(connection.ConnectionString);
                    connection.Open();
                    resultTable.Load(command.ExecuteReader());
                    connection.Close();
                    break;
                case act.manipulation:
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                    break;
            }
        }
    }
}