------Câu1_a---------------
create trigger Themnv ON NHANVIEN for insert as 
if (select LUONG from inserted )<15000
begin 
print 'Lương phải >15000'
rollback transaction 
end
go
insert into NHANVIEN values (N'Nguyễn',N'Văn',N'Toàn','020',cast('1967-10-20' as date),N'230 Lê Văn Sỹ,TP HCM','Nam',30000,'010',4)
--------Câu1_b)-------------------
create trigger check_themnv ON NHANVIEN for insert as 
declare @tuoi int
set @tuoi=year(getdate()) - (select year(NGSINH) from inserted)
if (@tuoi < 18 or @tuoi > 65 )
begin
print'Yêu cầu nhập tuổi từ 18 đến 65'
rollback transaction 
end
go
insert into NHANVIEN values (N'Lê',N'An',N'Sơn','011',cast('1970-10-20' as date),N'200 Lê Văn Sỹ,TP HCM','Nam',300000,'011',4)
----------------------Câu 1_c----------------
create trigger update_NV on NHANVIEN for update as
IF (SELECT DCHI FROM inserted ) like '%TP HCM%'
begin
print'Không thể cập nhật'
rollback transaction
end
update NHANVIEN SET TENNV='Như' where MANV ='001'
----Câu2_a-------------------
create trigger trg_TongNV
   on NHANVIEN
   AFTER INSERT
AS
   Declare @male int, @female int;
   select @female = count(Manv) from NHANVIEN where PHAI = N'Nữ';
   select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
   print N'Tổng số nhân viên là nữ: ' + cast(@female as varchar);
   print N'Tổng số nhân viên là nam: ' + cast(@male as varchar);

INSERT INTO NHANVIEN VALUES ('Lê','Xuân','Hiệp','033','7-12-1999','TP HCM','Nam',60000,'003',1)
GO
 --------Câu2_b--------------------
 create trigger trg_TongNVSauUpdate
   on NHANVIEN
   AFTER update
AS
   if (select top 1 PHAI FROM deleted) != (select top 1 PHAI FROM inserted)
   begin
      Declare @male int, @female int;
      select @female = count(Manv) from NHANVIEN where PHAI = N'Nữ';
      select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
      print N'Tổng số nhân viên là nữ: ' + cast(@female as varchar);
      print N'Tổng số nhân viên là nam: ' + cast(@male as varchar);
   end;
UPDATE NHANVIEN
   SET HONV = 'Lê',PHAI = N'Nữ'
 WHERE  MaNV = '010'
GO
-------------Câu2_c----------------------
CREATE TRIGGER trg_TongNVSauXoa on DEAN
AFTER DELETE
AS
begin
   SELECT MA_NVIEN, COUNT(MADA) as 'Số đề án đã tham gia' from PHANCONG
      GROUP BY MA_NVIEN
	  end
	  select * from DEAN
insert into dean values ('SQL', 50, 'HH', 4)
delete from dean where MADA=50

--------Câu3_ a------------------------
create trigger delete_thannhan on NHANVIEN
instead of delete
as
begin
delete from THANNHAN where MA_NVIEN in(select manv from deleted)
delete from NHANVIEN where manv in(select manv from deleted)
end
insert into THANNHAN values ('031', 'Khang', 'Nam', '03-10-2017', 'con')
delete NHANVIEN where manv='031'

-------------Câu3_b---------------------------
create trigger nhanvien3 on NHANVIEN
after insert 
as
begin
insert into PHANCONG values ((select manv from inserted), 1,2,20)
end
INSERT INTO NHANVIEN VALUES ('Lê','Xuân','Hiệp','031','7-12-1999','Hà nội','Nam',60000,'003',1)