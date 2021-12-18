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
