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


--BEGIN Tạo bảng dữ liệu
if OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_khong_pk_khong_idx', N'U') is null
begin
	create table SinhVien_khong_pk_khong_idx
	(
		MaSV nvarchar(50) not null,
		HoLotSV nvarchar(200) null,
		TenSV nvarchar(200) null,
	);
end

if OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_khong_pk_co_nonclustered_idx', N'U') is null
begin
	create table SinhVien_khong_pk_co_nonclustered_idx
	(
		MaSV nvarchar(50) not null,
		HoLotSV nvarchar(200) null,
		TenSV nvarchar(200) null,
	);

	IF not exists (
		select 1
		from sys.indexes
		where
			object_id = OBJECT_ID('SinhVien_khong_pk_co_nonclustered_idx.TenSV') and
			name = 'idx_nonclustered_tensv')
	begin
		create nonclustered index idx_nonclustered_tensv
			on SinhVien_khong_pk_co_nonclustered_idx(TenSV);
	end
end

if OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_co_pk', N'U') is null
begin
	create table SinhVien_co_pk
	(
		MaSV nvarchar(50) not null,
		HoLotSV nvarchar(200) null,
		TenSV nvarchar(200) null,
		constraint pk_sinh_vien primary key (MaSV)
	);
end

if OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_co_pk_co_nonclustered_idx', N'U') is null
begin
	create table SinhVien_co_pk_co_nonclustered_idx
	(
		MaSV nvarchar(50) not null,
		HoLotSV nvarchar(200) null,
		TenSV nvarchar(200) null,
		constraint pk_sinh_vien_co_nonclustered_idx primary key (MaSV)
	);

	IF not exists (
		select 1
		from sys.indexes 
		where
			object_id = OBJECT_ID('SinhVien_co_pk_co_nonclustered_idx.TenSV') and
			name = 'idx_tensv')
	begin
		create nonclustered index idx_tensv
			on SinhVien_co_pk_co_nonclustered_idx(TenSV);
	end

end
--END Tạo bảng dữ liệu

--BEGIN Chèn dữ liệu
if OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_khong_pk_khong_idx', N'U') is not null
begin
	truncate table SinhVien_khong_pk_khong_idx;
end

if OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_co_pk', N'U') is not null
begin
	truncate table SinhVien_co_pk;
end

if OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_co_pk_co_nonclustered_idx', N'U') is not null
begin
	truncate table SinhVien_co_pk_co_nonclustered_idx;
end

declare @counter int = 1;
declare @max int = 1000;
declare @MaSV nvarchar(50);
declare @HoLotSV nvarchar(200);
declare @TenSV nvarchar(200);

if
	(OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_khong_pk_khong_idx', N'U') is not null) and
	(OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_co_pk', N'U') is not null) and
	(OBJECT_ID(N'IndexTestingSQL.dbo.SinhVien_co_pk_co_nonclustered_idx', N'U') is not null)
begin
	set nocount on
	while(@counter <= @max)
	begin
		set @MaSV = 'masv' + RTRIM(@counter);
		set @HoLotSV  = 'holotsv' + RTRIM(@counter);
		set @TenSV = 'tensv' + RTRIM(@counter);

		insert into SinhVien_khong_pk_khong_idx values(@MaSV, @HoLotSV, @TenSV);
		insert into SinhVien_khong_pk_co_nonclustered_idx values(@MaSV, @HoLotSV, @TenSV);
		insert into SinhVien_co_pk values(@MaSV, @HoLotSV, @TenSV);
		insert into SinhVien_co_pk_co_nonclustered_idx values(@MaSV, @HoLotSV, @TenSV);

		set @counter += 1;
	end
end
--END Chèn dữ liệu