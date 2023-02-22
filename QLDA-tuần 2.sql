
USE	qlda2
--1)
create table PHONGBAN(
MaPhg varchar(2) ,
TenPhg nvarchar(20) not null,
primary key (MaPhg),
)
create table THANNHAN
(
	MaNV  varchar(9) ,
	TenTN nvarchar(20),
	NgaySinh smalldatetime not null,
	Phai varchar(3) not null,
	QuanHe varchar(15) not null,
	primary key (MaNV,TenTN),
)
create table PHANCONG
(
	MaNV varchar(9) ,
	MaDA varchar(2) ,
	ThoiGian numeric(18,0) not null,
	PRIMARY KEY (MaNV, MaDA)

)
create table DEAN
(
	MaDA varchar(2) primary key,
	TenDA nvarchar(50) not null,
	DDiemDA varchar(20) not null,
)
create table  NHANVIEN
(	
MaNV varchar(9) primary key,
HoNV nvarchar(15) not null,
TenLot nvarchar(30) not null,
TenNV nvarchar	(30)  not null,
NgSinh smalldatetime not null,
DiaChi nvarchar(150) not null,
Phai nvarchar(3) not null,
Luong numeric(18,0) not null,
Phong varchar(2) not null,
)


--4
ALTER TABLE PHONGBAN
ALTER COLUMN TenPhg nvarchar(30)

ALTER TABLE DEAN
ALTER COLUMN DDiemDA nvarchar(20)

ALTER TABLE THANNHAN
ALTER COLUMN TenTN nvarchar(20)

ALTER TABLE THANNHAN
ALTER COLUMN Phai nvarchar(3)

ALTER TABLE THANNHAN
ALTER COLUMN QuanHe nvarchar(15)

--them cot sdt
ALTER TABLE NHANVIEN
ADD SoDienThoai varchar(15);
--xoa cot sdt
ALTER TABLE NHANVIEN
DROP COLUMN SoDienThoai;

--5

INSERT INTO NHANVIEN
    (MaNV, HoNV, TenLot,TenNV, NgSinh, DiaChi,Phai,Luong,Phong)
VALUES
    ('123', 'Đinh', 'Bá', 'Tiến', '1982-2-27', 'Mộ Đức','Nam','','4'),
	('234', 'Nguyễn', 'Thanh', 'Tùng', '1956-8-12', 'Sơn Tịnh','','Nam','5'),
	('345', 'Bùi', 'Thúy', 'Vũ', '', 'Tư Nghĩa','Nữ','','4'),
	('567', 'Nguyễn', 'Mạnh', 'Hùng', '1985-3-25', 'Sơn Tịnh','Nam','','5'),
	('678', 'Trần ', 'Hồng', 'Quang', '', 'Bình Sơn','Nam','','5');

insert into PHONGBAN
	(MaPhg,TenPhg)
values
('1','Quản Lý'),
('4','Điều Hành'),
('5','Nghiên Cứu');

insert into DEAN
	(MaDA,TenDA,DDiemDA)
values
('1','Nâng cao cắp muối ','Sa Huỳnh'),
('10','Xây dựng máu chế biến thủy sản ','Dung Quất'),
('2','Phát triển ha tầng mạng ','Quảng Ngãi'),
('20','Truyền tải cơ quan ','Quảng Ngãi'),
('3','Tin học hóa trường học ','BaTo');

insert into PHANCONG
	(MaNV,MaDA,ThoiGian)
values
('123','1',33),
('123','2',8),
('345','10',10),
('345','20',10),
('456','1',20),
('456','2',20);

