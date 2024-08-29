if DB_ID(N'master') is not null
begin
	use master;
end
go

if DB_ID(N'QuanLySinhVien') is null
begin
	create database QuanLySinhVien;
end
go

if DB_ID(N'QuanLySinhVien') is not null
begin
	use QuanLySinhVien;
end
go