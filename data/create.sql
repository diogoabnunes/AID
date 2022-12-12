PRAGMA foreign_keys=ON;
PRAGMA enconding="UTF-8";

DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Market;
DROP TABLE IF EXISTS Contract;
DROP TABLE IF EXISTS Order;
DROP TABLE IF EXISTS Deal;

CREATE TABLE "User" (
    UserID int PRIMARY KEY ,
    Name VARCHAR(200)  NOT NULL ,
    Address VARCHAR(200)  NOT NULL ,
    PostalCode VARCHAR(200)  NOT NULL ,
    City VARCHAR(200)  NOT NULL ,
    BirthDate date  NOT NULL ,
    Age int  NOT NULL ,
    Phone VARCHAR(200)  NOT NULL ,
    Country VARCHAR(200)  NOT NULL ,
    -- Depending on having a Deal or not
    Active boolean  NOT NULL ,
    -- Depending on being excluded or not
    Excluded boolean  NOT NULL
);

CREATE TABLE "Event" (
    EventID int  PRIMARY KEY ,
    -- Ex.: Porto - Sporting
    Name VARCHAR(200)  NOT NULL ,
    Date date  NOT NULL ,
    -- Ex.: Football
    Category VARCHAR(200)  NOT NULL ,
    Active boolean  NOT NULL ,
    Result VARCHAR(200) NOT NULL
);

CREATE TABLE "Market" (
    MarketID int  PRIMARY KEY ,
    -- Correct Score, Match Winner, ...
    Type VARCHAR(200)  NOT NULL ,
    EventID int REFERENCES "Event"(EventID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "Contract" (
    ContractID int PRIMARY KEY ,
    -- Home, Away, Draw
    Description VARCHAR(200)  NOT NULL ,
    MarketID int REFERENCES Market(MarketID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "Order" (
    OrderID int  PRIMARY KEY ,
    UserID int  REFERENCES "User"(UserID) ON DELETE CASCADE ON UPDATE CASCADE ,
    ContractID int  REFERENCES Contract(ContractID) ON DELETE CASCADE ON UPDATE CASCADE ,
    -- Value already betted (already in some Deal)
    InitialValue int  NOT NULL ,
    -- Current value available
    CurrentValue int  NOT NULL ,
    -- Won, Lost, Pending
    Status VARCHAR(200)  NOT NULL 
);

CREATE TABLE "Deal" (
    OrderBuy int  NOT NULL ,
    OrderSell int  NOT NULL ,
    -- Maximum amount between the 2 Bets "matched"
    Value int  NOT NULL ,
    Date date  NOT NULL 
);

ALTER TABLE "Market" ADD CONSTRAINT fk_Market_EventID FOREIGN KEY(EventID)
REFERENCES "Event" (EventID);

ALTER TABLE "Contract" ADD CONSTRAINT fk_Contract_MarketID FOREIGN KEY(MarketID)
REFERENCES "Market" (MarketID);

ALTER TABLE "Order" ADD CONSTRAINT fk_Order_UserID FOREIGN KEY(UserID)
REFERENCES "User" (UserID);

ALTER TABLE "Order" ADD CONSTRAINT fk_Order_ContractID FOREIGN KEY(ContractID)
REFERENCES "Contract" (ContractID);

ALTER TABLE "Deal" ADD CONSTRAINT fk_Deal_OrderBuy FOREIGN KEY(OrderBuy)
REFERENCES "Order" (OrderID);

ALTER TABLE "Deal" ADD CONSTRAINT fk_Deal_OrderSell FOREIGN KEY(OrderSell)
REFERENCES "Order" (OrderID);

CREATE INDEX idx_User_Name
ON "User" (Name);

