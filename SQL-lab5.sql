--bài 1
--In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của bạn.
CREATE PROC sp_1a @name NVARCHAR(20)
AS
BEGIN
	PRINT 'Xin chào: ' + @name
END
EXEC dbo.sp_1a @name = N'Văn Đồng' -- nvarchar(20)

--Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2.

CREATE PROC sp_1b @s1 INT, @s2 INT
AS
BEGIN
	DECLARE @tg INT =0
	SET @tg = @s1 +@s2
	PRINT 'Tong la: ' + CAST(@tg AS VARCHAR(10))
END
EXEC sp_1b 3,7

---Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.
CREATE PROC sp_1c @n INT
AS
BEGIN
	DECLARE @s INT = 0, @i INT = 0 ;
	WHILE @i < @n
		BEGIN
			SET @s = @s +@i
			SET @i =@i +2
		END
		PRINT 'tong cac so chan: '+ CAST(@s AS VARCHAR(10))
END
EXEC sp_1c 10
---1d
CREATE PROC sp_1d @a INT, @b INT
AS
BEGIN
	WHILE (@a != @b)
	BEGIN
		IF(@a>@b)
		SET @a=@a-@b
		ELSE SET @b=@b-@a
	END
	RETURN @a
END
DECLARE @c INT 
EXEC @c=sp_1d 6,8
PRINT @c
---bai2
---a
CREATE PROC sp_2a @MaNV VARCHAR(5)
AS
BEGIN
	SELECT * FROM dbo.NHANVIEN WHERE MANV=@MaNV
END
EXEC sp_2a '002'
---b
CREATE PROC sp_2b @Manv INT 
AS
BEGIN
	SELECT COUNT(MANV) AS N'Số lượng',tenphg,MADA FROM dbo.NHANVIEN
	INNER JOIN dbo.PHONGBAN ON dbo.NHANVIEN.PHG=dbo.PHONGBAN.MAPHG
	INNER JOIN dbo.DEAN ON dbo.DEAN.PHONG = dbo.PHONGBAN.MAPHG
	WHERE MADA = @Manv
	GROUP BY tenphg,MADA

END
EXEC sp_2b '003'
--c
CREATE PROC sp_2c @manv INT, @diadiem VARCHAR(20)
AS
BEGIN
	SELECT COUNT(MANV) AS N'Số lượng',tenphg,MADA FROM dbo.NHANVIEN
	INNER JOIN dbo.PHONGBAN ON dbo.NHANVIEN.PHG=dbo.PHONGBAN.MAPHG
	INNER JOIN dbo.DEAN ON dbo.DEAN.PHONG = dbo.PHONGBAN.MAPHG
	WHERE MADA = @Manv AND DDIEM_DA = @diadiem
	GROUP BY tenphg,MADA
END
EXEC sp_2c 1,N'Hà Nội'
SELECT * FROM dbo.DEAN
--d
CREATE PROC sp_2d @matp VARCHAR(5)
AS
BEGIN
	SELECT *FROM dbo.NHANVIEN
	INNER JOIN dbo.PHONGBAN ON PHONGBAN.MAPHG = NHANVIEN.PHG
	LEFT OUTER JOIN dbo.THANNHAN ON THANNHAN.MA_NVIEN = NHANVIEN.MANV
	WHERE dbo.THANNHAN.MA_NVIEN IS NULL AND TRPHG = @matp
END 
EXEC sp_2d '008'
--e
CREATE PROC sp_2e @manv VARCHAR(10),@mapb VARCHAR(10)
AS
BEGIN
	IF EXISTS (SELECT * FROM dbo.NHANVIEN WHERE MANV=@manv AND PHG=@mapb)
		PRINT 'Nhan vien '+@manv+' co trong phong ban: '+@mapb
	ELSE
		PRINT 'Nhan vien '+@manv+'khong co trong phong ban: '+@mapb
END 
EXEC sp_2e '001','4'