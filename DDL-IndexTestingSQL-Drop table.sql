if DB_ID(N'IndexTestingSQL') is not null
begin
	use IndexTestingSQL;
end
go

drop index if exists idx_nonclustered_tensv
	on SinhVien_khong_pk_co_nonclustered_idx;

drop index if exists idx_tensv
	on SinhVien_co_pk_co_nonclustered_idx;

drop table if exists SinhVien_khong_pk_khong_idx;

drop table if exists SinhVien_khong_pk_co_nonclustered_idx;

drop table if exists SinhVien_co_pk;

drop table if exists SinhVien_co_pk_co_nonclustered_idx;