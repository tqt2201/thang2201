
select iif(luong>=ltb,'Khong tang luong','tang luong')
as thuong,tennv,luong,ltb
from
(select tennv,luong,ltb from NHANVIEN,
(select phg,avg(luong) as 'ltb' from NHANVIEN group by phg) as temp
where NHANVIEN.PHG=temp.PHG) as abc
select * from NHANVIEN
select phg,avg(luong) as 'ltb' from NHANVIEN group by phg



select iif(luong>=ltb,'truong phong','nhan vien')
as chucvu,tennv,luong
from
(select tennv,luong,ltb from NHANVIEN,
(select phg,avg(luong) as 'ltb' from NHANVIEN group by phg) as temp
where NHANVIEN.PHG=temp.PHG) as abc
select * from NHANVIEN
select phg,avg(luong) as 'ltb' from NHANVIEN group by phg


select tennv = case PHAI
when 'nam' then 'Mr.'+[TENNV]
else 'Ms.'+[TENNV]
end
from NHANVIEN


select TENNV,LUONG,thue=case 
when LUONG	between 0 and 25000 then LUONG*0.1
when LUONG	between 25000 and 30000 then LUONG*0.12
when LUONG	between 30000 and 40000 then LUONG*0.15
when LUONG	between 40000 and 50000 then LUONG*0.2
else LUONG*0.25 end
from NHANVIEN



declare @dem int = 2;
while @dem <(select count(manv) from NHANVIEN )
	begin 
		select * from NHANVIEN where cast (manv as int ) = @dem
		set @dem = @dem +2 ;
		end

declare @dem1 int = 2 , @i int;
while @dem1 <(select count(manv) from NHANVIEN )
	begin 
	if (@dem1 = 4 )
		begin set @dem1 = @dem1 + 2
			end
		select * from NHANVIEN where cast (manv as int ) = @dem1
		set @dem1 = @dem1 +2 ;
	end


BEGIN TRY 
INSERT PHONGBAN (TENPHG, MAPHG, TRPHG,NG_NHANCHUC)
VALUES('SDD',5,'06','1989-10-12')
PRINT'thêm dữ liệu thành công'
END TRY
BEGIN CATCH
PRINT 'thêm dữ liệu thất bại' + CONVERT(VARCHAR, ERROR_NUMBER(),1)
+ ': ' + ERROR_MESSAGE()
END CATCH

DECLARE @tong int = 0,@c int,@g int = 1;
SET @c = 10 
WHILE (@g<=@c)
BEGIN
if (@g %2 =0)
SET @tong = @tong + @g
SET @g = @g + 1 
END
PRINT ('Ket qua la: ' )
PRINT @tong


DECLARE @tong1 int = 0,@d INT = 10,@F INT
SET @F = 1
WHILE (@f<=@d)
BEGIN
if (@f %2 =0)
SET @tong1 = @tong1 + @f
SET @f = @f + 1 
if(@f = 4)
SET @tong1 = @tong1 - 4
END
PRINT ('Ket qua la: ' )
PRINT @tong1
