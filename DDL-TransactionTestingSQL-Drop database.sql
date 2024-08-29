if DB_ID(N'master') is not null
begin
	use master;
end
go

if DB_ID(N'TransactionTestingSQL') is not null
begin
	alter database TransactionTestingSQL
		set single_user with rollback immediate;
end
go

if DB_ID(N'master') is not null
begin
	use master;
end
go

drop database if exists TransactionTestingSQL;
go