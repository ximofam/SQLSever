if DB_ID(N'TransactionTestingSQL') is not null
begin
	use TransactionTestingSQL;
end
go

drop table if exists Khoa;