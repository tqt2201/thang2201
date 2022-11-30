---------Câu-1-----------
create proc cau1_XuatTen
@name nvarchar(20)
as
	begin
		print N'Chào mừng bạn đến với lớp học của chúng tôi: : ' + @name
	end
go
exec cau1_XuatTen N'Tạ Quang Thắng'

create proc Tong @so1 int, @so2 int, @tg int OUT
as
	SET @tg = @so1 + @so2
go
declare @tg int
exec Tong 22, 42, @tg out
PRINT N'Tổng là: ' + STR(@tg)

CREATE PROC TONGSOCHAN @N INT 
AS
	DECLARE @TONG INT = 0,@DEM INT =2;
	WHILE @DEM<@N
		BEGIN
			SET @TONG=@TONG+@DEM
			SET @DEM=@DEM+2
		END
	PRINT'TONG' + CAST (@TONG AS VARCHAR(4))
EXEC TONGSOCHAN 8
GO

create proc UocChungLN @a int, @b int
as
	begin
		while (@a != @b)
			begin
				if(@a > @b)
					set @a = @a -@b
				else
					set @b = @b - @a
			end
			return @a
	end
declare @l int
exec @l = UocChungLN 5,7 
print @l
go

----------Câu-2-------------
create proc Cau2_XuatTT @MaNV varchar(20)
as
	begin
		select * from NHANVIEN where MANV = @MaNV
	end
exec Cau2_XuatTT '003'
go

create proc cau2_b @MaDa int
as
begin
    select count(MANV), MADA, TENPHG from PHONGBAN
    inner join NHANVIEN on NHANVIEN.PHG = PHONGBAN.MAPHG
    inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
    where MADA = @MaDa
    group by TENPHG,MADA
    having MADA = @MaDa
end
go
exec cau2_b 20
go

---------câu 3---------
create proc sp_ThemPhongBan @TenPHG nvarchar(15), @MaPHG int,
@TRPHG nvarchar(9), @NG_NHANCHUC date
as
if exists (select * from PHONGBAN where MAPHG = @MaPHG)
update PHONGBAN set TENPHG = @TenPHG, TRPHG = @Trphg, NG_NHANCHUC = @NG_NHANCHUC
where MAPHG = @MaPHG
else
insert into PHONGBAN
values (@TenPHG, @MaPHG, @TRPHG, @NG_NHANCHUC)
drop proc sp_ThemPhongBan
go
exec sp_ThemPhongBan 'CNTT', 6, '008', '1985-01-01'

-----------------
create proc sp_capnhatphongban
	@TENPHGCU nvarchar(15),
	@TENPHG nvarchar(15),
	@MAPHG int,
	@TRPHG nvarchar(9),
	@NG_NHANCHUC date
as
begin
	update PHONGBAN
	set TENPHG = @TENPHG,
		MAPHG = @MAPHG,
		TRPHG = @TRPHG,
		NG_NHANCHUC = @NG_NHANCHUC
	where TENPHG = @TENPHGCU;
end;

exec sp_capnhatphongban 'CNTT', 'IT', 10, '005', '1-1-2020';

--------------------

create proc sp_themNV
	@HONV nvarchar(15),
	@TENLOT nvarchar(15),
	@TENNV nvarchar(15),
	@MANV nvarchar(9),
	@NGSINH datetime,
	@DCHI nvarchar(30),
	@PHAI nvarchar(3),
	@LUONG float,
	@PHG int
as
begin
	if not exists(select*from PHONGBAN where TENPHG = 'IT')
	begin
		print N'Nhân viên phải trực thuộc phòng IT';
		return;
	end;
	declare @MA_NQL nvarchar(9);
	if @LUONG > 25000
		set @MA_NQL = '005';
	else
		set @MA_NQL = '009';
	declare @age int;
	select @age = DATEDIFF(year,@NGSINH,getdate()) + 1;
	if @PHAI = 'Nam' and (@age < 18 or @age >60)
	begin
		print N'Nam phải có độ tuổi từ 18-65';
		return;
	end;
	else if @PHAI = 'Nữ' and (@age < 18 or @age >60)
	begin
		print N'Nữ phải có độ tuổi từ 18-60';
		return;
	end;
	INSERT INTO NHANVIEN(HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG,MA_NQL,PHG)
		VALUES(@HONV,@TENLOT,@TENNV,@MANV,@NGSINH,@DCHI,@PHAI,@LUONG,@MA_NQL,@PHG)
end;

exec sp_themNV N'Tạ',N'Quang',N'Thắng','022','22-1-2002',N'Lâm Đồng','Nam',30000,6;
