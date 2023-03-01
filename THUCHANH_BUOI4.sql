---1. Liệt kê danh sách tất cả các nhân viên

select * from NHANVIEN

--2. Tìm các nhân viên làm việc ở phòng số 5

select *  from NHANVIEN where PHG = 5

--3. Liệt kê họ tên và phòng làm việc các nhân viên có mức lương trên 6.000.000 đồng

select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', PHG from NHANVIEN where LUONG > 6000000

--4. Tìm các nhân viên có mức lương trên 6.500.000 ở phòng 1 hoặc các nhân viên có mức lương trên 5.000.000 ở phòng 4

select * from NHANVIEN where LUONG > 650000 and PHG = 1 or LUONG > 5000000 and PHG = 4

--5. Cho biết họ tên đầy đủ của các nhân viên ở TP Quảng Ngãi

select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên' from NHANVIEN where DCHI like '%TP Quảng Ngãi'

--6. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'

select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên' from NHANVIEN  where HONV like 'N%'

--7. Cho biết ngày sinh và địa chỉ của nhân viên Cao Thanh Huyền

select NGSINH, DCHI from NHANVIEN where HONV like 'Cao' and TENLOT like 'Thanh' and TENNV like 'Huyền'

--8. Cho biết các nhân viên có năm sinh trong khoảng 1955 đến 1975

select * from NHANVIEN where YEAR(NGSINH) between 1955 AND 1975

--9. Cho biết các nhân viên và năm sinh của nhân viên

select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', YEAR(NGSINH) as 'Năm sinh' from NHANVIEN

-- 10. Cho biết họ tên và tuổi của tất cả các nhân viên

select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', (2023 - YEAR(NGSINH)) as 'Tuổi' from NHANVIEN

--11. Tìm tên những người trưởng phòng của từng phòng ban

select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên Trưởng Phòng' from PHONGBAN,NHANVIEN
where PHONGBAN.TRPHG = NHANVIEN.MANV

--12.Tìm tên và địa chỉ của tất cả các nhân viên của phòng 'Điều hành'

select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', DCHI from NHANVIEN inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
where PHONGBAN.MAPHG = 4

--13. Với mỗi đề án ở Tp Quảng Ngãi, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó.

select TENDEAN, TENPHG, HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', NG_NHANCHUC 
from NHANVIEN inner join PHONGBAN 
ON NHANVIEN.PHG = PHONGBAN.MAPHG 
inner join DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
where PHONGBAN.TRPHG = NHANVIEN.MANV and DCHI like '%Tp Quảng Ngãi'

--14. Tìm tên những nữ nhân viên và tên người thân của họ

select HONV+ ' ' +TENLOT+ ' ' +TENNV as 'Họ và tên', TENTN as 'Tên người thân' 
from NHANVIEN inner join THANNHAN ON NHANVIEN.MANV = THANNHAN.MA_NVIEN
where NHANVIEN.PHAI = N'Nữ'

--15. Với mỗi nhân viên, cho biết họ tên của nhân viên, họ tên trưởng phòng của phòng ban mà nhân viên đó đang làm việc.

select NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV as 'Họ và tên nhân viên', QL.HONV+ ' ' + QL.TENLOT + ' ' + QL.TENNV as 'Họ và tên quản lí'
	from NHANVIEN NV,NHANVIEN QL
	where NV.MA_NQL = QL.MANV

--16. Tên những nhân viên phòng Nghiên cứu có tham gia vào đề án "Xây dựng nhà máy chế biến thủy sản"

select HONV+ ' ' + TENLOT + ' ' + TENNV as 'Họ và tên' 
from NHANVIEN inner join DEAN ON NHANVIEN.PHG = DEAN.PHONG
where DEAN.TENDEAN = 'Xây dựng nhà máy chế biến thủy sản'

--17. Cho biết tên các đề án mà nhân viên Trần Thanh Tâm đã tham gia.

select TENDEAN as 'Tên đề án'
from NHANVIEN inner join DEAN ON NHANVIEN.PHG = DEAN.PHONG
where NHANVIEN.HONV = N'Trần' and NHANVIEN.TENLOT = N'Thanh' and NHANVIEN.TENNV = N'Tâm'