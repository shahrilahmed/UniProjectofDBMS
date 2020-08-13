--Creating Database

CREATE DATABASE UniversityLibraryMS

--Creating Tables

CREATE TABLE BOOKSCATALOG(
csrl INT IDENTITY,
catagory_id AS 'C' + RIGHT('0000' + CAST(csrl AS VARCHAR(10)), 4) PERSISTED PRIMARY KEY,
catagory varchar(30) NOT NULL
);

CREATE TABLE BOOKS(
bsrl int identity,
book_id AS 'B' + RIGHT('0000' + CAST(bsrl AS VARCHAR(10)), 4) PERSISTED PRIMARY KEY,
bookcatagory_id varchar(5) foreign key references BOOKSCATALOG(catagory_id) NOT NULL,
book_title varchar(100) NOT NULL,
book_author varchar(50) NOT NULL,
book_available int
);

CREATE TABLE LIBRARIANS(
lsrl int identity,
librarian_id AS 'L' + RIGHT('0000' + CAST(lsrl AS VARCHAR(10)), 4) PERSISTED PRIMARY KEY,
librarian_name varchar(50) NOT NULL,
librarian_department varchar(15) NOT NULL
);

CREATE TABLE STUDENTS(
ssrl int identity,
student_id AS 'S' + RIGHT('0000' + CAST(ssrl AS VARCHAR(10)), 4) PERSISTED PRIMARY KEY,
student_name varchar(50) NOT NULL,
student_department varchar(15) NOT NULL,
student_semester varchar(20) NOT NULL
);

CREATE TABLE ISSUEDBOOKS(
issueid int identity primary key,
ibook_id varchar(5) foreign key references BOOKS(book_id) NOT NULL,
istudent_id varchar(5) foreign key references STUDENTS(student_id) NOT NULL,
ilibrarian_id varchar(5) foreign key references LIBRARIANS(librarian_id) NOT NULL,
issuedate date NOT NULL,
duedate AS DATEADD(DAY, 15, issuedate),
returndate date,
);

CREATE TABLE FINES(
fsrl int identity,
fissueid int foreign key references ISSUEDBOOKS(issueid),
fstudent_id varchar(5) foreign key references STUDENTS(student_id) NOT NULL,
fineamount int,
paymentdate date,
paymentstatus varchar(15)
);

-- After creating the tables we entered the data for the tables BOOKSCATALOG, BOOKS, STUDENTS and LIBRARIANS
-- ISSUEDBOOKS and FINES tables will be updated with the queries

-- For resetting identity value for the tables after deleting entries from a table in case of wrong data entry---------

DBCC CHECKIDENT(BOOKSCATALOG, RESEED, 0)
-----------------------------------------------------------------------------------------------------------------------

-- STORED PROCEDURES for:
-- 1) Issuing books
-- 2) Returning books
-- 3) Payments of Fines in case of is there any

-- Issuing books :

