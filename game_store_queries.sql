-- Employee Table
CREATE TABLE Employee(
 EmpID CHAR(5),
 EmpPositionID CHAR(5),
 EmpFName VARCHAR(20) NOT NULL,
 EmpLName VARCHAR(20) NOT NULL,
 EmpPhone CHAR(12) NOT NULL,
 EmpDoB DATE NOT NULL,
 EmpStartDate DATE NOT NULL,
 EmpSalary CURRENCY NOT NULL,

 CONSTRAINT PKEmployee PRIMARY KEY (EmpID),
  
 CONSTRAINT FKEmployee_EmpPositionID FOREIGN KEY (EmpPositionID) REFERENCES EmployeePosition
);

-- Customer Table
CREATE TABLE IF NOT EXISTS Customer(

 CusID CHAR(5),
 CusFName VARCHAR(20) NOT NULL,
 CusLName VARCHAR(20) NOT NULL,
 CusGender CHAR(1),
 CusDoB DATE,
 CusEmail VARCHAR(20) NOT NULL,
 CusPhone CHAR(12) NOT NULL,
 CusStreet VARCHAR(50) NOT NULL,
 CusCity VARCHAR(50) NOT NULL,
 CusState CHAR(2) NOT NULL,
 CusZipcode CHAR(5) NOT NULL,

 CONSTRAINT PKCustomer PRIMARY KEY  (CusID)
);

-- EmployeePosition Table

CREATE TABLE IF NOT EXISTS EmployeePosition(
 EmpPositionID  CHAR(5),
 EmpTitle VARCHAR(20) NOT NULL,
 PositionDesc VARCHAR(100) NOT NULL,
 
 CONSTRAINT PKEmployeePosition PRIMARY KEY (EmpPositionID)
);

-- Schedule Table
CREATE TABLE IF NOT EXISTS Schedule(
 SchedCode CHAR(5),
 SchedDay CHAR(3) NOT NULL,
 SchedTime VARCHAR NOT NULL,
 
 CONSTRAINT PKSchedule PRIMARY KEY (SchedCode)
);

-- EmployeeSchedule Table
CREATE TABLE IF NOT EXISTS EmployeeSchedule(
 SchedCode CHAR(5),
 EmpID CHAR(5),
 WorkDate DATE NOT NULL,

 CONSTRAINT PKEmployeeSchedule PRIMARY KEY (SchedCode, EmpID),

 CONSTRAINT FKEmployeeSchedule_SchedCode FOREIGN KEY (SchedCode) REFERENCES  Schedule,
 
 CONSTRAINT FKEmployeeSchedule_EmpID FOREIGN KEY  (EmpID) REFERENCES Employee

);

-- GamePlatform Table
CREATE TABLE GamePlatform(
 PlatformID CHAR(1),
 PlatformName VARCHAR(20) NOT NULL,
 
 CONSTRAINT PKGamePlatform PRIMARY KEY (PlatformID)
);

-- Genre Table
CREATE TABLE IF NOT EXISTS Genre(
 GenreID CHAR(2),
 GenreName VARCHAR(20) NOT NULL,
 GenreDesc VARCHAR(100) NOT NULL,

 CONSTRAINT PKGenre PRIMARY KEY (GenreID)
);

-- Location Table
CREATE TABLE IF NOT EXISTS Location(
 LocationCode CHAR(5),
 LocationDesc VARCHAR(100),
 
 CONSTRAINT PKLocation PRIMARY KEY (LocationCode)
);

--Product Table
CREATE TABLE IF NOT EXISTS Product(
 ProdID CHAR(10),
 ProdName VARCHAR(100) NOT NULL,
 GenreID CHAR(10),
 PlatformID CHAR(1),
 ProdPrice DOUBLE PRECISION NOT NULL,
 ProdDesc VARCHAR(100),
 ProdPlayerNum CHAR(2),
 ProdReleaseDate DATE,
 
 CONSTRAINT PKProduct PRIMARY KEY  (ProdID),
 
 CONSTRAINT FKProduct_GenreID FOREIGN KEY  (GenreID)  REFERENCES Genre,
 
 CONSTRAINT FKProduct_PlatformID FOREIGN KEY (PlatformID) REFERENCES GamePlatform
);

-- Production Location Table
CREATE TABLE IF NOT EXISTS ProductLocation(
 LocationCode CHAR(5),
 ProdID CHAR(5), 

 CONSTRAINT PKProductLocation PRIMARY KEY 
 (LocationCode, ProdID),
 
 CONSTRAINT FKProductLocation_LocationCode FOREIGN KEY (LocationCode) REFERENCES Location,
 
 CONSTRAINT FKProductLocation_Location_ProdID FOREIGN KEY  (ProdID) REFERENCES Product
);

-- Purchase Table
CREATE TABLE IF NOT EXISTS Purchase(
 PurchaseID CHAR(5),
 CusID CHAR(5) NOT NULL,
 PurchaseDate DATE NOT NULL,
 PurchaseTime TIME NOT NULL,
 TotalAmount DOUBLE PRECISION NOT NULL,
 
 CONSTRAINT PKINVOICE PRIMARY KEY (PurchaseID),

 CONSTRAINT FKCustomer_CusID FOREIGN KEY(CusID) REFERENCES Customer
);

-- PurchaseLine Table
CREATE TABLE IF NOT EXISTS PurchaseLine(
 PurchaseID CHAR(5),
 ProdID CHAR(5),
 LineQty SMALLINT NOT NULL,
 LinePrice DOUBLE PRECISION NOT NULL,
 
 CONSTRAINT PKPurchaseLine PRIMARY KEY 
 (PurchaseID, ProdID),

 CONSTRAINT FKPurchaseLine_PurchaseID FOREIGN KEY (PurchaseID) REFERENCES Purchase,
 
 CONSTRAINT FKPurchaseLine_ProdID FOREIGN KEY (ProdID) REFERENCES Product
);

-- Survey Table
CREATE TABLE IF NOT EXISTS Survey(
 SurveyID CHAR(5),
 PurchaseID CHAR(5),
 EmpID CHAR(5),
 SurveyDate DATE NOT NULL,
 SurveyTime TIME NOT NULL,
 SurveyRating DOUBLE PRECISION NOT NULL,
 SurveyComment VARCHAR(100),
 
 CONSTRAINT PKSurvey PRIMARY KEY (SurveyID),

 CONSTRAINT FKSurvey_PurchaseID FOREIGN KEY (PurchaseID) REFERENCES Purchase,

 CONSTRAINT FKSurvey_EmpID FOREIGN KEY (EmpID) REFERENCES Employee

);
 
 