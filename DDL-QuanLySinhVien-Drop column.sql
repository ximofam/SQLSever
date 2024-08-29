if DB_ID(N'QuanLySinhVien') is not null
begin
	use QuanLySinhVien;
end
go

if OBJECT_ID(N'QuanLySinhVien.dbo.Khoa', N'U') is not null
begin
	if COL_LENGTH(N'QuanLySinhVien.dbo.Khoa', N'MoTaKhoa2') is not null
	begin
		alter table Khoa
			drop column MoTaKhoa2;
	end
end