﻿--bai1
	SELECT IIF(LUONG>=ltb,'khong tang luong','tang luong')
	AS thuong,tennv,LUONG,ltb
	FROM
    (SELECT dbo.NHANVIEN.TENNV,dbo.NHANVIEN.LUONG,ltb FROM dbo.NHANVIEN,
	(SELECT dbo.NHANVIEN.PHG,AVG(dbo.NHANVIEN.LUONG) AS 'ltb' FROM dbo.NHANVIEN GROUP BY PHG) AS tam 
	WHERE dbo.NHANVIEN.PHG=tam.PHG) AS abc
--muc luong
	SELECT IIF(LUONG>=ltb,'truong phong','nhan vien')
	AS ChucVu,tennv,LUONG,ltb
	FROM
    (SELECT dbo.NHANVIEN.TENNV,dbo.NHANVIEN.LUONG,ltb FROM dbo.NHANVIEN,
	(SELECT dbo.NHANVIEN.PHG,AVG(dbo.NHANVIEN.LUONG) AS 'ltb' FROM dbo.NHANVIEN GROUP BY PHG) AS tam 
	WHERE dbo.NHANVIEN.PHG=tam.PHG) AS abc
---hiển thị tên nhân viên dựa  vào cột phái
SELECT tennv = CASE phai
WHEN 'Nam' THEN 'Mr.'+ [tennv]
WHEN 'Nữ' THEN 'Ms.'+[tennv]
end
FROM dbo.NHANVIEN

SELECT * FROM dbo.NHANVIEN
--thuế--
SELECT tennv,luong,thue = CASE
WHEN luong BETWEEN 0 AND 25000 THEN luong*0.1
WHEN luong BETWEEN 25000 AND 30000 THEN luong*0.12
WHEN luong BETWEEN 30000 AND 40000 THEN luong*0.15
WHEN luong BETWEEN 40000 AND 50000 THEN luong*0.2
WHEN luong  > 50000 THEN luong*0.25
END 
FROM dbo.NHANVIEN
--bai 2
--Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn.
DECLARE @chan INT =2
WHILE @chan < (SELECT COUNT(MANV) FROM dbo.NHANVIEN)
BEGIN
	SELECT TENNV,MANV FROM dbo.NHANVIEN WHERE CAST(MANV AS INT)=@chan
	SET @chan=@chan+2;
	END
--Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn nhưng không tính nhân viên có MaNV là 4.
DECLARE @chan INT =2
 WHILE @chan < (SELECT COUNT(MANV) FROM dbo.NHANVIEN)
BEGIN
	IF @chan=4 
	BEGIN
	SET @chan=@chan+2;
	END
	SELECT TENNV,MANV FROM dbo.NHANVIEN WHERE CAST(MANV AS INT)=@chan
	SET @chan=@chan+2;
END