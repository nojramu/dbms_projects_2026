CREATE TABLE Vendors (
    VendorID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(100) NOT NULL UNIQUE,
    ContactEmail VARCHAR(100),
    Website VARCHAR(255)
);
Describe Vendors;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);
Describe Categories;

CREATE TABLE Components (
    ComponentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(150) NOT NULL,
    Specs TEXT,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
Describe Components;

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    ComponentID INT,
    VendorID INT,
    QuantityInStock INT DEFAULT 0,
    UnitCost INT,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ComponentID) REFERENCES Components(ComponentID),
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID),
    UNIQUE KEY unique_component_vendor (ComponentID, VendorID)
);
Describe Inventory;

CREATE TABLE Builds (
    BuildID INT PRIMARY KEY AUTO_INCREMENT,
    BuildName VARCHAR(100) UNIQUE,
    CreationDate DATE
);
Describe Builds;

CREATE TABLE Build_Components (
    BuildDetailID INT PRIMARY KEY AUTO_INCREMENT,
    BuildID INT,
    ComponentID INT,
    QuantityUsed INT DEFAULT 1,
    FOREIGN KEY (BuildID) REFERENCES Builds(BuildID),
    FOREIGN KEY (ComponentID) REFERENCES Components(ComponentID),
    UNIQUE KEY unique_build_part (BuildID, ComponentID)
);
Describe Build_Components;
