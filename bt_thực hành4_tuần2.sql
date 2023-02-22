-- câu 1
CREATE DATABASE QLKHO
use QLKHO

CREATE TABLE Ton (
    MaVT VARCHAR(10) PRIMARY KEY,
    TenVT VARCHAR(50) NOT NULL,
    SoLuongT INT NOT NULL,
);
CREATE TABLE Nhap (
    SoHDN INT PRIMARY KEY,
    MaVT VARCHAR(10) NOT NULL,
    SoLuongN INT NOT NULL,
    DonGiaN INT NOT NULL,
    NgayN DATE NOT NULL,
    FOREIGN KEY (MaVT) REFERENCES Ton(MaVT)
);

CREATE TABLE Xuat (
    SoHDX INT PRIMARY KEY,
    MaVT VARCHAR(10) NOT NULL,
    SoLuongX INT NOT NULL,
    DonGiaX INT NOT NULL,
    NgayX DATE NOT NULL,
    FOREIGN KEY (MaVT) REFERENCES Ton(MaVT)
);


INSERT INTO Ton VALUES ('VT001', 'Vật tư 1', 10);
INSERT INTO Ton VALUES ('VT002', 'Vật tư 2', 5);
INSERT INTO Ton VALUES ('VT003', 'Vật tư 3', 15);
INSERT INTO Ton VALUES ('VT004', 'Vật tư 4', 20);
INSERT INTO Ton VALUES ('VT005', 'Vật tư 5', 25);

INSERT INTO Nhap VALUES (1, 'VT001', 10, 1000, '2020-01-01');
INSERT INTO Nhap VALUES (2, 'VT002', 5, 2000, '2020-01-02');
INSERT INTO Nhap VALUES (3, 'VT003', 15, 500, '2020-01-03');

INSERT INTO Xuat VALUES (1, 'VT001', 5, 500, '2020-02-01');
INSERT INTO Xuat VALUES (2, 'VT002', 2, 1500, '2020-02-02');
go
-- câu 2
CREATE VIEW CAU2
AS
select ton.MaVT,TenVT,sum(SoLuongX*DonGiaX) as tienban
from Xuat inner join ton on Xuat.MaVT=ton.MaVT
group by ton.mavt,tenvt
go
SELECT * FROM CAU2
-- câu 3 
go
CREATE VIEW CAU3
AS
select ton.tenvt, sum(soluongx) as SoLuongT
from xuat inner join ton on xuat.mavt=ton.mavt
group by ton.tenvt
go
SELECT * FROM CAU3
go 
-- câu 4
CREATE VIEW CAU4
AS
SELECT ton.TenVT, SUM(SoLuongN) AS SoLuongNhap
FROM Nhap inner join ton on Nhap.MaVT=ton.MaVT
group by ton.TenVT
go
SELECT * FROM CAU4
go
-- câu 5
CREATE VIEW CAU5
AS
select ton.mavt,ton.tenvt,sum(soluongN)-sum(soluongX) +
sum(soluongT) as tongton
from nhap inner join ton on nhap.mavt=ton.mavt
 inner join xuat on ton.mavt=xuat.mavt
group by ton.mavt,ton.tenvt
go 
SELECT * FROM CAU5
go
-- câu 6
CREATE VIEW CAU6
AS
select tenvt
from ton
where soluongT = (select max(soluongT) from Ton)
go
SELECT * FROM CAU6
go
-- câu 7
CREATE VIEW CAU7
AS
select ton.mavt,ton.tenvt
from ton inner join xuat on ton.mavt=xuat.mavt
group by ton.mavt,ton.tenvt
having sum(soluongX)>=100
go
SELECT * FROM CAU7
go
--câu 8 

CREATE VIEW CAU8 AS
SELECT MONTH(NgayX) AS "Tháng xuất", YEAR(NgayX) AS "Năm xuất", SUM(SoLuongX) AS Total_Quantity
FROM Xuat
GROUP BY MONTH(NgayX), YEAR(NgayX);
go
SELECT * FROM CAU8

--câu 9: tạo view đưa ra mã vật tư. tên vật tư. số lượng nhập. số
--lượng xuất. đơn giá N. đơn giá X. ngày nhập. Ngày xuất
go
CREATE VIEW CAU9 AS
SELECT t.MaVT, t.TenVT,n.SoLuongN,x.SoLuongX, n.DonGiaN,x.DonGiaX, n.NgayN, x.NgayX
FROM Ton t
INNER JOIN Nhap n ON t.MaVT = n.MaVT
INNER JOIN Xuat x ON t.MaVT = x.MaVT;
go
SELECT * FROM CAU9
go 
--câu 10: Tạo view đưa ra mã vật tư. tên vật tư và tổng số lượng còn lại trong kho. biết còn lại = SoluongN-
-- SoLuongX+SoLuongT theo từng loại Vật tư trong năm 2015

CREATE VIEW CAU10 AS
SELECT t.MaVT, t.TenVT, SUM(n.SoLuongN-x.SoLuongX+t.SoLuongT) as "SL còn lại"
FROM Ton t
INNER JOIN Nhap n ON t.MaVT = n.MaVT
INNER JOIN Xuat x ON t.MaVT = x.MaVT
where YEAR(n.NgayN) = 2015 OR YEAR(x.NgayX) = 2015
GROUP BY t.MaVT,t.TenVT;
go
SELECT * FROM CAU10