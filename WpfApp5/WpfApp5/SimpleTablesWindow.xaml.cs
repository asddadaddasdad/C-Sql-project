using PSE_desktop_app;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace WpfApp5
{
    /// <summary>
    /// Логика взаимодействия для Admin.xaml
    /// </summary>
    public partial class Admin : Window
    {
        public Admin()
        {
            InitializeComponent();
        }

        private void Type_OrganizationFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_Type_Organization], [Type_Name] from [dbo].[Type_Organization]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChangeType_Organization;
                    dgType_Organization.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgType_Organization.Columns[0].Visibility = Visibility.Hidden;
                    dgType_Organization.Columns[1].Header = "Название Организации";
                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChangeType_Organization(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                Type_OrganizationFill();
            }
        }

        private void dgType_Organization_Loaded(object sender, RoutedEventArgs e)
        {
            Type_OrganizationFill();
        }

        private void btType_OrganizationInsert_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("insert into [dbo].[Type_Organization] ([Type_Name]) values ('{0}')", tbType_Organization.Text), DataBaseClass.act.manipulation);
            tbType_Organization.Text = "";
        }

        private void btType_OrganizationUpdate_Click(object sender, RoutedEventArgs e)
        {
            //update [dbo].[Type_Organization] set [Type_Name] = '' where [ID_Type_Organization] = 
            DataBaseClass dataBaseClass = new DataBaseClass();
            DataRowView dataRowView = dgType_Organization.SelectedItems[0] as DataRowView;
            dataBaseClass.sqlExecute(String.Format("update [dbo].[Type_Organization] set [Type_Name] = '{0}' where [ID_Type_Organization] = {1}", tbType_Organization.Text, dataRowView[0]), DataBaseClass.act.manipulation);
            tbType_Organization.Text = "";
        }

        private void btType_OrganizationDelete_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRowView = dgType_Organization.SelectedItems[0] as DataRowView;
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("delete [dbo].[Type_Organization] where [ID_Type_Organization] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
        }

        private void dgType_Organization_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            try
            {
                DataRowView dataRowView = dgType_Organization.SelectedItems[0] as DataRowView;
                tbType_Organization.Text = dataRowView[1].ToString();
            }
            catch { }
        }

        // ##########################Права############################################
        private void LicenseFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_License], [Type_License] from [dbo].[License]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChange_License;
                    dgLicense.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgLicense.Columns[0].Visibility = Visibility.Hidden;
                    dgLicense.Columns[1].Header = "Название прав";

                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChange_License(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                LicenseFill();
            }
        }
        private void dgLicense_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                LicenseFill();
            }
            catch { }
        }

        private void btLicense_Insert_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("insert into [dbo].[License] ([Type_License]) values ('{0}')", tb_License.Text), DataBaseClass.act.manipulation);
            tb_License.Text = "";
        }

        private void btLicense_Delete_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRowView = dgLicense.SelectedItems[0] as DataRowView;
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("delete [dbo].[License] where [ID_License] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
        }

        private void btType_License_Update(object sender, RoutedEventArgs e)
        {
            //update [dbo].[Type_Organization] set [Type_Name] = '' where [ID_Type_Organization] = 
            DataBaseClass dataBaseClass = new DataBaseClass();
            DataRowView dataRowView = dgLicense.SelectedItems[0] as DataRowView;
            dataBaseClass.sqlExecute(String.Format("update [dbo].[License] set [Type_License] = '{0}' where [ID_License] = {1}", tb_License.Text, dataRowView[0]), DataBaseClass.act.manipulation);
            tb_License.Text = "";
        }

        private void dgLicense_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            try
            {
                DataRowView dataRowView = dgLicense.SelectedItems[0] as DataRowView;
                tb_License.Text = dataRowView[1].ToString();
            }
            catch { }
        }

        // #######################################Брэнд############################################3
        private void BrandFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_Brand], [Name_Brand] from [dbo].[Brand]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChange_Brand;
                    dgBrand.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgBrand.Columns[0].Visibility = Visibility.Hidden;
                    dgBrand.Columns[1].Header = "Назваие Бренда";
                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChange_Brand(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                BrandFill();
            }
        }

        private void dgBrand_Loaded(object sender, RoutedEventArgs e)
        {
            BrandFill();
        }

        private void btBrand_Insert_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute(String.Format("insert into [dbo].[Brand] ([Name_Brand]) values ('{0}')", tb_Brand.Text), DataBaseClass.act.manipulation);
                tb_Brand.Text = "";
            }
            catch { }
            
        }

        private void btBrand_Delete_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRowView = dgBrand.SelectedItems[0] as DataRowView;
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("delete [dbo].[Brand] where [ID_Brand] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
        }

        private void btBrand_Update_Click(object sender, RoutedEventArgs e)
        {
            //update [dbo].[Type_Organization] set [Type_Name] = '' where [ID_Type_Organization] = 
            DataBaseClass dataBaseClass = new DataBaseClass();
            DataRowView dataRowView = dgBrand.SelectedItems[0] as DataRowView;
            dataBaseClass.sqlExecute(String.Format("update [dbo].[Brand] set [Name_Brand] = '{0}' where [ID_Brand] = {1}", tb_Brand.Text, dataRowView[0]), DataBaseClass.act.manipulation);
            tb_Brand.Text = "";
        }

        private void dgBrand_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            try
            {
                DataRowView dataRowView = dgBrand.SelectedItems[0] as DataRowView;
                tb_Brand.Text = dataRowView[1].ToString();
            }
            catch { }
        }

        //#########################################################Точки Доставки#######################################
        

        private void PostFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_Post], [Name_Post] from [dbo].[Post]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChange_Post;
                    dgPost.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgPost.Columns[0].Visibility = Visibility.Hidden;
                    dgPost.Columns[1].Header = "Название должности";
                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChange_Post(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                PostFill();
            }
        }

        private void dgPost_Loaded(object sender, RoutedEventArgs e)
        {
            PostFill();
        }

        private void btPost_Insert_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("insert into [dbo].[Post] ([Name_Post]) values ('{0}')", tb_Post.Text), DataBaseClass.act.manipulation);
            tb_Post.Text = "";
        }

        private void btPost_Update_Click(object sender, RoutedEventArgs e)
        {
            //update [dbo].[Type_Organization] set [Type_Name] = '' where [ID_Type_Organization] = 
            DataBaseClass dataBaseClass = new DataBaseClass();
            DataRowView dataRowView = dgPost.SelectedItems[0] as DataRowView;
            dataBaseClass.sqlExecute(String.Format("update [dbo].[Post] set [Name_Post] = '{0}' where [ID_Post] = {1}", tb_Post.Text, dataRowView[0]), DataBaseClass.act.manipulation);
            tb_Post.Text = "";
        }

        private void btPost_Delete_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRowView = dgPost.SelectedItems[0] as DataRowView;
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("delete [dbo].[Post] where [ID_Post] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
        }

        private void dgPost_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            try
            {
                DataRowView dataRowView = dgPost.SelectedItems[0] as DataRowView;
                tb_Post.Text = dataRowView[1].ToString();
            }
            catch { }
        }

        //##########################################################################################################################
        private void CountryFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_Country], [Name_Country] from [dbo].[Country]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChange_Country;
                    dgCountry.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgCountry.Columns[0].Visibility = Visibility.Hidden;
                    dgCountry.Columns[1].Header = "Страна Производителя";
                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChange_Country(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                CountryFill();
            }
        }
        private void dgCountry_Loaded(object sender, RoutedEventArgs e)
        {
            CountryFill();
        }

        private void btCountry_Insert_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("insert into [dbo].[Country] ([Name_Country]) values ('{0}')", tb_Country.Text), DataBaseClass.act.manipulation);
            tb_Country.Text = "";
        }

        private void btCountry_Update_Click(object sender, RoutedEventArgs e)
        {
            //update [dbo].[Type_Organization] set [Type_Name] = '' where [ID_Type_Organization] = 
            DataBaseClass dataBaseClass = new DataBaseClass();
            DataRowView dataRowView = dgCountry.SelectedItems[0] as DataRowView;
            dataBaseClass.sqlExecute(String.Format("update [dbo].[Country] set [Name_Country] = '{0}' where [ID_Country] = {1}", tb_Country.Text, dataRowView[0]), DataBaseClass.act.manipulation);
            tb_Country.Text = "";
        }

        private void btCountry_Delete_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRowView = dgCountry.SelectedItems[0] as DataRowView;
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("delete [dbo].[Country] where [ID_Country] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
        }

        private void dgCountry_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            try
            {
                DataRowView dataRowView = dgCountry.SelectedItems[0] as DataRowView;
                tb_Country.Text = dataRowView[1].ToString();
            }
            catch { }
        }
        //##########################
        private void CargoFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_Cargo], [Description_Cargo], [Weight_Cargo], [Length_Cargo], [Width_Cargo], [Height_Cargo] from [dbo].[Cargo]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChange_Cargo;
                    dgCargo.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgCargo.Columns[0].Visibility = Visibility.Hidden;
                    dgCargo.Columns[1].Header = "Описание";
                    dgCargo.Columns[2].Header = "Вес";
                    dgCargo.Columns[3].Header = "Высота";
                    dgCargo.Columns[4].Header = "Длина";
                    dgCargo.Columns[5].Header = "Ширина";
                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChange_Cargo(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                CargoFill();
            }
        }

        private void dgCargo_Loaded(object sender, RoutedEventArgs e)
        {
            CargoFill();
        }

        private void btCargo_Insert_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("insert into [dbo].[Cargo] ([Description_Cargo], [Weight_Cargo], [Length_Cargo], [Width_Cargo], [Height_Cargo]) values ('{0}', '{1}', '{2}', '{3}', '{4}')", tbCargo_opisanie.Text, tbCargo_ves.Text, tbCargo_dlina.Text, tbCargo_visota.Text, tbCargo_shirina.Text), DataBaseClass.act.manipulation);
            tbType_Organization.Text = "";
            tbCargo_opisanie.Text = "";
            tbCargo_ves.Text = "";
            tbCargo_dlina.Text = "";
            tbCargo_visota.Text = "";
            tbCargo_shirina.Text = "";
        }

        private void btCargo_Update_Click(object sender, RoutedEventArgs e)
        {
            //update [dbo].[Type_Organization] set [Type_Name] = '' where [ID_Type_Organization] = 
            DataBaseClass dataBaseClass = new DataBaseClass();
            DataRowView dataRowView = dgCargo.SelectedItems[0] as DataRowView;
            dataBaseClass.sqlExecute(String.Format("update [dbo].[Cargo] set [Description_Cargo] = '{0}'," +
                "[Weight_Cargo] = '{1}'," +
                "[Length_Cargo] = '{2}'," +
                "[Width_Cargo] = '{3}'," +
                "[Height_Cargo] = '{4}'" +
                "where [ID_Cargo] = {5}",
                tbCargo_opisanie.Text, tbCargo_ves.Text, tbCargo_dlina.Text, tbCargo_visota.Text, tbCargo_shirina.Text, dataRowView[0]), DataBaseClass.act.manipulation); 
        }

        private void btCargo_Delete_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRowView = dgCargo.SelectedItems[0] as DataRowView;
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("delete [dbo].[Cargo] where [ID_Cargo] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
        }

        private void dgCargo_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            try
            {
                DataRowView dataRowView = dgCargo.SelectedItems[0] as DataRowView;
                tbCargo_opisanie.Text = dataRowView[1].ToString();
                tbCargo_ves.Text = dataRowView[2].ToString();
                tbCargo_dlina.Text = dataRowView[3].ToString();
                tbCargo_visota.Text = dataRowView[4].ToString();
                tbCargo_shirina.Text = dataRowView[5].ToString();
            }
            catch { }
        }


        private void ModelFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_Model], [Name_Model], [Name_Brand] from [dbo].[Model] inner join [dbo].[Brand] on [ID_Brand] = [Brand_ID]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChange_Model;
                    dgModel.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgModel.Columns[0].Visibility = Visibility.Hidden;
                    dgModel.Columns[1].Header = "Модель";
                    dgModel.Columns[2].Header = "Марка";
                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChange_Model(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                ModelFill();
            }
        }

        private void dgModel_Loaded(object sender, RoutedEventArgs e)
        {
            ModelFill();
            cbModel_ObjFill();
        }
        //dataBaseClass.sqlExecute("select [ID_Brand], [Name_Brand] from [dbo].[Brand] inner join [dbo].[Model] on ID_Brand = ID_Model", DataBaseClass.act.select);

        private void cbModel_ObjFill()
        {
            Action action = () =>
            {
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute("select [ID_Brand], [Name_Brand] from [dbo].[Brand] inner join [dbo].[Model] on ID_Brand = ID_Model", DataBaseClass.act.select);
                dataBaseClass.dependency.OnChange += cbModel_Dependency_OnChange;
                cbModel_Obj.ItemsSource = dataBaseClass.resultTable.DefaultView;
                cbModel_Obj.SelectedValuePath = dataBaseClass.resultTable.Columns[0].ColumnName;
                cbModel_Obj.DisplayMemberPath = dataBaseClass.resultTable.Columns[1].ColumnName;

            };
            Dispatcher.Invoke(action);
        }

        private void cbModel_Dependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
                cbModel_ObjFill();
        }
        private void cbModel_Obj_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                cbModel_ObjFill();
            }
            catch
            {

            }
        }

        private void btModel_Insert_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(string.Format("insert into [dbo].[Model] ([Brand_ID], [Name_Model])" +
                " values ({0}, '{1}')", cbModel_Obj.SelectedValue, tb_Model_Name.Text), DataBaseClass.act.manipulation);

        }

        private void btModel_Delete_Click(object sender, RoutedEventArgs e)
        {
            DataRowView dataRowView = dgModel.SelectedItems[0] as DataRowView;
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(String.Format("delete [dbo].[Model] where [ID_Model] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
        }

        private void btModel_Update_Click(object sender, RoutedEventArgs e)
        {
            if (dgModel.Items.Count != 0 & dgModel.SelectedItems.Count != 0)
            {
                DataRowView dataRowView = (DataRowView)dgModel.SelectedItems[0];
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute(string.Format("update [dbo].[Model] set " +
                    "[Brand_ID]  = '{0}'," +
                    "[Name_Model]  = '{1}'" +
                    "where [ID_Model] = {2}",
                    cbModel_Obj.SelectedValue, tb_Model_Name.Text, dataRowView[0]), DataBaseClass.act.manipulation);
            }
        }
        //#################################################################################################################
        private void TransportFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_Transport], [Length_Transport], [Width_Transport], [Height_Transport], [Load_Copacity], [Copacity], [Number_Transport], [Model_ID], [Model_ID], [Name_Model] from [dbo].[Transport] inner join [dbo].[Model] on [ID_Model] = [Model_ID]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChange_Transport;
                    dgTransport.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgTransport.Columns[0].Visibility = Visibility.Hidden;
                    dgTransport.Columns[1].Header = "Длина";
                    dgTransport.Columns[2].Header = "Высота";
                    dgTransport.Columns[3].Header = "Ширина";
                    dgTransport.Columns[4].Header = "Грузоподьемность";
                    dgTransport.Columns[5].Header = "Вместимость";
                    dgTransport.Columns[6].Header = "Номер";
                    dgTransport.Columns[7].Visibility = Visibility.Hidden;
                    dgTransport.Columns[8].Visibility = Visibility.Hidden;
                    dgTransport.Columns[9].Header = "Модель";
                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChange_Transport(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                TransportFill();
            }
        }
        private void dgTransport_Loaded(object sender, RoutedEventArgs e)
        {
            TransportFill();
            cbDuty_ObjFill();
        }

        private void btTransport_Insert_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(string.Format("insert into [dbo].[Transport] ([Model_ID], [Length_Transport], [Width_Transport], [Height_Transport], " +
                "[Load_Copacity], [Copacity], [Number_Transport]) values ({0}, '{1}','{2}', '{3}', '{4}', '{5}','{6}')", cbDuty_Obj.SelectedValue, tb_dlina.Text, tb_visota.Text, tb_shirina.Text, tb_gruz.Text, tb_vmestimost.Text, tb_nomer.Text), DataBaseClass.act.manipulation);

        }

        private void btTransport_Delete_Click(object sender, RoutedEventArgs e)
        {
            if (dgTransport.Items.Count != 0 & dgTransport.SelectedItems.Count != 0)
            {
                DataRowView dataRowView = (DataRowView)dgTransport.SelectedItems[0];
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute(string.Format("delete from [dbo].[Transport] where [ID_Transport] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
            }
            
        }

        private void btTransport_Update_Click(object sender, RoutedEventArgs e)
        {
                if (dgTransport.Items.Count != 0 & dgTransport.SelectedItems.Count != 0)
                {
                    DataRowView dataRowView = (DataRowView)dgTransport.SelectedItems[0];
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute(string.Format("update [dbo].[Transport] set " +
                        "[Model_ID]  = '{0}'," +
                        "[Length_Transport]  = '{2}'," +
                        "[Width_Transport]  = '{1}'," +
                        "[Height_Transport] = '{3}'," +
                        "[Load_Copacity] = '{4}'," +
                        "[Copacity] = '{5}'," +
                        "[Number_Transport] = '{6}'" +
                        "where [ID_Transport] = {7}",
                        cbDuty_Obj.SelectedValue, tb_shirina.Text, tb_dlina.Text, tb_visota.Text, tb_gruz.Text, tb_vmestimost.Text, tb_nomer.Text, dataRowView[0]), DataBaseClass.act.manipulation);
                }
        }

        private void dgTransport_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            try
            {
                DataRowView dataRowView = dgTransport.SelectedItems[0] as DataRowView;
                tb_dlina.Text = dataRowView[1].ToString();
                tb_visota.Text = dataRowView[2].ToString();
                tb_shirina.Text = dataRowView[3].ToString();
                tb_gruz.Text = dataRowView[4].ToString();
                tb_vmestimost.Text = dataRowView[5].ToString();
                tb_nomer.Text = dataRowView[6].ToString();
                cbDuty_Obj.SelectedValue = dataRowView[7];
            }
            catch
            {

            }
        }


        //##################################################################################################################
        

        private void EmployeeFill()
        {
            try
            {
                Action action = () =>
                {
                    DataBaseClass dataBaseClass = new DataBaseClass();
                    dataBaseClass.sqlExecute("select [ID_Employee], [Name_Employee], [Surname_Employee], [Lastname_Employee], [SNILS], [FOMS], [Login_Employee], [Password_Employee], [Name_Carrier] from [dbo].[Employee] inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]", DataBaseClass.act.select);
                    dataBaseClass.dependency.OnChange += DependancyOnChange_Employee;
                    dgEmployee.ItemsSource = dataBaseClass.resultTable.DefaultView;
                    dgEmployee.Columns[0].Visibility = Visibility.Hidden;
                    dgEmployee.Columns[1].Header = "Имя";
                    dgEmployee.Columns[2].Header = "Фамилия";
                    dgEmployee.Columns[3].Header = "Отчество";
                    dgEmployee.Columns[4].Header = "СНИЛС";
                    dgEmployee.Columns[5].Header = "ФОМС";
                    dgEmployee.Columns[6].Header = "Логин";
                    dgEmployee.Columns[7].Header = "Пароль";
                    dgEmployee.Columns[8].Header = "Название организации перевозчика";
                };
                Dispatcher.Invoke(action);
            }
            catch { }
        }

        private void DependancyOnChange_Employee(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
            {
                EmployeeFill();
            }
        }

        private void dgEmployee_Loaded(object sender, RoutedEventArgs e)
        {
            EmployeeFill();
        }


        private void cbEmployee_ObjFill()
        {
            Action action = () =>
            {
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute("select [Carrier_ID], [Name_Carrier] from [dbo].[Employee] inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]", DataBaseClass.act.select);
                dataBaseClass.dependency.OnChange += cbEmployee_ObjDependency_OnChange;
                cbEmployee_Obj.ItemsSource = dataBaseClass.resultTable.DefaultView;
                cbEmployee_Obj.SelectedValuePath = dataBaseClass.resultTable.Columns[0].ColumnName;
                cbEmployee_Obj.DisplayMemberPath = dataBaseClass.resultTable.Columns[1].ColumnName;

            };
            Dispatcher.Invoke(action);
        }

        private void cbEmployee_Obj_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                cbEmployee_ObjFill();
            }
            catch
            {

            }
        }

        private void cbEmployee_ObjDependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            if (e.Info != SqlNotificationInfo.Invalid)
                cbEmployee_ObjFill();
        }

        private void btEmployee_Insert_Click(object sender, RoutedEventArgs e)
        {
            DataBaseClass dataBaseClass = new DataBaseClass();
            dataBaseClass.sqlExecute(string.Format("insert into [dbo].[Employee] ([Carrier_ID], [Name_Employee], [Surname_Employee], [Lastname_Employee], " +
                "[SNILS], [FOMS], [Login_Employee], [Password_Employee]) values ({0}, '{1}','{2}', '{3}', '{4}', '{5}','{6}', {7})", cbEmployee_Obj.SelectedValue, tbEmployee_Familiya.Text, tbEmployee_Imia.Text, tbEmployee_Otchestvo.Text, tbEmployee_Snils.Text, tbEmployee_Foms.Text, tbEmployee_Login.Text, tbEmployee_Parol.Text), DataBaseClass.act.manipulation);

        }

        private void btEmployee_Delete_Click(object sender, RoutedEventArgs e)
        {
            if (dgEmployee.Items.Count != 0 & dgEmployee.SelectedItems.Count != 0)
            {
                DataRowView dataRowView = (DataRowView)dgEmployee.SelectedItems[0];
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute(string.Format("delete from [dbo].[Employee] where [ID_Employee] = {0}", dataRowView[0]), DataBaseClass.act.manipulation);
            }

        }

        private void btEmployee_Update_Click(object sender, RoutedEventArgs e)
        {
            if (dgEmployee.Items.Count != 0 & dgEmployee.SelectedItems.Count != 0)
            {
                DataRowView dataRowView = (DataRowView)dgEmployee.SelectedItems[0];
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute(string.Format("update [dbo].[Employee] set " +
                    "[Carrier_ID]  = '{0}'," +
                    "[Name_Employee]  = '{1}'," +
                    "[Surname_Employee]  = '{2}'," +
                    "[Lastname_Employee] = '{3}'," +
                    "[SNILS] = '{4}'," +
                    "[FOMS] = '{5}'," +
                    "[Login_Employee] = '{6}'," +
                    "[Password_Employee] = '{7}'" +
                    "where [ID_Employee] = {8}",
                    cbEmployee_Obj.SelectedValue, tbEmployee_Familiya.Text, tbEmployee_Imia.Text, tbEmployee_Otchestvo.Text, tbEmployee_Snils.Text, tbEmployee_Foms.Text, tbEmployee_Login.Text, tbEmployee_Parol.Text, dataRowView[0]), DataBaseClass.act.manipulation);
            }
        }

        //#############################################################################################################################################
        

        

        

        

        


        private void cbDuty_ObjFill()
        {
            Action action = () =>
            {
                DataBaseClass dataBaseClass = new DataBaseClass();
                dataBaseClass.sqlExecute("select [Model_ID], [Name_Model] from [dbo].[Transport] inner join [dbo].[Model] on [ID_Model] = [Model_ID]", DataBaseClass.act.select);
                dataBaseClass.dependency.OnChange += cbDuty_ObjDependency_OnChange;
                cbDuty_Obj.ItemsSource = dataBaseClass.resultTable.DefaultView;
                cbDuty_Obj.SelectedValuePath = dataBaseClass.resultTable.Columns[0].ColumnName;
                cbDuty_Obj.DisplayMemberPath = dataBaseClass.resultTable.Columns[1].ColumnName;
                
            };
            Dispatcher.Invoke(action);
        }

        private void cbDuty_Obj_Loaded(object sender, RoutedEventArgs e)
        {
            try
            {
                cbDuty_ObjFill();
            }
            catch
            {

            }
        }

        private void cbDuty_ObjDependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            if(e.Info != SqlNotificationInfo.Invalid)
                cbDuty_ObjFill();
        }


        

    }
}