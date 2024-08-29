if DB_ID(N'QuanLySinhVien') is not null
begin
	use QuanLySinhVien;
end
go

if OBJECT_ID(N'QuanLySinhVien.dbo.Lop', N'U') is not null
begin
	alter table Lop
		drop constraint if exists fk_lop_khoa; --if exists có từ SQL Server 2016 (phiên bản 13.x)
end

if OBJECT_ID(N'QuanLySinhVien.dbo.SinhVien', N'U') is not null
begin
	alter table SinhVien
		drop constraint if exists fk_sinh_vien_lop;
end

if OBJECT_ID(N'QuanLySinhVien.dbo.MonHoc', N'U') is not null
begin
	alter table MonHoc
		drop constraint if exists fk_mon_hoc_khoa_quan_ly;
end

if OBJECT_ID(N'QuanLySinhVien.dbo.Diem', N'U') is not null
begin
	alter table Diem
		drop constraint if exists fk_diem_sinh_vien;

	alter table Diem
		drop constraint if exists fk_diem_mon_hoc;

	alter table Diem
		drop constraint if exists fk_diem_giang_vien;
end

drop table if exists SinhVien; --if exists có từ SQL Server 2016 (phiên bản 13.x)

drop table if exists Lop;

drop table if exists Khoa;

drop table if exists MonHoc;

drop table if exists GiangVien;

drop table if exists Diem;

drop type if exists nvarchar_max;