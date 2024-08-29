if DB_ID(N'master') is not null
begin
	use master;
end
go

if DB_ID(N'IndexTestingSQL') is not null
begin
	alter database IndexTestingSQL
		set single_user with rollback immediate;
end
go

if DB_ID(N'master') is not null
begin
	use master;
end
go

drop database if exists IndexTestingSQL;
go