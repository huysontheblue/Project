-- 1. Danh sách các sinh viên khoa “Công nghệ Thông tin” khoá 2002-2006
Select Sinh_Vien.* from Sinh_Vien
LEFT JOIN LOP ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
LEFT JOIN Khoa ON Lop.Ma_Khoa = Khoa.Ma_Khoa
where Khoa.Ma_Khoa = 'CNTT'
and Khoa_Hoc.Nam_bat_Dau = 2019
and Khoa_Hoc.Nam_Ket_Thuc = 2024


--​Câu 2: "Cho biết các thông tin (MSSV, họ tên ,năm sinh) của các sinh viên học sớm hơn tuổi qui định (theo tuổi qui định thi sinh viên đủ 18 tuổi khi bắt đầu khóa học)"
-- Day(GETDATE()) -> lấy ngày trong tháng
-- Month(GETDATE()) -> lấy Tháng trong Năm
-- Year(GETDATE()) -> lấy năm
select Sinh_Vien.MaSV, Sinh_Vien.Ho_Ten, Sinh_Vien.Nam_Sinh from Sinh_Vien
LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
where Khoa_Hoc.Nam_Bat_Dau - Sinh_Vien.Nam_Sinh < 18

-- Câu 3:" Cho biết sinh viên khoa CNTT, khoá 2002-2006 chưa học môn cấu trúc dữ liệu"
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
and Mon_Hoc.TenMH = N'Cấu trúc dữ liệu 1')

-- 4. Cho biết sinh viên thi không đậu (Diem <5) môn cấu trúc dữ liệu 1 nhưng chưa thi lại. (bài tập về nhà)

-- lấy ra các sinh viên thi môn cấu trúc dữ liệu 1 mà không phải lần 1

-- truy vấn lồng
select Sinh_Vien.* from Sinh_Vien
LEFT JOIN Ket_Qua ON Sinh_Vien.MaSV = Ket_Qua.MaSV
LEFT JOIN Mon_Hoc ON Ket_Qua.MaMH = Mon_Hoc.MaMH
where Mon_Hoc.TenMH like N'Cấu trúc dữ liệu 1'
and Ket_Qua.Lan_Thi = 1
and Ket_Qua.Diem_Thi < 5
and Sinh_Vien.MaSV NOT IN
(
select Sinh_Vien.MaSV from Sinh_Vien
LEFT JOIN Ket_Qua ON Sinh_Vien.MaSV = Ket_Qua.MaSV
LEFT JOIN Mon_Hoc ON Ket_Qua.MaMH = Mon_Hoc.MaMH
where Mon_Hoc.TenMH like N'Cấu trúc dữ liệu 1'
and Ket_Qua.Lan_Thi > 1
)

-- 5.Với mỗi lớp thuộc khoa CNTT, cho biết mã lớp, mã khóa học, tên chương trình và số sinh viên thuộc lớp đó (bài tập về nhà)
select Lop.Ma_Lop, Lop.Ma_Khoa_Hoc, Chuong_Trinh_Hoc.Ten_CT, count(Sinh_Vien.MaSV) as [Số sinh viên] from Lop
LEFT JOIN Chuong_Trinh_Hoc ON Lop.Ma_CT = Chuong_Trinh_Hoc.Ma_CT
LEFT JOIN Sinh_Vien ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa ON Khoa.Ma_Khoa = Lop.Ma_Khoa
where Khoa.Ma_Khoa = 'CNTT'
group by Lop.Ma_Lop, Lop.Ma_Khoa_Hoc, Chuong_Trinh_Hoc.Ten_CT

-- 6. Cho biết điểm trung bình của sinh viên có mã số 0212003 (điểm trung bình chỉ tính trên lần thi sau cùng của sinh viên) (bài tập về nhà)

-- cách dùng group by truy vấn lồng
select avg(Ket_Qua.Diem_Thi) as [Điểm trung bình] from Ket_Qua
LEFT JOIN (select MaMH, Max(Lan_Thi) as [Last time] from Ket_Qua
where Ket_Qua.MaSV = '0212003'
group by MaMH) table2
ON Ket_Qua.MaMH = table2.MaMH
where MaSV = '0212003'
and Ket_Qua.Lan_Thi = table2.[Last time]

-- cách không dùng group by, dùng truy vấn lồng
SELECT AVG(KQ.Diem_Thi) AS DTB
FROM Ket_Qua KQ
WHERE KQ.MaSV = '0212003'
AND KQ.Lan_Thi = (SELECT MAX(KQ2.Lan_Thi)
FROM Ket_Qua KQ2
WHERE KQ2.MaMH = KQ.MaMH
AND KQ2.MaSV = KQ.MaSV)