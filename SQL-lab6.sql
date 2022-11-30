---bai1
--Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì xuất thông báo “luong phải >15000’\
CREATE TRIGGER trg_chenNV ON dbo.NHANVIEN
FOR INSERT
AS
IF(SELECT luong FROM Inserted)<15000
BEGIN
	PRINT 'Luong phai lon hon 15000'
	ROLLBACK TRANSACTION
	END

INSERT INTO dbo.NHANVIEN
(
    HONV,
    TENLOT,
    TENNV,
    MANV,
    NGSINH,
    DCHI,
    PHAI,
    LUONG,
    MA_NQL,
    PHG
)
VALUES
(   N'Tran',       -- HONV - nvarchar(15)
    N'thi',       -- TENLOT - nvarchar(15)
    N'tam',       -- TENNV - nvarchar(15)
    N'021',       -- MANV - nvarchar(9)
    '2022-11-30', -- NGSINH - datetime
    N'dak lak',       -- DCHI - nvarchar(30)
    N'nam',       -- PHAI - nvarchar(3)
    14000,       -- LUONG - float
    '004',      -- MA_NQL - nvarchar(9)
    1       -- PHG - int
    )
--1b
CREATE TRIGGER trg_chenNv1 ON NHANVIEN
FOR INSERT
AS 
 DECLARE @tuoi INT
 SET @tuoi = YEAR(GETDATE())-(SELECT YEAR(Inserted.NGSINH) FROM Inserted)
 IF (@tuoi < 18 OR @tuoi>65)
BEGIN
	PRINT 'tuoi nam trong 18 den 65'
	ROLLBACK TRANSACTION
END
INSERT INTO dbo.NHANVIEN
(
    HONV,
    TENLOT,
    TENNV,
    MANV,
    NGSINH,
    DCHI,
    PHAI,
    LUONG,
    MA_NQL,
    PHG
)
VALUES
(   N'Tran',       -- HONV - nvarchar(15)
    N'thi',       -- TENLOT - nvarchar(15)
    N'tam',       -- TENNV - nvarchar(15)
    N'022',       -- MANV - nvarchar(9)
    '2022-11-30', -- NGSINH - datetime
    N'dak lak',       -- DCHI - nvarchar(30)
    N'nam',       -- PHAI - nvarchar(3)
    16000,       -- LUONG - float
    '004',      -- MA_NQL - nvarchar(9)
    1       -- PHG - int
    ) 
--1c
CREATE TRIGGER trg_UpdateNV ON nhanvien
FOR UPDATE
AS 
 IF(SELECT dchi FROM Inserted) LIKE '%hcm%'
	BEGIN
		PRINT 'dia chi khong hop le'
		ROLLBACK TRANSACTION
	END
SELECT * FROM dbo.NHANVIEN
UPDATE dbo.NHANVIEN SET TENNV='phamTu' WHERE MANV ='001'
---baitaptrenlop
CREATE TRIGGER Xoa_NV
ON Nhanvien
AFTER DELETE
AS 
BEGIN
	DECLARE @momat NCHAR(10)
	SELECT @momat=COUNT(*) FROM deleted
	PRINT N'so luong nhan vien da xoa '+@momat
END

DELETE FROM dbo.NHANVIEN WHERE MANV='017'
--bai2
--a
CREATE TRIGGER trg_insertnva ON nhanvien
AFTER INSERT
AS 
BEGIN
	SELECT COUNT(CASE WHEN UPPER(phai)='Nam' THEN 1 end) Nam,
	COUNT(CASE WHEN UPPER(Phai)=N'Nữ' THEN 1 end) Nữ
	FROM dbo.NHANVIEN
END
INSERT INTO dbo.NHANVIEN
(
    HONV,
    TENLOT,
    TENNV,
    MANV,
    NGSINH,
    DCHI,
    PHAI,
    LUONG,
    MA_NQL,
    PHG
)
VALUES
(   N'Tran',       -- HONV - nvarchar(15)
    N'thi',       -- TENLOT - nvarchar(15)
    N'tam',       -- TENNV - nvarchar(15)
    N'025',       -- MANV - nvarchar(9)
    '1998-11-30', -- NGSINH - datetime
    N'dak lak',       -- DCHI - nvarchar(30)
    N'nam',       -- PHAI - nvarchar(3)
    16000,       -- LUONG - float
    '004',      -- MA_NQL - nvarchar(9)
    1       -- PHG - int
    ) 
	--b
CREATE TRIGGER trg_updatenv2b ON nhanvien
AFTER UPDATE 
AS 
BEGIN 
	IF UPDATE(Phai)
	BEGIN
		SELECT COUNT(CASE WHEN UPPER(phai)='Nam' THEN 1 end) Nam,
		COUNT(CASE WHEN UPPER(Phai)=N'Nữ' THEN 1 end) Nữ
		FROM dbo.NHANVIEN
	END
END
UPDATE dbo.NHANVIEN SET PHAI='Nam' WHERE MANV='023'
---c
CREATE TRIGGER trg_demduan2c ON dean
AFTER DELETE
AS 
BEGIN
	SELECT ma_nvien, COUNT(mada) FROM
    dbo.PHANCONG GROUP BY MA_NVIEN
END 
DELETE dbo.DEAN WHERE MADA = 12
---bai3
CREATE TRIGGER trg_xoathannhan ON nhanvien
INSTEAD OF DELETE
AS 
BEGIN 
	DELETE FROM dbo.THANNHAN WHERE MA_NVIEN IN (SELECT manv FROM deleted)
	DELETE FROM dbo.NHANVIEN WHERE MANV IN (SELECT manv FROM deleted)
END
DELETE dbo.NHANVIEN WHERE MANV='001'
---b
ALTER TRIGGER trg_chennv3b ON nhanvien
AFTER INSERT
AS BEGIN
	INSERT INTO dbo.PHANCONG
	(
	    MA_NVIEN,
	    MADA,
	    STT,
	    THOIGIAN
	)
	VALUES
	(  (SELECT manv FROM Inserted),1,1,100
	    )
END
INSERT INTO dbo.NHANVIEN
(
    HONV,
    TENLOT,
    TENNV,
    MANV,
    NGSINH,
    DCHI,
    PHAI,
    LUONG,
    MA_NQL,
    PHG
)
VALUES
(   N'Tran',       -- HONV - nvarchar(15)
    N'thi',       -- TENLOT - nvarchar(15)
    N'tam',       -- TENNV - nvarchar(15)
    N'025',       -- MANV - nvarchar(9)
    '1998-11-30', -- NGSINH - datetime
    N'dak lak',       -- DCHI - nvarchar(30)
    N'nam',       -- PHAI - nvarchar(3)
    16000,       -- LUONG - float
    '004',      -- MA_NQL - nvarchar(9)
    1       -- PHG - int
    )
