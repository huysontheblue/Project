

--1.In danh sách các sinh viên của 1 lớp học
-- Phải có mã lớp
-- Tìm tất cả sinh viên dựa theo mã lớp

create proc KP_List_SV_From_Lop
	 @malop varchar(10)
as
begin
	--set @malop = 'TH2002/01'
	select Sinh_Vien.* from Sinh_Vien
	LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = @malop
end

exec KP_List_SV_From_Lop 'TH2002/01'
go

-- 2. Nhập vào 2 sinh viên, 1 môn học, tìm xem sinh viên nào có điểm thi môn học
--đó lần đầu tiên là cao hơn

create function KF_Max_Diem_First_Time
(
	@masv varchar(10),
	@mamh varchar(10)
)
returns float
as
begin
	declare @ketqua float;
	set @ketqua = 0;
	select @ketqua = Diem_Thi from Ket_Qua
	where Ket_Qua.MaMH = @mamh
	and Ket_Qua.MaSV = @masv
	and Ket_Qua.Lan_Thi = 1
	return @ketqua
end
go

create proc KP_Max_Diem_SV
	 @masv1 varchar(10),
	 @masv2 varchar(10),
	 @mamh varchar(10)
as
begin
--declare @masv1 varchar(10)
--declare @masv2 varchar(10)
--declare @mamh varchar(10)

--set @masv1 = '0212001'
--set @masv2 = '0212002'
--set @mamh = 'THT01'

declare @ketqua1 float
declare @ketqua2 float
select @ketqua1 = dbo.KF_Max_Diem_First_Time(@masv1, @mamh)
select @ketqua2 = dbo.KF_Max_Diem_First_Time(@masv2, @mamh)
if (@ketqua1 > @ketqua2)
	print @masv1
else
	print @masv2
	
end
go

exec KP_Max_Diem_SV '1858', '1854', 'MH4'

-- 3.Nhập vào 1 môn học và 1 mã sv, kiểm tra xem sinh viên có đậu môn này trong
-- lần thi đầu tiên không, nếu đậu thì xuất ra là “Đậu”, không thì xuất ra “Không đậu”
create proc KP_Do_Khong_Do
	 @masv varchar(10),
	 @mamh varchar(10)
as
begin
--declare @masv varchar(10)
--declare @mamh varchar(10)
--set @masv = '0212002'
--set @mamh = 'THT01'

if (exists (select * from Ket_Qua 
where Ket_Qua.MaSV = @masv
and Ket_Qua.MaMH = @mamh
and Ket_Qua.Lan_Thi = 1
and Ket_Qua.Diem_Thi >= 5))
	print N'Đậu'
else
	print N'Không Đậu'
end
go

exec KP_Do_Khong_Do '1858', 'MH4'
go
-- cách không dùng exists
CREATE PROC USP_Cau3
    @masv VARCHAR(10) ,
    @mamh VARCHAR(10)
AS
    BEGIN
        DECLARE @diem FLOAT
        SELECT  @diem = Diem_Thi
        FROM    dbo.Ket_Qua
        WHERE   MaSV = @masv
                AND MaMH = @mamh
                AND Lan_Thi = 1
        IF ( @diem < 5 )
            PRINT N'Không đậu'
        ELSE
			PRINT N'Đậu'
    END

exec USP_Cau3 '1851', 'MH2'
go

-- Nhập vào 1 khoa, in danh sách các sinh viên (mã sinh viên, họ tên, ngày sinh) thuộc khoa này.

CREATE PROC KP_List_SV_In_Khoa
    @makhoa VARCHAR(10)
AS
begin
--declare @makhoa varchar(10)
--set @makhoa = 'CNTT'
select Sinh_Vien.* from Sinh_Vien
LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa ON Lop.Ma_Khoa = Khoa.Ma_Khoa
end
go

exec KP_List_SV_In_Khoa 'VL'

-- .5 Nhập vào 1 sinh viên và 1 môn học, in điểm thi của sinh viên này của các lần
--thi môn học đó.
--Ví dụ:
--Lần 1 : 10
--Lần 2: 8


CREATE PROC KP_Lan_Thi_Va_Diem
    @masv VARCHAR(10) ,
    @mamh VARCHAR(10)
AS
BEGIN
	select Ket_Qua.Lan_Thi, Ket_Qua.Diem_Thi from Ket_Qua 
	where Ket_Qua.MaSV = @masv
	and Ket_Qua.MaMH = @mamh
end
go

exec KP_Lan_Thi_Va_Diem '1851', 'Mh2'

-- 6. Nhập vào 1 sinh viên, in ra các môn học mà sinh viên này phải học.
select * from dbo.KF_List_MH('0212001')
go

-- cách tái sử dụng lại function đã viết
CREATE PROC KP_List_MH
    @masv VARCHAR(10)
AS
begin
	select * from dbo.KF_List_MH(@masv)
end
go

exec KP_List_MH '1858'
go

-- cách sài lại query đã viết
CREATE PROC KP_List_MH_2
    @masv VARCHAR(10)
AS
begin
	select Mon_Hoc.* from Mon_Hoc
	LEFT JOIN Khoa ON Mon_Hoc.Ma_Khoa = Khoa.Ma_Khoa 
	LEFT JOIN Lop ON Lop.Ma_Khoa = Khoa.Ma_Khoa
	LEFT JOIN Sinh_Vien on Sinh_Vien.Ma_Lop = Lop.Ma_Lop
	where Sinh_Vien.MaSV = @masv
end
go
exec KP_List_MH_2 '1857'
go


-- 7. Nhập vào 1 môn học, in danh sách các sinh viên đậu môn này trong lần thi đầu tiên.
create function KF_Check_Dau
(
	@mamh VARCHAR(10),
	@masv VARCHAR(10)
)
returns nvarchar(10)
as 
begin
		DECLARE @diem FLOAT
        SELECT  @diem = Diem_Thi
        FROM    dbo.Ket_Qua
        WHERE   MaSV = @masv
                AND MaMH = @mamh
                AND Lan_Thi = 1
        IF ( @diem < 5 )
           return N'Không đậu'
        ELSE
			return N'Đậu'

return N'Không đậu'

end
go

-- kiểu ngắn gọn khoe điểm
CREATE PROC USP_Cau7 @mamh VARCHAR(10)
AS
    BEGIN
        SELECT  *
        FROM    dbo.Ket_Qua
        WHERE   MaMH = 'THT01'--@mamh
                AND Lan_Thi = 1
                AND Diem_Thi > 5
    END
GO

--select dbo.KF_Check_Dau('THT01', '0212002')

-- kiểu con nhà người ta chỉ khinh khỉnh nói là tao rớt hay không
CREATE PROC KP_Cau_7
    @mamh VARCHAR(10)
AS
begin
	select Ket_Qua.MaMH, Ket_Qua.MaSV, dbo.KF_Check_Dau(Ket_Qua.MaMH, Ket_Qua.MaSV) as [Kết quả] from Ket_Qua
	where Ket_Qua.MaMH = @mamh
	and Ket_Qua.Lan_Thi = 1
	group by Ket_Qua.MaMH, Ket_Qua.MaSV
end
go
exec KP_Cau_7 'THT02'
go

-- 8. In điểm các môn học của sinh viên có mã số là maSinhVien được nhập vào.
-- (Chú ý: điểm của môn học là điểm thi của lần thi sau cùng)
CREATE PROC USP_Cau8 @masv VARCHAR(10)
AS
    BEGIN
	
        SELECT  * FROM   dbo.Ket_Qua KQ
        WHERE   KQ.MaSV = @masv
        AND KQ.Lan_Thi = ( SELECT MAX(KQ2.Lan_Thi)
            FROM  Ket_Qua KQ2
            WHERE KQ2.MaSV = KQ.MaSV
            AND KQ2.MaMH = KQ.MaMH
        )
    END
GO

exec USP_Cau8 '1858'
go