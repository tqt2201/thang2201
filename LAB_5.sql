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