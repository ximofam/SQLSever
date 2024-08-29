if DB_ID(N'Northwind') is not null
begin
	use Northwind;
end
go

drop view if exists TestingViewThongTinKhachHangRutGon;

drop view if exists TestingViewThongTinNhanVienLaSalesRepresentative;

drop view if exists TestingViewDanhSachDonHangTrongNam1997;

drop view if exists TestingViewDanhSachDonHangXuatSangUSAHoacUKV1;

drop view if exists TestingViewDanhSachDonHangXuatSangUSAHoacUKV2;

drop view if exists TestingViewKhachHangMuaDonHang;

drop view if exists TestingViewSoDonHangCuaKhachHangV1;

drop view if exists TestingViewSoDonHangCuaKhachHangV2;