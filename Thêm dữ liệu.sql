use Quan_Ly_Sinh_Vien

-- nhập liệu cho bảng Khoa
Insert into Khoa(Ma_Khoa, Ten_Khoa, Nam_Thanh_Lap) values( 'CNTT', N'Công nghệ thông tin',1995);
Insert into Khoa values('VL', N'Vật Lý' , 1970);


-- nhập liệu cho bảng Khóa Học
Insert into Khoa_Hoc(Ma_Khoa_Hoc, Nam_Bat_Dau, Nam_Ket_Thuc) values('K2018', 2018 , 2023);
Insert into Khoa_Hoc values('K2019', 2019, 2024);
Insert into Khoa_Hoc values('K2020', 2020, 2025);


-- Nhập liệu cho bảng Chương trình học
Insert into Chuong_Trinh_Hoc(Ma_CT, Ten_CT) values('CQ', N'Chính Quy');


-- nhập liệu cho bảng Lớp
Insert into Lop(Ma_Lop, Ma_Khoa, Ma_Khoa_Hoc, Ma_CT, STT) values('59k', 'CNTT' , 'K2018', 'CQ', 1);
Insert into Lop values('60k', 'CNTT','K2019', 'CQ', 2);
Insert into Lop values('61k', 'VL','K2020', 'CQ', 1);

-- Nhập liệu cho sinh viên
Insert into Sinh_Vien(MaSV, Ho_Ten, Nam_Sinh, Dan_Toc, Ma_Lop) values('1857', N'Nguyễn Vĩnh An', 2000, N'Kinh', '59k');
Insert into Sinh_Vien values('1858', N'Nguyễn Thanh Bình', 2001, N'Kinh', '60k');
Insert into Sinh_Vien values('1851', N'Nguyễn Thanh Cường', 2002, N'Kinh', '61k');
Insert into Sinh_Vien values('1852', N'Nguyễn Quốc Duy', 2003, N'Kinh', '61k');
Insert into Sinh_Vien values('1853', N'Phan Tuấn Anh', 1999, N'Kinh', '59k');
Insert into Sinh_Vien values('1854', N'Huỳnh Thanh Sang', 2001, N'Kinh', '60k');


-- Nhập liệu cho bảng Môn học
Insert into Mon_Hoc(MaMH, Ma_Khoa, TenMH) values('MH1', 'CNTT', N'Toán cao cấp');
Insert into Mon_Hoc values('MH2', 'VL', N'Vật lý đại cương');
Insert into Mon_Hoc values('MH3', 'CNTT', N'Toán rời rạc');
Insert into Mon_Hoc values('MH4', 'CNTT', N'Cấu trúc dữ liệu');
Insert into Mon_Hoc values('Mh5', 'CNTT', N'Hệ điều hành');

-- Nhập liệu cho bảng Kết quả
Insert into Ket_Qua(MaSV, MaMH, Lan_Thi, Diem_Thi) values('1858', 'MH4', 1 , 7);
Insert into Ket_Qua values('1857', 'MH1', 1 , 9);
Insert into Ket_Qua values('1851', 'Mh2', 1 , 6.5);
Insert into Ket_Qua values('1852', 'MH3', 1 , 8);
Insert into Ket_Qua values('1853', 'MH5', 1 , 6.3);
Insert into Ket_Qua values('1854', 'MH4', 1 , 8);


-- Nhập liệu cho bảng Giảng Khoa
Insert into Giang_Khoa(Ma_CT, Ma_Khoa, MaMH, Nam_Hoc, Hoc_Ky, STLT, STTH, So_Tin_Chi) values('CQ', 'CNTT', 'MH1', 2021, 1, 60, 30, 4);
Insert into Giang_Khoa values('CQ', 'CNTT', 'MH5', 2022, 2, 45, 30, 3);
Insert into Giang_Khoa values('CQ', 'VL', 'MH2', 2020, 1, 45, 30, 3);
