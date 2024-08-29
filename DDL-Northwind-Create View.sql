if DB_ID(N'Northwind') is not null
begin
	use Northwind;
end
go

create or alter view TestingViewThongTinKhachHangRutGon
as
select
	Customers.CustomerID, Customers.ContactName, Customers.ContactTitle,
	Customers.CompanyName, Customers.Country, Customers.City
from Customers;
go

create or alter view TestingViewThongTinNhanVienLaSalesRepresentative
as
select *
from Employees
where Employees.Title = N'Sales Representative';
go

create or alter view TestingViewDanhSachDonHangTrongNam1997
as
select *
from Orders
where Orders.OrderDate between '1997-01-01' and '1997-12-31';
go

create or alter view TestingViewDanhSachDonHangXuatSangUSAHoacUKV1
as
select *
from Orders
where Orders.ShipCountry in (N'USA', N'UK');
go

create or alter view TestingViewDanhSachDonHangXuatSangUSAHoacUKV2
as
select *
from Orders
where
	Orders.ShipCountry = N'USA' or
	Orders.ShipCountry = N'UK';
go

create or alter view TestingViewKhachHangMuaDonHang
as
select
	Customers.CustomerID, Customers.ContactName, Customers.ContactTitle, Customers.CompanyName,
	Orders.OrderID, Orders.OrderDate, Orders.RequiredDate
from Customers
	inner join Orders
		on Customers.CustomerID = Orders.CustomerID;
go

create or alter view TestingViewSoDonHangCuaKhachHangV1
as
select
	Customers.CustomerID, Customers.ContactName, Customers.ContactTitle, Customers.CompanyName,
	count(Orders.OrderID) as SoLuongDonHang
from Customers
	inner join Orders
		on Customers.CustomerID = Orders.CustomerID
group by Customers.CustomerID, Customers.ContactName, Customers.ContactTitle, Customers.CompanyName;
go

create or alter view TestingViewSoDonHangCuaKhachHangV2
as
select
	Customers.CustomerID, Customers.ContactName, Customers.ContactTitle, Customers.CompanyName,
	CustomerIDVaSLDonHang.SoLuongDonHang
from
	Customers
		inner join (
			select
				Customers.CustomerID,
				count(Orders.OrderID) as SoLuongDonHang
			from Customers
				inner join Orders
					on Customers.CustomerID = Orders.CustomerID
			group by Customers.CustomerID
	) CustomerIDVaSLDonHang
		on Customers.CustomerID = CustomerIDVaSLDonHang.CustomerID;
go