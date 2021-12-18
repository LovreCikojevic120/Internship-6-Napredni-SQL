CREATE DATABASE ForeignLanguageSchool
DROP DATABASE ForeignLanguageSchool
USE ForeignLanguageSchool

CREATE TABLE Teachers(
	Oib varchar(10) PRIMARY KEY CHECK(Oib NOT LIKE '%[^0-9]%' AND LEN(Oib) = 10),
	NameSurname nvarchar(50) NOT NULL CHECK(NameSurname NOT LIKE '%[0-9]%')
)

CREATE TABLE Classrooms(
	Id int PRIMARY KEY
)

CREATE TABLE Customers(
	Oib varchar(10) PRIMARY KEY CHECK(Oib NOT LIKE '%[^0-9]%' AND LEN(Oib) = 10),
	NameSurname nvarchar(50) NOT NULL CHECK(NameSurname NOT LIKE '%[0-9]%'),
	Age int NOT NULL,
	KnowledgeDegree varchar(2)
)

CREATE TABLE Groups(
	Id int IDENTITY(1,1) PRIMARY KEY,
	CustomerOib varchar(10) UNIQUE FOREIGN KEY REFERENCES Customers(Oib) NOT NULL,
	GroupName varchar(10) NOT NULL
)

CREATE TABLE Classes(
	Id int IDENTITY(1,1) PRIMARY KEY,
	ClassName nvarchar(20) UNIQUE NOT NULL,
	ClassroomId int FOREIGN KEY REFERENCES Classrooms(Id),
	TeacherOib varchar(10) FOREIGN KEY REFERENCES Teachers(Oib)
)

CREATE TABLE TimeTables(
	Id int IDENTITY(1,1) PRIMARY KEY,
	ClassId int FOREIGN KEY REFERENCES Classes(Id),
	GroupId int FOREIGN KEY REFERENCES Groups(Id),
	ClassStart datetime2 NOT NULL,
	ClassEnd datetime2 NOT NULL,
	CONSTRAINT CK_IdenticalDates CHECK (CAST(ClassStart AS DATE) = CAST(ClassEnd AS DATE))
)

CREATE TABLE Workbooks(
	Id int IDENTITY(1,1) PRIMARY KEY,
	ClassId int FOREIGN KEY REFERENCES Classes(Id),
	CustomerOib varchar(10) FOREIGN KEY REFERENCES Customers(Oib),
	Attendence int CHECK(Attendence <= 100),
	MonthlyRate int NOT NULL
)

INSERT INTO Teachers(Oib, NameSurname) VALUES
('0000000000', 'Ante Antić'),
('1111111111', 'Bruno Brunić'),
('2222222222', 'Dino Dinić'),
('3333333333', 'Filip Filipović'),
('4444444444', 'Duje Dujmović')

INSERT INTO Classrooms(Id) VALUES (100),(101),(102),(103),(104)

INSERT INTO Customers(Oib, NameSurname, Age, KnowledgeDegree) VALUES
('5555555555', 'Zrinka Zrinić', 45, 'B2'),
('6666666666', 'Pavao Pavić', 17, 'C3'),
('7777777777', 'Roko Rokić', 70, ''),
('8888888888', 'Mislav Maretić', 25, 'A3'),
('9999999999', 'Tomislav Smolčić', 18, 'B2'),
('1000000000', 'Bartol Deak', 15, 'C1'),
('2000000000', 'Olga Olgić', 34, 'B3'),
('3000000000', 'Nika Nikić', 21, '')

INSERT INTO Groups(CustomerOib, GroupName) VALUES 
('5555555555', 'Grupa C'), 
('6666666666', 'Grupa A'),
('7777777777', 'Grupa D'),
('8888888888', 'Grupa B'),
('9999999999', 'Grupa B'),
('1000000000', 'Grupa A'),
('2000000000', 'Grupa C'),
('3000000000', 'Grupa B')

INSERT INTO Classes(ClassName, ClassroomId, TeacherOib) VALUES
('Francuski', 100, '3333333333'),
('Njemački', 102, '0000000000'),
('Talijanski', 101, '2222222222'),
('Španjolski', 104, '1111111111'),
('Engleski', 103, '4444444444')

INSERT INTO TimeTables(ClassId, GroupId, ClassStart, ClassEnd) VALUES
(1, 2, '2021-12-10 2PM', '2021-12-10 2:45PM'),
(2, 2, '2021-12-9 4PM', '2021-12-9 5:35PM'),
(3, 1, '2021-11-3 8AM', '2021-11-3 9AM'),
(4, 1, '2021-11-5 8AM', '2021-11-5 9AM'),
(5, 3, '2021-12-28 8AM', '2021-12-28 9AM'),
(1, 4, '2021-12-3 8AM', '2021-12-3 9AM'),
(5, 1, '2021-11-4 8AM', '2021-11-4 9AM'),
(3, 4, '2021-10-3 8AM', '2021-10-3 9AM')

INSERT INTO Workbooks(ClassId, CustomerOib, Attendence, MonthlyRate) VALUES
(1, '8888888888', 90, 250),
(2, '9999999999', 100, 500),
(3, '6666666666', 45, 750),
(4, '6666666666', 74, 250),
(5, '2000000000', 80, 100),
(1, '9999999999', 100, 150),
(5, '5555555555', 80, 100),
(3, '7777777777', 100, 50),
(1, '3000000000', 80, 100),
(5, '2000000000', 80, 100)
