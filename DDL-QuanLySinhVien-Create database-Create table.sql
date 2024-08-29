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


if TYPE_ID(N'dbo.nvarchar_max') is null
begin
	create type nvarchar_max from nvarchar(max) null;
end
go

if OBJECT_ID(N'QuanLySinhVien.dbo.Khoa', N'U') is null
begin
	create table Khoa
	(
		MaKhoa nvarchar(10) not null primary key,
		TenKhoa nvarchar(50) null,
		MoTaKhoa nvarchar(100) null,
		MoTaKhoa2 nvarchar(100) null,
	);
end

if OBJECT_ID(N'QuanLySinhVien.dbo.Lop', N'U') is null
begin
	create table Lop
	(
		MaLop nvarchar(10) not null default 'CS',
		MoTaLop nvarchar(100) null,
		MaKhoa nvarchar(10) null,
		constraint pk_lop primary key (MaLop),
		constraint fk_lop_khoa foreign key (MaKhoa) references Khoa (MaKhoa)
			on update cascade
			on delete set null
	);
end

if OBJECT_ID(N'QuanLySinhVien.dbo.SinhVien', N'U') is null
begin
	create table SinhVien
	(
		MaSV nvarchar(10) not null,
		HoLotSV nvarchar(50) null,
		TenSV nvarchar(50) null,
		GioiTinhSV nvarchar(20) null constraint df_gioi_tinh_sv_m default 'M',-- default 'F',-- check(GioiTinhSV in ('M', 'F')),
		GhiChuSV nvarchar_max,
		EmailSinhVien nvarchar(100) null,
		MaLop nvarchar(10) null,
		constraint ck_gioi_tinh_sv check(GioiTinhSV in ('M', 'F')),
		constraint uq_email_sinh_vien unique(EmailSinhVien)
	);
end

if OBJECT_ID(N'QuanLySinhVien.dbo.SinhVien', N'U') is not null
begin
	if OBJECT_ID(N'pk_sinh_vien') is null
	begin
		alter table SinhVien
			add constraint pk_sinh_vien primary key (MaSV);
	end
	
	if COL_LENGTH(N'QuanLySinhVien.dbo.SinhVien', N'TenSV') is not null
	begin
		alter table SinhVien
			alter column TenSV nvarchar(50) not null;
	end
end

if OBJECT_ID(N'QuanLySinhVien.dbo.MonHoc', N'U') is null
begin
	create table MonHoc
	(
		MaMonHoc nvarchar(10) not null constraint pk_mon_hoc primary key,
		TenMonHoc nvarchar(100) null,
		MaKhoaQuanLy nvarchar(10) null constraint fk_mon_hoc_khoa_quan_ly foreign key references Khoa (MaKhoa),
	);
end

if OBJECT_ID(N'QuanLySinhVien.dbo.GiangVien', N'U') is null
begin
	create table GiangVien
	(
		MaGiangVien nvarchar(10) not null primary key,
		HoLotGiangVien nvarchar(100) null,
		TenGiangVien nvarchar(50) null,
		GioiTinhGiangVien nvarchar(20) null check (GioiTinhGiangVien in ('F', 'M')),
		EmailGiangVien nvarchar(100) null unique
	);
end

if OBJECT_ID(N'QuanLySinhVien.dbo.Diem', N'U') is null
begin
	create table Diem
	(
		MaSV nvarchar(10) not null,
		MaMonHoc nvarchar(10) not null,
		MaGiangVien nvarchar(10) not null,
		Diem decimal(14,7) null,
		constraint pk_diem primary key (MaSV, MaMonHoc, MaGiangVien),
		constraint fk_diem_sinh_vien foreign key (MaSV) references SinhVien (MaSV),
		constraint fk_diem_mon_hoc foreign key (MaMonHoc) references MonHoc (MaMonHoc),
		constraint fk_diem_giang_vien foreign key (MaGiangVien) references GiangVien (MaGiangVien)
	);
end
go

if OBJECT_ID(N'QuanLySinhVien.dbo.Khoa', N'U') is not null
begin
	if OBJECT_ID(N'uq_ten_khoa', N'UQ') is null
	begin
		alter table Khoa
			add constraint uq_ten_khoa unique(TenKhoa);
	end

	if COL_LENGTH(N'QuanLySinhVien.dbo.Khoa', N'SoDienThoaiKhoa') is null
	begin
		alter table Khoa
			add SoDienThoaiKhoa nvarchar(20) null;
	end
end

if OBJECT_ID(N'QuanLySinhVien.dbo.SinhVien', N'U') is not null
begin
	if OBJECT_ID(N'fk_sinh_vien_lop', N'F') is null
	begin
		alter table SinhVien
			add constraint fk_sinh_vien_lop foreign key (MaLop) references Lop (MaLop);
	end

	if OBJECT_ID(N'df_gioi_tinh_sv_m', N'D') is not null
	begin
		alter table SinhVien
			drop constraint df_gioi_tinh_sv_m;
	end

	if OBJECT_ID(N'df_gioi_tinh_sv_f', N'D') is null
	begin
		alter table SinhVien
			add constraint df_gioi_tinh_sv_f default 'F' for GioiTinhSV;
	end
end