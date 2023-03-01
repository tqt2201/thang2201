--18. Cho biết số lượng đề án của công ty
SELECT COUNT(DEAN.MADA)
FROM DEAN

--19. Liệt kê danh sách các phòng ban có tham gia chủ trì các đề án
select * from DEAN,PHONGBAN where DEAN.PHONG = PHONGBAN.MAPHG

--20. Cho biết số lượng các phòng ban có tham gia chủ trì các đề án
select * from DEAN,PHONGBAN where DEAN.PHONG = PHONGBAN.MAPHG

--21. Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì.
SELECT COUNT(DEAN.MADA)
FROM DEAN, PHONGBAN
WHERE DEAN.PHONG = PHONGBAN.MAPHG AND
PHONGBAN.TENPHG = N'Nghiên cứu'

--22. Cho biết lương trung bình của các nữ nhân viên.
SELECT AVG(NHANVIEN.LUONG)
FROM NHANVIEN
WHERE NHANVIEN.PHAI = N'Nữ'

--23. Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'.
SELECT COUNT(THANNHAN.MA_NVIEN)
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN AND NHANVIEN.HONV = N'Đinh' AND NHANVIEN.TENLOT = N'Bá' AND NHANVIEN.TENNV = N'Tiến'

--24. Liệt kê danh sách 3 nhân viên lớn tuổi nhất, danh sách bao gồm họ tên và năm sinh.

--25. Với mỗi đề án, liệt kê mã đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
SELECT DEAN.MADA, COUNT(DEAN.MADA) AS 'Số lượng công việc'
FROM DEAN, CONGVIEC
WHERE DEAN.MADA = CONGVIEC.MADA
GROUP BY DEAN.MADA, DEAN.TENDA
--26. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó.
SELECT DEAN.TENDA, COUNT(DEAN.MADA) AS 'Số lượng công việc'
FROM DEAN, CONGVIEC
WHERE DEAN.MADA = CONGVIEC.MADA
GROUP BY DEAN.MADA, DEAN.TENDA
--27. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó, thông tin bao gồm tên đề án và số lượng nhân viên.
SELECT (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên nhân viên', COUNT(THANNHAN.MA_NVIEN) AS 'Số lượng thân nhân'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MANV = THANNHAN.MA_NVIEN
GROUP BY (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV)

--28.
--29.
--30. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
SELECT PHONGBAN.MAPHG, PHONGBAN.TENPHG, AVG(NHANVIEN.LUONG) AS 'Lương trung bình'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
GROUP BY PHONGBAN.MAPHG, PHONGBAN.TENPHG

--31.Với các phòng ban có mức lương trung bình trên 5.200.000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
SELECT PHONGBAN.TENPHG, COUNT(NHANVIEN.MANV) AS N'Số lượng nhân viên'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
GROUP BY PHONGBAN.TENPHG
HAVING AVG(NHANVIEN.LUONG)>5200000

--32. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì.
SELECT PHONGBAN.TENPHG, COUNT(DEAN.PHONG) AS 'Số lượng đề án'
FROM PHONGBAN, DEAN
WHERE PHONGBAN.MAPHG = DEAN.PHONG
GROUP BY PHONGBAN.TENPHG

--33. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì.
SELECT PHONGBAN.TENPHG, (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV) AS 'Họ tên trưởng phòng', COUNT(DEAN.PHONG) AS 'Số lượng đề án'
FROM NHANVIEN, PHONGBAN, DEAN
WHERE NHANVIEN.MANV = PHONGBAN.TRPHG AND PHONGBAN.MAPHG = DEAN.PHONG
GROUP BY PHONGBAN.TENPHG, (NHANVIEN.HONV + ' ' + NHANVIEN.TENLOT + ' ' + NHANVIEN.TENNV)

--34. Với mỗi đề án, cho biết tên đề án và số lượng nhân viên tham gia đề án