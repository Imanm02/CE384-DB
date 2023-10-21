Use master
Go

-- ایجاد پایگاه‌ داده‌ی بوت‌کمپ الگوریتم کوئرا
Create Database queraAlgorithmBootcamp
   -- on( Name='bootcamp_data',FileName='G:\database\quera_algorithm_bootcamp\bootcamp_data.mdf',Size=5 )
   -- log on( Name='bootcamp_log',FileName='G:\database\quera_algorithm_bootcamp\bootcamp_log.ldf' )
Go

-- تنظیم تطبیق حروف برای زبان فارسی
Alter Database queraAlgorithmBootcamp Collate Persian_100_CI_AI
GO

USE queraAlgorithmBootcamp
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Final_exam')
CREATE TABLE Final_exam
(
	Exam_id nvarchar(50) primary key,			     -- شناسه آزمون نهایی
	Exam_date date not null,				         -- تاریخ برگزاری آزمون
	Nom_of_Exam tinyint not null,			     -- تعداد سوالات
	Exam_time time not null,                      -- مدت زمان آزمون
)
Go

-- درج داده در جدول آزمون نهایی
Insert Into Final_exam
Values 
	(N'آزمون نهایی', '2023-07-01', 7, '12:00:00')
Go 
-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Registeredـpeople')
CREATE TABLE Registeredـpeople				-- جدول افراد ثبت ‌نامی
(
	National_id nchar(10) PRIMARY KEY,		-- کد ملی افراد ثبت ‌نامی
	Mobile_number char(11) NOT NULL,		-- شماره تلفن‌همراه افراد ثبت‌ نامی
	First_name nvarchar(30) NOT NULL,		-- نام افراد ثبت‌ نامی 
	Last_name nvarchar(30) NOT NULL,		-- نام خانوداگی افراد ثبت ‌نامی
	Degree nvarchar(20) NULL,				-- مدرک افراد ثبت‌ نامی
	Register_time datetime NOT NULL,		-- زمان ثبت‌ ‌نام افراد ثبت ‌نامی
	Exam_id nvarchar(50) NOT NULL,
	Exam_score int not null,
)
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Participant')
CREATE TABLE Participant				  -- جدول شرکت کنندگان
(
	National_id nchar(10) PRIMARY KEY,    -- کد ملی شرکت کنندگان
	Mobile_number char(11) NOT NULL,      -- شماره تلفن‌همراه شرکت کنندگان
	First_name nvarchar(30) NOT NULL,     -- نام شرکت کنندگان
	Last_name nvarchar(30) NOT NULL,      -- نام خانوادگی شرکت کنندگان
	Degree nvarchar(20) NULL,             -- مدرک شرکت کنندگان
	Register_time datetime NOT NULL,      -- زمان ثبت‌ نام شرکت کنندگان
	Exam_id nvarchar(50) NOT NULL,
	Exam_score int not null,
)
GO

INSERT INTO Registeredـpeople
VALUES
	('0352465468', '09120312485', N'مجید', N'حسینی', N'کارشناسی', '2023-01-02 16:20:11', N'آزمون نهایی', 100),
	('0784688419', '09174412481', N'رضا', N'مصیبی', N'کارشناسی', '2023-01-02 18:20:22', N'آزمون نهایی', 88),
	('0318960291', '09874398465', N'یاسمین', N'رضاییان', N'کارشناسی ارشد', '2023-01-02 18:10:12', N'آزمون نهایی', 66),
	('0372865461', '09345398785', N'دنیا', N'محمدی', N'کارشناسی', '2023-01-03 19:10:10', N'آزمون نهایی', 25),
	('0973274052', '09135394143', N'ایمان', N'نوابی', N'دکتری', '2023-01-03 22:20:15', N'آزمون نهایی', 90),
	('0973274055', '09145394231', N'محمد', N'رضایی', N'دکتری', '2023-01-04 12:20:15', N'آزمون نهایی', 27),
	('0973274050', '09178924232', N'سارا', N'ملاکی', N'دیپلم', '2023-01-02 15:50:13', N'آزمون نهایی', 98),
	('1294274044', '09164744242', N'هومان', N'شریفی', N'کارشناسی', '2023-01-04 12:50:53', N'آزمون نهایی', 85),
	('1052465470', '09120312586', N'محمود', N'میرزایی', N'کارشناسی', '2023-01-02 08:20:11', N'آزمون نهایی', 68),
	('2084688420', '09174412582', N'فرهاد', N'صدیقی', N'کارشناسی', '2023-01-02 11:20:22', N'آزمون نهایی', 50),
	('3058960292', '09874398566', N'زهرا', N'کریمی', N'کارشناسی ارشد', '2023-01-02 14:10:12', N'آزمون نهایی', 40),
	('4062865461', '09345398885', N'شیما', N'شریفی', N'کارشناسی', '2023-01-02 15:10:10', N'آزمون نهایی', 35),
	('5063274052', '09135394243', N'علی', N'محمدی', N'دکتری', '2023-01-02 16:20:15', N'آزمون نهایی', 75),
	('6063274055', '09145394331', N'بهنام', N'رضایی', N'دکتری', '2023-01-03 09:20:15', N'آزمون نهایی', 25),
	('7063274050', '09178924332', N'لیلا', N'نوروزی', N'دیپلم', '2023-01-03 12:50:13', N'آزمون نهایی', 30),
	('8074274044', '09164744342', N'عباس', N'رستمی', N'کارشناسی', '2023-01-03 15:50:53', N'آزمون نهایی', 80),
	('9084274047', '09164744345', N'فاطمه', N'علیزاده', N'کارشناسی', '2023-01-03 18:20:23', N'آزمون نهایی', 100),
	('1093274058', '09178924339', N'پریسا', N'محسنی', N'دکتری', '2023-01-04 09:30:25', N'آزمون نهایی', 90),
	('2103274060', '09178924341', N'عارف', N'رضایی', N'دکتری', '2023-01-04 12:20:35', N'آزمون نهایی', 40),
	('3103274061', '09178924342', N'نیما', N'شیخی', N'کارشناسی', '2023-01-04 15:20:45', N'آزمون نهایی', 88),
	('4103274062', '09178924343', N'حمید', N'زینتی', N'کارشناسی ارشد', '2023-01-04 17:20:55', N'آزمون نهایی', 98),
	('5103274063', '09178924344', N'مینا', N'موحد', N'کارشناسی ارشد', '2023-01-05 09:30:05', N'آزمون نهایی', 100),
	('6103274064', '09178924345', N'بهمن', N'بهرامی', N'کارشناسی', '2023-01-05 12:30:15', N'آزمون نهایی', 99),
	('7103274065', '09178924346', N'ریحانه', N'سعیدی', N'کارشناسی', '2023-01-05 15:30:25', N'آزمون نهایی', 65),
	('8103274066', '09178924347', N'کاوه', N'کریمی', N'کارشناسی', '2023-01-05 18:30:35', N'آزمون نهایی', 69),
	('9103274067', '09178924348', N'آرش', N'افشار', N'کارشناسی ارشد', '2023-01-05 21:30:45', N'آزمون نهایی', 21),
	('1010374068', '09178924349', N'ندا', N'مومنی', N'دیپلم', '2023-01-06 09:40:55', N'آزمون نهایی', 29),
	('2013274069', '09178924350', N'رضا', N'حسینی', N'کارشناسی', '2023-01-06 12:40:05', N'آزمون نهایی', 80),
	('3010324070', '09178924351', N'مهران', N'رستگار', N'کارشناسی ارشد', '2023-01-06 15:40:15', N'آزمون نهایی', 10),
	('4013274071', '09178924352', N'مریم', N'جعفری', N'کارشناسی ارشد', '2023-01-06 18:40:25', N'آزمون نهایی', 5);
GO

SELECT I.*
FROM Registeredـpeople I
INNER JOIN (
	SELECT TOP 15 National_id, MIN(Register_time) AS Min_Register
	FROM Registeredـpeople
	WHERE Degree in (N'دیپلم', N'کارشناسی', N'کارشناسی ارشد')
	GROUP BY National_id
) AS S
ON I.National_id = S.National_id
GO

INSERT INTO Participant
SELECT TOP 20 * FROM Registeredـpeople
ORDER BY Register_time ASC;
GO

ALTER TABLE Participant
ADD FOREIGN KEY (National_id) REFERENCES Registeredـpeople(National_id);
GO

ALTER TABLE Participant
ADD FOREIGN KEY (Exam_id) REFERENCES Final_exam;
GO

SELECT * FROM Participant
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Homework')
CREATE TABLE Homework								-- جدول تمرین					
(
	Homework_id nvarchar(50) primary key,              -- شناسه تمرین
	Homework_number tinyint not null,               -- شماره تمرین
	Pahse_release_time datetime null,				-- زمان انتشار تمرین
	Phase_submission_deadline datetime not null,    -- مهلت ارسال تمرین
	Project_subject nvarchar(20) not null,			-- موضوع تمرین  
)
Go

INSERT INTO Homework
VALUES
  (N'تمرین یک' , 1, '2023-04-01 00:00:00', '2023-04-07 00:00:00', N'کار با متغیر'),
  (N'تمرین دو' , 2, '2023-04-07 00:00:00', '2023-04-14 00:00:00', N'کار تابع'),
  (N'تمرین سه' , 3, '2023-04-14 00:00:00', '2023-04-21 00:00:00', N'تابع بازگشتی'),
  (N'تمرین چهار' , 4, '2023-04-21 00:00:00', '2023-04-28 00:00:00', N'ساختار داده');
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Project')
-- ایجاد جدول پروژه‌
create table Project
(
   Phase_id nvarchar(50) primary key,                 -- شناسه پروژه
   Phase_nom tinyint not null,                     -- شماره‌ی فاز پروژه
   Pahse_release_time datetime null,		   -- زمان ریلیز فاز پروژه
   Phase_submission_deadline datetime not null,    -- مهلت ارسال فاز پروژه
   Project_subject nvarchar(50) not null,		   -- موضوع پروژه  
 )
Go

-- درج داده در جدول پروژه‌
Insert Into Project
Values 
  (N'فاز یک پروژه' , 1, '2023-06-01 00:00:00', '2023-06-10 00:00:00', N'الگوریتم مقدماتی'),
  (N'فاز دو پروژه' , 2, '2023-06-10 00:00:00', '2023-06-20 00:00:00', N'الگوریتم پیشرفته')
Go 

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Head_bootcamp')
-- ایجاد جدول رئیس بوت کمپ
CREATE TABLE Head_bootcamp					-- جدول رئیس بوتکمپ
(
	Head_id nchar(10) PRIMARY KEY,			-- کد رئیس بوتکمپ
	Mobile_number char(11) NOT NULL,		-- شماره تلفن‌همراه رئیس بوتکمپ
	First_name nvarchar(30) NOT NULL,		-- نام رئیس بوتکمپ 
	Last_name nvarchar(30) NOT NULL,		-- نام خانوداگی رئیس بوتکمپ
	Degree nvarchar(20) NULL,				-- مدرک رئیس بوتکمپ
)
GO

INSERT INTO Head_bootcamp
VALUES
	('1273694880', '09138094457', N'شایان', N'صالحی', N'دکتری')
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Company')
CREATE TABLE Company						-- جدول شرکت‌ها
(
	Company_id nchar(5) PRIMARY KEY,		-- کد شرکت
	Phone_number char(11) NOT NULL,			-- شماره تلفن‌ ثابت شرکت
	[Name] nvarchar(50) NOT NULL,			-- نام شرکت 
	Work_type nvarchar(30) NULL,			-- نوع کار شرکت
	Field nvarchar(30) NULL,				-- زمینه کار شرکت
	Salary nchar(20) NULL,					-- حقوق پیشنهادی شرکت
	Head_id nchar(10) NOT NULL,
	FOREIGN KEY (Head_id) REFERENCES Head_bootcamp
)
GO

INSERT INTO Company
VALUES
	('14891', '02123192488', N'همکاران سیستم', N'حضوری', N'نرم‌افزار', '12,000,000', '1273694880'),
	('31252', '02123423461', N'فناوران نوین', N'مجازی', N'تحلیل داده', '15,000,000', '1273694880'),
	('51626', '02151717173', N'خودران سیستم', N'مجازی', N'پایگاه داده', '13,500,000', '1273694880'),
	('37353', '02148235226', N'زیبا الگوریتم', N'حضوری', N'طراحی الگوریتم', '8,800,000', '1273694880'),
	('36261', '02124261465', N'نرم‌ نشان', N'حضوری', N'نرم افزار', '16,600,000', '1273694880'),
	('86377', '02142456169', N'خردسازان اندیشه', N'حضوری', N'هوش مصنوعی', '15,360,000', '1273694880');
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Mentors')
-- ایجاد جدول منتور ها
create table Mentors
(
	Mentor_id nchar(10) primary key,				 -- کد ملی مربی
	[Mobile_number] char(11) NOT NULL,
	First_name nvarchar(30) NOT NULL,				-- نام مربی
	Last_name nvarchar(30) NOT NULL,				-- نام خانوداگی مربی
	Degree nvarchar(20) NULL,						-- مدرک مربی	
	Project_id  nvarchar(50) null,				  -- شناسه پروژه
	HW_id  nvarchar(50) null,					  -- شناسه تمرین
	Exam_id  nvarchar(50) null,					  -- شناسه آزمون نهایی
	Head_id nchar(10) not null,
	FOREIGN KEY (project_id) REFERENCES Project,
	FOREIGN KEY (Exam_id) REFERENCES Final_exam,
	FOREIGN KEY (HW_id) REFERENCES Homework,
	FOREIGN KEY (Head_id) REFERENCES Head_bootcamp
)
GO

INSERT INTO Mentors
VALUES
	('1294523781', '09123316655', N'محمد', N'امینی', N'دکتری', null, null, N'آزمون نهایی', '1273694880'),
	('1294462762', '09183776646', N'رسول', N'رضوی', N'دکتری', null, N'تمرین یک', null, '1273694880'),
	('1304442181', '09198816655', N'احمد', N'احمدی', N'دکتری', null, N'تمرین دو', null, '1273694880'),
	('1284522581', '09223327655', N'رضا', N'دادبخش', N'کارشناسی ارشد', null, N'تمرین سه', null, '1273694880'),
	('1314563781', '09333399655', N'حمید', N'صالحی', N'دکتری', null, N'تمرین چهار', null, '1273694880'),
	('1324577781', '09883316344', N'علی', N'رجولی', N'دکتری', N'فاز یک پروژه', null, null, '1273694880'),
	('1334523991', '09393316231', N'سینا', N'آسانی', N'کارشناسی ارشد', N'فاز دو پروژه', null, null, '1273694880'),
	('1224888781', '09303316781', N'غزل', N'سختی', N'دکتری', N'فاز یک پروژه', null, null, '1273694880'),
	('1214613781', '09023316694', N'لاله', N'متوسطی', N'دکتری', N'فاز دو پروژه', null, null, '1273694880'),
	('1194588781', '09013316593', N'مریم', N'فاقد اهمیت', N'دکتری', null, null, N'آزمون نهایی', '1273694880')
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Individual_submissions_hw')
-- ایجاد جدول سابمیت‌های فردی
create table Individual_submissions_hw
(  
   Homework_id nvarchar(50) not null,                                             -- شماره تمرین
   Submission_time datetime not null,                                   -- زمان (تاریخ + ساعت) ارسال
   Submission_score int not null,                                       -- نمره‌ی ارسال
   Submitter_id nchar(10) not null,		                                -- کد ملی فرد ارسال‌کننده  
   Constraint Submission_id_hw primary key(Submitter_id, Submission_time), -- شناسه فرد ارسال‌کننده
   FOREIGN KEY (Submitter_id) REFERENCES Participant,
 )
 Go

 -- درج داده در جدول سابمیت‌های فردی
Insert Into Individual_submissions_hw
values
  (N'تمرین یک', '2023-05-02 16:20:11', 12, '0352465468'),
  (N'تمرین یک', '2023-05-03 17:45:23', 13, '0352465468'),
  (N'تمرین یک', '2023-05-04 20:20:45', 13, '0352465468'),
  (N'تمرین یک', '2023-05-06 03:20:32', 15, '0352465468'),
  (N'تمرین یک', '2023-05-06 16:20:15', 18, '0352465468'),
  (N'تمرین یک', '2023-05-03 12:11:23', 5, '0784688419'),
  (N'تمرین یک', '2023-05-04 12:33:23', 16, '0784688419'),
  (N'تمرین یک', '2023-05-04 02:01:23', 18, '0784688419'),
  (N'تمرین یک', '2023-05-05 12:22:23', 22, '0784688419'),
  (N'تمرین یک', '2023-05-06 14:11:23', 24, '0784688419'),
  (N'تمرین یک', '2023-05-02 23:16:38', 17, '0318960291'),
  (N'تمرین یک', '2023-05-02 23:56:01', 25, '0318960291'),
  (N'تمرین دو', '2023-05-08 12:16:46', 15, '0352465468'),
  (N'تمرین دو', '2023-05-10 15:46:09', 25, '0352465468'),
  (N'تمرین دو', '2023-05-09 11:21:42', 18, '0352465468'),
  (N'تمرین دو', '2023-05-11 16:29:35', 19, '0352465468'),
  (N'تمرین دو', '2023-05-11 19:23:47', 25, '0352465468'),
  (N'تمرین دو', '2023-05-10 15:46:09', 25, '0318960291'),
  (N'تمرین سه', '2023-05-15 20:47:12', 18, '0352465468'),
  (N'تمرین سه', '2023-05-15 19:37:12', 17, '0352465468'),
  (N'تمرین سه', '2023-05-15 11:24:14', 25, '0352465468'),
  (N'تمرین سه', '2023-05-17 18:24:33', 20, '0973274052'),
  (N'تمرین سه', '2023-05-20 13:21:42', 16, '0784688419'),
  (N'تمرین سه', '2023-05-20 23:21:32', 23, '0784688419'),
  (N'تمرین چهار', '2023-05-21 17:22:54', 21, '0352465468'),
  (N'تمرین چهار', '2023-05-22 17:11:54', 23, '0352465468'),
  (N'تمرین چهار', '2023-05-26 15:36:24', 24, '0352465468'),
  (N'تمرین چهار', '2023-05-28 14:56:17', 25, '0352465468'),
  (N'تمرین چهار', '2023-05-29 16:00:15', 22, '0784688419'),
  (N'تمرین چهار', '2023-05-25 07:39:18', 17, '0973274055'),
  (N'تمرین چهار', '2023-05-27 14:50:36', 25, '0973274055'),
  (N'تمرین چهار', '2023-05-29 19:37:12', 16, '0973274050')
Go

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Final_submissions_hw')
-- ایجاد جدول سابمیت‌های نهایی
create table Final_submissions_hw
(
   Homework_id nvarchar(50) not null,                                               -- شماره تمرین
   Submission_time datetime not null,                                   -- زمان (تاریخ + ساعت) ارسال
   Submission_score int not null,                                       -- نمره‌ی ارسال
   Submitter_id nchar(10) not null,		                                -- کد ملی فرد ارسال‌کننده  
   Constraint final_Submission_id_hw primary key(Submitter_id, Submission_time), -- شناسه فرد ارسال‌کننده
)
 Go

INSERT INTO Final_submissions_hw
SELECT I.*
FROM Individual_submissions_hw I
INNER JOIN (
    SELECT Submitter_id, MAX(Submission_score) AS Max_Score
    FROM Individual_submissions_hw
    GROUP BY Submitter_id
) AS S
ON I.Submitter_id = S.Submitter_id AND I.Submission_score = S.Max_Score
GO

ALTER TABLE Final_submissions_hw
ADD FOREIGN KEY (Submitter_id, Submission_time) REFERENCES Individual_submissions_hw(Submitter_id, Submission_time);
GO

ALTER TABLE Final_submissions_hw
ADD FOREIGN KEY (Homework_id) REFERENCES Homework(Homework_id);
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Individual_submissions_project')
-- ایجاد جدول سابمیت های فردی پروژه در هر تیم
create table Individual_submissions_project
(  
   Phase_id nvarchar(50) not null,                                             -- شماره تمرین
   Submission_time datetime not null,                                   -- زمان (تاریخ + ساعت) ارسال
   Submission_score int not null,                                       -- نمره‌ی ارسال
   Submitter_id nchar(10) not null,		                                -- کد ملی فرد ارسال‌کننده  
   Constraint Submission_id_project primary key(Submitter_id, Submission_time), -- شناسه فرد ارسال‌کننده
   FOREIGN KEY (Submitter_id) REFERENCES Participant,
 )
Go

Insert Into Individual_submissions_project
values
  (N'فاز یک پروژه', '2023-06-02 16:20:11', 50, '0352465468'),
  (N'فاز یک پروژه', '2023-06-03 17:45:23', 55, '0352465468'),
  (N'فاز یک پروژه', '2023-06-04 20:20:45', 55, '0352465468'),
  (N'فاز یک پروژه', '2023-06-06 03:20:32', 60, '0352465468'),
  (N'فاز یک پروژه', '2023-06-06 16:20:15', 70, '0352465468'),
  (N'فاز یک پروژه', '2023-06-03 12:11:23', 20, '0784688419'),
  (N'فاز یک پروژه', '2023-06-04 12:33:23', 65, '0784688419'),
  (N'فاز یک پروژه', '2023-06-04 02:01:23', 75, '0784688419'),
  (N'فاز یک پروژه', '2023-06-05 12:22:23', 89, '0784688419'),
  (N'فاز یک پروژه', '2023-06-06 14:11:23', 95, '0784688419'),
  (N'فاز یک پروژه', '2023-06-02 23:16:38', 70, '0318960291'),
  (N'فاز یک پروژه', '2023-06-02 23:56:01', 100, '0318960291'),
  (N'فاز یک پروژه', '2023-06-08 12:16:46', 70, '0352465468'),
  (N'فاز یک پروژه', '2023-06-10 15:46:09', 100, '0352465468'),
  (N'فاز یک پروژه', '2023-06-09 11:21:42', 75, '0352465468'),
  (N'فاز یک پروژه', '2023-06-11 16:29:35', 75, '0352465468'),
  (N'فاز یک پروژه', '2023-06-11 19:23:47', 100, '0352465468'),
  (N'فاز دو پروژه', '2023-06-10 15:46:09', 100, '0318960291'),
  (N'فاز دو پروژه', '2023-06-15 20:47:12', 75, '0352465468'),
  (N'فاز دو پروژه', '2023-06-15 19:37:12', 75, '0352465468'),
  (N'فاز دو پروژه', '2023-06-15 11:24:14', 100, '0352465468'),
  (N'فاز دو پروژه', '2023-06-17 18:24:33', 80, '0973274052'),
  (N'فاز دو پروژه', '2023-06-20 13:21:42', 75, '0784688419'),
  (N'فاز دو پروژه', '2023-06-20 23:21:32', 95, '0784688419'),
  (N'فاز دو پروژه', '2023-06-21 17:22:54', 85, '0352465468'),
  (N'فاز دو پروژه', '2023-06-22 17:11:54', 95, '0352465468'),
  (N'فاز دو پروژه', '2023-06-26 15:36:24', 97, '0352465468'),
  (N'فاز دو پروژه', '2023-06-28 14:56:17', 100, '0352465468'),
  (N'فاز دو پروژه', '2023-06-29 16:00:15', 90, '0784688419'),
  (N'فاز دو پروژه', '2023-06-25 07:39:18', 70, '0973274055'),
  (N'فاز دو پروژه', '2023-06-27 14:50:36', 100, '0973274055'),
  (N'فاز دو پروژه', '2023-06-29 19:37:12', 75, '0973274050')
Go

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Final_submissions_project')
-- ایجاد جدول سابمیت های نهایی پروژه
create table Final_submissions_project
(
   Phase_id nvarchar(50) not null,                                               -- شماره تمرین
   Submission_time datetime not null,                                   -- زمان (تاریخ + ساعت) ارسال
   Submission_score int not null,                                       -- نمره‌ی ارسال
   Submitter_id nchar(10) not null,		                                -- کد ملی فرد ارسال‌کننده  
   Constraint final_Submission_id_project primary key(Submitter_id, Submission_time), -- شناسه فرد ارسال‌کننده
)
Go

INSERT INTO Final_submissions_project
SELECT I.*
FROM Individual_submissions_project I
INNER JOIN (
    SELECT Submitter_id, MAX(Submission_score) AS Max_Score
    FROM Individual_submissions_project
    GROUP BY Submitter_id
) AS S
ON I.Submitter_id = S.Submitter_id AND I.Submission_score = S.Max_Score
GO

ALTER TABLE Final_submissions_project
ADD FOREIGN KEY (Submitter_id, Submission_time) REFERENCES Individual_submissions_project(Submitter_id, Submission_time);
GO

ALTER TABLE Final_submissions_project
ADD FOREIGN KEY (Phase_id) REFERENCES Project(Phase_id);
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Teacher')
-- ایجاد جدول اساتید
CREATE TABLE Teacher						-- جدول اساتید
(
	Teacher_id nchar(10) PRIMARY KEY,		-- کد ملی اساتید
	Mobile_number char(11) NOT NULL,		-- شماره تلفن‌همراه اساتید
	First_name nvarchar(30) NOT NULL,		-- نام اساتید 
	Last_name nvarchar(30) NOT NULL,		-- نام خانوداگی اساتید
	Degree nvarchar(20) NULL,				-- مدرک اساتید
	Email varchar(50) NULL				-- ایمیل اساتید
)
GO

INSERT INTO Teacher
VALUES
	('1414523974', '09163316655', N'آرمین', N'رضایی', N'دکتری', 'armin.betoche@gmail.com'),
	('1444493781', '09283776646', N'علیرضا', N'محمدزاده', N'دکتری', 'ali.khastam@gmail.com'),
	('1884433181', '09298828855', N'عاطفه', N'نیازمند', N'دکتری', 'atni.nemikham@gmail.com'),
	('1584522491', '09823335655', N'سارا', N'اجمالی', N'کارشناسی ارشد', 'sara.hey@gmail.com'),
	('1384563755', '09533411655', N'نیره', N'حیدری', N'دکتری', 'nayare.movafagh@gmail.com')
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Class')
-- ایجاد جدول کلاس
CREATE TABLE Class
(
	Class_id nchar(5) PRIMARY KEY,
	Teacher_id nchar(10) NOT NULL,
	Beginning_time time NOT NULL,
	End_time time NOT NULL,
	[Subject] nvarchar(50) NOT NULL,
	FOREIGN KEY (Teacher_id) REFERENCES Teacher

)
GO

INSERT INTO Class
VALUES
	('21221', '1414523974', '16:00:00', '18:00:00', N'الگوریتم خسته'),
	('21741', '1444493781', '14:00:00', '15:30:00', N'پیاده‌سازی اسباب ‌بازی'),
	('31241', '1884433181', '22:00:00', '23:30:30', N'نیازهای اولیه'),
	('62622', '1584522491', '10:00:00', '12:30:00', N'مقدمات ساختار'),
	('72262', '1384563755', '17:00:00', '19:00:00', N'هوش ساختگی')
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Class_participant')
CREATE TABLE Class_participant
(
	Class_id nchar(5) NOT NULL,
	Participant_id nchar(10) NOT NULL,
	Constraint Class_participant_id primary key(Class_id, Participant_id),
	FOREIGN KEY (Participant_id) REFERENCES Participant(National_id),
	FOREIGN KEY (Class_id) REFERENCES Class
)
GO

INSERT INTO Class_participant
VALUES
	('21221', '0318960291'),
	('21221', '0784688419'),
	('21221', '0973274050'),
	('21221', '1052465470'),
	('21221', '1093274058'),
	('21741', '0352465468'),
	('21741', '4062865461'),
	('21741', '0318960291'),
	('31241', '0973274050'),
	('62622', '7063274050'),
	('72262', '6063274055')
GO

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Accepted')
-- ساخت جدول قبول شدگان براساس نمرات کل تمرین و پروژه و آزمون نهایی
CREATE TABLE Accepted				  -- جدول قبول شدگان
(
	Accepted_id nchar(10) PRIMARY KEY,    -- کد ملی قبول شدگان
	Mobile_number char(11) NOT NULL,      -- شماره تلفن‌همراه قبول شدگان
	First_name nvarchar(30) NOT NULL,     -- نام قبول شدگان
	Last_name nvarchar(30) NOT NULL,      -- نام خانوادگی قبول شدگان
	Degree nvarchar(20) NULL,             -- مدرک قبول شدگان
	All_score int not null,
)
GO

INSERT INTO Accepted
	SELECT TOP 10 Participant.National_id AS participant_id,Mobile_number,First_name,Last_name,Degree, (ISNULL(final_exam_score.final_exam_score, 0) + ISNULL(final_HW_score.HWs_score, 0) + ISNULL(final_project_score.project_score, 0)) AS all_scores 
	FROM Participant 
	FULL OUTER JOIN
	(SELECT National_id AS participant_id_1, Exam_score AS final_exam_score FROM Participant) AS final_exam_score
	ON Participant.National_id = final_exam_score.participant_id_1
	FULL OUTER JOIN 
	(SELECT HW_scores.participant_id AS participant_id_2, SUM(HW_scores.score) AS HWs_score 
	from (SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, MAX(Final_submissions_hw.Submission_score) AS score 
	FROM Individual_submissions_hw 
	 JOIN Final_submissions_hw
	 ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id
	 GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
	 GROUP BY HW_scores.participant_id) AS final_HW_score
	 ON final_exam_score.participant_id_1 = final_HW_score.participant_id_2
	 FULL OUTER join
	(SELECT project_scores.participant_id, SUM(project_scores.score) AS project_score 
	from (SELECT Final_submissions_project.Submitter_id AS participant_id , Final_submissions_project.Phase_id, MAX(Final_submissions_project.Submission_score) AS score 
	FROM Final_submissions_project
	GROUP BY Final_submissions_project.Phase_id, Final_submissions_project.Submitter_id) AS project_scores
	GROUP BY project_scores.participant_id) AS final_project_score
	ON final_HW_score.participant_id_2 = final_project_score.participant_id
	ORDER BY all_scores DESC
GO


ALTER TABLE Accepted
ADD FOREIGN KEY (Accepted_id) REFERENCES Participant(National_id);
GO

SELECT * FROM Accepted

-- در صورتی که جدولی با این نام وجود نداشت، آن را بساز
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Interview')
-- ساخت جدول مصاحبه پذیرفته شدگان
CREATE TABLE Interview
(
	Interview_id nchar(10) PRIMARY KEY,
	Accepted_id nchar(10) NOT NULL,
	Company_id nchar(5) NOT NULL,
	Interview_time datetime NOT NULL,
	[Subject] nvarchar(50) NOT NULL
	FOREIGN KEY (Accepted_id) REFERENCES Accepted(Accepted_id),
	FOREIGN KEY (Company_id) REFERENCES Company(Company_id)
)
GO

INSERT INTO Interview
VALUES
	('8289935211', '0352465468', '14891', '2023-08-01 16:00:00', N'هوش مصنوعی'),
	('8255621372', '0318960291', '31252', '2023-08-02 16:00:00', N'الگوریتم پیشرفته'),
	('8282345157', '0784688419', '37353', '2023-08-01 18:00:00', N'ساختار داده'),
	('8264256149', '0973274055', '86377', '2023-08-03 18:00:00', N'نیاز مالی'),
	('8242169241', '1294274044', '14891', '2023-08-01 18:00:00', N'پایگاه ماشین')
GO

-- در صورت وجود تابعی با این اسم ابتدا حذف می‌شود تا بعد ساخته شود
DROP PROCEDURE IF EXISTS GetParticipantScores;
GO
-- تابعی که به عنوان ورودی ک د ملی شرک کننده را گرفته و مجموع نمرات تمرین، پروژه و امتحان فرد را اعلام کند.
CREATE PROCEDURE GetParticipantScores
    @participant_id nchar(10)
AS
BEGIN
  SELECT all_scores FROM
    (SELECT Participant.National_id AS participant_id, 
        (ISNULL(final_exam_score.final_exam_score, 0) + ISNULL(final_HW_score.HWs_score, 0) + ISNULL(final_project_score.project_score, 0)) AS all_scores 
    FROM Participant 
    FULL OUTER JOIN
        (SELECT National_id AS participant_id_1, Exam_score AS final_exam_score FROM Participant) AS final_exam_score
    ON Participant.National_id = final_exam_score.participant_id_1
    FULL OUTER JOIN 
        (SELECT HW_scores.participant_id AS participant_id_2, SUM(HW_scores.score) AS HWs_score 
        from (
            SELECT Final_submissions_hw.Submitter_id AS participant_id, Final_submissions_hw.Homework_id, MAX(Final_submissions_hw.Submission_score) AS score 
            FROM Individual_submissions_hw 
            JOIN Final_submissions_hw
            ON Individual_submissions_hw.Submitter_id = Final_submissions_hw.Submitter_id
            --WHERE Final_submissions_hw.Submitter_id = @participant_id
            GROUP BY Final_submissions_hw.Homework_id, Final_submissions_hw.Submitter_id) AS HW_scores
        GROUP BY HW_scores.participant_id) AS final_HW_score
    ON final_exam_score.participant_id_1 = final_HW_score.participant_id_2
    FULL OUTER JOIN
        (SELECT project_scores.participant_id, SUM(project_scores.score) AS project_score 
        from (
            SELECT Final_submissions_project.Submitter_id AS participant_id , Final_submissions_project.Phase_id, MAX(Final_submissions_project.Submission_score) AS score 
            FROM Final_submissions_project
            --WHERE Final_submissions_project.Submitter_id = @participant_id
            GROUP BY Final_submissions_project.Phase_id, Final_submissions_project.Submitter_id) AS project_scores
        GROUP BY project_scores.participant_id) AS final_project_score
    ON final_HW_score.participant_id_2 = final_project_score.participant_id) AS final_table
  WHERE final_table.participant_id = @participant_id
END
GO

EXEC GetParticipantScores @participant_id = '3103274061'
GO