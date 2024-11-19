-- Tạo cơ sở dữ liệu
CREATE DATABASE SU24_COM2012_TD00541;
GO

USE SU24_COM2012_TD00541;
GO

-- Tạo bảng SanPham
CREATE TABLE SanPham (
    MaSP INT PRIMARY KEY,
    TenSP NVARCHAR(50) NOT NULL,
    SoLuong INT NOT NULL,
    XuatXu NVARCHAR(50)
);
GO
alter table SanPham
add Gia DECIMAL(18, 2) not null;

-- Tạo bảng HoaDon
CREATE TABLE HoaDon (
    MaHD INT PRIMARY KEY,
    NgayLap DATE NOT NULL,
    SDT NVARCHAR(15),
    Ma_NguoiLap INT
);
GO

-- Tạo bảng HoaDonChiTiet
CREATE TABLE HoaDonChiTiet (
    MaSP INT,
    MaHD INT,
    SoLuongMua INT NOT NULL,
    GiaMua DECIMAL(18, 2) NOT NULL,
    PRIMARY KEY (MaSP, MaHD),
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD)
);
GO

-- Thêm dữ liệu vào bảng SanPham
INSERT INTO SanPham (MaSP, TenSP, Gia, SoLuong, XuatXu)
VALUES
(1, 'SanPham1', 100000, 50, 'Vietnam'),
(2, 'SanPham2', 200000, 30, 'China'),
(3, 'SanPham3', 150000, 20, 'USA');
GO

-- Thêm dữ liệu vào bảng HoaDon
INSERT INTO HoaDon (MaHD, NgayLap, SDT, Ma_NguoiLap)
VALUES
(1, '2024-08-01', '0123456789', 101),
(2, '2024-08-02', '0987654321', 102),
(3, '2024-08-03', NULL, 103);
GO

-- Thêm dữ liệu vào bảng HoaDonChiTiet
INSERT INTO HoaDonChiTiet (MaSP, MaHD, SoLuongMua, GiaMua)
VALUES
(1, 1, 2, 100000),
(2, 2, 1, 200000),
(3, 3, 3, 150000);
GO

-- Hiển thị danh sách sản phẩm
SELECT TenSP, Gia, SoLuong
FROM SanPham;
GO

-- Hiển thị danh sách hóa đơn của khách vãng lai
SELECT * FROM HoaDon
WHERE SDT IS NULL;
GO

-- Cập nhật số lượng sản phẩm theo mã
UPDATE SanPham
SET SoLuong = SoLuong - 1
WHERE MaSP = 1;
GO

-- Xóa sản phẩm có số lượng tồn bằng 0
DELETE FROM SanPham
WHERE SoLuong = 0;
GO

-- Hiển thị danh sách chi tiết hóa đơn
SELECT HoaDon.MaHD, SanPham.TenSP, HoaDonChiTiet.SoLuongMua, HoaDonChiTiet.GiaMua, (HoaDonChiTiet.SoLuongMua * HoaDonChiTiet.GiaMua) AS ThanhTien
FROM HoaDonChiTiet
JOIN SanPham ON HoaDonChiTiet.MaSP = SanPham.MaSP
JOIN HoaDon ON HoaDonChiTiet.MaHD = HoaDon.MaHD;
GO

-- Hiển thị thông tin biến động giá của một sản phẩm
SELECT TenSP, Gia, NgayLap
FROM SanPham
JOIN HoaDonChiTiet ON SanPham.MaSP = HoaDonChiTiet.MaSP
JOIN HoaDon ON HoaDonChiTiet.MaHD = HoaDon.MaHD
ORDER BY NgayLap;
GO
