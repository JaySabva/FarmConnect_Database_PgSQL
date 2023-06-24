-------------------------------------------------------------------------------------------------
--                      Data Definition Language Script -- FarmConnect G7                      --  
-------------------------------------------------------------------------------------------------

--Loaction(LocationID, District, State, RelativeDistance)
CREATE TABLE LOCATION (
	LocationID BIGINT PRIMARY KEY,
	District VARCHAR(50) NOT NULL,
	"State" VARCHAR(50) NOT NULL,
	RelativeDistance BIGINT NOT NULL
);

--Farmer(FarmerID, Name, FarmingType, City, LocationID, Rating)
CREATE TABLE FARMER (
	FarmerID BIGINT PRIMARY KEY,
	"Name" VARCHAR(50) NOT NULL,
	FarmingType VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
	LocationID BIGINT NOT NULL,
	Rating FLOAT(2),
    FOREIGN KEY (LocationID) REFERENCES LOCATION(LocationID) ON UPDATE CASCADE ON DELETE CASCADE
);

--FarmerEmail(FarmerID, EmailID)
CREATE TABLE FARMER_EMAIL (
	FarmerID BIGINT,
	EmailID VARCHAR,
	PRIMARY KEY(FarmerID, EmailID),
	FOREIGN KEY (FarmerID) REFERENCES FARMER(FarmerID) ON UPDATE CASCADE ON DELETE CASCADE
);

--FarmerPhone(FarmerID, PhoneNo)
CREATE TABLE FARMER_PHONENO (
	FarmerID BIGINT,
	PhoneNo BIGINT,
	PRIMARY KEY(FarmerID, PhoneNo),
	FOREIGN KEY (FarmerID) REFERENCES FARMER(FarmerID) ON UPDATE CASCADE ON DELETE CASCADE
);

--Buyer(BuyerID, Name, BuyerType, City, LocationID)
CREATE TABLE BUYER (
	BuyerID BIGINT PRIMARY KEY,
	"Name" VARCHAR(50) NOT NULL,
	BuyerType VARCHAR(50) NOT NULL,
	City VARCHAR(50),
	LocationID BIGINT NOT NULL
);

--BuyerEmail(BuyerID, EmailID)
CREATE TABLE BUYER_EMAIL (
	BuyerID BIGINT,
	EmailID VARCHAR,
	PRIMARY KEY(BuyerID, EmailID),
	FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID) ON UPDATE CASCADE ON DELETE CASCADE
);

--BuyerPhone(BuyerID, PhoneNo)
CREATE TABLE BUYER_PHONENO (
	BuyerID BIGINT,
	PhoneNo BIGINT,
	PRIMARY KEY(BuyerID, PhoneNo),
	FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID) ON UPDATE CASCADE ON DELETE CASCADE
);

--Crop(CropID, CropName, CropCategory, ShelfLife)
CREATE TABLE CROP (
	CropID BIGINT PRIMARY KEY,
	CropName VARCHAR(20) NOT NULL,
	CropCategory VARCHAR(20) NOT NULL,
	ShelfLife VARCHAR(20) NOT NULL
);

--Market(FarmerID, CropID, HarvestTime, Quantity, Start_Price, Status)
CREATE TABLE MARKET (
	FarmerID BIGINT,
	CropID BIGINT,
	HarvestTime DATE,
	Quantity FLOAT(2) NOT NULL,
	Start_Price FLOAT(2) NOT NULL,
	Status VARCHAR(20) NOT NULL,
	PRIMARY KEY (FarmerID, CropID, HarvestTime),
	FOREIGN KEY (FarmerID) REFERENCES Farmer(FarmerID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (CropID) REFERENCES Crop(CropID) ON UPDATE CASCADE ON DELETE CASCADE
);

--Bid(BidID, BuyerID, FarmerID, CropID, BidAmount, BidTime, BidStatus, HarvestTime)
CREATE TABLE BID (
	BidID BIGINT PRIMARY KEY,
	BuyerID BIGINT NOT NULL,
	FarmerID BIGINT NOT NULL,
	CropID BIGINT NOT NULL,
	BidAmount FLOAT(2) NOT NULL,
	BidTime TIMESTAMP NOT NULL,
	BidStatus VARCHAR(20) NOT NULL,
	HarvestTime DATE NOT NULL,
	FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (FarmerID, CropID, HarvestTime) REFERENCES MARKET(FarmerID, CropID, HarvestTime) ON UPDATE CASCADE ON DELETE CASCADE
);

--Transaction(TransactionID, BidID, TotalPayableCharges, PaymentMethod, PaymentStatus, TransTime)
CREATE TABLE TRANSACTION (
    TransactionID BIGINT PRIMARY KEY,
    BidID BIGINT NOT NULL,
    TotalPayableCharges FLOAT(2),
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL,
	TransTime TIMESTAMP NOT NULL,
    FOREIGN KEY (BidID) REFERENCES Bid(BidID) ON UPDATE CASCADE ON DELETE CASCADE
);

--CropRequested(BuyerID, CropID, QtyRequired, Aprice, Status, RequestTime)
CREATE TABLE CROPREQUESTED (
    BuyerID INT NOT NULL,
    CropID INT NOT NULL,
    FarmerID INT,
    QtyRequired INT NOT NULL,
    APrice FLOAT(2) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    ReqTime TIMESTAMP NOT NULL,
    PRIMARY KEY (BuyerID, CropID, ReqTime),
    FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (CropID) REFERENCES Crop(CropID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (FarmerID) REFERENCES Farmer(FarmerID) ON UPDATE CASCADE ON DELETE CASCADE
);