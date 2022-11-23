select iif(luong>=ltb,'khong tang luong','tang luong')
as thuong,tennv,luong,ltb
from
(select tennv,luong,ltb from NHANVIEN,
(select PHG,AVG(luong) as 'ltb' from NHANVIEN group by PHG) as temp
where NHANVIEN.PHG = temp.PHG) as a

select iif(luong>=ltb,'truong phong','nhan vien')
as chucvu,tennv,luong
from
(select tennv,luong,ltb from NHANVIEN,
(select PHG,AVG(luong) as 'ltb' from NHANVIEN group by PHG) as temp
where NHANVIEN.PHG = temp.PHG) as a

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
	while (@dem1 < @i)
	begin 
	if (@dem1 = 4 )
		begin set @dem1 = @dem1 + 2
	continue;
			end
		select * from NHANVIEN where cast (manv as int ) = @dem1
		set @dem1 = @dem1 +2 ;
	end
