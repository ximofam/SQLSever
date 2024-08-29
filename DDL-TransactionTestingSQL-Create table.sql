if DB_ID(N'TransactionTestingSQL') is not null
begin
	use TransactionTestingSQL;
end
go

if OBJECT_ID(N'TransactionTestingSQL.dbo.Khoa', N'U') is null
begin
	create table Khoa
	(
		MaKhoa nvarchar(10) not null primary key,
		TenKhoa nvarchar(200) null,
	);
end
go

if OBJECT_ID(N'TransactionTestingSQL.dbo.Khoa', N'U') is not null
begin
	truncate table Khoa;
end

begin transaction
insert into Khoa
values
	(N'CNTT', N'Công nghệ thông tin'),
	(N'XD', N'Xây dựng');
commit; -- commit transaction;

/*
Kết quả:

+--------+---------------------+
| MaKhoa | TenKhoa             |
+--------+---------------------+
| CNTT   | Công nghệ thông tin |
+--------+---------------------+
| XD     | Xây dựng            |
+--------+---------------------+

*/
go

begin transaction
insert into Khoa
values
	(N'XHH', N'Xã hội học - Công tác xã hội - Đông Nam Á'),
	(N'QTKD', N'Quản trị kinh doanh');
rollback; -- rollback transaction;

/*

Do có lời gọi rollback nên hai mẫu tin được thêm từ values là:

+------+-------------------------------------------+
| XHH  | Xã hội học - Công tác xã hội - Đông Nam Á |
+------+-------------------------------------------+
| QTKD | Quản trị kinh doanh                       |
+------+-------------------------------------------+

không lưu vào bảng dữ liệu Khoa

Kết quả:

+--------+---------------------+
| MaKhoa | TenKhoa             |
+--------+---------------------+
| CNTT   | Công nghệ thông tin |
+--------+---------------------+
| XD     | Xây dựng            |
+--------+---------------------+

*/
go

if OBJECT_ID(N'TransactionTestingSQL.dbo.Khoa', N'U') is not null
begin
	select *
	from Khoa;
end