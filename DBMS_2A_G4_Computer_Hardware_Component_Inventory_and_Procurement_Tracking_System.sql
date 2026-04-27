	DROP DATABASE IF EXISTS hardware_inventory_db;
	CREATE DATABASE hardware_inventory_db;
	USE hardware_inventory_db;


	CREATE TABLE Vendor (
	VendorID INT PRIMARY KEY AUTO_INCREMENT,
	TableName VARCHAR(100) NOT NULL,
	Contact VARCHAR(100) NOT NULL,
	Lead_Time INT NOT NULL
	);
    
    
    INSERT INTO Vendor (TableName, Contact, Lead_Time) VALUES
('TechSource Inc.', 'techsource@email.com', 7),
('Prime Circuits', 'prime@email.com', 10),
('NanoParts Ltd.', 'nano@email.com', 5),
('CircuitHub', 'hub@email.com', 12),
('ElectroWorld', 'electro@email.com', 8),
('PowerCore', 'power@email.com', 6),
('MicroTech Supplies', 'micro@email.com', 9),
('Future Components', 'future@email.com', 11),
('Alpha Electronics', 'alpha@email.com', 7),
('Beta Systems', 'beta@email.com', 6),
('Gamma Supplies', 'gamma@email.com', 10),
('Delta Hardware', 'delta@email.com', 8),
('Epsilon Tech', 'epsilon@email.com', 9),
('Zeta Parts', 'zeta@email.com', 5),
('Eta Devices', 'eta@email.com', 7),
('Theta Circuits', 'theta@email.com', 6),
('Iota Components', 'iota@email.com', 8),
('Kappa Supplies', 'kappa@email.com', 9),
('Lambda Tech', 'lambda@email.com', 7),
('Mu Hardware', 'mu@email.com', 10),
('Nu Devices', 'nu@email.com', 6),
('Xi Electronics', 'xi@email.com', 8),
('Omicron Parts', 'omicron@email.com', 7),
('Pi Circuits', 'pi@email.com', 9),
('Rho Systems', 'rho@email.com', 6);

SELECT * FROM Vendor;

	CREATE TABLE Components (
	ComponentID INT PRIMARY KEY AUTO_INCREMENT,
	VendorID INT NOT NULL,
	Part_Name VARCHAR(100) NOT NULL,
	Category VARCHAR(50) NOT NULL,
	Unit_Price DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID) ON DELETE CASCADE ON UPDATE CASCADE
	);


INSERT INTO Components (VendorID, Part_Name, Category, Unit_Price) VALUES
(1,'Intel i5 CPU','Processor',12000.00),
(2,'AMD Ryzen 5','Processor',11500.00),
(3,'Kingston 8GB RAM','Memory',2500.00),
(4,'Corsair 16GB RAM','Memory',4500.00),
(5,'Samsung SSD 500GB','Storage',4000.00),
(6,'WD HDD 1TB','Storage',3000.00),
(7,'ASUS Motherboard','Motherboard',7000.00),
(8,'MSI Motherboard','Motherboard',6800.00),
(9,'NVIDIA GTX 1650','GPU',9000.00),
(10,'AMD RX 6600','GPU',14000.00),
(11,'Cooler Master PSU','Power Supply',3500.00),
(12,'EVGA PSU','Power Supply',3700.00),
(13,'Logitech Mouse','Peripheral',800.00),
(14,'Mechanical Keyboard','Peripheral',2500.00),
(15,'Dell Monitor 24"','Display',9000.00),
(16,'HP Monitor 27"','Display',12000.00),
(17,'TP-Link Router','Networking',2000.00),
(18,'Netgear Switch','Networking',3000.00),
(19,'Cooling Fan','Cooling',500.00),
(20,'Liquid Cooler','Cooling',4500.00),
(21,'NZXT Case','Case',4000.00),
(22,'Thermaltake Case','Case',3800.00),
(23,'Sound Card','Audio',1500.00),
(24,'Webcam HD','Accessory',1200.00),
(25,'USB Hub','Accessory',600.00);

SELECT * FROM Components;

	CREATE TABLE Warranty_Details (
	WarrantyID INT PRIMARY KEY AUTO_INCREMENT,
	ComponentID INT NOT NULL,
	Coverage_Period INT NOT NULL,
	Terms VARCHAR(255) NOT NULL,
	Provider VARCHAR(100) NOT NULL ,
	FOREIGN KEY (ComponentID) REFERENCES Components(ComponentID) ON DELETE CASCADE ON UPDATE CASCADE
	);


INSERT INTO Warranty_Details (ComponentID, Coverage_Period, Terms, Provider) VALUES
(1,24,'Manufacturer defects','Intel'),
(2,24,'Manufacturer defects','AMD'),
(3,12,'Replacement only','Kingston'),
(4,24,'Replacement or repair','Corsair'),
(5,36,'Full coverage','Samsung'),
(6,24,'Limited warranty','WD'),
(7,36,'Full warranty','ASUS'),
(8,36,'Full warranty','MSI'),
(9,24,'Repair only','NVIDIA'),
(10,24,'Repair only','AMD'),
(11,12,'Replacement','Cooler Master'),
(12,12,'Replacement','EVGA'),
(13,6,'Limited','Logitech'),
(14,12,'Repair','Generic'),
(15,24,'Full warranty','Dell'),
(16,24,'Full warranty','HP'),
(17,12,'Replacement','TP-Link'),
(18,12,'Replacement','Netgear'),
(19,6,'Limited','Generic'),
(20,12,'Repair','Cooler Brand'),
(21,24,'Full warranty','NZXT'),
(22,24,'Full warranty','Thermaltake'),
(23,12,'Replacement','Generic'),
(24,12,'Replacement','Generic'),
(25,6,'Limited','Generic');

SELECT * FROM Warranty_Details;

	CREATE TABLE Inventory (
	StockID INT PRIMARY KEY AUTO_INCREMENT,
	ComponentID INT NOT NULL,
	Quantity INT NOT NULL,
	Last_Update DATE NOT NULL,
	FOREIGN KEY (ComponentID) REFERENCES Components(ComponentID) ON DELETE CASCADE ON UPDATE CASCADE
	);


INSERT INTO Inventory (ComponentID, Quantity, Last_Update) VALUES
(1,10,'2026-04-01'),
(2,12,'2026-04-01'),
(3,25,'2026-04-02'),
(4,20,'2026-04-02'),
(5,15,'2026-04-03'),
(6,18,'2026-04-03'),
(7,8,'2026-04-04'),
(8,9,'2026-04-04'),
(9,6,'2026-04-05'),
(10,5,'2026-04-05'),
(11,14,'2026-04-06'),
(12,13,'2026-04-06'),
(13,30,'2026-04-07'),
(14,22,'2026-04-07'),
(15,7,'2026-04-08'),
(16,6,'2026-04-08'),
(17,11,'2026-04-09'),
(18,10,'2026-04-09'),
(19,40,'2026-04-10'),
(20,12,'2026-04-10'),
(21,9,'2026-04-11'),
(22,10,'2026-04-11'),
(23,16,'2026-04-12'),
(24,18,'2026-04-12'),
(25,20,'2026-04-13');

SELECT * FROM Inventory;

	CREATE TABLE Builds (
	BuildID INT PRIMARY KEY AUTO_INCREMENT,
	Build_Name VARCHAR(100) NOT NULL,
	Build_Status VARCHAR(50) NOT NULL,
	Assembly_Date DATE NOT NULL
	);


INSERT INTO Builds (Build_Name, Build_Status, Assembly_Date) VALUES
('Office PC 1','Completed','2026-04-01'),
('Office PC 2','Completed','2026-04-02'),
('Gaming Rig 1','In Progress','2026-04-03'),
('Gaming Rig 2','Planned','2026-04-04'),
('Workstation 1','Completed','2026-04-05'),
('Workstation 2','In Progress','2026-04-06'),
('Budget PC 1','Completed','2026-04-07'),
('Budget PC 2','Completed','2026-04-08'),
('Server 1','Planned','2026-04-09'),
('Server 2','In Progress','2026-04-10'),
('Editing PC','Completed','2026-04-11'),
('Streaming PC','In Progress','2026-04-12'),
('Student PC 1','Completed','2026-04-13'),
('Student PC 2','Completed','2026-04-14'),
('Lab PC 1','Planned','2026-04-15'),
('Lab PC 2','In Progress','2026-04-16'),
('Mini PC','Completed','2026-04-17'),
('HTPC','Completed','2026-04-18'),
('AI Workstation','Planned','2026-04-19'),
('Crypto Rig','In Progress','2026-04-20'),
('Office Upgrade','Completed','2026-04-21'),
('Gaming Upgrade','Planned','2026-04-22'),
('Backup Server','Completed','2026-04-23'),
('Test Bench','In Progress','2026-04-24'),
('Custom Build','Planned','2026-04-25');

SELECT * FROM Builds;

	CREATE TABLE Build_Items (
	BuildItemID INT PRIMARY KEY AUTO_INCREMENT,
	BuildID INT NOT NULL,
	ComponentID INT NOT NULL,
	Quantity_Used INT NOT NULL,
	Note VARCHAR(255),
	FOREIGN KEY (BuildID) REFERENCES Builds(BuildID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ComponentID) REFERENCES Components(ComponentID) ON DELETE CASCADE ON UPDATE CASCADE
	);


INSERT INTO Build_Items (BuildID, ComponentID, Quantity_Used, Note) VALUES
(1,1,1,'CPU'),
(1,3,2,'RAM'),
(2,2,1,'CPU'),
(2,4,2,'RAM'),
(3,9,1,'GPU'),
(3,5,1,'SSD'),
(4,10,1,'GPU'),
(4,6,1,'HDD'),
(5,7,1,'Motherboard'),
(6,8,1,'Motherboard'),
(7,11,1,'PSU'),
(8,12,1,'PSU'),
(9,15,1,'Monitor'),
(10,16,1,'Monitor'),
(11,13,1,'Mouse'),
(12,14,1,'Keyboard'),
(13,17,1,'Router'),
(14,18,1,'Switch'),
(15,19,2,'Fans'),
(16,20,1,'Cooler'),
(17,21,1,'Case'),
(18,22,1,'Case'),
(19,23,1,'Sound Card'),
(20,24,1,'Webcam'),
(21,25,1,'USB Hub');

SELECT * FROM Build_Items;

	CREATE TABLE Procurement (
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
	VendorID INT NOT NULL,
	Order_Date DATE NOT NULL,
	Order_Condition VARCHAR(50) NOT NULL,
	Shipping_Method VARCHAR(50) NOT NULL,
	FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID)
	);


INSERT INTO Procurement (VendorID, Order_Date, Order_Condition, Shipping_Method) VALUES
(1,'2026-03-01','New','Air'),
(2,'2026-03-02','New','Sea'),
(3,'2026-03-03','Urgent','Air'),
(4,'2026-03-04','Standard','Land'),
(5,'2026-03-05','New','Air'),
(6,'2026-03-06','Standard','Sea'),
(7,'2026-03-07','Urgent','Air'),
(8,'2026-03-08','Standard','Land'),
(9,'2026-03-09','New','Air'),
(10,'2026-03-10','Urgent','Sea'),
(11,'2026-03-11','Standard','Land'),
(12,'2026-03-12','New','Air'),
(13,'2026-03-13','Standard','Sea'),
(14,'2026-03-14','Urgent','Air'),
(15,'2026-03-15','New','Land'),
(16,'2026-03-16','Standard','Air'),
(17,'2026-03-17','Urgent','Sea'),
(18,'2026-03-18','New','Land'),
(19,'2026-03-19','Standard','Air'),
(20,'2026-03-20','Urgent','Sea'),
(21,'2026-03-21','New','Land'),
(22,'2026-03-22','Standard','Air'),
(23,'2026-03-23','Urgent','Sea'),
(24,'2026-03-24','New','Land'),
(25,'2026-03-25','Standard','Air');

SELECT * FROM Procurement;

