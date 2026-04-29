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

INSERT INTO Vendors (CompanyName, ContactEmail) VALUES 
('SiliconSource', 'sales@siliconsource.com'),
('TechMega', 'procurement@techmega.com'),
('GigaTech Supplies', 'b2b@gigatech.com'),
('PowerHouse Components', 'orders@powerhouse.net'),
('Cooling Direct', 'wholesale@coolingdirect.com');
SELECT * FROM Vendors;

INSERT INTO Categories (CategoryName) VALUES 
('Processor'), ('Memory'), ('Storage'), ('Motherboard'), 
('Graphics Card'), ('Power Supply'), ('Case'), ('Cooling');
SELECT * FROM Categories;

INSERT INTO Components (Name, Specs, CategoryID) VALUES 
('Intel Core i9-14900K', '24 Cores, Up to 6.0 GHz', 1),
('Corsair 32GB DDR5', '5600MHz, CL40', 2),
('Samsung 990 Pro 2TB', 'NVMe PCIe 4.0', 3),
('AMD Ryzen 9 7950X3D', '16 Cores, Up to 5.7 GHz', 1),
('WD Black SN850X 4TB', 'NVMe PCIe 4.0, 7300 MB/s', 3),
('ASUS ROG Maximus Z790', 'ATX, LGA 1700, DDR5', 4),
('MSI MAG B650 Tomahawk', 'ATX, AM5, DDR5', 4),
('NVIDIA GeForce RTX 4090', '24GB GDDR6X', 5),
('AMD Radeon RX 7900 XTX', '24GB GDDR6', 5),
('Corsair RM1000x', '1000W, 80+ Gold', 6),
('Lian Li O11 Dynamic EVO', 'Mid-Tower, Dual Chamber', 7),
('NZXT Kraken Elite 360', '360mm AIO Liquid Cooler', 8),
('Intel Core i7-14700K', '20 Cores, Up to 5.6 GHz', 1),
('AMD Ryzen 7 7800X3D', '8 Cores, Up to 5.0 GHz', 1),
('G.Skill Trident Z5 64GB', '6000MHz, CL30', 2),
('Kingston Fury 16GB DDR4', '3200MHz, CL16', 2),
('Crucial P3 Plus 1TB', 'NVMe PCIe 4.0', 3),
('Seagate IronWolf 8TB', '7200 RPM SATA HDD', 3),
('Gigabyte X670E AORUS', 'E-ATX, AM5, PCIe 5.0', 4),
('ASRock B760M Pro RS', 'Micro-ATX, LGA 1700', 4),
('NVIDIA GeForce RTX 4070 Ti', '12GB GDDR6X', 5),
('AMD Radeon RX 7600', '8GB GDDR6', 5),
('EVGA SuperNOVA 850W', '850W, 80+ Gold', 6),
('Seasonic Focus GX-750', '750W, 80+ Gold', 6),
('Fractal Design North', 'Mid-Tower, Wood Front', 7),
('Corsair 4000D Airflow', 'Mid-Tower, High Airflow', 7),
('Noctua NH-D15', 'Dual-Tower CPU Cooler', 8),
('Arctic Liquid Freezer II', '280mm AIO Cooler', 8),
('Intel Core i5-13400F', '10 Cores, Up to 4.6 GHz', 1),
('NVIDIA GeForce RTX 4060', '8GB GDDR6', 5);
SELECT * FROM Components;

INSERT INTO Inventory (ComponentID, VendorID, QuantityInStock, UnitCost) VALUES 
(1, 1, 15, 35810),
(2, 2, 100, 7010),
(3, 1, 40, 10320),
(4, 3, 25, 36360),
(5, 1, 60, 18210),
(6, 3, 10, 38240),
(7, 3, 30, 13350),
(8, 2, 5, 97120),
(9, 4, 12, 60670),
(10, 4, 45, 11530),
(11, 2, 20, 9100),
(12, 5, 18, 17000),
(13, 1, 35, 24280),
(14, 3, 40, 23610),
(15, 2, 25, 12750),
(16, 2, 150, 2730),
(17, 1, 80, 4010),
(18, 4, 30, 11470),
(19, 3, 15, 18210),
(20, 1, 50, 7890),
(21, 2, 20, 48560),
(22, 4, 45, 16390),
(23, 4, 30, 8500),
(24, 4, 40, 6680),
(25, 2, 25, 8500),
(26, 2, 60, 6370),
(27, 5, 35, 7280),
(28, 5, 20, 6680),
(29, 1, 75, 12750),
(30, 2, 55, 18210);
SELECT * FROM Inventory;

INSERT INTO Builds (BuildName, CreationDate) VALUES 
('CAD Workstation Alpha', '2026-04-01'),
('Gaming Rig Omega', '2026-04-02'),
('Office Standard V1', '2026-04-03'),
('Video Editor Pro', '2026-04-04'),
('Budget Gamer X', '2026-04-05'),
('Streamer Setup 1', '2026-04-06'),
('Data Science Node', '2026-04-07'),
('Home Server NAS', '2026-04-08'),
('VR Ready Build', '2026-04-09'),
('Student Laptop Alternative', '2026-04-10'),
('Reception Desk PC', '2026-04-11'),
('Design Studio Mac Killer', '2026-04-12'),
('Esports Tournament Rig', '2026-04-13'),
('Silent PC Build', '2026-04-14'),
('RGB Showcase System', '2026-04-15'),
('Developer Workstation', '2026-04-16'),
('Machine Learning Rig', '2026-04-17'),
('Living Room HTPC', '2026-04-18'),
('Crypto Mining Testbench', '2026-04-19'),
('Architecture Render Node', '2026-04-20'),
('Music Production Studio', '2026-04-21'),
('Stock Trading Terminal', '2026-04-22'),
('Flight Sim Cockpit PC', '2026-04-23'),
('Kiosk Information System', '2026-04-24'),
('Point Of Sale Unit', '2026-04-25'),
('IT Admin Console', '2026-04-26'),
('Security Camera NVR', '2026-04-27'),
('Podcast Recording PC', '2026-04-28'),
('Guest Room PC', '2026-04-29'),
('Warehouse Inventory Terminal', '2026-04-30');
SELECT * FROM Builds;

INSERT INTO Build_Components (BuildID, ComponentID, QuantityUsed) VALUES 
(1, 1, 1),   
(2, 8, 1),   
(3, 20, 1),
(4, 5, 2),
(5, 30, 1),
(6, 14, 1),
(7, 15, 2),
(8, 18, 4),
(9, 21, 1),
(10, 29, 1),
(11, 16, 1),
(12, 4, 1),
(13, 9, 1),
(14, 27, 1),
(15, 11, 1),
(16, 6, 1),
(17, 10, 1),
(18, 25, 1),
(19, 23, 2),
(20, 19, 1),
(21, 3, 2), 
(22, 7, 1), 
(23, 12, 1),
(24, 17, 1),
(25, 26, 1),
(26, 2, 1),
(27, 24, 1), 
(28, 13, 1),
(29, 22, 1),
(30, 28, 1);

SELECT BuildName, CreationDate FROM Builds
WHERE BuildID = 29;

INSERT INTO Categories (CategoryName) 
VALUES ('Operating System');

INSERT INTO Components (Name, Specs, CategoryID) 
VALUES ('Windows 11 Pro', '64-bit, OEM License', LAST_INSERT_ID());

INSERT INTO Inventory (ComponentID, VendorID, QuantityInStock, UnitCost) 
VALUES (LAST_INSERT_ID(), 1, 100, 8500);

INSERT INTO Builds (BuildName, CreationDate) 
VALUES ('Pro Workstation 2026', CURDATE());

INSERT INTO Build_Components (BuildID, ComponentID, QuantityUsed) 
VALUES (
    LAST_INSERT_ID(), 
    (SELECT ComponentID FROM Components WHERE Name = 'Windows 11 Pro' LIMIT 1), 
    1
);
SELECT Name, ComponentID, Specs, CategoryID FROM Components
WHERE Name = 'Windows 11 Pro';

UPDATE

UPDATE Inventory
SET UnitCost = UnitCost * 1.05
WHERE ComponentID IN (
    SELECT ComponentID 
    FROM Components 
    WHERE CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName = 'Processor')
);

SELECT 
    C.Name AS ComponentName, 
    I.UnitCost, 
    CAT.CategoryName
FROM Components C
JOIN Inventory I ON C.ComponentID = I.ComponentID
JOIN Categories CAT ON C.CategoryID = CAT.CategoryID
WHERE CAT.CategoryName = 'Processor';

DELETE

DELETE FROM Build_Components 
WHERE BuildID = (SELECT BuildID FROM Builds WHERE BuildName = 'Budget Gamer X');
SELECT * FROM Build_Components;

SELECT B.BuildName, C.Name AS ComponentName, CAT.CategoryName, BC.QuantityUsed
FROM Builds B
JOIN Build_Components BC ON B.BuildID = BC.BuildID
JOIN Components C ON BC.ComponentID = C.ComponentID
JOIN Categories CAT ON C.CategoryID = CAT.CategoryID;

SELECT C.Name, V.CompanyName, I.QuantityInStock, I.UnitCost
FROM Inventory I
JOIN Components C ON I.ComponentID = C.ComponentID
JOIN Vendors V ON I.VendorID = V.VendorID;

SELECT CAT.CategoryName, C.Name, C.Specs
FROM Categories CAT
JOIN Components C ON CAT.CategoryID = C.CategoryID
ORDER BY CAT.CategoryName;

SELECT 
    C.Name AS ComponentName, 
    I.UnitCost, 
    CAT.CategoryName
FROM Components C
JOIN Inventory I ON C.ComponentID = I.ComponentID
JOIN Categories CAT ON C.CategoryID = CAT.CategoryID
WHERE CAT.CategoryName = 'Processor';

SELECT ComponentID, UnitCost 
FROM Inventory 
WHERE UnitCost > (SELECT AVG(UnitCost) FROM Inventory);

SELECT Name 
FROM Components 
WHERE ComponentID NOT IN (SELECT ComponentID FROM Build_Components);

SELECT CompanyName 
FROM Vendors 
WHERE VendorID IN (
    SELECT VendorID 
    FROM Inventory 
    WHERE QuantityInStock < 10
);

SELECT CAT.CategoryName, COUNT(C.ComponentID) AS TotalProducts
FROM Categories CAT
LEFT JOIN Components C ON CAT.CategoryID = C.CategoryID
GROUP BY CAT.CategoryName;

SELECT SUM(QuantityInStock * UnitCost) AS TotalWarehouseValue
FROM Inventory;

SELECT V.CompanyName, AVG(I.UnitCost) AS AveragePartCost
FROM Vendors V
JOIN Inventory I ON V.VendorID = I.VendorID
GROUP BY V.CompanyName;

-- This will fail because CategoryID 999 does not exist.
INSERT INTO Components (Name, Specs, CategoryID) 
VALUES ('Quantum Processor', '1000 Qubits', 999);

-- This will fail because 'SiliconSource' is already in the table.
INSERT INTO Vendors (CompanyName, ContactEmail) 
VALUES ('SiliconSource', 'sales@siliconsource.com');

-- This will fail because CategoryID 1 (Processor) is being referenced 
-- by multiple rows in the Components table.
DELETE FROM Categories 
WHERE CategoryName = 'Processor';
