create database quanlysinhvien

create table Khoa
(
	Ma_Khoa varchar(10) primary key,
	Ten_Khoa varchar(100),
	Nam_Thanh_Lap int
)

create table Khoa_Hoc
(
	Ma_Khoa_Hoc varchar(10) primary key, 
	Nam_Bat_Dau int,
	Nam_Ket_Thuc int
)

create table Chuong_Trinh_Hoc
(
	Ma_CT varchar(10) primary key,
	Ten_CT nvarchar(100)
)


create table Lop
(
	Ma_Lop varchar(10) primary key,
	Ma_Khoa varchar(10) not null,
	Ma_Khoa_Hoc varchar(10) not null,
	Ma_CT varchar(10) not null,
	STT int
	foreign key(Ma_Khoa) references Khoa(Ma_Khoa),
	foreign key(Ma_Khoa_Hoc) references Khoa_Hoc(Ma_Khoa_Hoc),
	foreign key(Ma_CT) references Chuong_Trinh_Hoc(Ma_CT)
)


create table Sinh_Vien
(
	MaSV varchar(10) primary key,
	Ho_Ten nvarchar(100),
	Nam_Sinh int,
	Dan_Toc nvarchar(20),
	Ma_Lop varchar(10) not null
	foreign key(Ma_Lop) references Lop(Ma_Lop)
)

create table Mon_Hoc
(
	MaMH varchar(10) primary key,
	Ma_Khoa varchar(10) not null,
	TenMH nvarchar(100)
	foreign key(Ma_Khoa) references Khoa(Ma_Khoa)
)

create table Ket_Qua
(
	MaSV varchar(10) not null,
	MaMH varchar(10) not null,	
	Lan_Thi int not null,
	Diem_Thi float
	primary key(MaSV, MaMH, Lan_Thi),
	foreign key(MaSV) references Sinh_Vien(MaSV),
	foreign key(MaMH) references Mon_Hoc(MaMH)
)

create table Giang_Khoa
(
	Ma_CT varchar(10) not null,
	Ma_Khoa varchar(10) not null,	
	MaMH varchar(10) not null,
	Nam_Hoc int not null,
	Hoc_Ky int,
	STLT int,
	STTH int,
	So_Tin_Chi int
	primary key(Ma_CT, Ma_Khoa, MaMH,Nam_Hoc),
	foreign key(Ma_CT) references Chuong_Trinh_Hoc(Ma_CT),
	foreign key(Ma_Khoa) references Khoa(Ma_Khoa),
	foreign key(MaMH) references Mon_Hoc(MaMH)
)
