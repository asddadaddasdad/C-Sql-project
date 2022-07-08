set ansi_nulls on
go
set ansi_padding on
go
set quoted_identifier on
go

create database [Test_Cargo2]
go

use [Test_Cargo2]
go

create table [dbo].[Browser2]
(
[ID_Browser2] [int] not null identity(1,1),
[Link] [varchar] (2000) not null,
[Time_Data_Google] [DateTime] not null,
constraint [PK_Browser2] primary key clustered ([ID_Browser2] ASC) on [PRIMARY]
)
go

select * from [dbo].[Browser2]
go

insert [dbo].[Browser2] ([Link], [Time_Data_Google]) values ('Somethingasdin', GETDATE())
go

--create or alter view [dbo].Customer_Application_to_Route_Sheet("Заказчик", "Сформированный маршрутный лист", "Точки доставки")
--as
--	select 'Фио покупателя: ' + Name_Customer + ' ' + Surname_Customer + ' ' + Lastname_Customer + ', Логин: ' + Login_Customer + ', Пароль: ' + 
--	Password_Customer + ', ИИН: ' + TIN + ', БИК: ' + BIC + ', ОКПО: ' + OKPO + ', Тип и название организации: ' + Type_Organization_ID +
--	Name_Customer_Organization + ', Адрес организации: ' + Organization_Address from bdo.Customer
		

--[Name_Customer_Organization] [varchar] (50) not null,
--	[Organization_Address] [varchar] (max) not null,
--	[TIN] [varchar] (12) not null,
--	[BIC] [varchar] (9) not null,
--	[OKPO] [varchar] (8) not null,
--	[Login_Customer] [varchar] (50) not null,
--	[Password_Customer] [varchar] (32) not null,
--	[Name_Customer] [varchar] (32) not null,
--	[Surname_Customer] [varchar] (32) not null,
--	[Lastname_Customer] [varchar] (32) null default('-'),
--	[Type_Organization_ID] [int] not null

create table [dbo].[License]
(
	[ID_License] [int] not null identity(1,1),
	[Type_License] [varchar] (10) not null
	constraint [PK_License] primary key clustered
	([ID_License] ASC) on [PRIMARY],
	constraint [UQ_Type_License] unique ([Type_License])
)
go

create or alter procedure [dbo].[License_Insert]
@Type_License [varchar] (10)
as
declare @exsist [int] = (select count(*) from
[dbo].[License]
where [Type_License] = @Type_License)
if (@exsist > 0)
print('Данные о правах уже существует в таблице')
else
insert into [dbo].[License] ([Type_License])
values (@Type_License)
go

create or alter procedure [dbo].[License_Update]
@ID_License [int], @Type_License [varchar] (10)
as 
	declare @exsist [int] = (select count(*) from
[dbo].[License]
where [Type_License] = @Type_License)
if (@exsist > 0)
print('Данный о правах уже есть в таблице')
else
update [dbo].[License] set
[Type_License] = @Type_License
where
[ID_License] = @ID_License
go

create or alter procedure [dbo].[License_Delete]
@ID_License [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[License]
	where [ID_License] = @ID_License)
	if (@any_child_record > 0)
	print('Права не могут быть удалены так как в таблице 
	"Права сотрудника" есть связанные данные!')
	else 
	delete from [dbo].[License]
		where 
		[ID_License] = @ID_License
go

insert into [dbo].[License] ([Type_License])
values ('A'), ('B'), ('C')
go

select [Type_License] as 'Категория' from [dbo].[License]
order by [Type_License] ASC
go


create table [dbo].[Type_Organization]
(
	[ID_Type_Organization] [int] not null identity(1,1),
	[Type_Name] [varchar] (max) not null
	constraint [PK_Type_Organization] primary key clustered
	([ID_Type_Organization] ASC) on [PRIMARY]
)
go

update [dbo].[Type_Organization] set [Type_Name] = 'ЮЮЮ'
where [ID_Type_Organization] = 3
go

delete [dbo].[Type_Organization] where [ID_Type_Organization] = 2
go

create or alter procedure [dbo].[Type_Organization_Insert]
@Type_Name [varchar] (max)
as
	begin try 
	insert into [Type_Organization] ([Type_Name])
	values (@Type_Name)
	end try 
	begin catch 
	print('Ошибка при вводе типа организации')
	end catch
go



create or alter procedure [dbo].[Type_Organization_Update]
@ID_Type_Organization [int], @Type_Name [varchar] (max)
as 
	begin try 
	update [dbo].[Type_Organization] set 
	[Type_Name] = @Type_Name
	where 
		[ID_Type_Organization] = @ID_Type_Organization
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу тип организации!')
	end catch
go


create or alter procedure [dbo].[Type_Organization_Delete]
@ID_Type_Organization [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Type_Organization]
	where [ID_Type_Organization] = @ID_Type_Organization)
	if (@any_child_record > 0)
	print('Тип организации не может быть удалены так как в таблице 
	"Заказчика", "Перевозчика" есть связанные данные!')
	else 
	delete from [dbo].[Type_Organization]
		where 
		[ID_Type_Organization] = @ID_Type_Organization
go

delete [dbo].[Type_Organization] where [ID_Type_Organization] = 1
select * from dbo.Type_Organization where [ID_Type_Organization] = 1
--update [dbo].[Type_Organization] set [Type_Name] = '' where [ID_Type_Organization] = 


insert into [dbo].[Type_Organization] ([Type_Name]) 
values ('ААА'), ('НПАО'), ('ЕЕЕ')
go

select [Type_Name] as 'Тип организации' from [dbo].[Type_Organization]
order by [Type_Name] ASC
go

create table [dbo].[Brand]
(
	[ID_Brand] [int] not null identity(1,1),
	[Name_Brand] [varchar] (50) not null
	constraint [PK_Brand] primary key clustered
	([ID_Brand] ASC) on [PRIMARY],
	constraint [UQ_Name_Brand] unique ([Name_Brand])
)
go

update [dbo].[Brand] set [Name_Brand] = 'BMW'
where [ID_Brand] = 1
go

delete [dbo].[Brand] where [ID_Brand] = 1
go

create or alter procedure [dbo].[Brand_Insert]
@Name_Brand [varchar] (50)
as
	begin try
	declare @exsist [int] = (select count(*) from
	[dbo].[Brand]
	where [Name_Brand] = @Name_Brand)
	if (@exsist > 0)
	insert into [dbo].[Brand] ([Name_Brand])
	values (@Name_Brand)
	end try
	begin catch
	print('Данные о марке уже существует в таблице')
	end catch
go

create or alter procedure [dbo].[Brand_Update]
@ID_Brand [int], @Name_Brand [varchar] (50)
as 
	declare @exsist [int] = (select count(*) from
[dbo].[Brand]
where [Name_Brand] = @Name_Brand)
if (@exsist > 0)
print('Данный о правах уже есть в таблице')
else
update [dbo].[Brand] set
[Name_Brand] = @Name_Brand
where
[ID_Brand] = @ID_Brand
go

create or alter procedure [dbo].[Brand_Delete]
@ID_Brand [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Brand]
	where [ID_Brand] = @ID_Brand)
	if (@any_child_record > 0)
	print('Бренд не может быть удалены так как в таблице 
	"Модель" есть связанные данные!')
	else 
	delete from [dbo].[Brand]
		where 
		[ID_Brand] = @ID_Brand
go

insert into [dbo].[Brand] ([Name_Brand])
values ('Man'), ('Volvo')
go

select [Name_Brand] as 'Марка' from [dbo].[Brand]
order by [Name_Brand] DESC
go

create table [dbo].[Delivery_Points]
(
	[ID_Delivery_Point] [int] not null identity(1,1),
	[Delivery_Address] [varchar] (max) not null
	constraint [PK_Delivery_Point] primary key clustered
	([ID_Delivery_Point] ASC) on [PRIMARY]
)
go

create or alter procedure [dbo].[Delivery_Points_Insert]
@Delivery_Address [varchar] (max)
as
	begin try 
	insert into [Delivery_Points] ([Delivery_Address])
	values (@Delivery_Address)
	end try 
	begin catch 
	print('Ошибка при вводе точек доставки')
	end catch
go



create or alter procedure [dbo].[Delivery_Points_Update]
@ID_Delivery_Points [int], @Delivery_Address [varchar] (max)
as 
	begin try 
	update [dbo].[Delivery_Points] set 
	[Delivery_Address] = @Delivery_Address
	where 
		[ID_Delivery_Point] = @ID_Delivery_Points
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу точки доставки!')
	end catch
go


create or alter procedure [dbo].[Delivery_Points_Delete]
@ID_Delivery_Points [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Delivery_Points]
	where [ID_Delivery_Point] = @ID_Delivery_Points)
	if (@any_child_record > 0)
	print('Точки доставки не может быть удалены так как в таблице 
	"Точки маршрутного листа" есть связанные данные!')
	else 
	delete from [dbo].[Delivery_Points]
		where 
		[ID_Delivery_Point] = @ID_Delivery_Points
go

insert into [dbo].[Delivery_Points] ([Delivery_Address])
values ('Ул. Вернадского, д. 3, стр. 4'), ('Ул. Витебская, д. 8, к. 5'), ('Ул. Вернадского, д. 6, к. 3'), ('Ул. Арбат, д. 8, к. 3'), ('Ул. Арбат, д. 1, стр. 3')
go

select [Delivery_Address] as 'Адрес точки доставки' from [dbo].[Delivery_Points]
order by [Delivery_Address] ASC
go

create table [dbo].[Post]
(
	[ID_Post] [int] not null identity(1,1),
	[Name_Post] [varchar] (50) not null
	constraint [PK_Post] primary key clustered
	([ID_Post] ASC) on [PRIMARY],
	constraint [UQ_Name_Post] unique ([Name_Post])
)
go

update [dbo].[Post] set [Name_Post] = 'Строитель'
where [ID_Post] = 1
go

delete [dbo].[Post] where [ID_Post] = 1
go

create or alter procedure [dbo].[Post_Insert]
@Name_Post [varchar] (50)
as
declare @exsist [int] = (select count(*) from
[dbo].[Post]
where [Name_Post] = @Name_Post)
if (@exsist > 0)
print('Данные о должностях уже существует в таблице')
else
insert into [dbo].[Post] ([Name_Post])
values (@Name_Post)
go

create or alter procedure [dbo].[Post_Update]
@ID_Post [int], @Name_Post [varchar] (10)
as
	declare @exsist [int] = (select count(*) from
	[dbo].[Post]
	where [Name_Post] = @Name_Post)
	if (@exsist > 0)
	print('Данный о должностях уже есть в таблице')
	else
	update [dbo].[Post] set
	[Name_Post] = @Name_Post
	where
	[ID_Post] = @ID_Post
go

create or alter procedure [dbo].[Post_Delete]
@ID_Post [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Post]
	where [ID_Post] = @ID_Post)
	if (@any_child_record > 0)
	print('Права не могут быть удалены так как в таблице 
	"Права сотрудника" есть связанные данные!')
	else 
	delete from [dbo].[Post]
		where 
		[ID_Post] = @ID_Post
go

insert into [dbo].[Post] ([Name_Post])
values ('Водитель'),('Менеджер по заказам'),('Менеджер по продажам'),('Директор')
go

select [Name_Post] as 'Должность' from [dbo].[Post]
order by [Name_Post] ASC
go

create table [dbo].[Country]
(
	[ID_Country] [int] not null identity(1,1),
	[Name_Country] [varchar] (50) not null
	constraint [PK_Country] primary key clustered
	([ID_Country] ASC) on [PRIMARY],
	constraint [UQ_Name_Country] unique ([Name_Country])
)
go

select [Name_Country] as 'Название страны' from [dbo].[Country]
where [Name_Country] = 'Германия' 
go


create or alter procedure [dbo].[Country_Insert]
@Name_Country [varchar] (50)
as
declare @exsist [int] = (select count(*) from [dbo].[Country] where [Name_Country] = @Name_Country)
if (@exsist > 0)
begin
	print('Данные о стране уже существует в таблице')
end
else
begin
	insert into [dbo].[Country] ([Name_Country])
	values (@Name_Country)
end
go

create or alter procedure [dbo].[Country_Update]
@ID_Country [int], @Name_Country [varchar] (50)
as 
	declare @exsist [int] = (select count(*) from [dbo].[Country] where [Name_Country] = @Name_Country)
if (@exsist > 0)
begin
print('Данный о стране уже есть в таблице')
end
else
begin
update [dbo].[Country] set
[Name_Country] = @Name_Country
where
[ID_Country] = @ID_Country
end
go

create or alter procedure [dbo].[Country_Delete]
@ID_Country [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Country]
	where [ID_Country] = @ID_Country)
	if (@any_child_record > 0)
	begin
		print('Страна не могут быть удалены так как в таблице "Страна транспорта" есть связанные данные!')
	end
	else 
	begin
		delete from [dbo].[Country] where [ID_Country] = @ID_Country
	end
go

insert into [dbo].[Country] ([Name_Country])
values ('Германия'), ('Шведция')
go

select [Name_Country] as 'Должность' from [dbo].[Country]
order by [Name_Country] ASC
go

create table [dbo].[Cargo]
(
	[ID_Cargo] [int] not null identity(1,1),
	[Description_Cargo] [varchar] (max) not null,
	[Weight_Cargo] [int] not null,
	[Length_Cargo] [varchar] (8) not null,
	[Width_Cargo] [varchar] (8) not null,
	[Height_Cargo] [varchar] (8) not null
	constraint [PK_Cargo] primary key clustered
	([ID_Cargo] ASC) on [PRIMARY],
	constraint [CH_Weight_Cargo] check ([Weight_Cargo] like ('[0-9][0-9][0-9]')
	or [Weight_Cargo] like ('[0-9][0-9][0-9][0-9]') or [Weight_Cargo] like ('[0-9][0-9][0-9][0-9][0-9]')),
	constraint [CH_Length_Cargo] check ([Length_Cargo] like ('[0-9][0-9][0-9]')
	or [Length_Cargo] like ('[0-9][0-9][0-9][0-9]') or [Length_Cargo] like ('[0-9][0-9][0-9][0-9][0-9]')),
	constraint [CH_Width_Cargo] check ([Width_Cargo] like ('[0-9][0-9][0-9]')
	or [Width_Cargo] like ('[0-9][0-9][0-9][0-9]') or [Width_Cargo] like ('[0-9][0-9][0-9][0-9][0-9]')),
	constraint [CH_Height_Cargo] check ([Height_Cargo] like ('[0-9][0-9][0-9]')
	or [Height_Cargo] like ('[0-9][0-9][0-9][0-9]') or [Height_Cargo] like ('[0-9][0-9][0-9][0-9][0-9]'))
)	
go

create or alter procedure [dbo].[Cargo_Insert]
@Description_Cargo [varchar] (max), @Weight_Cargo [varchar] (8), @Length_Cargo [varchar] (8), @Width_Cargo [varchar] (8), @Height_Cargo [varchar] (8)
as
	begin try 
		insert into [Cargo] ([Description_Cargo], [Weight_Cargo], [Length_Cargo], [Width_Cargo], [Height_Cargo])
		values (@Description_Cargo, @Weight_Cargo, @Length_Cargo, @Width_Cargo, @Height_Cargo)
	end try 
	begin catch 
		print('Ошибка при вводе данных в таблицу груз')
	end catch
go

create or alter procedure [dbo].[Cargo_Update]
@ID_Cargo [int], @Description_Cargo [varchar] (max), @Weight_Cargo [varchar] (8), @Length_Cargo [varchar] (8), @Width_Cargo [varchar] (8), @Height_Cargo [varchar] (8)
as 
	begin try 
	update [dbo].[Cargo] set 
	[Description_Cargo] = @Description_Cargo,
	[Weight_Cargo] = @Weight_Cargo,
	[Length_Cargo] = @Length_Cargo,
	[Width_Cargo] = @Width_Cargo,
	[Height_Cargo] = @Height_Cargo
	where 
		[ID_Cargo] = @ID_Cargo
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу Груз!')
	end catch
go

create or alter procedure [dbo].[Cargo_Delete]
@ID_Cargo [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Cargo]
	where [ID_Cargo] = @ID_Cargo)
	if (@any_child_record > 0)
	begin
	print('Груз не может быть удален так как в таблице 
	"Заявка Груза" есть связанные данные!')
	end
	else
	begin
	delete from [dbo].[Cargo]
		where 
		[ID_Cargo] = @ID_Cargo
	end
go

insert into [dbo].[Cargo] ([Description_Cargo], [Weight_Cargo], [Length_Cargo], [Width_Cargo], [Height_Cargo])
values ('Цистерны', '4000', '1000', '2000', '1000'), ('Древисина', '1000', '8000', '2000', '1000'),
('Древисина', '1000', '8000', '2000', '1000'), ('Цистерны', '4000', '1000', '2000', '1000'), ('Цистерны', '4000', '1000', '2000', '1000')
go

select [Description_Cargo] as 'Описание', [Weight_Cargo] as 'Вес', [Length_Cargo]+' '+[Width_Cargo]+' '+[Height_Cargo] as 'Габариты' from [dbo].[Cargo]
order by [Description_Cargo] ASC
go

create table [dbo].[Model]
(
	[ID_Model] [int] not null identity(1,1),
	[Name_Model] [varchar] (50) not null,
	[Brand_ID] [int] not null
	constraint [PK_Model] primary key clustered
	([ID_Model] ASC) on [PRIMARY],
	constraint [UQ_Name_Model] unique ([Name_Model]),
	constraint [FK_Brand_Model] foreign key ([Brand_ID])
	references [dbo].[Brand] ([ID_Brand])
)
go

create or alter procedure [dbo].[Model_Insert]
@Name_Model [varchar] (50), @Brand_ID [int]
as
declare @exsist [int] = (select count(*) from
[dbo].[Model]
where [Name_Model] = @Name_Model and
[Brand_ID] = @Brand_ID)
if (@exsist > 0)
print('Данные о модели уже существует в таблице')
else
insert into [dbo].[Model] ([Name_Model], [Brand_ID])
values (@Name_Model, @Brand_ID)
go

create or alter procedure [dbo].[Model_Update]
@ID_Model [int], @Name_Model [varchar] (50), @Brand_ID [int]
as 
	declare @exsist [int] = (select count(*) from
[dbo].[Model]
where [Brand_ID] = @Brand_ID and
[Name_Model] = @Name_Model)
if (@exsist > 0)
print('Данный о модели уже есть в таблице')
else
update [dbo].[Model] set
[Name_Model] = @Name_Model,
[Brand_ID] = @Brand_ID
where
[ID_Model] = @ID_Model
go

create or alter procedure [dbo].[Model_Delete]
@ID_Model [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Model]
	where [ID_Model] = @ID_Model)
	if (@any_child_record > 0)
	print('Модели не могут быть удалены так как в таблице 
	"Транспорт" есть связанные данные!')
	else 
	delete from [dbo].[Model]
		where 
		[ID_Model] = @ID_Model
go

insert into [dbo].[Model] ([Name_Model], [Brand_ID])
values ('F2000', 1), ('FL7', 2)
go

select [Name_Model] as 'Модель', [Name_Brand] as 'Марка'  from [dbo].[Model]
inner join [dbo].[Brand] on [ID_Brand] = [Brand_ID]
go

--select [Name_Model] as 'Модель', [Name_Brand] as 'Марка'  from [dbo].[Model]
--inner join [dbo].[Brand] on [ID_Brand] = [Brand_ID]
--where [Name_Brand] = 'ГАЗ'
--go

--select [ID_Model], [Name_Brand] from [dbo].[Brand] inner join [dbo].[Model] on ID_Brand = ID_Model

--create table [dbo].[Transport]
--(
--	[ID_Transport] [int] not null identity(1,1),
--	[Length_Transport] [varchar] (8) not null,
--	[Width_Transport] [varchar] (8) not null,
--	[Height_Transport] [varchar] (8) not null,
--	[Load_Copacity] [varchar] (8) not null,
--	[Copacity] [varchar] (9) not null,
--	[Number_Transport] [varchar] (10) not null,
--	[Model_ID] [int] not null
--	constraint [PK_Transport] primary key clustered
--	([ID_Transport] ASC) on [PRIMARY],
--	constraint [CH_Length_Transport] check ([Length_Transport] like ('[0-9][0-9][0-9][0-9] мм')),
--	constraint [CH_Width_Transport] check ([Width_Transport] like ('[0-9][0-9][0-9][0-9] мм')),
--	constraint [CH_Height_Transport] check ([Height_Transport] like ('[0-9][0-9][0-9][0-9] мм')),
--	constraint [CH_Load_Copacity] check ([Load_Copacity] like ('[0-9][0-9][0-9][0-9] кг')
--	or [Load_Copacity] like ('[0-9][0-9][0-9][0-9][0-9] кг')),
--	constraint [CH_Copacity] check ([Copacity] like ('[0-9][0-9] куб. м')),
--	constraint [CH_Number_Transport] check ([Number_Transport] like ('[А-Я][0-9][0-9][0-9][А-Я][А-Я]-[0-9][0-9]')
--	or [Number_Transport] like ('[А-Я][0-9][0-9][0-9][А-Я][А-Я]-[0-9][0-9][0-9]')),
--	constraint [UQ_Number_Transport] unique ([Number_Transport]),
--	constraint [FK_Model_Transport] foreign key ([Model_ID])
--	references [dbo].[Model] ([ID_Model])
--)
--go

--select ID_Model, Name_Brand from [dbo].[Brand] inner join [dbo].[Model] on ID_Model = Brand_ID
--go

--select [Brand_ID], [Name_Brand], [Name_Model] from [dbo].[Model]
--inner join [dbo].Brand on Brand_ID = ID_Brand
--go

--insert into [dbo].[Transport] ([Model_ID], [Length_Transport],[Width_Transport],[Height_Transport],[Load_Copacity],[Copacity],[Number_Transport])
--values (1, '8584 мм', '2300 мм', '2740 мм', '8000 кг', '43 куб. м', 'Д232ОА-78'), (2, '9340 мм', '2300 мм', '3650 мм', '9000 кг', '45 куб. м', 'О003БВ-102'),
--(3, '6373 мм', '2513 мм', '2175 мм', '4600 кг', '29 куб. м', 'С831АК-161'), (3, '6373 мм', '2513 мм', '2175 мм', '4600 кг', '29 куб. м', 'К715АС-161'),
--(3, '6373 мм', '2513 мм', '2175 мм', '4600 кг', '29 куб. м', 'С512СА-78')
--go

--select [Length_Transport]+' '+[Width_Transport]+' '+[Height_Transport] as 'Габариты', [Load_Copacity] as 'Грузоподъемность', [Copacity] as 'Вместимость', 
--[Number_Transport] as 'Номер', [Name_Model] as 'Модель' from [dbo].[Transport]
--inner join [dbo].[Model] on [ID_Model] = [Model_ID]
--go

--select * from [dbo].[Transport]
--inner join [dbo].[Model] on [ID_Model] = [Model_ID]
--go

create table [dbo].[Transport] 
(
	[ID_Transport] [int] not null identity(1,1),
	[Length_Transport] [varchar] (8) not null,
	[Width_Transport] [varchar] (8) not null,
	[Height_Transport] [varchar] (8) not null,
	[Load_Copacity] [varchar] (8) not null,
	[Copacity] [varchar] (9) not null,
	[Number_Transport] [varchar] (10) not null,
	[Model_ID] [int] not null
	constraint [PK_Transport] primary key clustered
	([ID_Transport] ASC) on [PRIMARY],
	constraint [CH_Length_Transport] check ([Length_Transport] like ('[0-9][0-9][0-9][0-9]')),
	constraint [CH_Width_Transport] check ([Width_Transport] like ('[0-9][0-9][0-9][0-9]')),
	constraint [CH_Height_Transport] check ([Height_Transport] like ('[0-9][0-9][0-9][0-9]')),
	constraint [CH_Load_Copacity] check ([Load_Copacity] like ('[0-9][0-9][0-9][0-9]')
	or [Load_Copacity] like ('[0-9][0-9][0-9][0-9][0-9]')),
	constraint [CH_Copacity] check ([Copacity] like ('[0-9][0-9]')),
	constraint [CH_Number_Transport] check ([Number_Transport] like ('[А-Я][0-9][0-9][0-9][А-Я][А-Я]')),
	constraint [UQ_Number_Transport] unique ([Number_Transport]),
	constraint [FK_Model_Transport] foreign key ([Model_ID])
	references [dbo].[Model] ([ID_Model])
)
go

create or alter procedure [dbo].[Transport_Insert]
@Length_Transport [varchar] (8), @Width_Transport [varchar] (8), @Height_Transport [varchar] (8), @Load_Copacity [varchar] (8), @Copacity [varchar] (9), @Number_Transport [varchar] (10), @Model_ID [int]
as
declare @exsist [int] = (select count(*) from
[dbo].[Transport]
where [Length_Transport] = @Length_Transport and
[Width_Transport] = @Width_Transport and
[Height_Transport] = @Height_Transport and
[Load_Copacity] = @Load_Copacity and
[Copacity] = @Copacity and
[Number_Transport] = @Number_Transport and
[Model_ID] = @Model_ID)
if (@exsist > 0)
print('Данные о транспорте уже существует в таблице')
else
insert into [dbo].[Transport] ([Length_Transport], [Width_Transport], [Height_Transport], [Load_Copacity], [Copacity], [Number_Transport], [Model_ID])
values (@Length_Transport, @Width_Transport, @Height_Transport, @Load_Copacity, @Copacity, @Number_Transport, @Model_ID)
go

create or alter procedure [dbo].[Transport_Update]
@ID_Transport [int], @Length_Transport [varchar] (8), @Width_Transport [varchar] (8), @Height_Transport [varchar] (8), @Load_Copacity [varchar] (8), @Copacity [varchar] (9), @Number_Transport [varchar] (10), @Model_ID [int]

as 
	declare @exsist [int] = (select count(*) from
[dbo].[Transport]
where [Model_ID] = @Model_ID and
[Length_Transport] = @Length_Transport and
[Width_Transport] = @Width_Transport and
[Height_Transport] = @Height_Transport and
[Load_Copacity] = @Load_Copacity and
[Copacity] = @Copacity and
[Number_Transport] = @Number_Transport)
if (@exsist > 0)
print('Данный о транспорте уже есть в таблице')
else
update [dbo].[Transport] set
[Length_Transport] = @Length_Transport,
[Width_Transport] = @Width_Transport,
[Height_Transport] = @Height_Transport,
[Load_Copacity] = @Load_Copacity,
[Copacity] = @Copacity,
[Number_Transport] = @Number_Transport,
[Model_ID] = @Model_ID
where
[ID_Transport] = @ID_Transport
go

create or alter procedure [dbo].[Transport_Delete]
@ID_Transport [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Transport]
	where [ID_Transport] = @ID_Transport)
	if (@any_child_record > 0)
	print('Транспорт не могут быть удалены так как в таблице 
	"Страна Транспорта", "Маршрутный лист" есть связанные данные!')
	else 
	delete from [dbo].[Transport]
		where 
		[ID_Transport] = @ID_Transport
go


insert into [dbo].[Transport] ([Model_ID], [Length_Transport],[Width_Transport],[Height_Transport],[Load_Copacity],[Copacity],[Number_Transport])
values (1, '2342', '2342', '2342', '9000', '55', 'Х213ЫМ'), (2, '3211', '3223', '1115', '7000', '44', 'Х058ЕА'),
(2, '3211', '3223', '1115', '7000', '44', 'Е824ТС'), (1, '2342', '2342', '2342', '9000', '55', 'Т595ХЕ'),
(1, '2342', '2342', '2342', '9000', '55', 'У995ОО')
go

select [Length_Transport]+' '+[Width_Transport]+' '+[Height_Transport] as 'Габариты', [Load_Copacity] as 'Грузоподъемность', [Copacity] as 'Вместимость', 
[Number_Transport] as 'Номер', [Name_Model] as 'Модель' from [dbo].[Transport]
inner join [dbo].[Model] on [ID_Model] = [Model_ID]
go



create table [dbo].[Customer]
(
	[ID_Customer] [int] not null identity(1,1),
	[Name_Customer_Organization] [varchar] (50) not null,
	[Organization_Address] [varchar] (max) not null,
	[TIN] [varchar] (12) not null,
	[BIC] [varchar] (9) not null,
	[OKPO] [varchar] (8) not null,
	[Login_Customer] [varchar] (50) not null,
	[Password_Customer] [varchar] (32) not null,
	[Name_Customer] [varchar] (32) not null,
	[Surname_Customer] [varchar] (32) not null,
	[Lastname_Customer] [varchar] (32) null default('-'),
	[Type_Organization_ID] [int] not null
	constraint [PK_Customer] primary key clustered
	([ID_Customer] ASC) on [PRIMARY],
	constraint [CH_TIN] check 
	([TIN] like ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
	constraint [UQ_TIN] unique ([TIN]),
	constraint [CH_BIC] check ([BIC] like ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
	constraint [CH_OKPO] check ([OKPO] like ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
	constraint [UQ_OKPO] unique ([OKPO]),
	constraint [CH_Login_Customer] check 
	(len([Login_Customer]) >=4),
	constraint [UQ_Login_Customer] unique ([Login_Customer]),
	constraint [CH_Password_Customer] check 
	(len([Password_Customer]) >=4),
	constraint [FK_Type_Organization_Customer] foreign key ([Type_Organization_ID])
	references [dbo].[Type_Organization] ([ID_Type_Organization])
)
go

select [Name_Customer] as 'Название модели'
from [dbo].[Customer]
where [Name_Customer] = 'Бронислав' 
go

update [dbo].[Customer] set [Name_Customer] = 'Иван'
where [ID_Customer] = 1
go

delete [dbo].[Customer] where [ID_Customer] = 1
go

create or alter procedure [dbo].[Customer_Insert]
@Name_Customer_Organization [varchar] (50), @Organization_Address [varchar] (max), @TIN [varchar] (12), @BIC [varchar] (9) ,@OKPO [varchar] (8),
@Login_Customer [varchar] (50), @Password_Customer [varchar] (32), @Name_Customer [varchar] (32), @Surname_Customer [varchar] (32), 
@Lastname_Customer [varchar] (32), @Type_Organization_ID [int]
as
declare @exsist [int] = (select count(*) from
[dbo].[Customer]
where [Name_Customer_Organization] = @Name_Customer_Organization and
[Organization_Address] = @Organization_Address and
[TIN] = @TIN and
[BIC] = @BIC and
[OKPO] = @OKPO and
[Login_Customer] = @Login_Customer and
[Password_Customer] = @Password_Customer and
[Name_Customer] = @Name_Customer and
[Surname_Customer] = @Surname_Customer and
[Lastname_Customer] = @Lastname_Customer and
[Type_Organization_ID] = @Type_Organization_ID)
if (@exsist > 0)
print('Данные о Заказчике уже существует в таблице')
else
insert into [dbo].[Customer] ([Name_Customer_Organization], [Organization_Address], [TIN], [BIC], [OKPO], [Login_Customer], [Password_Customer], [Name_Customer], [Surname_Customer], [Lastname_Customer], [Type_Organization_ID])
values (@Name_Customer_Organization, @Organization_Address, @TIN, @BIC, @OKPO, @Login_Customer, @Password_Customer, @Name_Customer, @Surname_Customer, @Lastname_Customer, @Type_Organization_ID)
go

create or alter procedure [dbo].[Customer_Update]
@ID_Customer [int], @Name_Customer_Organization [varchar] (50), @Organization_Address [varchar] (max), @TIN [varchar] (12), @BIC [varchar] (9) ,@OKPO [varchar] (8),
@Login_Customer [varchar] (50), @Password_Customer [varchar] (32), @Name_Customer [varchar] (32), @Surname_Customer [varchar] (32), 
@Lastname_Customer [varchar] (32), @Type_Organization_ID [int]
as 
	declare @exsist [int] = (select count(*) from
[dbo].[Customer]	
where [Name_Customer_Organization] = @Name_Customer_Organization and
[Organization_Address] = @Organization_Address and
[TIN] = @TIN and
[BIC] = @BIC and
[OKPO] = @OKPO and
[Login_Customer] = @Login_Customer and
[Password_Customer] = @Password_Customer and
[Name_Customer] = @Name_Customer and
[Surname_Customer] = @Surname_Customer and
[Lastname_Customer] = @Lastname_Customer and
[Type_Organization_ID] = @Type_Organization_ID)
if (@exsist > 0)
print('Данный о Заказчике уже есть в таблице')
else
update [dbo].[Customer] set
[Name_Customer_Organization] = @Name_Customer_Organization,
[Organization_Address] = @Organization_Address,
[TIN] = @TIN,
[BIC] = @BIC,
[OKPO] = @OKPO,
[Login_Customer] = @Login_Customer,
[Password_Customer] = @Password_Customer,
[Name_Customer] = @Name_Customer,
[Surname_Customer] = @Surname_Customer,
[Lastname_Customer] = @Lastname_Customer,
[Type_Organization_ID] = @Type_Organization_ID
where
[ID_Customer] = @ID_Customer
go

create or alter procedure [dbo].[Customer_Delete]
@ID_Customer [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Customer]
	where [ID_Customer] = @ID_Customer)
	if (@any_child_record > 0)
	print('Заказчик не может быть удалены так как в таблице 
	"Заявка", "Должность Заказчика" есть связанные данные!')
	else 
	delete from [dbo].[Customer]
		where 
		[ID_Customer] = @ID_Customer
go


insert into [dbo].[Customer] ([Type_Organization_ID], [Name_Customer_Organization], [Organization_Address], [TIN], [BIC], [OKPO],
[Login_Customer], [Password_Customer], [Name_Customer], [Surname_Customer], [Lastname_Customer])
values (3, '"РоялТранс"', 'Ул. Чертановская, д. 3, стр. 3', '623874628773', '487238473', '00432445', 'Qwerty1', '1234567', 'Егор', 'Брагин', 'Петрович'),
(3, '"МакТранс"', 'Ул. Степановская, д. 6, к. 1', '584638576223', '004342561', '21123156', 'Qwerty2', '1234567', 'Рубен', 'Родионов', 'Дамирович'),
(2, '"Центр грузоперевозки"', 'Ул. Чертановская, д. 2, стр. 1', '464736767782', '000423213', '32847234', 'Qwerty3', '1234567', 'Бронислав', 'Пестов', 'Максимович'),
(1, '"С-Грузов"', 'Ул. Арбат, д. 2, к. 6', '784738748772', '762314876', '00345343', 'Qwerty4', '1234567', 'Игнатий', 'Зиновьев', 'Андреевич'),
(3, '"Груз-сервис"', 'Ул. Молочная, д. 13, к. 5', '723847282341', '594823589', '00232312', 'Qwerty5', '1234567', 'Станислав', 'Лазарев', 'Валерьянович')
go


select [Name_Customer]+' '+[Surname_Customer]+' '+[Lastname_Customer] as 'Фио покупателя', [Login_Customer] as 'Логин', [Password_Customer] as 'Пароль',
[TIN] as 'ИНН', [BIC] as 'БИК', [OKPO] as 'ОКПО', [Type_Name] as 'Тип организации', [Name_Customer_Organization] as 'Название организации',
[Organization_Address] as 'Адрес организации' from [dbo].[Customer]
inner join [dbo].[Type_Organization] on [ID_Type_Organization] = [Type_Organization_ID]
go

create table [dbo].[Carrier]
(
	[ID_Carrier] [int] not null identity(1,1),
	[Name_Carrier] [varchar] (50) not null,
	[Type_Organization_ID] [int] not null
	constraint [PK_Carrier] primary key clustered
	([ID_Carrier] ASC) on [PRIMARY],
	constraint [UQ_Name_Carrier] unique ([Name_Carrier]),
	constraint [FK_Type_Organization_Carrier] foreign key ([Type_Organization_ID])
	references [dbo].[Type_Organization] ([ID_Type_Organization])
)
go

create or alter procedure [dbo].[Carrier_Insert]
@Name_Carrier [varchar] (50), @Type_Organization_ID [int]
as
declare @exsist [int] = (select count(*) from
[dbo].[Carrier]
where [Name_Carrier] = @Name_Carrier and
[Type_Organization_ID] = @Type_Organization_ID)
if (@exsist > 0)
print('Данные о Перевозчике уже существует в таблице')
else
insert into [dbo].[Carrier] ([Name_Carrier], [Type_Organization_ID])
values (@Name_Carrier, @Type_Organization_ID)
go

create or alter procedure [dbo].[Carrier_Update]
@ID_Carrier [int], @Name_Carrier [varchar] (50),  @Type_Organization_ID [int]
as 
	declare @exsist [int] = (select count(*) from
[dbo].[Carrier]	
where [Name_Carrier] = @Name_Carrier and
[Type_Organization_ID] = @Type_Organization_ID)
if (@exsist > 0)
print('Данный о Перевозчике уже есть в таблице')
else
update [dbo].[Carrier] set
[Name_Carrier] = @Name_Carrier,
[Type_Organization_ID] = @Type_Organization_ID
where
[ID_Carrier] = @ID_Carrier
go

create or alter procedure [dbo].[Carrier_Delete]
@ID_Carrier [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Carrier]
	where [ID_Carrier] = @ID_Carrier)
	if (@any_child_record > 0)
	print('Перевозчки не может быть удален так как в таблице 
	"Сотрудника", "Маршрутный лист" есть связанные данные!')
	else 
	delete from [dbo].[Carrier]
		where 
		[ID_Carrier] = @ID_Carrier
go

update [dbo].[Carrier] set [Type_Organization_ID] = 2 where [ID_Carrier] = 1
go

delete [dbo].[Carrier] where [ID_Carrier] = 2
go

insert into [dbo].[Carrier] ([Name_Carrier], [Type_Organization_ID])
values ('"Экспресс-доставка"', 1), ('"МаксФорт"', 3), ('"ГрузиВезу"', 2),
('"ГрузовичОк"', 3), (' "ГрузиВезу"', 3)
go

select [Name_Carrier] as 'Название организации', [Type_Name] as 'Тип организации' from [dbo].[Carrier]
inner join [dbo].[Type_Organization] on [ID_Type_Organization] = [Type_Organization_ID]
go

select [Name_Carrier] as 'Название организации', [Type_Name] as 'Тип организации' from [dbo].[Carrier]
inner join [dbo].[Type_Organization] on [ID_Type_Organization] = [Type_Organization_ID]
where [Type_Name] = 'ООО' 
go

create table [dbo].[Employee]
(
	[ID_Employee] [int] not null identity(1,1),
	[Name_Employee] [varchar] (32) not null,
	[Surname_Employee] [varchar] (32) not null,
	[Lastname_Employee] [varchar] (32) null default('-'),
	[SNILS] [varchar] (14) not null,
	[FOMS] [varchar] (16) not null,
	[Login_Employee] [varchar] (50) not null,
	[Password_Employee] [varchar] (32) not null,
	[Carrier_ID] [int] not null
	constraint [PK_Employee] primary key clustered
	([ID_Employee] ASC) on [PRIMARY],
	constraint [UQ_SNILS] unique ([SNILS]),
	constraint [CH_SNILS] check
	([SNILS] like ('[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9] [0-9][0-9]')),
	constraint [UQ_FOMS] unique ([FOMS]),
	constraint [CH_FOMS] check
	([FOMS] like ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
	constraint [UQ_Login_Employee] unique ([Login_Employee]),
	constraint [CH_Login_Employee] check (len([Login_Employee])>=8),
	constraint [CH_Password_Employee] check 
	(len([Password_Employee]) >=4),
	constraint [FK_Carrier_Employee] foreign key ([Carrier_ID])
	references [dbo].[Carrier] ([ID_Carrier])
)
go

create or alter procedure [dbo].[Employee_Insert]
@Name_Employee [varchar] (32), @Surname_Employee [varchar] (32), @Lastname_Employee [varchar] (32), @SNILS [varchar] (14), @FOMS [varchar] (16),
@Login_Employee [varchar] (50), @Password_Employee [varchar] (32), @Carrier_ID [int] 
as
declare @exsist [int] = (select count(*) from
[dbo].[Employee]
where [Name_Employee] = @Name_Employee and
[Surname_Employee] = @Surname_Employee and
[Lastname_Employee] = @Lastname_Employee and
[SNILS] = @SNILS and
[FOMS] = @FOMS and
[Login_Employee] = @Login_Employee and
[Password_Employee] = @Password_Employee and
[Carrier_ID] = @Carrier_ID)
if (@exsist > 0)
print('Данные о Сотруднике уже существует в таблице')
else
insert into [dbo].[Employee] ([Name_Employee], [Surname_Employee], [Lastname_Employee], [SNILS], [FOMS], [Login_Employee], [Password_Employee], [Carrier_ID])
values (@Name_Employee, @Surname_Employee, @Lastname_Employee, @SNILS, @FOMS, @Login_Employee, @Password_Employee, @Carrier_ID)
go

create or alter procedure [dbo].[Employee_Update]
@ID_Employee [int], @Name_Employee [varchar] (32), @Surname_Employee [varchar] (32), @Lastname_Employee [varchar] (32), @SNILS [varchar] (14), 
@FOMS [varchar] (16), @Login_Employee [varchar] (50), @Password_Employee [varchar] (32), @Carrier_ID [int] 

as 
	declare @exsist [int] = (select count(*) from
[dbo].[Employee]	
where [Name_Employee] = @Name_Employee and
[Surname_Employee] = @Surname_Employee and
[Lastname_Employee] = @Lastname_Employee and
[SNILS] = @SNILS and
[FOMS] = @FOMS and
[Login_Employee] = @Login_Employee and
[Password_Employee] = @Password_Employee and
[Carrier_ID] = @Carrier_ID)
if (@exsist > 0)
print('Данный о Сотруднике уже есть в таблице')
else
update [dbo].[Employee] set
[Name_Employee] = @Name_Employee,
[Surname_Employee] = @Surname_Employee,
[Lastname_Employee] = @Lastname_Employee,
[SNILS] = @SNILS,
[FOMS] = @FOMS,
[Login_Employee] = @Login_Employee,
[Password_Employee] = @Password_Employee,
[Carrier_ID] = @Carrier_ID
where
[ID_Employee] = @ID_Employee
go

create or alter procedure [dbo].[Employee_Delete]
@ID_Employee [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Employee]
	where [ID_Employee] = @ID_Employee)
	if (@any_child_record > 0)
	print('Сотрудники не могут быть удалены так как в таблице 
	"Права сотрудника", "Должность Сотрудника" есть связанные данные!')
	else 
	delete from [dbo].[Employee]
		where 
		[ID_Employee] = @ID_Employee
go

insert into [dbo].[Employee] ([Name_Employee], [Surname_Employee], [Lastname_Employee], [SNILS], [FOMS], [Login_Employee], [Password_Employee], [Carrier_ID])
values ('Августин', 'Тарасов', 'Натанович', '155-144-737 00', '7849123112311240', 'Driver__1', '1234567', 1),
('Дмитрий', 'Дмитриев', 'Дмитриевич', '152-512-232 00', '2384198471152980', 'Driver__2', '1234567', 2),
('Олег', 'Олегов', 'Олегович', '124-512-535 00', '8712638716238760', 'Driver__3', '1234567', 3),
('Олег', 'Олегов', 'Олегович', '654-412-123 00', '4739247392487910', 'Driver__4', '1234567', 4),
('Павел', 'Павлов', 'Павлович', '412-123-321 00', '3487162487619280', 'Driver__5', '1234567', 5)
go

select [Name_Employee]+' '+[Surname_Employee]+' '+[Lastname_Employee] as 'ФИО сотрудника', [SNILS] as 'СНИЛС', [FOMS] as 'ФОМС', [Login_Employee] as 'Логин',
[Password_Employee] as 'Пароль', [Name_Carrier] as 'Название организации перевозчика' from [dbo].[Employee]
inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]
go

create table [dbo].[Route_Sheet]
(
	[ID_Route_Sheet] [int] not null identity(1,1),
	[Number_Route_Sheet] [varchar] (max) not null,
	[Date_Route_Sheet] [date] not null default(getdate()),
	[Time_Route_Sheet] [time] not null default(getdate()),
	[Carrier_ID] [int] not null,
	[Transport_ID] [int] not null
	constraint [PK_Route_Sheet] primary key clustered
	([ID_Route_Sheet] ASC) on [PRIMARY],
	constraint [CH_Number_Route_Sheet] check
	([Number_Route_Sheet] like ('[0-9][0-9][0-9][0-9]-[0-9][0-9]')),
	constraint [FK_Carrier_Route_Sheet] foreign key ([Carrier_ID])
	references [dbo].[Carrier] ([ID_Carrier]),
	constraint [FK_Transport_Route_Sheet] foreign key ([Transport_ID])
	references [dbo].[Transport] ([ID_Transport]),
)
go

create or alter procedure [dbo].[Route_Sheet_Insert]
@Number_Route_Sheet [varchar] (max), @Date_Route_Sheet [date], @Time_Route_Sheet [time], @Carrier_ID [int], @Transport_ID [int]
as
	begin try 
	insert into [Route_Sheet] ([Number_Route_Sheet], [Date_Route_Sheet], [Time_Route_Sheet], [Carrier_ID], [Transport_ID])
	values (@Number_Route_Sheet, @Date_Route_Sheet, @Time_Route_Sheet, @Carrier_ID, @Transport_ID)
	end try 
	begin catch 
	print('Ошибка при вводе данных в маршрутный лист')
	end catch
go



create or alter procedure [dbo].[Route_Sheet_Update]
@ID_Route_Sheet [int], @Number_Route_Sheet [varchar] (max), @Date_Route_Sheet [date], @Time_Route_Sheet [time], @Carrier_ID [int], @Transport_ID [int]

as 
	begin try 
	update [dbo].[Route_Sheet] set 
	[Number_Route_Sheet] = @Number_Route_Sheet,
	[Date_Route_Sheet] = @Date_Route_Sheet,
	[Time_Route_Sheet] = @Time_Route_Sheet,
	[Carrier_ID] = @Carrier_ID,
	[Transport_ID] = @Transport_ID
	where 
		[ID_Route_Sheet] = @ID_Route_Sheet
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу маршрутный лист')
	end catch
go


create or alter procedure [dbo].[Route_Sheet_Delete]
@ID_Route_Sheet [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Route_Sheet]
	where [ID_Route_Sheet] = @ID_Route_Sheet)
	if (@any_child_record > 0)
	print('Маршрутный лист не может быть удален так как в таблице 
	"Заявка", "Точки маршрутного листа" есть связанные данные!')
	else 
	delete from [dbo].[Route_Sheet]
		where 
		[ID_Route_Sheet] = @ID_Route_Sheet
go

update [dbo].[Route_Sheet] set [Number_Route_Sheet] = '2372-22' where [ID_Route_Sheet] = 3
go

delete [dbo].[Route_Sheet] where [ID_Route_Sheet] = 5
go

insert into [dbo].[Route_Sheet] ([Number_Route_Sheet], [Date_Route_Sheet], [Time_Route_Sheet], [Carrier_ID], [Transport_ID])
values ('0001-21', Convert(date, '24.12.2021'), Convert(time, '17:43:00'), 1, 1),
('0002-21', Convert(date, '28.12.2021'), Convert(time, '18:22:00'), 2, 2),
('0003-22', Convert(date, '01.01.2022'), Convert(time, '05:23:00'), 3, 3),
('0004-22', Convert(date, '01.12.2022'), Convert(time, '23:32:00'), 4, 4),
('0005-22', Convert(date, '03.12.2022'), Convert(time, '20:21:00'), 5, 5)
go

select [Number_Route_Sheet] as 'Номер', [Date_Route_Sheet] as 'Дата', [Time_Route_Sheet] as 'Время', [Name_Carrier] as 'Перевозчик',
[Name_Model]+' '+[Number_Transport] from [dbo].[Route_Sheet]
inner join [dbo].[Carrier] on [ID_Carrier] = [Carrier_ID]
inner join [dbo].[Transport] on [ID_Transport] = [Transport_ID] inner join [dbo].[Model] on [ID_Model] = [Model_ID]
go

create table [dbo].[Application]
(
	[ID_Application] [int] not null identity(1,1),
	[Number_Application] [varchar] (max) not null,
	[Date_Application] [date] not null default(getdate()),
	[Time_Application] [time] not null default(getdate()),
	[Status_Application] [varchar] (15) not null,
	[Customer_ID] [int] not null,
	[Route_Sheet_ID] [int] not null
	constraint [PK_Application] primary key clustered
	([ID_Application] ASC) on [PRIMARY],
	constraint [CH_Status_Application] check 
	([Status_Application] in ('Обработан', 'Обрабатывается', 'Отменен')),
	constraint [FK_Customer_Application] foreign key ([Customer_ID])
	references [dbo].[Customer] ([ID_Customer]),
	constraint [FK_Route_Sheet_Application] foreign key ([Route_Sheet_ID])
	references [dbo].[Route_Sheet] ([ID_Route_Sheet])
)
go

create or alter procedure [dbo].[Application_Insert]
@Number_Application [varchar] (max), @Date_Application [date], @Time_Application [time], @Status_Application [varchar] (15), 
@Customer_ID [int], @Route_Sheet_ID [int]
as
	begin try 
	insert into [Application] ([Number_Application], [Date_Application], [Time_Application], [Status_Application], [Customer_ID], [Route_Sheet_ID])
	values (@Number_Application, @Date_Application, @Time_Application, @Status_Application, @Customer_ID, @Route_Sheet_ID)
	end try 
	begin catch 
	print('Ошибка при вводе данных в заявку')
	end catch
go



create or alter procedure [dbo].[Application_Update]
@ID_Application [int], @Number_Application [varchar] (max), @Date_Application [date], @Time_Application [time], @Status_Application [varchar] (15), 
@Customer_ID [int], @Route_Sheet_ID [int]

as 
	begin try 
	update [dbo].[Application] set 
	[Number_Application] = @Number_Application,
	[Date_Application] = @Date_Application,
	[Time_Application] = @Time_Application,
	[Status_Application] = @Status_Application,
	[Customer_ID] = @Customer_ID,
	[Route_Sheet_ID] = @Route_Sheet_ID
	where 
		[ID_Application] = @ID_Application
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу заявка')
	end catch
go


create or alter procedure [dbo].[Application_Delete]
@ID_Application [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Application]
	where [ID_Application] = @ID_Application)
	if (@any_child_record > 0)
	print('Таблица Заявка может быть удалена так как у неё нет связей')
	else 
	delete from [dbo].[Application]
		where 
		[ID_Application] = @ID_Application
go

insert into [dbo].[Application] ([Number_Application], [Date_Application], [Time_Application], [Status_Application], [Customer_ID], [Route_Sheet_ID])
values ('1', Convert(date, '23.12.2021'), Convert(time, '17:43'), 'Обработан', 1, 1),
('2', Convert(date, '28.12.2021'), Convert(time, '16:23'), 'Обработан', 2, 2),
('3', Convert(date, '01.01.2022'), Convert(time, '00:00'), 'Обработан', 3, 3),
('4', Convert(date, '01.01.2022'), Convert(time, '19:32'), 'Обработан', 4, 4),
('5', Convert(date, '03.01.2022'), Convert(time, '17:21'), 'Обрабатывается', 5, 5)
go

select [Number_Application] as 'Номер заявки', [Date_Application] as 'Дата', [Time_Application] as 'Время', [Status_Application] as 'Статус',
[Name_Customer]+' '+[Surname_Customer]+' '+[Lastname_Customer] as 'ФИО покупателя', [Number_Route_Sheet] as 'Номер маршрутного листа' from [dbo].[Application]
inner join [dbo].[Customer] on [ID_Customer] = [Customer_ID]
inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]
go

select [Number_Application] as 'Номер заявки', [Date_Application] as 'Дата', [Time_Application] as 'Время', [Status_Application] as 'Статус',
[Name_Customer]+' '+[Surname_Customer]+' '+[Lastname_Customer] as 'ФИО покупателя', [Number_Route_Sheet] as 'Номер маршрутного листа' from [dbo].[Application]
inner join [dbo].[Customer] on [ID_Customer] = [Customer_ID]
inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]
where Convert(int, [Number_Application]) >= 3
go

create table [dbo].[Points_Route_Sheet]
(
	[ID_Point_Route_Sheet] [int] not null identity(1,1),
	[Delivery_Point_ID] [int] not null,
	[Route_Sheet_ID] [int] not null
	constraint [PK_Point_Route_Sheet] primary key clustered
	([ID_Point_Route_Sheet] ASC) on [PRIMARY],
	constraint [FK_Delivery_Point] foreign key ([Delivery_Point_ID])
	references [dbo].[Delivery_Points] ([ID_Delivery_Point]),
	constraint [FK_Route_Sheet] foreign key ([Route_Sheet_ID])
	references [dbo].[Route_Sheet] ([ID_Route_Sheet]),
)
go

create or alter procedure [dbo].[Points_Route_Sheet_Insert]
@Delivery_Point_ID [int], @Route_Sheet_ID [int]
as
	begin try 
	insert into [Points_Route_Sheet] ([Delivery_Point_ID], [Route_Sheet_ID])
	values (@Delivery_Point_ID, @Route_Sheet_ID)
	end try 
	begin catch 
	print('Ошибка при вводе данных в таблицу точки маршрутного листа')
	end catch
go



create or alter procedure [dbo].[Points_Route_Sheet_Update]
@ID_Points_Route_Sheet [int], @Delivery_Point_ID [int], @Route_Sheet_ID [int]

as 
	begin try 
	update [dbo].[Points_Route_Sheet] set 
	[Delivery_Point_ID] = @Delivery_Point_ID,
	[Route_Sheet_ID] = @Route_Sheet_ID
	where 
		[ID_Point_Route_Sheet] = @ID_Points_Route_Sheet
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу точки маршрутного листа')
	end catch
go


create or alter procedure [dbo].[Points_Route_Sheet_Delete]
@ID_Points_Route_Sheet [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Points_Route_Sheet]
	where [ID_Point_Route_Sheet] = @ID_Points_Route_Sheet)
	if (@any_child_record > 0)
	print('Таблица точки маршрутного листа может быть удалена так как у неё нет связей')
	else 
	delete from [dbo].[Points_Route_Sheet]	
		where 
		[ID_Point_Route_Sheet] = @ID_Points_Route_Sheet
go

insert into [dbo].[Points_Route_Sheet] ([Delivery_Point_ID], [Route_Sheet_ID])
values (1,1), (2,1), (1,2), (4,2), (1,3), (1,4), (3,4), (1,5), (5,5)
go

select [Delivery_Address] as 'Адрес доставки', [Number_Route_Sheet] as 'Номер маршрутного листа' from [dbo].[Points_Route_Sheet]
inner join [dbo].[Delivery_Points] on [ID_Delivery_Point] = [Delivery_Point_ID]
inner join [dbo].[Route_Sheet] on [ID_Route_Sheet] = [Route_Sheet_ID]
order by [Number_Route_Sheet] ASC
go

create table [dbo].[Post_Customer]
(
	[ID_Post_Customer] [int] not null identity(1,1),
	[Post_ID] [int] not null,
	[Customer_ID] [int] not null
	constraint [PK_Post_Customer] primary key clustered
	([ID_Post_Customer] ASC) on [PRIMARY],
	constraint [FK_Post] foreign key ([Post_ID])
	references [dbo].[Post] ([ID_Post]),
	constraint [FK_Customer] foreign key ([Customer_ID])
	references [dbo].[Customer] ([ID_Customer]),
)
go

create or alter procedure [dbo].[Post_Customer_Insert]
@Post_ID [int], @Customer_ID [int]
as
	begin try 
	insert into [Post_Customer] ([Post_ID], [Customer_ID])
	values (@Post_ID, @Customer_ID)
	end try 
	begin catch 
	print('Ошибка при вводе данных в таблицу должность заказчика')
	end catch
go



create or alter procedure [dbo].[Post_Customer_Update]
@ID_Post_Customer [int], @Post_ID [int], @Customer_ID [int]

as 
	begin try 
	update [dbo].[Post_Customer] set 
	[Post_ID] = @Post_ID,
	[Customer_ID] = @Customer_ID
	where 
		[ID_Post_Customer] = @ID_Post_Customer
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу должность заказчика')
	end catch
go


create or alter procedure [dbo].[Post_Customer_Delete]
@ID_Post_Customer [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Post_Customer]
	where [ID_Post_Customer] = @ID_Post_Customer)
	if (@any_child_record > 0)
	print('Таблица должность заказчика может быть удалена так как у неё нет связей')
	else 
	delete from [dbo].[Post_Customer]	
		where 
		[ID_Post_Customer] = @ID_Post_Customer
go

insert into [dbo].[Post_Customer] ([Post_ID], [Customer_ID])
values (2,1), (2,2), (4,3), (3,4), (4,5)
go

select [Name_Customer]+' '+[Surname_Customer]+' '+[Lastname_Customer] as 'ФИО заказчика', [Name_Post] as 'Должность' from [dbo].[Post_Customer]
inner join [dbo].[Customer] on [ID_Customer] = [Customer_ID]
inner join [dbo].[Post] on [ID_Post] = [Post_ID]
go

create table [dbo].[Country_Trasnport]
(
	[ID_Country_Transport] [int] not null identity(1,1),
	[Country_ID] [int] not null,
	[Transport_ID] [int] not null
	constraint [PK_Country_Transport] primary key clustered
	([ID_Country_Transport] ASC) on [PRIMARY],
	constraint [FK_Country] foreign key ([Country_ID])
	references [dbo].[Country] ([ID_Country]),
	constraint [FK_Transport] foreign key ([Transport_ID])
	references [dbo].[Transport] ([ID_Transport]),
)
go

create or alter procedure [dbo].[Country_Trasnport_Insert]
@Country_ID [int], @Transport_ID [int]
as
	begin try 
	insert into [Country_Trasnport] ([Country_ID], [Transport_ID])
	values (@Country_ID, @Transport_ID)
	end try 
	begin catch 
	print('Ошибка при вводе данных в таблицу страна транспорта')
	end catch
go



create or alter procedure [dbo].[Country_Trasnport_Update]
@ID_Country_Transport [int], @Country_ID [int], @Transport_ID [int]

as 
	begin try 
	update [dbo].[Country_Trasnport] set 
	[Country_ID] = @Country_ID,
	[Transport_ID] = @Transport_ID
	where 
		[ID_Country_Transport] = @ID_Country_Transport
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу страна транспорта')
	end catch
go


create or alter procedure [dbo].[Country_Trasnport_Delete]
@ID_Country_Transport [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Country_Trasnport]
	where [ID_Country_Transport] = @ID_Country_Transport)
	if (@any_child_record > 0)
	print('Таблица страна транспорта может быть удалена так как у неё нет связей')
	else 
	delete from [dbo].[Country_Trasnport]	
		where 
		[ID_Country_Transport] = @ID_Country_Transport
go

insert into [dbo].[Country_Trasnport] ([Country_ID], [Transport_ID])
values (1,1), (1,2), (2,3), (2,4), (2,5)
go

select [Number_Transport] as 'Номер', [Name_Country] as 'Страна' from [dbo].[Country_Trasnport]
inner join [dbo].[Country] on [ID_Country] = [Country_ID]
inner join [dbo].[Transport] on [ID_Transport] = [Transport_ID]
go

create table [dbo].[Post_Employee]
(
	[ID_Post_Employee] [int] not null identity(1,1),
	[Post_ID] [int] not null,
	[Employee_ID] [int] not null
	constraint [PK_Post_Employee] primary key clustered
	([ID_Post_Employee] ASC) on [PRIMARY],
	constraint [FK_Post_Employee] foreign key ([Post_ID])
	references [dbo].[Post] ([ID_Post]),
	constraint [FK_Employee] foreign key ([Employee_ID])
	references [dbo].[Employee] ([ID_Employee]),
)
go

create or alter procedure [dbo].[Post_Employee_Insert]
@Post_ID [int], @Employee_ID [int]
as
	begin try 
	insert into [Post_Employee] ([Post_ID], [Employee_ID])
	values (@Post_ID, @Employee_ID)
	end try 
	begin catch 
	print('Ошибка при вводе данных в таблицу должность сотрудника')
	end catch
go



create or alter procedure [dbo].[Post_Employee_Update]
@ID_Post_Employee [int], @Post_ID [int], @Employee_ID [int]

as 
	begin try 
	update [dbo].[Post_Employee] set 
	[Post_ID] = @Post_ID,
	[Employee_ID] = @Employee_ID	
	where 
		[ID_Post_Employee] = @ID_Post_Employee
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу должность сотрудника')
	end catch
go


create or alter procedure [dbo].[Post_Employee_Delete]
@ID_Post_Employee [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Post_Employee]
	where [ID_Post_Employee] = @ID_Post_Employee)
	if (@any_child_record > 0)
	print('Таблица должность сотрудника может быть удалена так как у неё нет связей')
	else 
	delete from [dbo].[Post_Employee]	
		where 
		[ID_Post_Employee] = @ID_Post_Employee
go


insert into [dbo].[Post_Employee] ([Employee_ID], [Post_ID])
values (1,1),(2,1),(3,1),(4,1),(5,1)
go

select [Name_Employee]+' '+[Surname_Employee]+' '+[Lastname_Employee] as 'ФИО сотрудника', [Login_Employee] as 'Логин', [Name_Post] as 'Должность' from [dbo].[Post_Employee]
inner join [dbo].[Employee] on [ID_Employee] = [Employee_ID]
inner join [dbo].[Post] on [ID_Post] = [Post_ID]
go

create table [dbo].[Cargo_Application]
(
	[ID_Cargo_Application] [int] not null identity(1,1),
	[Cargo_ID] [int] not null,
	[Application_ID] [int] null
	constraint [PK_Cargo_Application] primary key clustered
	([ID_Cargo_Application] ASC) on [PRIMARY],
	constraint [FK_Cargo] foreign key ([Cargo_ID])
	references [dbo].[Cargo] ([ID_Cargo]),
	constraint [FK_Application] foreign key ([Application_ID])
	references [dbo].[Application] ([ID_Application])
)
go

create or alter procedure [dbo].[Cargo_Application_Insert]
@Cargo_ID [int], @Application_ID [int]
as
	begin try 
	insert into [Cargo_Application] ([Cargo_ID], [Application_ID])
	values (@Cargo_ID, @Application_ID)
	end try 
	begin catch 
	print('Ошибка при вводе данных в таблицу заявка груза')
	end catch
go



create or alter procedure [dbo].[Cargo_Application_Update]
@ID_Cargo_Application [int], @Cargo_ID [int], @Application_ID [int]

as 
	begin try 
	update [dbo].[Cargo_Application] set 
	[Cargo_ID] = @Cargo_ID,
	[Application_ID] = @Application_ID	
	where 
		[ID_Cargo_Application] = @ID_Cargo_Application
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу заявка груза')
	end catch
go


create or alter procedure [dbo].[Cargo_Application_Delete]
@ID_Cargo_Application [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Cargo_Application]
	where [ID_Cargo_Application] = @ID_Cargo_Application)
	if (@any_child_record > 0)
	print('Таблица заявка груза может быть удалена так как у неё нет связей')
	else 
	delete from [dbo].[Cargo_Application]	
		where 
		[ID_Cargo_Application] = @ID_Cargo_Application
go


insert into [dbo].[Cargo_Application] ([Cargo_ID], [Application_ID])
values (1,1), (2,2), (3,3), (4,4), (5,5)
go

select [Description_Cargo] as 'Название товара', [Number_Application] as 'Номер заявки' from [dbo].[Cargo_Application]
inner join [dbo].[Cargo] on [ID_Cargo] = [Cargo_ID]
inner join [dbo].[Application] on [ID_Application] = [Application_ID]
go

create table [dbo].[Employee_License]
(
	[ID_Employee_License] [int] not null identity(1,1),
	[Employee_ID] [int] not null,
	[License_ID] [int] null
	constraint [PK_Employee_License] primary key clustered
	([ID_Employee_License] ASC) on [PRIMARY],
	constraint [FK_Employee_License] foreign key ([Employee_ID])
	references [dbo].[Employee] ([ID_Employee]),
	constraint [FK_License] foreign key ([License_ID])
	references [dbo].[License] ([ID_License])
)
go

create or alter procedure [dbo].[Employee_License_Insert]
@Employee_ID [int], @License_ID [int]
as
	begin try 
	insert into [Employee_License] ([Employee_ID], [License_ID])
	values (@Employee_ID, @License_ID)
	end try 
	begin catch 
	print('Ошибка при вводе данных в таблицу права сотрудника')
	end catch
go



create or alter procedure [dbo].[Employee_License_Update]
@ID_Employee_License [int], @Employee_ID [int], @License_ID [int]

as 
	begin try 
	update [dbo].[Employee_License] set 
	[Employee_ID] = @Employee_ID	,
	[License_ID] = @License_ID	
	where 
		[ID_Employee_License] = @ID_Employee_License
	end try 
	begin catch 
	print ('Ошибка при вводе данных в таблицу права сотрудника')
	end catch
go


create or alter procedure [dbo].[Employee_License_Delete]
@ID_Employee_License [int]
as
	declare @any_child_record [int] = (select count(*) from [dbo].[Employee_License]
	where [ID_Employee_License] = @ID_Employee_License)
	if (@any_child_record > 0)
	print('Таблица права сотрудника может быть удалена так как у неё нет связей')
	else 
	delete from [dbo].[Employee_License]	
		where 
		[ID_Employee_License] = @ID_Employee_License
go

insert into [dbo].[Employee_License] ([Employee_ID], [License_ID])
values (1,1), (2,1), (3,1), (3,2), (4,1),(5,1)
go

select [Name_Employee]+' '+[Surname_Employee]+' '+[Lastname_Employee] as 'ФИО', [Login_Employee] as 'Логин',
[Type_License] as 'Категория прав' from [dbo].[Employee_License]
inner join [dbo].[Employee] on [ID_Employee] = [Employee_ID]
inner join [dbo].[License] on [ID_License] = [License_ID]
go


create table [dbo].[EmployeeCust]
(
	[ID_EmployeeCust] [int] not null identity(1,1),
	[Employee_ID] [int] not null,
	[Application_ID] [int] not null,
	constraint [PK_EmployeeCust] primary key clustered 
	([ID_EmployeeCust] ASC) on [PRIMARY],
	constraint [FK_EmployeeCust] foreign key([Employee_ID])
	references [dbo].[Employee] ([ID_Employee]),
	constraint [FK_ApplicationCust] foreign key([Application_ID])
	references [dbo].[Application] ([ID_Application])
)
go

insert into [dbo].[EmployeeCust] ([Employee_ID], [Application_ID])
values
(1,1),
(1,1),
(1,1),
(1,1),
(1,1)
go

select [Employee_ID], [Application_ID] from [dbo].[EmployeeCust]
inner join [dbo].[Employee] on [ID_Employee] = [Employee_ID]
inner join [dbo].[Application] on [ID_Application] = [Application_ID]
go

create table [dbo].[BuyerCust]
(
	[ID_BayerCust] [int] not null identity(1,1),
	[Buyer_ID] [int] not null,
	[Application_ID] [int] not null,
	constraint [PK_Buyer_Cust] primary key clustered 
	([ID_BayerCust] ASC) on [PRIMARY],
	constraint [FK_BuyerCust] foreign key([Buyer_ID])
	references [dbo].[Buyer] ([ID_Buyer]),
	constraint [FK_CustomerApplicationCust] foreign key([Application_ID])
	references [dbo].[Application] ([ID_Application])
)
go

insert into [dbo].[CustomerCust] ([Customer_ID], [Application_ID])
values
(1,1),
(1,1),
(1,1),
(1,1),
(1,1)
go

select * from [dbo].[CustomerCust]