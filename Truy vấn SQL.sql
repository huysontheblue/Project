-- 1. Danh sách các sinh viên khoa “Công nghệ Thông tin” khoá 2019-2024
Select Sinh_Vien.* from Sinh_Vien
LEFT JOIN LOP ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
LEFT JOIN Khoa ON Lop.Ma_Khoa = Khoa.Ma_Khoa
WHERE Khoa.Ma_Khoa = 'CNTT'
AND Khoa_Hoc.Nam_bat_Dau = 2019
AND Khoa_Hoc.Nam_Ket_Thuc = 2024


--​Câu 2: "Cho biết các thông tin (MSSV, họ tên ,năm sinh) của các sinh viên học sớm hơn tuổi qui định (theo tuổi qui định thi sinh viên đủ 18 tuổi khi bắt đầu khóa học)"
-- Day(GETDATE()) -> lấy ngày trong tháng
-- Month(GETDATE()) -> lấy Tháng trong Năm
-- Year(GETDATE()) -> lấy năm

select Sinh_Vien.MaSV, Sinh_Vien.Ho_Ten, Sinh_Vien.Nam_Sinh from Sinh_Vien
LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
where Khoa_Hoc.Nam_Bat_Dau - Sinh_Vien.Nam_Sinh < 18

-- Câu 3:" Cho biết sinh viên khoa CNTT, khoá 2018-2023 chưa học môn cấu trúc dữ liệu"
select distinct Sinh_Vien.*  from Sinh_Vien
LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa ON Lop.Ma_Khoa = Khoa.Ma_Khoa
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
LEFT JOIN Mon_Hoc ON Mon_Hoc.Ma_Khoa = Khoa.Ma_Khoa
where Khoa.Ma_Khoa = 'CNTT'
and Khoa_Hoc.Nam_Bat_Dau = 2018
and Khoa_Hoc.Nam_Ket_Thuc = 2023
and Mon_Hoc.TenMH NOT LIKE N'Cấu trúc dữ liệu 1'

-- Theo cách truy vấn lồng
select Sinh_Vien.* from Sinh_Vien
LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa ON Lop.Ma_Khoa = Khoa.Ma_Khoa
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
LEFT JOIN Mon_Hoc ON Mon_Hoc.Ma_Khoa = Khoa.Ma_Khoa
where Khoa.Ma_Khoa = 'CNTT'
and Khoa_Hoc.Nam_Bat_Dau = 2018
and Khoa_Hoc.Nam_Ket_Thuc = 2023
and Sinh_Vien.MaSV not in
(select Sinh_Vien.MaSV  from Sinh_Vien
LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa ON Lop.Ma_Khoa = Khoa.Ma_Khoa
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
LEFT JOIN Mon_Hoc ON Mon_Hoc.Ma_Khoa = Khoa.Ma_Khoa
where Khoa.Ma_Khoa = 'CNTT'
and Khoa_Hoc.Nam_Bat_Dau = 2018
and Khoa_Hoc.Nam_Ket_Thuc = 2023
and Mon_Hoc.TenMH = N'Cấu trúc dữ liệu')