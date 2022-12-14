create database QLHang
go
CREATE TABLE VATTU (
	MaVT varchar(4) not null,
	TenVT NVARCHAR(20) not null,
	DVTinh NVARCHAR(20) not null,
	SLCon INT not null,
	CONSTRAINT pk_VT PRIMARY KEY(MaVT)
)
GO

CREATE TABLE HDBAN (
	MaHD VARCHAR(10) not null,
	NgayXuat SMALLDATETIME not null,
	HoTenKhach NVARCHAR(20) not null,
	CONSTRAINT pk_HDBAN PRIMARY KEY(MaHD)
)
GO

CREATE TABLE HANGXUAT(
	MaHD VARCHAR(10) not null,
	MaVT CHAR(4) not null,
	DongGia MONEY not null,
	SLBan INT not null,
	CONSTRAINT pk_HANGXUAT PRIMARY KEY(MAHD, MAVT)
)
GO



INSERT INTO VATTU(MaVT,TenVT,DVTinh,SLCon) VALUE (N'N001', N'ao khoac', 'VND', 100)
INSERT INTO VATTU VALUE(N'N002', N'cay canh', 'VND', 200)
INSERT INTO HDBAN(MaHD,NgayXuat,HoTenKhach) VALUE(N'H001',CAST(N'2022-10-3'AS DATE),N'BACH VAN THAI ')
INSERT INTO HDBAN VALUE(N'H002',CAST(N'2022-9-5'AS DATE),N'HUYNH VAN NGHI ')
INSERT INTO HangXuat(MaHD,MaVT,DonGia,SLBan) VALUE(N'HD001',N'VT01',30000, 200)
INSERT INTO HangXuat VALUE(N'HD002',N'VT01',10000, 300)
INSERT INTO HangXuat VALUE(N'HD003',N'VT02',20000, 600)
INSERT INTO HangXuat VALUE(N'HD004',N'VT02',50000, 200)


--CAU 2
select top 1 MaHD, sum(DongGia) as TongTien from HangXuat group by MaHD,
DongGia order by DongGia desc

--CAU 3
CREATE FUNCTION C3 (@MAHD varchar(10))
RETURNS TABLE
AS
RETURN
    SELECT 
        HX.MaHD,
        HD.NgayXuat,
        HD.MaVT,
        HX.DongGia,
        HX.SLBan,  
        CASE
            WHEN WEEKDAY(HD.NgayXuat) = 0 THEN N'Thứ hai'            
            WHEN WEEKDAY(HD.NgayXuat) = 1 THEN N'Thứ ba'
            WHEN WEEKDAY(HD.NgayXuat) = 2 THEN N'Thứ tư'
            WHEN WEEKDAY(HD.NgayXuat) = 3 THEN N'Thứ năm'
            WHEN WEEKDAY(HD.NgayXuat) = 4 THEN N'Thứ sáu'
            WHEN WEEKDAY(HD.NgayXuat) = 5 THEN N'Thứ bảy'
            ELSE N'Chủ nhật'
        END AS NGAYTHU
    FROM HangXuat HX
    INNER JOIN HDBan HD ON HX.MaHD = HD.MaHD
    WHERE HX.MaHD = @MaHD;


--CAU 4
CREATE PROCEDURE C4 @thang int, @nam int 
AS
SELECT 
SUM(SLBan * DongGia)
FROM HangXuat HX
INNER JOIN HDB HD ON HX.MAHD = HD.MAHD
where MONTH(HD.NGAYXUAT) = @THANG AND YEAR(HD.NGAYXUAT) = @NAM;
select top 1 MAHD, sum(DONGIA) as TongTien from HANGXUAT group by MAHD,
DONGIA order by DONGIA desc


