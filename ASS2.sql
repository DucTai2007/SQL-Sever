CREATE DATABASE ThuVien_Poly;
USE ThuVien_Poly;

CREATE TABLE LoaiSach (
    MaLoai NVARCHAR(100) PRIMARY KEY NOT NULL,
    TenSach NVARCHAR(100) NOT NULL
);

CREATE TABLE Sach (
    MaSach VARCHAR(100) PRIMARY KEY NOT NULL,
    TenSach NVARCHAR(100) NOT NULL,
    NhaXuatBan NVARCHAR(100) NOT NULL,
    TacGia NVARCHAR(200) NOT NULL,
    NgayNhapKho DATE NOT NULL,
    SoTrang INT CHECK (SoTrang > 5),
    ViTri NVARCHAR(500) NOT NULL,
    SoLuongBS INT CHECK (SoLuongBS > 1),
    GiaTien MONEY CHECK (GiaTien > 0),
    MaLoai NVARCHAR(100),
    FOREIGN KEY (MaLoai) REFERENCES LoaiSach(MaLoai)
);

CREATE TABLE SinhVien (
    MaSinhVien NVARCHAR(100) PRIMARY KEY NOT NULL,
    Ngay_HH DATE NOT NULL,
    TenSV NVARCHAR(500) NOT NULL,
    SoDT VARCHAR(110) UNIQUE,
    ChuyenNganh NVARCHAR(150),
);

alter table SinhVien 
add email nvarchar(50) unique;

CREATE TABLE PhieuMuon (
    MaPhieuMuon VARCHAR(100) PRIMARY KEY not null,
    MaSinhVien NVARCHAR(100) NOT NULL,
    NgayMuon DATE,
    NgayTra DATE,
);
alter table PhieuMuon
add constraint fk_PhieuMuon_SinhVien
FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien);

CREATE TABLE ChiTietPhieuMuon (
    MaPhieuMuon VARCHAR(100) NOT NULL,
    MaSach VARCHAR(100) NOT NULL,
    GhiChu NVARCHAR(255) NOT NULL,
    PRIMARY KEY (MaPhieuMuon, MaSach),
);

ALTER TABLE ChiTietPhieuMuon
ADD CONSTRAINT FK_ChiTietPhieuMuon_PhieuMuon
FOREIGN KEY (MaPhieuMuon) REFERENCES PhieuMuon(MaPhieuMuon),
CONSTRAINT FK_ChiTietPhieuMuon_Sach
FOREIGN KEY (MaSach) REFERENCES Sach(MaSach);


INSERT INTO LoaiSach
VALUES 
('L001', 'Khoa học'),
('L002', 'Văn học'),
('L003', 'Kỹ thuật'),
('L004', 'Y học'),
('L005', 'Nghệ thuật');
INSERT INTO Sach
VALUES
('S001', 'Lap trinh', 'NXB1', 'Nguyen Van A', '2023-01-01', 300, 'A1', 10, 50000, 'L003'),
('S002', 'Toan cao', 'NXB2', 'Tran Van B', '2023-02-01', 250, 'B1', 5, 60000, 'L001'),
('S003', 'Van hoc', 'NXB3', 'Le Thi C', '2023-03-01', 200, 'C1', 8, 70000, 'L002'),
('S004', 'Sinh hoc', 'NXB4', 'Pham Van D', '2023-04-01', 150, 'D1', 6, 80000, 'L001'),
('S005', 'Nghe thuat', 'NXB5', 'Hoang Van E', '2023-05-01', 100, 'E1', 3, 90000, 'L005');

INSERT INTO SinhVien
VALUES
('SV001', '2024-01-01', 'Nguyen Van A', '0901234567', 'CNTT', 'vana@gmail.com'),
('SV002', '2024-02-01', 'Tran Thi B', '0902345678', 'Toan', 'thib@gmail.com'),
('SV003', '2024-03-01', 'Le Van C', '0903456789', 'Ly', 'lec@gmail.com'),
('SV004', '2024-04-01', 'Pham Thi D', '0904567890', 'Hoa', 'thid@gmail.com'),
('SV005', '2024-05-01', 'Hoang Van E', '0905678901', 'Sinh', 'vane@gmail.com');

INSERT INTO PhieuMuon
VALUES
('PM001', 'SV001', '2023-01-10', '2023-01-20'),
('PM002', 'SV002', '2023-02-15', '2023-02-25'),
('PM003', 'SV003', '2023-03-20', '2023-03-30'),
('PM004', 'SV004', '2023-04-25', '2023-05-05'),
('PM005', 'SV005', '2023-05-30', '2023-06-10');

INSERT INTO ChiTietPhieuMuon 
VALUES
('PM001', 'S001', 'Không ghi chú'),
('PM002', 'S002', 'Không ghi chú'),
('PM003', 'S003', 'Không ghi chú'),
('PM004', 'S004', 'Không ghi chú'),
('PM005', 'S005', 'Không ghi chú'),
('PM001', 'S002', 'Mượn thêm sách'),
('PM002', 'S003', 'Mượn thêm sách'),
('PM003', 'S004', 'Mượn thêm sách'),
('PM004', 'S005', 'Mượn thêm sách'),
('PM005', 'S001', 'Mượn thêm sách');
go
select * from Sach
select * from LoaiSach
select * from PhieuMuon
select * from ChiTietPhieuMuon
select *from SinhVien

--Y6.
--1
select L.TenSach, MaSach, GiaTien,TacGia
from Sach S join LoaiSach L on S.MaLoai = L.MaLoai
where L.TenSach = 'Khoa học';
--2
select P.MaPhieuMuon, CT.MaSach, P.NgayMuon, P.NgayMuon
from PhieuMuon P join ChiTietPhieuMuon CT on P.MaPhieuMuon = CT.MaPhieuMuon
where YEAR(P.NgayMuon) = 2023 and MONTH(P.NgayMuon) = 1;
--3
select MaPhieuMuon, MaSinhVien, NgayMuon, NgayTra
from PhieuMuon
order by NgayMuon asc;
--4
select L.MaLoai, L.TenSach, SUM(S.SoLuongBS) AS TongSoLuong
from LoaiSach L JOIN Sach S on l.MaLoai = s.MaLoai
GROUP BY L.MaLoai, L.TenSach;
--5
select COUNT(distinct MaSinhVien) as LuotSinhVien
from PhieuMuon;
--6
select * from Sach
where TenSach LIKE '%van%';
--7
select s.MaSinhVien, s.TenSV, p.MaPhieuMuon, sach.TenSach, p.NgayMuon, p.NgayTra
from PhieuMuon p join SinhVien s ON p.MaSinhVien = s.MaSinhVien
join ChiTietPhieuMuon c on p.MaPhieuMuon = c.MaPhieuMuon
join Sach sach on c.MaSach = sach.MaSach
ORDER BY p.NgayMuon;
--8
select s.MaSach, s.TenSach, COUNT(c.MaPhieuMuon) as LuotMuon
from Sach s join ChiTietPhieuMuon c ON s.MaSach = c.MaSach
group by s.MaSach, s.TenSach
having COUNT(c.MaPhieuMuon) >= 2;
--9
update Sach
set GiaTien = GiaTien * 0.7
where NgayNhapKho < '2024-01-01';
--10
update PhieuMuon
set NgayTra = GETDATE()
where MaSinhVien = 'SV002';
--12
update Sach
set SoLuongBS = SoLuongBS + 5
where MaSach IN (
    select MaSach
    from ChiTietPhieuMuon
    group by MaSach
    having COUNT(MaPhieuMuon) > 1
);
--13
delete from PhieuMuon
where NgayMuon < '2023-02-01' and NgayTra < '2023-03-01';

select L.Ma_Loai, l.Ten_loai sum(Sach.SL_BanSao) as TongSoLuong
from  Loaisach l  join Sach s
on L.Ma_Loai = S.Ma_Loai
group by Loaisach.Ma_Loai, Loaisach.Ten_loai