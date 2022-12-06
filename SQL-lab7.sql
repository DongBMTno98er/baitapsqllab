--bai1
--1a
CREATE FUNCTION fuMaNhanVien(@maNV NVARCHAR(10))
RETURNS INT
AS 
BEGIN 
	RETURN (SELECT YEAR(GETDATE())-YEAR(ngsinh)
	FROM dbo.NHANVIEN
	WHERE MANV=@maNV
	)
END
PRINT 'tuoi cua nhan vien: ' + CAST(dbo.fuMaNhanVien('005') AS NVARCHAR(10))
SELECT *FROM dbo.NHANVIEN
--1b
CREATE FUNCTION fuDeAn(@maNV NVARCHAR(10))
RETURNS INT
AS 
BEGIN 
	RETURN (SELECT COUNT(mada)
	FROM dbo.PHANCONG
	WHERE MA_NVIEN=@maNV
	)
END
PRINT 'so luong de an ma nhan vien do tham gia: '+ CAST(dbo.fuDeAn('005') AS NVARCHAR(10))
--1c
CREATE FUNCTION fuPhai(@gt NVARCHAR(5))
RETURNS INT
AS 
BEGIN 
	RETURN (SELECT COUNT(*)
	FROM dbo.NHANVIEN
	WHERE PHAI=@gt
	)
END
PRINT 'so luong nhan vien nam: '+ CAST(dbo.fuPhai('Nam') AS NVARCHAR(10))
PRINT 'so luong nhan vien nu: '+ CAST(dbo.fuPhai(N'Nữ') AS NVARCHAR(10))
--1d
ALTER FUNCTION fuLuong(@tenphgban nvarchar(25))
RETURNS @Dsnv TABLE(hoten nvarchar(60),luong float)
AS
BEGIN
	DECLARE @luongtb FLOAT
	SELECT @luongtb=AVG(luong) FROM dbo.NHANVIEN
	INNER JOIN dbo.PHONGBAN ON PHONGBAN.MAPHG = NHANVIEN.PHG
	WHERE TENPHG=@tenphgban 

	INSERT INTO @Dsnv
	SELECT CONCAT(honv,' ',tenlot,' ',tennv), luong FROM dbo.NHANVIEN
	WHERE LUONG > @luongtb
	RETURN
END
SELECT * FROM dbo.fuLuong(N'Điều hành')
--1e
CREATE FUNCTION fuPb_dean(@Mapb int)
RETURNs @Dspb TABLE(tenphong nvarchar(20),hotennv nvarchar(50),slduan int)
AS
BEGIN
	INSERT INTO @Dspb
	SELECT dbo.PHONGBAN.TENPHG, CONCAT(honv,' ',tenlot,' ',tennv),COUNT(MADA)
	FROM dbo.PHONGBAN INNER JOIN dbo.DEAN ON DEAN.PHONG = PHONGBAN.MAPHG 
	INNER JOIN dbo.NHANVIEN ON NHANVIEN.PHG = PHONGBAN.MAPHG
	WHERE MAPHG=@Mapb
	GROUP BY TENPHG,HONV,TENLOT,TENNV
	RETURN
END
SELECT * FROM dbo.fuPb_dean('001')