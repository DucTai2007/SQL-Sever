--1
CREATE DATABASE taindtd00541;
USE taindtd00541;

CREATE TABLE GiangVien (
    MaGiangVien INT PRIMARY KEY not null,
    TenGiangVien NVARCHAR(100) not null,
    BoMon NVARCHAR(100),
    Email NVARCHAR(100),
    NamSinh DATE not null
);

CREATE TABLE HoiDongDATN (
    MaHoiDong INT PRIMARY KEY not null,
    TenHoiDong NVARCHAR(100) not null,
    ChuyenNganh NVARCHAR(100) not null,
    HocKy NVARCHAR(50)
);

CREATE TABLE DanhSachHoiDong (
    MaGiangVien INT not null,
    MaHoiDong INT not null,
    VaiTro NVARCHAR(50) not null,
    GhiChu NVARCHAR(200),
    PRIMARY KEY (MaGiangVien, MaHoiDong),
    FOREIGN KEY (MaGiangVien) REFERENCES GiangVien(MaGiangVien),
    FOREIGN KEY (MaHoiDong) REFERENCES HoiDongDATN(MaHoiDong)
);

--2
CREATE PROCEDURE sp_InsertGiangVien
    @MaGiangVien INT,
    @TenGiangVien NVARCHAR(100),
    @BoMon NVARCHAR(100),
    @Email NVARCHAR(100),
    @NamSinh DATE
AS
BEGIN
    -- Kiểm tra các tham số không được NULL
    IF @MaGiangVien IS NULL OR @TenGiangVien IS NULL OR @BoMon IS NULL OR @Email IS NULL OR @NamSinh IS NULL
    BEGIN
        PRINT 'Vui lòng nhập đầy đủ thông tin.'
        RETURN
    END

    INSERT INTO GiangVien (MaGiangVien, TenGiangVien, BoMon, Email, NamSinh)
    VALUES (@MaGiangVien, @TenGiangVien, @BoMon, @Email, @NamSinh)
    
    PRINT 'Dữ liệu đã được chèn thành công.'
END

EXEC sp_InsertGiangVien @MaGiangVien=1, @TenGiangVien='Nguyen Van A', @BoMon='Phát triển phần mềm', @Email='a.nguyen@example.com', @NamSinh='1980-01-01'
EXEC sp_InsertGiangVien @MaGiangVien=2, @TenGiangVien='Nguyen Van B', @BoMon='Thiết kế đồ hoạ', @Email='b.nguyen@example.com', @NamSinh='1988-04-20'
EXEC sp_InsertGiangVien @MaGiangVien=3, @TenGiangVien='Nguyen Van C', @BoMon='Ứng dụng phần mềm', @Email='c.nguyen@example.com', @NamSinh='1999-01-01'


CREATE PROCEDURE sp_InsertHoiDongDATN
    @MaHoiDong INT,
    @TenHoiDong NVARCHAR(100),
    @ChuyenNganh NVARCHAR(100),
    @HocKy NVARCHAR(50)
AS
BEGIN
    -- Kiểm tra các tham số không được NULL
    IF @MaHoiDong IS NULL OR @TenHoiDong IS NULL OR @ChuyenNganh IS NULL OR @HocKy IS NULL
    BEGIN
        PRINT 'Vui lòng nhập đầy đủ thông tin.'
        RETURN
    END

    INSERT INTO HoiDongDATN (MaHoiDong, TenHoiDong, ChuyenNganh, HocKy)
    VALUES (@MaHoiDong, @TenHoiDong, @ChuyenNganh, @HocKy)
    
    PRINT 'Dữ liệu đã được chèn thành công.'
END

EXEC sp_InsertHoiDongDATN @MaHoiDong=1, @TenHoiDong='Hội Đồng 1', @ChuyenNganh='Phát triển phần mềm', @HocKy='2023-2024'
EXEC sp_InsertHoiDongDATN @MaHoiDong=2, @TenHoiDong='Hội Đồng 1', @ChuyenNganh='Thiết kế đồ hoạ', @HocKy='2023-2024'
EXEC sp_InsertHoiDongDATN @MaHoiDong=3, @TenHoiDong='Hội Đồng 1', @ChuyenNganh='Ứng dụng phần mềm', @HocKy='2023-2024'

CREATE PROCEDURE sp_InsertDanhSachHoiDong
    @MaGiangVien INT,
    @MaHoiDong INT,
    @VaiTro NVARCHAR(50),
    @GhiChu NVARCHAR(200)
AS
BEGIN
    -- Kiểm tra các tham số không được NULL
    IF @MaGiangVien IS NULL OR @MaHoiDong IS NULL OR @VaiTro IS NULL
    BEGIN
        PRINT 'Vui lòng nhập đầy đủ thông tin.'
        RETURN
    END

    INSERT INTO DanhSachHoiDong (MaGiangVien, MaHoiDong, VaiTro, GhiChu)
    VALUES (@MaGiangVien, @MaHoiDong, @VaiTro, @GhiChu)
    
    PRINT 'Dữ liệu đã được chèn thành công.'
END

EXEC sp_InsertDanhSachHoiDong @MaGiangVien=1, @MaHoiDong=1, @VaiTro='Chủ tịch', @GhiChu='Không có nhận xét'
EXEC sp_InsertDanhSachHoiDong @MaGiangVien=2, @MaHoiDong=1, @VaiTro='Phó chủ tịch', @GhiChu='Không có nhận xét'
EXEC sp_InsertDanhSachHoiDong @MaGiangVien=3, @MaHoiDong=1, @VaiTro='Tổng giám đốc', @GhiChu='Không có nhận xét'

--3
CREATE VIEW V_GiangVien AS
SELECT 
    MaGiangVien,
    TenGiangVien,
    BoMon,
    YEAR(GETDATE()) - YEAR(NamSinh) AS Tuoi
FROM 
    GiangVien;

SELECT * FROM V_GiangVien;

--4
CREATE VIEW V_TopChamThi AS
SELECT 
    TOP 2 
    gv.MaGiangVien,
    gv.TenGiangVien,
    COUNT(ds.MaHoiDong) AS SoLuongHoiDong
FROM 
    GiangVien gv
JOIN 
    DanhSachHoiDong ds ON gv.MaGiangVien = ds.MaGiangVien
GROUP BY 
    gv.MaGiangVien, gv.TenGiangVien
ORDER BY 
    SoLuongHoiDong DESC;

SELECT * FROM V_TopChamThi;

--5
CREATE FUNCTION dbo.GetAccountName(@Email NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @AccountName NVARCHAR(100)
    SET @AccountName = LEFT(@Email, CHARINDEX('@', @Email) - 1)
    RETURN @AccountName
END

SELECT 
    Email, 
    dbo.GetAccountName(Email) AS AccountName
FROM 
    GiangVien;

--6
CREATE PROCEDURE sp_DeleteGiangVien
    @MaGiangVien INT
AS
BEGIN
    -- Bắt đầu một giao dịch
    BEGIN TRANSACTION

    BEGIN TRY
        -- Xóa thông tin giảng viên từ bảng DanhSachHoiDong
        DELETE FROM DanhSachHoiDong WHERE MaGiangVien = @MaGiangVien;

        -- Xóa thông tin giảng viên từ bảng GiangVien
        DELETE FROM GiangVien WHERE MaGiangVien = @MaGiangVien;

        -- Nếu tất cả các thao tác đều thành công, commit giao dịch
        COMMIT TRANSACTION;
        
        PRINT 'Xóa thành công giảng viên và các thông tin liên quan.'
    END TRY
    BEGIN CATCH
        -- Nếu có lỗi xảy ra, rollback giao dịch
        ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        -- Lấy thông tin lỗi
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Ghi lỗi
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);

        PRINT 'Có lỗi xảy ra, không thể xóa giảng viên.';
    END CATCH
END

-- Gọi để xóa giảng viên với MaGiangVien cụ thể
EXEC sp_DeleteGiangVien @MaGiangVien = 1;




