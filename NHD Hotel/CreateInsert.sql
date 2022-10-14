DROP DATABASE IF EXISTS NHDMall;
GO
CREATE DATABASE NHDMall;
GO

USE NHDMall;


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Mall') AND type in (N'U')) DROP TABLE Mall;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'BoothColor') AND type in (N'U')) DROP TABLE BoothColor;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'BoothLocation') AND type in (N'U')) DROP TABLE BoothLocation;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Booth') AND type in (N'U'))DROP TABLE Booth;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Dealer') AND type in (N'U')) DROP TABLE Dealer;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DealerBooths') AND type in (N'U')) DROP TABLE DealerBooths;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ItemMaster') AND type in (N'U')) DROP TABLE ItemMaster;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Inventory') AND type in (N'U')) DROP TABLE Inventory;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SaleHeader') AND type in (N'U')) DROP TABLE SaleHeader;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SaleDetail') AND type in (N'U')) DROP TABLE SaleDetail;
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Rent') AND type in (N'U')) DROP TABLE Rent;


CREATE TABLE Mall(
MallID int NOT NULL,
MallName varchar(100) NOT NULL,
CommissionRate decimal(18, 2) NOT NULL,
CONSTRAINT PK_Mall primary key (MallID));


CREATE TABLE BoothColor(
ColorID int NOT NULL,
ColorName varchar(50) NOT NULL,
CONSTRAINT PK_BoothColor primary key (ColorID));


CREATE TABLE BoothLocation(
LocationID int NOT NULL,
LocationDescription varchar(20) NOT NULL,
CONSTRAINT PK_BoothLocation primary key (LocationID));


CREATE TABLE Booth(
BoothID int NOT NULL,
BoothName varchar(10) NOT NULL,
MallID int NOT NULL,
LocationID int NOT NULL,
ColorID int NOT NULL,
IsRafted bit NOT NULL,
IsCarpeted bit NOT NULL,
IsRent bit NOT NULL,
Rent decimal(18, 2) NOT NULL,
LengthFeet decimal(18, 2) NOT NULL,
WidthFeet decimal(18, 2) NOT NULL,
CONSTRAINT PK_Booth primary key (BoothID),
CONSTRAINT FK_Booth_BoothColor FOREIGN KEY(ColorID) REFERENCES BoothColor (ColorID),
CONSTRAINT FK_Booth_BoothLocation FOREIGN KEY(LocationID) REFERENCES BoothLocation (LocationID),
CONSTRAINT FK_Booth_Mall FOREIGN KEY(MallID) REFERENCES Mall (MallID));


CREATE TABLE Dealer(
DealerID int NOT NULL,
DealerName varchar(100) NOT NULL,
Address varchar(100) NOT NULL,
City varchar(50) NOT NULL,
State varchar(20) NOT NULL,
Zip nvarchar(10) NOT NULL,
Phone nvarchar(20) NOT NULL,
CellPhone nvarchar(20) NULL,
TaxID nvarchar(10) NOT NULL,
Comment varchar(500) NULL,
CONSTRAINT PK_Dealer primary key (DealerID));


CREATE TABLE DealerBooths(
DealerBoothID int NOT NULL,
DealerID int NULL,
BoothID int NULL,
CONSTRAINT PK_DealerBooths primary key (DealerBoothID),
CONSTRAINT FK_DealerBooths_Booth FOREIGN KEY(BoothID) REFERENCES Booth (BoothID),
CONSTRAINT FK_DealerBooths_Dealer FOREIGN KEY(DealerID) REFERENCES Dealer (DealerID));


CREATE TABLE ItemMaster(
ItemID int NOT NULL,
ItemDescription varchar(50) NOT NULL,
ItemPrice decimal(18, 2) NOT NULL,
CONSTRAINT PK_ItemMaster primary key (ItemID));


CREATE TABLE Inventory(
DealerID int NOT NULL,
ItemID int NOT NULL,
Quantity decimal(18, 2) NOT NULL,
CONSTRAINT PK_Inventory primary key (DealerID,ItemID),
CONSTRAINT FK_Inventory_Dealer FOREIGN KEY(DealerID) REFERENCES Dealer (DealerID),
CONSTRAINT FK_Inventory_ItemMaster FOREIGN KEY(ItemID) REFERENCES ItemMaster (ItemID));
 

CREATE TABLE SaleHeader(
SaleID int NOT NULL,
DealerBoothID int NOT NULL,
SaleDate datetime NOT NULL,
SaleAmount decimal(18, 2) NOT NULL,
CONSTRAINT PK_SaleHeader primary key (SaleID),
CONSTRAINT FK_SaleHeader_DealerBooths FOREIGN KEY(DealerBoothID) REFERENCES DealerBooths (DealerBoothID));


CREATE TABLE SaleDetail(
SaleID int NOT NULL,
ItemID int NOT NULL,
Quantity decimal(18, 2) NOT NULL,
Amount decimal(18, 2) NOT NULL,
CONSTRAINT FK_SaleDetail_ItemMaster FOREIGN KEY(ItemID) REFERENCES ItemMaster (ItemID),
CONSTRAINT FK_SaleDetail_SaleHeader FOREIGN KEY(SaleID) REFERENCES SaleHeader (SaleID));


CREATE TABLE Rent(
RentID int NOT NULL,
DealerBoothID int NOT NULL,
Date datetime NOT NULL,
TotalSale decimal(18, 2) NOT NULL,
RentAmount decimal(18, 2) NOT NULL,
Commisson decimal(18, 2) NOT NULL,
PaymentAmount decimal(18, 2) NOT NULL,
CONSTRAINT PK_Rent primary key (RentID),
CONSTRAINT FK_Rent_DealerBooths FOREIGN KEY(DealerBoothID) REFERENCES DealerBooths (DealerBoothID));


INSERT Mall (MallID, MallName, CommissionRate) VALUES (1, 'Memories Antique Mall - 01', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (2, 'Memories Antique Mall - 02', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (3, 'Memories Antique Mall - 03', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (4, 'Memories Antique Mall - 04', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (5, 'Memories Antique Mall - 05', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (6, 'Memories Antique Mall - 06', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (7, 'Memories Antique Mall - 07', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (8, 'Memories Antique Mall - 08', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (9, 'Memories Antique Mall - 09', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (10, 'Memories Antique Mall - 10', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (11, 'Memories Antique Mall - 11', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (12, 'Memories Antique Mall - 12', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (13, 'Memories Antique Mall - 13', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (14, 'Memories Antique Mall - 14', CAST(10.00 AS Decimal(18, 2)));
INSERT Mall (MallID, MallName, CommissionRate) VALUES (15, 'Memories Antique Mall - 15', CAST(10.00 AS Decimal(18, 2)));


INSERT BoothColor (ColorID, ColorName) VALUES (1, 'green');
INSERT BoothColor (ColorID, ColorName) VALUES (2, 'tan');
INSERT BoothColor (ColorID, ColorName) VALUES (3, 'yellow');
INSERT BoothColor (ColorID, ColorName) VALUES (4, 'white');


INSERT BoothLocation (LocationID, LocationDescription) VALUES (1, 'outside perimeter');
INSERT BoothLocation (LocationID, LocationDescription) VALUES (2, 'insider perimeter');
INSERT BoothLocation (LocationID, LocationDescription) VALUES (3, 'aisle');


INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (1, 'A-01', 1, 1, 1, 1, 1, 1, CAST(310.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (2, 'A-02', 1, 1, 2, 1, 1, 1, CAST(310.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (3, 'A-03', 1, 1, 3, 1, 1, 1, CAST(290.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (4, 'A-04', 1, 1, 4, 1, 1, 0, CAST(290.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (5, 'A-05', 1, 1, 1, 1, 1, 1, CAST(290.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (6, 'A-06', 1, 1, 2, 1, 1, 1, CAST(310.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (7, 'A-07', 1, 1, 3, 1, 1, 1, CAST(290.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (8, 'A-08', 1, 1, 4, 1, 1, 0, CAST(230.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (9, 'A-09', 1, 1, 1, 1, 1, 1, CAST(230.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (10, 'A-10', 1, 1, 2, 1, 1, 1, CAST(230.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (11, 'A-11', 1, 1, 3, 1, 1, 1, CAST(310.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (12, 'A-12', 1, 1, 4, 1, 1, 0, CAST(310.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (13, 'A-13', 1, 1, 1, 1, 1, 1, CAST(230.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (14, 'A-14', 1, 1, 2, 1, 1, 1, CAST(230.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (15, 'A-15', 1, 1, 3, 1, 1, 1, CAST(175.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (16, 'A-16', 1, 1, 4, 1, 1, 0, CAST(175.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (17, 'A-17', 1, 1, 1, 1, 1, 1, CAST(175.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (18, 'A-18', 1, 1, 2, 1, 1, 1, CAST(290.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (19, 'A-19', 1, 1, 3, 1, 1, 1, CAST(310.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (20, 'A-20', 1, 1, 4, 1, 1, 0, CAST(310.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (21, 'B-01', 1, 2, 1, 0, 1, 1, CAST(120.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (22, 'B-02', 1, 2, 2, 0, 1, 1, CAST(120.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (23, 'B-03', 1, 2, 3, 0, 1, 1, CAST(120.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (24, 'B-04', 1, 2, 4, 0, 1, 0, CAST(105.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (25, 'B-05', 1, 2, 1, 0, 1, 1, CAST(105.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (26, 'B-06', 1, 2, 2, 0, 1, 1, CAST(105.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (27, 'B-07', 1, 2, 3, 0, 1, 1, CAST(105.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (28, 'B-08', 1, 2, 4, 0, 1, 0, CAST(120.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (29, 'B-09', 1, 2, 1, 0, 1, 1, CAST(120.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (30, 'B-10', 1, 2, 2, 0, 1, 1, CAST(120.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (31, 'B-11', 1, 2, 3, 0, 1, 1, CAST(175.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (32, 'B-12', 1, 2, 4, 0, 1, 0, CAST(175.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (33, 'B-13', 1, 2, 1, 0, 1, 1, CAST(175.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (34, 'B-14', 1, 2, 2, 0, 1, 1, CAST(120.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (35, 'B-15', 1, 2, 3, 0, 1, 1, CAST(120.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (36, 'C-01', 1, 3, 4, 0, 1, 0, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (37, 'C-02', 1, 3, 1, 0, 1, 1, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (38, 'C-03', 1, 3, 2, 0, 1, 1, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (39, 'C-04', 1, 3, 3, 0, 1, 1, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (40, 'C-05', 1, 3, 4, 0, 1, 0, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (41, 'C-06', 1, 3, 1, 0, 1, 1, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (42, 'C-07', 1, 3, 2, 0, 1, 1, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (43, 'C-08', 1, 3, 3, 0, 1, 1, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (44, 'C-09', 1, 3, 4, 0, 1, 0, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (45, 'C-10', 1, 3, 1, 0, 1, 1, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (46, 'C-11', 1, 3, 2, 0, 1, 1, CAST(90.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (47, 'C-12', 1, 3, 3, 0, 1, 1, CAST(150.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (48, 'C-13', 1, 3, 4, 0, 1, 0, CAST(150.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (49, 'C-14', 1, 3, 1, 0, 1, 1, CAST(200.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)));
INSERT Booth (BoothID, BoothName, MallID, LocationID, ColorID, IsRafted, IsCarpeted, IsRent, Rent, LengthFeet, WidthFeet) VALUES (50, 'C-15', 1, 3, 2, 0, 1, 1, CAST(200.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)));


INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (1, 'Wanda Rampling', '1902 Travis Street', 'West Palm Beach', 'Florida', '33401', '772-559-8331', '331-302-3261', 'P28424490', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (2, 'Ian Watso', '2792 Lauren Drive', 'Dodgeville', 'Wisconsi', '52650', '608-478-2916', '570-865-6333', 'P99996378', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (3, 'Evan Poole', '2592 Oak Way', 'Omaha', 'Nebraska', '68164', '402-452-6845', '434-995-6646', '988349665', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (4, 'Anthony Nola', '4344 Rosebud Avenue', 'Grady', 'Arkansas', '71644', '874-479-8774', '303-924-3308', '996757007', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (5, 'Stephanie Taylor', '349 Conference Center Way', 'Sugar Notch', 'Pennsylvania', '18706', '570-986-2120', '616-379-7125', '469587679', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (6, 'Sam Baker', '2017 Deans Lane', 'Covingto', 'Louisiana', '70434', '914-921-2650', '801-264-9199', 'P77328493', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (7, 'Mary Howard', '4304 Green Gate Lane', 'Baltimore', 'Maryland', '21202', '443-747-0412', '270-313-8805', 'P99997145', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (8, 'Stephanie Payne', '3955 Court Street', 'Houma', 'Louisiana', '70363', '636-673-1154', '740-836-7787', '277208445', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (9, 'Matt Lambert', '3464 Carriage Court', 'Salton City', 'California', '92271', '760-394-7735', '608-645-7511', '970737827', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (10, 'Paul Rutherford', '3156 Virgil Street', 'Panama City', 'Florida', '32405', '850-248-0732', '231-818-9785', '192761997', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (11, 'Oliver James', '3301 Brown Street', 'Tempe', 'Arizona', '85282', '928-225-9523', '509-435-4822', 'P38369317', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (12, 'Jessica Carr', '2302 Wilkinson Court', 'Fort Myers', 'Florida', '33912', '239-494-1626', '660-218-1286', 'P99996195', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (13, 'Jacob Hart', '1734 Badger Pond Lane', 'Saint Petersburg', 'Florida', '33710', '727-346-7981', '253-796-2435', '841081686', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (14, 'Kevin MacLeod', '4527 Lakeland Terrace', 'Detroit', 'Michiga', '48219', '734-305-6762', '343-361-1163', '978804373', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (15, 'Richard Chapma', '1984 Austin Secret Lane', 'Long Beach', 'California', '90802', '435-433-8825', '361-489-7395', '352038190', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (16, 'Richard Parr', '522 Palmer Road', 'Rye', 'Texas', '77369', '614-616-4317', '385-335-7163', 'P64613713', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (17, 'Jacob Parr', '3796 Wiseman Street', 'Knoxville', 'Tennessee', '37921', '865-406-4898', '802-782-1487', 'P99994179', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (18, 'Alison Rutherford', '3929 Seneca Drive', 'Tigard', 'Ore', '97223', '503-884-0013', '317-333-5021', '632672173', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (19, 'rdon MacDonald', '2364 Stutler Lane', 'Altoona', 'Pennsylvania', '16601', '814-394-3625', '571-282-5374', '934721544', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (20, 'Madeleine Wright', '4241 Carriage Lane', 'Saint Joseph', 'Illinois', '61873', '570-285-6830', '580-837-5138', '451512142', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (21, 'Piers Greene', '4105 Coburn Hollow Road', 'Normanna', 'Texas', '78142', '309-454-5556', '262-705-6970', 'P50942597', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (22, 'Anna Buckland', '1751 Dark Hollow Road', 'Madiso', 'Wisconsi', '53703', '608-976-0512', '361-216-4100', 'P99995845', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (23, 'Joan Lyma', '1762 Straford Park', 'Somerset', 'Kentucky', '42503', '606-602-9715', '478-588-3663', '236702439', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (24, 'Stephanie Brow', ' 4784 Foley Street', 'Fort Lauderdale', 'Florida', '33308', '954-714-9490', '228-337-3480', '935729128', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (25, 'Joe Lewis', '739 Green Street', 'Lavergne', 'Tennessee', '37086', '615-501-1996', '205-727-2847', '345840862', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (26, 'Lillian Parr', '4386 Lincoln Drive', 'Hummelstow', 'Pennsylvania', '17036', '717-566-7430', '312-545-6417', 'P61861217', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (27, 'Jacob Brow', '3151 Cherry Tree Drive', 'Ponte Vedra Beach', 'Florida', '32082', '904-280-0688', '530-898-1953', 'P99997954', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (28, 'Carl Ross', '1663 Keyser Ridge Road', 'Greensboro', 'North Carolina', '27401', '336-480-9155', '540-372-7949', '374092482', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (29, 'Leonard Quin', '3456 Flanigan Oaks Drive', 'Glen Carbo', 'Illinois', '62034', '301-319-8346', '315-894-9822', '926722790', '');
INSERT Dealer (DealerID, DealerName, Address, City, State, Zip, Phone, CellPhone, TaxID, Comment) VALUES (30, 'Nicola Mathis', '4721 Memory Lane', 'Chica', 'Illinois', '60631', '815-919-7935', '619-554-6721', '432808806', '');


INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (1, 1, 1);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (2, 1, 2);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (3, 1, 3);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (4, 1, 4);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (5, 1, 5);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (6, 1, 6);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (7, 1, 7);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (8, 1, 8);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (9, 1, 9);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (10, 1, 10);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (11, 16, 36);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (12, 16, 37);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (13, 16, 38);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (14, 16, 39);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (15, 16, 40);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (16, 16, 41);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (17, 16, 42);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (18, 16, 43);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (19, 16, 44);
INSERT DealerBooths (DealerBoothID, DealerID, BoothID) VALUES (20, 16, 45);


INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (1, 'Google Pixel 4a', CAST(309.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (2, 'Apple iPhone 8, 64GB', CAST(185.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (3, 'Moto G7 Plus ', CAST(122.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (4, 'Apple iPhone X, 64GB', CAST(339.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (5, 'Apple iPhone 8 Plus, 64GB', CAST(279.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (6, 'Samsung Galaxy S10, 128GB', CAST(324.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (7, 'BLU Studio Mini -5.5HD Smartphone', CAST(69.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (8, 'Samsung Galaxy S9, 64GB', CAST(209.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (9, 'Samsung Galaxy Note 10+, 256GB', CAST(395.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (10, 'Samsung Galaxy A31 64GB', CAST(199.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (11, 'Acer Nitro 5 Gaming Laptop', CAST(649.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (12, 'Acer Aspire 5 Slim Laptop', CAST(434.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (13, 'Acer Chromebook Spin 311', CAST(261.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (14, 'ASUS F512JA-AS34 VivoBook 15 Thi', CAST(454.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (15, '2020 Apple MacBook Pro with Apple M1 Chip', CAST(1011.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (16, 'SAMSUNG XE350XBA-K01US Chromebook 4', CAST(231.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (17, 'HP 15 Laptop, 11th Gen Intel Core i5-1135G7', CAST(699.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (18, 'Acer Predator Helios 300 Gaming Laptop', CAST(1349.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (19, 'Lenovo Chromebook Flex 5 ', CAST(398.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (20, 'Samsung Chromebook XE303C12-A01', CAST(144.00 AS Decimal(18, 2)));
INSERT ItemMaster (ItemID, ItemDescription, ItemPrice) VALUES (21, 'Dell Gaming G3 15 3500', CAST(818.00 AS Decimal(18, 2)));


INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 1, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 2, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 3, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 4, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 5, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 6, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 7, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 8, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 9, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 10, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 11, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 12, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 13, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 14, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 15, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 16, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 17, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 18, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 19, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 20, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (1, 21, CAST(10.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 1, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 2, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 3, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 4, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 5, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 6, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 7, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 8, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 9, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 10, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 11, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 12, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 13, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 14, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 15, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 16, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 17, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 18, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 19, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 20, CAST(20.00 AS Decimal(18, 2)));
INSERT Inventory (DealerID, ItemID, Quantity) VALUES (16, 21, CAST(20.00 AS Decimal(18, 2)));


INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (1, 1, CAST('2021-01-01T00:00:00.000' AS DateTime), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (2, 2, CAST('2021-01-02T00:00:00.000' AS DateTime), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (3, 3, CAST('2021-01-03T00:00:00.000' AS DateTime), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (4, 4, CAST('2021-01-04T00:00:00.000' AS DateTime), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (5, 5, CAST('2021-01-05T00:00:00.000' AS DateTime), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (6, 6, CAST('2021-01-06T00:00:00.000' AS DateTime), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (7, 7, CAST('2021-01-07T00:00:00.000' AS DateTime), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (8, 8, CAST('2021-01-08T00:00:00.000' AS DateTime), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (9, 9, CAST('2021-01-09T00:00:00.000' AS DateTime), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (10, 10, CAST('2021-01-10T00:00:00.000' AS DateTime), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (11, 11, CAST('2021-01-11T00:00:00.000' AS DateTime), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (12, 12, CAST('2021-01-12T00:00:00.000' AS DateTime), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (13, 13, CAST('2021-01-13T00:00:00.000' AS DateTime), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (14, 14, CAST('2021-01-14T00:00:00.000' AS DateTime), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (15, 15, CAST('2021-01-15T00:00:00.000' AS DateTime), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (16, 16, CAST('2021-01-16T00:00:00.000' AS DateTime), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (17, 17, CAST('2021-01-17T00:00:00.000' AS DateTime), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (18, 18, CAST('2021-01-18T00:00:00.000' AS DateTime), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (19, 19, CAST('2021-01-19T00:00:00.000' AS DateTime), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (20, 20, CAST('2021-01-20T00:00:00.000' AS DateTime), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (21, 1, CAST('2021-01-21T00:00:00.000' AS DateTime), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (22, 2, CAST('2021-01-22T00:00:00.000' AS DateTime), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (23, 3, CAST('2021-01-23T00:00:00.000' AS DateTime), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (24, 4, CAST('2021-01-24T00:00:00.000' AS DateTime), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (25, 5, CAST('2021-01-25T00:00:00.000' AS DateTime), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (26, 6, CAST('2021-01-26T00:00:00.000' AS DateTime), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (27, 7, CAST('2021-01-27T00:00:00.000' AS DateTime), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (28, 8, CAST('2021-01-28T00:00:00.000' AS DateTime), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (29, 9, CAST('2021-01-29T00:00:00.000' AS DateTime), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (30, 10, CAST('2021-01-30T00:00:00.000' AS DateTime), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (31, 11, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (32, 12, CAST('2021-02-01T00:00:00.000' AS DateTime), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (33, 13, CAST('2021-02-02T00:00:00.000' AS DateTime), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (34, 14, CAST('2021-02-03T00:00:00.000' AS DateTime), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (35, 15, CAST('2021-02-04T00:00:00.000' AS DateTime), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (36, 16, CAST('2021-02-05T00:00:00.000' AS DateTime), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (37, 17, CAST('2021-02-06T00:00:00.000' AS DateTime), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (38, 18, CAST('2021-02-07T00:00:00.000' AS DateTime), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (39, 19, CAST('2021-02-08T00:00:00.000' AS DateTime), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (40, 20, CAST('2021-02-09T00:00:00.000' AS DateTime), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (41, 1, CAST('2021-02-10T00:00:00.000' AS DateTime), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (42, 2, CAST('2021-02-11T00:00:00.000' AS DateTime), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (43, 3, CAST('2021-02-12T00:00:00.000' AS DateTime), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (44, 4, CAST('2021-02-13T00:00:00.000' AS DateTime), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (45, 5, CAST('2021-02-14T00:00:00.000' AS DateTime), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (46, 6, CAST('2021-02-15T00:00:00.000' AS DateTime), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (47, 7, CAST('2021-02-16T00:00:00.000' AS DateTime), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (48, 8, CAST('2021-02-17T00:00:00.000' AS DateTime), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (49, 9, CAST('2021-02-18T00:00:00.000' AS DateTime), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (50, 10, CAST('2021-02-19T00:00:00.000' AS DateTime), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (51, 11, CAST('2021-02-20T00:00:00.000' AS DateTime), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (52, 12, CAST('2021-02-21T00:00:00.000' AS DateTime), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (53, 13, CAST('2021-02-22T00:00:00.000' AS DateTime), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (54, 14, CAST('2021-02-23T00:00:00.000' AS DateTime), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (55, 15, CAST('2021-02-24T00:00:00.000' AS DateTime), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (56, 16, CAST('2021-02-25T00:00:00.000' AS DateTime), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (57, 17, CAST('2021-02-26T00:00:00.000' AS DateTime), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (58, 18, CAST('2021-02-27T00:00:00.000' AS DateTime), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (59, 19, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (60, 20, CAST('2021-01-01T00:00:00.000' AS DateTime), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (61, 1, CAST('2021-01-02T00:00:00.000' AS DateTime), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (62, 2, CAST('2021-01-03T00:00:00.000' AS DateTime), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (63, 3, CAST('2021-01-04T00:00:00.000' AS DateTime), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (64, 4, CAST('2021-01-05T00:00:00.000' AS DateTime), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (65, 5, CAST('2021-01-06T00:00:00.000' AS DateTime), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (66, 6, CAST('2021-01-07T00:00:00.000' AS DateTime), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (67, 7, CAST('2021-01-08T00:00:00.000' AS DateTime), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (68, 8, CAST('2021-01-09T00:00:00.000' AS DateTime), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (69, 9, CAST('2021-01-10T00:00:00.000' AS DateTime), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (70, 10, CAST('2021-01-11T00:00:00.000' AS DateTime), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (71, 11, CAST('2021-01-12T00:00:00.000' AS DateTime), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (72, 12, CAST('2021-01-13T00:00:00.000' AS DateTime), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (73, 13, CAST('2021-01-14T00:00:00.000' AS DateTime), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (74, 14, CAST('2021-01-15T00:00:00.000' AS DateTime), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (75, 15, CAST('2021-01-16T00:00:00.000' AS DateTime), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (76, 16, CAST('2021-01-17T00:00:00.000' AS DateTime), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (77, 17, CAST('2021-01-18T00:00:00.000' AS DateTime), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (78, 18, CAST('2021-01-19T00:00:00.000' AS DateTime), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (79, 10, CAST('2021-01-20T00:00:00.000' AS DateTime), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (80, 20, CAST('2021-01-21T00:00:00.000' AS DateTime), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (81, 1, CAST('2021-01-22T00:00:00.000' AS DateTime), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (82, 2, CAST('2021-01-23T00:00:00.000' AS DateTime), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (83, 3, CAST('2021-01-24T00:00:00.000' AS DateTime), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (84, 4, CAST('2021-01-25T00:00:00.000' AS DateTime), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (85, 5, CAST('2021-01-26T00:00:00.000' AS DateTime), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (86, 6, CAST('2021-01-27T00:00:00.000' AS DateTime), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (87, 7, CAST('2021-01-28T00:00:00.000' AS DateTime), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (88, 8, CAST('2021-01-29T00:00:00.000' AS DateTime), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (89, 9, CAST('2021-01-30T00:00:00.000' AS DateTime), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (90, 10, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (91, 11, CAST('2021-02-01T00:00:00.000' AS DateTime), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (92, 12, CAST('2021-02-02T00:00:00.000' AS DateTime), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (93, 13, CAST('2021-02-03T00:00:00.000' AS DateTime), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (94, 14, CAST('2021-02-04T00:00:00.000' AS DateTime), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (95, 15, CAST('2021-02-05T00:00:00.000' AS DateTime), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (96, 16, CAST('2021-02-06T00:00:00.000' AS DateTime), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (97, 17, CAST('2021-02-07T00:00:00.000' AS DateTime), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (98, 18, CAST('2021-02-08T00:00:00.000' AS DateTime), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (99, 19, CAST('2021-02-09T00:00:00.000' AS DateTime), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (100, 20, CAST('2021-02-10T00:00:00.000' AS DateTime), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (101, 1, CAST('2021-02-11T00:00:00.000' AS DateTime), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (102, 2, CAST('2021-02-12T00:00:00.000' AS DateTime), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (103, 3, CAST('2021-02-13T00:00:00.000' AS DateTime), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (104, 4, CAST('2021-02-14T00:00:00.000' AS DateTime), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (105, 5, CAST('2021-02-15T00:00:00.000' AS DateTime), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (106, 6, CAST('2021-02-16T00:00:00.000' AS DateTime), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (107, 7, CAST('2021-02-17T00:00:00.000' AS DateTime), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (108, 8, CAST('2021-02-18T00:00:00.000' AS DateTime), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (109, 9, CAST('2021-02-19T00:00:00.000' AS DateTime), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (110, 10, CAST('2021-02-20T00:00:00.000' AS DateTime), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (111, 11, CAST('2021-02-21T00:00:00.000' AS DateTime), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (112, 12, CAST('2021-02-22T00:00:00.000' AS DateTime), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (113, 13, CAST('2021-02-23T00:00:00.000' AS DateTime), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (114, 14, CAST('2021-02-24T00:00:00.000' AS DateTime), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (115, 15, CAST('2021-02-25T00:00:00.000' AS DateTime), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (116, 16, CAST('2021-02-26T00:00:00.000' AS DateTime), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (117, 17, CAST('2021-02-27T00:00:00.000' AS DateTime), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleHeader (SaleID, DealerBoothID, SaleDate, SaleAmount) VALUES (118, 18, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(261.00 AS Decimal(18, 2)));


INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (1, 1, CAST(1.00 AS Decimal(18, 2)), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (2, 2, CAST(1.00 AS Decimal(18, 2)), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (3, 3, CAST(1.00 AS Decimal(18, 2)), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (4, 4, CAST(1.00 AS Decimal(18, 2)), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (5, 5, CAST(1.00 AS Decimal(18, 2)), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (6, 6, CAST(1.00 AS Decimal(18, 2)), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (7, 7, CAST(1.00 AS Decimal(18, 2)), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (8, 8, CAST(1.00 AS Decimal(18, 2)), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (9, 9, CAST(1.00 AS Decimal(18, 2)), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (10, 10, CAST(1.00 AS Decimal(18, 2)), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (11, 11, CAST(1.00 AS Decimal(18, 2)), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (12, 12, CAST(1.00 AS Decimal(18, 2)), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (13, 13, CAST(1.00 AS Decimal(18, 2)), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (14, 14, CAST(1.00 AS Decimal(18, 2)), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (15, 15, CAST(1.00 AS Decimal(18, 2)), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (16, 16, CAST(1.00 AS Decimal(18, 2)), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (17, 17, CAST(1.00 AS Decimal(18, 2)), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (18, 18, CAST(1.00 AS Decimal(18, 2)), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (19, 19, CAST(1.00 AS Decimal(18, 2)), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (20, 20, CAST(1.00 AS Decimal(18, 2)), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (21, 21, CAST(1.00 AS Decimal(18, 2)), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (22, 1, CAST(1.00 AS Decimal(18, 2)), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (23, 2, CAST(1.00 AS Decimal(18, 2)), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (24, 3, CAST(1.00 AS Decimal(18, 2)), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (25, 4, CAST(1.00 AS Decimal(18, 2)), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (26, 5, CAST(1.00 AS Decimal(18, 2)), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (27, 6, CAST(1.00 AS Decimal(18, 2)), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (28, 7, CAST(1.00 AS Decimal(18, 2)), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (29, 8, CAST(1.00 AS Decimal(18, 2)), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (30, 9, CAST(1.00 AS Decimal(18, 2)), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (31, 10, CAST(1.00 AS Decimal(18, 2)), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (32, 11, CAST(1.00 AS Decimal(18, 2)), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (33, 12, CAST(1.00 AS Decimal(18, 2)), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (34, 13, CAST(1.00 AS Decimal(18, 2)), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (35, 14, CAST(1.00 AS Decimal(18, 2)), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (36, 15, CAST(1.00 AS Decimal(18, 2)), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (37, 16, CAST(1.00 AS Decimal(18, 2)), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (38, 17, CAST(1.00 AS Decimal(18, 2)), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (39, 18, CAST(1.00 AS Decimal(18, 2)), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (40, 19, CAST(1.00 AS Decimal(18, 2)), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (41, 20, CAST(1.00 AS Decimal(18, 2)), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (42, 21, CAST(1.00 AS Decimal(18, 2)), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (43, 1, CAST(1.00 AS Decimal(18, 2)), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (44, 2, CAST(1.00 AS Decimal(18, 2)), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (45, 3, CAST(1.00 AS Decimal(18, 2)), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (46, 4, CAST(1.00 AS Decimal(18, 2)), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (47, 5, CAST(1.00 AS Decimal(18, 2)), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (48, 6, CAST(1.00 AS Decimal(18, 2)), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (49, 7, CAST(1.00 AS Decimal(18, 2)), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (50, 8, CAST(1.00 AS Decimal(18, 2)), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (51, 9, CAST(1.00 AS Decimal(18, 2)), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (52, 10, CAST(1.00 AS Decimal(18, 2)), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (53, 11, CAST(1.00 AS Decimal(18, 2)), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (54, 12, CAST(1.00 AS Decimal(18, 2)), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (55, 13, CAST(1.00 AS Decimal(18, 2)), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (56, 14, CAST(1.00 AS Decimal(18, 2)), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (57, 15, CAST(1.00 AS Decimal(18, 2)), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (58, 16, CAST(1.00 AS Decimal(18, 2)), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (59, 17, CAST(1.00 AS Decimal(18, 2)), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (60, 18, CAST(1.00 AS Decimal(18, 2)), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (61, 19, CAST(1.00 AS Decimal(18, 2)), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (62, 20, CAST(1.00 AS Decimal(18, 2)), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (63, 21, CAST(1.00 AS Decimal(18, 2)), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (64, 1, CAST(1.00 AS Decimal(18, 2)), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (65, 2, CAST(1.00 AS Decimal(18, 2)), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (66, 3, CAST(1.00 AS Decimal(18, 2)), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (67, 4, CAST(1.00 AS Decimal(18, 2)), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (68, 5, CAST(1.00 AS Decimal(18, 2)), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (69, 6, CAST(1.00 AS Decimal(18, 2)), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (70, 7, CAST(1.00 AS Decimal(18, 2)), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (71, 8, CAST(1.00 AS Decimal(18, 2)), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (72, 9, CAST(1.00 AS Decimal(18, 2)), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (73, 10, CAST(1.00 AS Decimal(18, 2)), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (74, 11, CAST(1.00 AS Decimal(18, 2)), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (75, 12, CAST(1.00 AS Decimal(18, 2)), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (76, 13, CAST(1.00 AS Decimal(18, 2)), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (77, 14, CAST(1.00 AS Decimal(18, 2)), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (78, 15, CAST(1.00 AS Decimal(18, 2)), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (79, 16, CAST(1.00 AS Decimal(18, 2)), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (80, 17, CAST(1.00 AS Decimal(18, 2)), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (81, 18, CAST(1.00 AS Decimal(18, 2)), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (82, 19, CAST(1.00 AS Decimal(18, 2)), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (83, 20, CAST(1.00 AS Decimal(18, 2)), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (84, 21, CAST(1.00 AS Decimal(18, 2)), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (85, 1, CAST(1.00 AS Decimal(18, 2)), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (86, 2, CAST(1.00 AS Decimal(18, 2)), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (87, 3, CAST(1.00 AS Decimal(18, 2)), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (88, 4, CAST(1.00 AS Decimal(18, 2)), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (89, 5, CAST(1.00 AS Decimal(18, 2)), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (90, 6, CAST(1.00 AS Decimal(18, 2)), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (91, 7, CAST(1.00 AS Decimal(18, 2)), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (92, 8, CAST(1.00 AS Decimal(18, 2)), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (93, 9, CAST(1.00 AS Decimal(18, 2)), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (94, 10, CAST(1.00 AS Decimal(18, 2)), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (95, 11, CAST(1.00 AS Decimal(18, 2)), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (96, 12, CAST(1.00 AS Decimal(18, 2)), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (97, 13, CAST(1.00 AS Decimal(18, 2)), CAST(261.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (98, 14, CAST(1.00 AS Decimal(18, 2)), CAST(454.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (99, 15, CAST(1.00 AS Decimal(18, 2)), CAST(1011.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (100, 16, CAST(1.00 AS Decimal(18, 2)), CAST(231.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (101, 17, CAST(1.00 AS Decimal(18, 2)), CAST(699.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (102, 18, CAST(1.00 AS Decimal(18, 2)), CAST(1349.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (103, 19, CAST(1.00 AS Decimal(18, 2)), CAST(398.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (104, 20, CAST(1.00 AS Decimal(18, 2)), CAST(144.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (105, 21, CAST(1.00 AS Decimal(18, 2)), CAST(818.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (106, 1, CAST(1.00 AS Decimal(18, 2)), CAST(309.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (107, 2, CAST(1.00 AS Decimal(18, 2)), CAST(185.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (108, 3, CAST(1.00 AS Decimal(18, 2)), CAST(122.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (109, 4, CAST(1.00 AS Decimal(18, 2)), CAST(339.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (110, 5, CAST(1.00 AS Decimal(18, 2)), CAST(279.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (111, 6, CAST(1.00 AS Decimal(18, 2)), CAST(324.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (112, 7, CAST(1.00 AS Decimal(18, 2)), CAST(69.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (113, 8, CAST(1.00 AS Decimal(18, 2)), CAST(209.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (114, 9, CAST(1.00 AS Decimal(18, 2)), CAST(395.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (115, 10, CAST(1.00 AS Decimal(18, 2)), CAST(199.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (116, 11, CAST(1.00 AS Decimal(18, 2)), CAST(649.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (117, 12, CAST(1.00 AS Decimal(18, 2)), CAST(434.00 AS Decimal(18, 2)));
INSERT SaleDetail (SaleID, ItemID, Quantity, Amount) VALUES (118, 13, CAST(1.00 AS Decimal(18, 2)), CAST(261.00 AS Decimal(18, 2)));



INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (1, 1, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(2874.00 AS Decimal(18, 2)), CAST(310.00 AS Decimal(18, 2)), CAST(287.40 AS Decimal(18, 2)), CAST(2276.60 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (2, 2, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1036.00 AS Decimal(18, 2)), CAST(310.00 AS Decimal(18, 2)), CAST(103.60 AS Decimal(18, 2)), CAST(622.40 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (3, 3, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1269.00 AS Decimal(18, 2)), CAST(290.00 AS Decimal(18, 2)), CAST(126.90 AS Decimal(18, 2)), CAST(852.10 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (4, 4, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1588.00 AS Decimal(18, 2)), CAST(290.00 AS Decimal(18, 2)), CAST(158.80 AS Decimal(18, 2)), CAST(1139.20 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (5, 5, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1112.00 AS Decimal(18, 2)), CAST(290.00 AS Decimal(18, 2)), CAST(111.20 AS Decimal(18, 2)), CAST(710.80 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (6, 6, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(910.00 AS Decimal(18, 2)), CAST(310.00 AS Decimal(18, 2)), CAST(91.00 AS Decimal(18, 2)), CAST(509.00 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (7, 7, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(854.00 AS Decimal(18, 2)), CAST(290.00 AS Decimal(18, 2)), CAST(85.40 AS Decimal(18, 2)), CAST(478.60 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (8, 8, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(896.00 AS Decimal(18, 2)), CAST(230.00 AS Decimal(18, 2)), CAST(89.60 AS Decimal(18, 2)), CAST(576.40 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (9, 9, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1207.00 AS Decimal(18, 2)), CAST(230.00 AS Decimal(18, 2)), CAST(120.70 AS Decimal(18, 2)), CAST(856.30 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (10, 10, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1218.00 AS Decimal(18, 2)), CAST(230.00 AS Decimal(18, 2)), CAST(121.80 AS Decimal(18, 2)), CAST(866.20 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (11, 11, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1057.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(105.70 AS Decimal(18, 2)), CAST(861.30 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (12, 12, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(829.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(82.90 AS Decimal(18, 2)), CAST(656.10 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (13, 13, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(460.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(46.00 AS Decimal(18, 2)), CAST(324.00 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (14, 14, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1103.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(110.30 AS Decimal(18, 2)), CAST(902.70 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (15, 15, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1445.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(144.50 AS Decimal(18, 2)), CAST(1210.50 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (16, 16, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(492.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(49.20 AS Decimal(18, 2)), CAST(352.80 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (17, 17, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(1153.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(115.30 AS Decimal(18, 2)), CAST(947.70 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (18, 18, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(2360.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(236.00 AS Decimal(18, 2)), CAST(2034.00 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (19, 19, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(398.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(39.80 AS Decimal(18, 2)), CAST(268.20 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (20, 20, CAST('2021-01-31T00:00:00.000' AS DateTime), CAST(2192.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(219.20 AS Decimal(18, 2)), CAST(1882.80 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (21, 1, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(843.00 AS Decimal(18, 2)), CAST(310.00 AS Decimal(18, 2)), CAST(84.30 AS Decimal(18, 2)), CAST(448.70 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (22, 2, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(2167.00 AS Decimal(18, 2)), CAST(310.00 AS Decimal(18, 2)), CAST(216.70 AS Decimal(18, 2)), CAST(1640.30 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (23, 3, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(707.00 AS Decimal(18, 2)), CAST(290.00 AS Decimal(18, 2)), CAST(70.70 AS Decimal(18, 2)), CAST(346.30 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (24, 4, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(329.00 AS Decimal(18, 2)), CAST(290.00 AS Decimal(18, 2)), CAST(32.90 AS Decimal(18, 2)), CAST(6.10 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (25, 5, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(940.00 AS Decimal(18, 2)), CAST(290.00 AS Decimal(18, 2)), CAST(94.00 AS Decimal(18, 2)), CAST(556.00 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (26, 6, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(648.00 AS Decimal(18, 2)), CAST(310.00 AS Decimal(18, 2)), CAST(64.80 AS Decimal(18, 2)), CAST(273.20 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (27, 7, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(464.00 AS Decimal(18, 2)), CAST(290.00 AS Decimal(18, 2)), CAST(46.40 AS Decimal(18, 2)), CAST(127.60 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (28, 8, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(446.00 AS Decimal(18, 2)), CAST(230.00 AS Decimal(18, 2)), CAST(44.60 AS Decimal(18, 2)), CAST(171.40 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (29, 9, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(408.00 AS Decimal(18, 2)), CAST(230.00 AS Decimal(18, 2)), CAST(40.80 AS Decimal(18, 2)), CAST(137.20 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (30, 10, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(488.00 AS Decimal(18, 2)), CAST(230.00 AS Decimal(18, 2)), CAST(48.80 AS Decimal(18, 2)), CAST(209.20 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (31, 11, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(788.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(78.80 AS Decimal(18, 2)), CAST(619.20 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (32, 12, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(1126.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(112.60 AS Decimal(18, 2)), CAST(923.40 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (33, 13, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(1687.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(168.70 AS Decimal(18, 2)), CAST(1428.30 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (34, 14, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(1289.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(128.90 AS Decimal(18, 2)), CAST(1070.10 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (35, 15, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(1563.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(156.30 AS Decimal(18, 2)), CAST(1316.70 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (36, 16, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(2548.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(254.80 AS Decimal(18, 2)), CAST(2203.20 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (37, 17, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(1937.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(193.70 AS Decimal(18, 2)), CAST(1653.30 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (38, 18, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(1645.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(164.50 AS Decimal(18, 2)), CAST(1390.50 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (39, 19, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(3059.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(305.90 AS Decimal(18, 2)), CAST(2663.10 AS Decimal(18, 2)));
INSERT Rent (RentID, DealerBoothID, Date, TotalSale, RentAmount, Commisson, PaymentAmount) VALUES (40, 20, CAST('2021-02-28T00:00:00.000' AS DateTime), CAST(629.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), CAST(62.90 AS Decimal(18, 2)), CAST(476.10 AS Decimal(18, 2)));


