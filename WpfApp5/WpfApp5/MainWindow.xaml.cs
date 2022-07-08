using System;
using System.Collections.Generic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using PSE_desktop_app;

namespace WpfApp5
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void btEnter_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass.Users_ID = pbLogin.Password;
            DataBaseClass.Password = pbPassword.Password;
            DataBaseClass.ConnectionStrig = string.Format(DataBaseClass.ConnectionStrig, DataBaseClass.Users_ID, DataBaseClass.Password);
            DataBaseClass dataBaseClass = new DataBaseClass();
            try
            {
                dataBaseClass.connection.Open();
                Visibility = Visibility.Hidden;
                Admin simpleTablesWindow = new Admin();
                simpleTablesWindow.Show();
            }
            catch
            {
                MessageBox.Show("Не верный логин или пароль!", DataBaseClass.App_Name);
                pbLogin.Focus();
            }
            finally
            {
                dataBaseClass.connection.Close();
                pbLogin.Clear();
                pbPassword.Clear();
            }
        }
    }
}
