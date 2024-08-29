if DB_ID(N'master') is not null
begin
	use master;
end
go

if DB_ID(N'IndexTestingSQL') is null
begin
	create database IndexTestingSQL;
end
go

if DB_ID(N'IndexTestingSQL') is not null
begin
	use IndexTestingSQL;
end
go