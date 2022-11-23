--1 chương trình tính chu vi dien tich hình chữ nhật

declare @DienTich int
declare @ChuVi int

declare @a int =10
declare @b int =20

set @DienTich = @a *@b
set @ChuVi = (@a + @b)*2

print @DienTich
print @ChuVi

--2--
--2.1 Cho biêt nhân viên có lương cao nhất
select * from NHANVIEN
declare @MaxLuong int

select @MaxLuong = MAX(LUONG) FROM NHANVIEN
PRINT @MaxLuong
--2.2 Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nghiên cứu”
select AVG(LUONG) from NHANVIEN

declare @LuongTB float
--set @LuongTB = LUONG > select AVG(LUONG) from NHANVIEN
select NHANVIEN.HONV,NHANVIEN.TENLOT,NHANVIEN.TENNV
from NHANVIEN
where @LuongTB=LUONG and @LuongTB > (select AVG(LUONG) from NHANVIEN, PHONGBAN where NHANVIEN.PHG=PHONGBAN.MAPHG and PHONGBAN.TENPHG='Nghiên cứu')

	--SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên nhân viên có lương trung bình trên mức lương trung bình của phòng "Nghiên cứu"'
	--FROM NHANVIEN
	--WHERE NHANVIEN.LUONG > (SELECT AVG(NHANVIEN.LUONG)
							--FROM NHANVIEN, PHONGBAN
							--WHERE NHANVIEN.PHG = PHONGBAN.MAPHG AND
								  --PHONGBAN.TENPHG = N'Nghiên cứu')

--2.3 Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
	declare @TenPhongBan char(30)
	declare @SoLuongNV int

	select @TenPhongBan=TENPHG,@SoLuongNV=COUNT(*)
	from PHONGBAN,NHANVIEN
	where MAPHG=PHG
	group by @TenPhongBan
	having avg(LUONG)>30000

	print @TenPhongBan
	print @SoLuongNV

	--select TENPHG,COUNT(*) as 'Số lượng nhân viên làm việc'
	--from PHONGBAN,NHANVIEN
	--where MAPHG=PHG
	--group by TENPHG
	--having avg(LUONG)>30000
--2.4 Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì

declare @tenphgban char
declare @sldean int

select @tenphgban=TENPHG, @sldean=COUNT(*)
from PHONGBAN, DEAN
where MAPHG=PHONG
group by TENPHG
	--select TENPHG,count(*) as 'Số lượng đề án'
	--from PHONGBAN,DEAN
	--where maphg=phong
	--group by TENPHG
	--select*
	--from DEAN