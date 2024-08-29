if DB_ID(N'master') is not null
begin
	use master;
end
go

if DB_ID(N'TransactionTestingSQL') is null
begin
	create database TransactionTestingSQL;
end
go

if DB_ID(N'TransactionTestingSQL') is not null
begin
	use TransactionTestingSQL;
end
go