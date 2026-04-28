CREATE DATABASE IF NOT EXISTS Digital; 
DROP DATABASE Digital;
USE Digital; 

SHOW TABLES;

CREATE TABLE Investigators (
	Badge_Number VARCHAR(50) PRIMARY KEY,
    First_Name VARCHAR(100),
    Last_Name VARCHAR(100),
    Rank_Pos VARCHAR(50),
    Jurisdiction VARCHAR(100),
    Account_Status BOOLEAN
);
DESCRIBE Investigators;
SELECT * FROM Investigators;

CREATE TABLE Cases(
	Case_ID INT PRIMARY KEY AUTO_INCREMENT,
	Case_Number VARCHAR(50) UNIQUE,
	Case_Title Varchar(50),
	Date_Opened Datetime,
	Priority ENUM('Low', 'Medium', 'High', 'Critical'),
	Status ENUM('Open','Closed','Archived'),
    Lead_Investigator_ID VARCHAR(50),
    FOREIGN KEY (Lead_Investigator_ID) REFERENCES Investigators(Badge_Number)
) AUTO_INCREMENT = 1001;
DESCRIBE Cases;


CREATE TABLE Evidence_Items(
	Evidence_ID INT AUTO_INCREMENT PRIMARY KEY,
    Case_ID INT,
    Item_Description TEXT,
    Serial_Number VARCHAR(50),
    Evidence_type ENUM('HDD','SSD','Mobile','Ram','Log Export'),
    Original_Hash VARCHAR(50),
    Date_Acquired DATETIME
    ) AUTO_INCREMENT = 5001;
DESCRIBE Evidence_Items;

    

CREATE TABLE Storage_Locations(
	Location_ID INT AUTO_INCREMENT PRIMARY KEY,
    Evidence_ID INT,
    Site_Name VARCHAR(100),
    Room_Number VARCHAR(100),
    Storage ENUM('Physical','Digital'),
    Security_Level INT,
    Is_Full BOOLEAN,
	FOREIGN KEY (Evidence_ID) REFERENCES Evidence_Items(Evidence_ID)
	);
DESCRIBE Storage_Locations;

CREATE TABLE Forensic_Findings(
	Finding_ID INT  AUTO_INCREMENT  PRIMARY KEY,
    Evidence_ID INT NOT NULL,
    Investigator_ID VARCHAR(50),
    Category ENUM ('File Recovery', 'Keyword Hit'),
    Finding_Detail LONGTEXT,
    File_Path VARCHAR(225),
		FOREIGN KEY (Evidence_ID) REFERENCES Evidence_Items(Evidence_ID),
		FOREIGN KEY (Investigator_ID) REFERENCES Investigators(Badge_Number)

)AUTO_INCREMENT = 7001;
DESCRIBE Forensic_Findings;

CREATE TABLE Custody_Logs (
	Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Evidence_ID INT,
    Case_ID INT,		
    Action_Taken ENUM('Checked-in','Checked-out','Transported','Destroyed'),
    From_Custodian VARCHAR(50),
    To_Custodian VARCHAR(50),
    Location_ID INT,
    Log_Timestamp DATETIME,
        FOREIGN KEY (Evidence_ID) REFERENCES Evidence_Items(Evidence_ID),
        FOREIGN KEY (Case_ID) REFERENCES Cases(Case_ID),
		FOREIGN KEY (From_Custodian) REFERENCES Investigators(Badge_Number),
		FOREIGN KEY (To_Custodian) REFERENCES Investigators(Badge_Number),
		FOREIGN KEY (Location_ID) REFERENCES Storage_Locations(Location_ID)
    )AUTO_INCREMENT = 9001;
DESCRIBE Custody_Logs;
SELECT * FROM Custody_Logs;


CREATE TABLE Case_Notes (
	Note_ID INT  AUTO_INCREMENT  PRIMARY KEY,
    Case_ID INT NOT NULL,
    Author_Badge VARCHAR(50),
    Note_Text LONGTEXT,
    Date_Stamp DATETIME,
    FOREIGN KEY (Case_ID) REFERENCES Cases(Case_ID),
    FOREIGN KEY (Author_Badge) REFERENCES Investigators(Badge_Number)
)AUTO_INCREMENT = 10001;
DESCRIBE Case_Notes; 




INSERT INTO Investigators (Badge_Number, First_Name, Last_Name, Rank_Pos, Jurisdiction, Account_Status) 
VALUES
('INV001', 'Juan', 'Dela Cruz', 'Senior', 'NCR', 1),
('INV002', 'Maria', 'Santos', 'Junior', 'NCR', 1),
('INV003', 'Pedro', 'Reyes', 'Detective', 'Region IV', 0),
('INV004', 'Ana', 'Garcia', 'Detective', 'Region III', 1), 
('INV005', 'Luis', 'Martinez', 'Senior', 'NCR', 1), 
('INV006', 'Carlos', 'Hernandez', 'Junior', 'Region I', 1), 
('INV007', 'Elena', 'Lopez', 'Detective', 'Region IV', 0), 
('INV008', 'Roberto', 'Gonzalez', 'Senior', 'NCR', 1), 
('INV009', 'Sofia', 'Perez', 'Junior', 'Region II', 1), 
('INV010', 'Miguel', 'Sanchez', 'Detective', 'Region III', 1), 
('INV011', 'Rosa', 'Ramirez', 'Senior', 'NCR', 0), 
('INV012', 'Jose', 'Torres', 'Junior', 'Region IV', 1), 
('INV013', 'Carmen', 'Flores', 'Detective', 'Region I', 1), 
('INV014', 'Ricardo', 'Rivera', 'Senior', 'Region II', 1), 
('INV015', 'Teresa', 'Gomez', 'Junior', 'Region III', 0), 
('INV016', 'Juan', 'Ted', 'Detective', 'NCR', 1),
('INV017', 'Lucia', 'Cruz', 'Senior', 'Region IV', 1), 
('INV018', 'Manuel', 'Morales', 'Junior', 'Region I', 1), 
('INV019', 'Gloria', 'Ortiz', 'Detective', 'Region II', 0), 
('INV020', 'Antonio', 'Gutierrez', 'Senior', 'NCR', 1);

SELECT * FROM Investigators;

SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name
FROM Investigators
WHERE Account_Status = 0;

SELECT COUNT(*) AS Deactivated_Count
FROM Investigators
WHERE Account_Status = 0;




INSERT INTO Cases (Case_Number, Case_Title, Date_Opened, Priority, Status, Lead_Investigator_ID) 
VALUES
('2025-MR-023', 'Missing Person Report', '2025-03-12 09:30:00', 'High', 'Open', 'INV001'),
('2025-FR-011', 'Online Fraud Case', '2025-02-28 14:15:00', 'Medium', 'Open', 'INV002'),
('2025-TH-007', 'Theft Incident', '2025-01-20 11:00:00', 'Low', 'Closed', 'INV003'), 
('2025-CY-004', 'Corporate Data Breach', '2025-03-14 08:00:00', 'Critical', 'Open', 'INV004'),
('2025-EX-005', 'Extortion Scheme', '2025-03-14 10:15:00', 'High', 'Open', 'INV005'),
('2025-TH-008', 'Hardware Theft', '2025-03-15 09:00:00', 'Medium', 'Closed', 'INV006'),
('2025-FR-012', 'Identity Theft', '2025-03-15 11:30:00', 'High', 'Open', 'INV008'),
('2025-MR-024', 'Missing Child', '2025-03-16 07:45:00', 'Critical', 'Open', 'INV010'),
('2025-CY-005', 'Ransomware Attack', '2025-03-16 13:20:00', 'Critical', 'Open', 'INV012'),
('2025-EX-006', 'Blackmail Case', '2025-03-17 09:10:00', 'Medium', 'Open', 'INV013'),
('2025-TH-009', 'Server Room Break-in', '2025-03-17 14:00:00', 'High', 'Closed', 'INV014'),
('2025-FR-013', 'Credit Card Fraud', '2025-03-18 10:05:00', 'Low', 'Archived', 'INV016'),
('2025-MR-025', 'Runaway Teenager', '2025-03-18 15:50:00', 'Medium', 'Open', 'INV017'),
('2025-CY-006', 'DDoS Investigation', '2025-03-19 08:30:00', 'High', 'Open', 'INV018'),
('2025-EX-007', 'Sextortion Report', '2025-03-19 11:45:00', 'Critical', 'Open', 'INV020'),
('2025-TH-010', 'Stolen Laptops', '2025-03-20 09:20:00', 'Low', 'Closed', 'INV004'),
('2025-FR-014', 'Phishing Campaign', '2025-03-20 13:15:00', 'Medium', 'Open', 'INV005'),
('2025-MR-026', 'Kidnapping', '2025-03-21 06:00:00', 'Critical', 'Open', 'INV008'),
('2025-CY-007', 'Unauthorized Access', '2025-03-21 10:30:00', 'High', 'Open', 'INV010'),
('2025-EX-008', 'Threatening Emails', '2025-03-22 14:00:00', 'Low', 'Archived', 'INV012');

SELECT * FROM Cases;

INSERT INTO Evidence_Items (Case_ID, Item_Description, Serial_Number, Evidence_Type, Original_Hash, Date_Acquired) 
VALUES
(1001, 'Mobile Phone (Samsung)', 'SN12345', 'Mobile', 'a1b2c3d4e5', '2025-03-12 10:00:00'),
(1001, 'USB Flash Drive', 'USB67890', 'SSD', 'f6g7h8i9j0', '2025-03-12 10:30:00'),
(1002, 'Laptop (Dell)', 'LT54321', 'Mobile', 'z9y8x7w6v5', '2025-02-28 15:00:00'),
(1003, 'CCTV Footage', 'CCTV111', 'Ram', 'm1n2b3v4c5', '2025-01-20 12:00:00'),
(1004, 'Server Solid State Drive', 'SSD98765', 'SSD', 'b2c3d4e5f6', '2025-03-14 09:30:00'),
(1005, 'Suspect Smartphone', 'MOB11223', 'Mobile', 'c3d4e5f6g7', '2025-03-14 11:00:00'),
(1006, 'External Hard Drive', 'HDD33445', 'HDD', 'd4e5f6g7h8', '2025-03-15 09:45:00'),
(1007, 'Firewall Logs Extract', 'LOG55667', 'Log Export', 'e5f6g7h8i9', '2025-03-15 12:00:00'),
(1008, 'Tablet Computer', 'MOB77889', 'Mobile', 'f6g7h8i9j0', '2025-03-16 08:30:00'),
(1009, 'Encrypted Workstation Drive', 'SSD99001', 'SSD', 'g7h8i9j0k1', '2025-03-16 14:00:00'),
(1010, 'Memory Dump File', 'RAM22334', 'Ram', 'h8i9j0k1l2', '2025-03-17 10:00:00'),
(1011, 'Backup Hard Drive', 'HDD44556', 'HDD', 'i9j0k1l2m3', '2025-03-17 15:30:00'),
(1012, 'Skimmer Device Memory', 'RAM66778', 'Ram', 'j0k1l2m3n4', '2025-03-18 11:15:00'),
(1013, 'Victim Mobile Phone', 'MOB88990', 'Mobile', 'k1l2m3n4o5', '2025-03-18 16:30:00'),
(1014, 'ISP Traffic Logs', 'LOG11221', 'Log Export', 'l2m3n4o5p6', '2025-03-19 09:00:00'),
(1015, 'Primary Laptop Drive', 'SSD33443', 'SSD', 'm3n4o5p6q7', '2025-03-19 12:30:00'),
(1016, 'Office Desktop HDD', 'HDD55665', 'HDD', 'n4o5p6q7r8', '2025-03-20 10:00:00'),
(1017, 'Email Server Export', 'LOG77887', 'Log Export', 'o5p6q7r8s9', '2025-03-20 14:00:00'),
(1018, 'Burner Phone', 'MOB99009', 'Mobile', 'p6q7r8s9t0', '2025-03-21 07:30:00'),
(1019, 'Captured RAM Image', 'RAM12312', 'Ram', 'q7r8s9t0u1', '2025-03-21 11:45:00'),
(1020, 'Threat Actor Drive', 'SSD34534', 'SSD', 'r8s9t0u1v2', '2025-03-22 15:15:00');

SELECT * FROM Evidence_Items;

INSERT INTO Storage_Locations 
(Evidence_ID, Site_Name, Room_Number, Storage, Security_Level, Is_Full)
VALUES
(5001, 'NCR Headquarters', 'Evidence Room A', 'Physical', 5, FALSE),
(5002, 'NCR Headquarters', 'Locker 42', 'Physical', 3, TRUE),
(5003, 'Cyber Lab', 'Secure Server 01', 'Digital', 5, FALSE),
(5004, 'Region IV Station', 'Evidence Room B', 'Physical', 4, FALSE),
(5005, 'NCR Headquarters', 'Evidence Room B', 'Physical', 5, FALSE),
(5006, 'Region III Station', 'Locker 12', 'Physical', 4, TRUE),
(5007, 'Region I Station', 'Locker 05', 'Physical', 3, FALSE),
(5008, 'Cyber Lab', 'Secure Server 02', 'Digital', 5, FALSE),
(5009, 'Region III Station', 'Evidence Room A', 'Physical', 4, FALSE),
(5010, 'NCR Headquarters', 'Safe 01', 'Physical', 5, TRUE),
(5011, 'Cyber Lab', 'Cold Storage Server', 'Digital', 4, FALSE),
(5012, 'Region II Station', 'Locker 22', 'Physical', 3, FALSE),
(5013, 'Cyber Lab', 'Cold Storage Server', 'Digital', 4, FALSE),
(5014, 'Region IV Station', 'Evidence Room A', 'Physical', 4, FALSE),
(5015, 'Cyber Lab', 'Secure Server 03', 'Digital', 5, FALSE),
(5016, 'NCR Headquarters', 'Evidence Room C', 'Physical', 5, FALSE),
(5017, 'Region I Station', 'Locker 08', 'Physical', 3, TRUE),
(5018, 'Cyber Lab', 'Secure Server 01', 'Digital', 5, FALSE),
(5019, 'NCR Headquarters', 'Locker 50', 'Physical', 3, FALSE),
(5020, 'Cyber Lab', 'Cold Storage Server', 'Digital', 4, FALSE);

SELECT * FROM Storage_Locations;

INSERT INTO Forensic_Findings 
(Evidence_ID, Investigator_ID, Category, Finding_Detail, File_Path)  --  removed Finding_Id since auto increment. 
VALUES
(5001, 'INV001', 'File Recovery', 'Successfully recovered 15 deleted SMS messages.', '/forensics/cases/2025-MR-023/ev101_sms.csv'),
(5003, 'INV002', 'Keyword Hit', 'Located multiple hits for "wire transfer" in email outbox.', '/forensics/cases/2025-FR-011/ev103_emails.pst'),
(5002, 'INV002', 'File Recovery', 'Extracted hidden financial spreadsheets.', '/forensics/cases/2025-MR-023/ev102_finances.xlsx'),
(5005, 'INV004', 'File Recovery', 'Restored 3 deleted database backups.', '/forensics/cases/1004/ev105_db.bak'),
(5006, 'INV005', 'Keyword Hit', 'Found "payoff" in WhatsApp chat logs.', '/forensics/cases/1005/ev106_whatsapp.db'),
(5007, 'INV006', 'File Recovery', 'Recovered formatted partition containing blueprints.', '/forensics/cases/1006/ev107_blueprints.pdf'),
(5008, 'INV008', 'Keyword Hit', 'Matched attacker IP address in firewall logs.', '/forensics/cases/1007/ev108_firewall.log'),
(5009, 'INV010', 'File Recovery', 'Extracted cached GPS location data.', '/forensics/cases/1008/ev109_gps.kml'),
(5010, 'INV012', 'Keyword Hit', 'Identified ransom note executable string.', '/forensics/cases/1009/ev110_strings.txt'),
(5011, 'INV013', 'Keyword Hit', 'Found password hashes matching the blackmail account.', '/forensics/cases/1010/ev111_hashes.txt'),
(5012, 'INV014', 'File Recovery', 'Recovered fragmented video files.', '/forensics/cases/1011/ev112_video.mp4'),
(5013, 'INV016', 'Keyword Hit', 'Located 450 stolen credit card numbers in memory.', '/forensics/cases/1012/ev113_cc_data.csv'),
(5014, 'INV017', 'File Recovery', 'Restored deleted social media app database.', '/forensics/cases/1013/ev114_social.db'),
(5015, 'INV018', 'Keyword Hit', 'Found botnet command and control server domains.', '/forensics/cases/1014/ev115_dns.log'),
(5016, 'INV020', 'File Recovery', 'Extracted hidden images using steganography tools.', '/forensics/cases/1015/ev116_images.zip'),
(5017, 'INV004', 'Keyword Hit', 'Located "admin" credentials in plaintext document.', '/forensics/cases/1016/ev117_creds.txt'),
(5018, 'INV005', 'File Recovery', 'Recovered phishing email templates.', '/forensics/cases/1017/ev118_phishing.eml'),
(5019, 'INV008', 'Keyword Hit', 'Matched target phone number in call logs.', '/forensics/cases/1018/ev119_calls.csv'),
(5020, 'INV010', 'Keyword Hit', 'Identified unauthorized SSH keys in memory.', '/forensics/cases/1019/ev120_keys.pub'),
(5020, 'INV012', 'File Recovery', 'Recovered draft extortion letters.', '/forensics/cases/1020/ev121_letters.docx');

SELECT * FROM Forensic_Findings;

INSERT INTO Custody_Logs 
(Evidence_ID, Case_ID, Action_Taken, From_Custodian, To_Custodian, Location_ID, Log_Timestamp)  -- Change Timestamp to log_timestamp since user-defined column name
VALUES
(5001, 1001, 'Checked-in', NULL, 'INV001', 1, '2025-03-12 10:05:00'),
(5001, 1001, 'Checked-out', 'INV001', 'INV002', 2, '2025-03-13 09:00:00'),
(5002, 1001, 'Transported', 'INV001', 'INV003', 3, '2025-03-13 11:30:00'),
(5003, 1002, 'Checked-in', NULL, 'INV002', 4, '2025-02-28 15:10:00'),
(5004, 1004, 'Checked-in', NULL, 'INV004', 1, '2025-03-14 09:45:00'),
(5005, 1005, 'Checked-in', NULL, 'INV005', 1, '2025-03-14 11:15:00'),
(5006, 1006, 'Checked-out', 'INV006', 'INV013', 2, '2025-03-15 10:00:00'),
(5007, 1007, 'Checked-in', NULL, 'INV008', 3, '2025-03-15 12:15:00'),
(5008, 1008, 'Transported', 'INV010', 'INV012', 4, '2025-03-16 09:00:00'),
(5009, 1009, 'Checked-in', NULL, 'INV012', 1, '2025-03-16 14:30:00'),
(5010, 1010, 'Checked-in', NULL, 'INV013', 2, '2025-03-17 10:15:00'),
(5011, 1011, 'Destroyed', 'INV014', NULL, 3, '2025-03-17 16:00:00'),
(5012, 1012, 'Checked-in', NULL, 'INV016', 4, '2025-03-18 11:30:00'),
(5013, 1013, 'Checked-out', 'INV017', 'INV004', 1, '2025-03-18 17:00:00'),
(5014, 1014, 'Checked-in', NULL, 'INV018', 2, '2025-03-19 09:15:00'),
(5015, 1015, 'Transported', 'INV020', 'INV005', 3, '2025-03-19 13:00:00'),
(5016, 1016, 'Destroyed', 'INV004', NULL, 4, '2025-03-20 10:30:00'),
(5017, 1017, 'Checked-in', NULL, 'INV005', 1, '2025-03-20 14:15:00'),
(5018, 1018, 'Checked-out', 'INV008', 'INV010', 2, '2025-03-21 08:00:00'),
(5019, 1019, 'Checked-in', NULL, 'INV010', 3, '2025-03-21 12:00:00'),
(5020, 1020, 'Checked-in', NULL, 'INV012', 4, '2025-03-22 15:30:00');

SELECT * FROM Custody_Logs;

INSERT INTO Case_Notes (Case_ID, Author_Badge, Note_Text, Date_Stamp)  -- case id was removed
VALUES
(1001, 'INV001', 'Initial neighborhood canvassing completed.', '2025-03-12 11:45:00'),
(1002, 'INV002', 'Subpoena requested for ISP logs.', '2025-03-01 09:15:00'),
(1001, 'INV002', 'Assisting lead investigator with digital artifact analysis.', '2025-03-13 10:00:00'),
(1003, 'INV003', 'CCTV footage reviewed. Suspect vehicle identified.', '2025-01-21 14:30:00'),
(1004, 'INV004', 'Initial triage of server logs; breach occurred at 02:00 AM.', '2025-03-14 10:00:00'),
(1005, 'INV005', 'Suspect phone placed in Faraday bag upon seizure.', '2025-03-14 11:30:00'),
(1006, 'INV006', 'Hard drive casing was damaged prior to acquisition.', '2025-03-15 10:15:00'),
(1007, 'INV008', 'Requested translation services for Spanish emails.', '2025-03-15 13:00:00'),
(1008, 'INV010', 'Tablet battery is dead; routing for external power bypass.', '2025-03-16 09:15:00'),
(1009, 'INV012', 'BitLocker encryption detected. Awaiting recovery key.', '2025-03-16 15:00:00'),
(1010, 'INV013', 'Memory dump successfully compiled using DumpIt tool.', '2025-03-17 11:00:00'),
(1011, 'INV014', 'Drive scheduled for physical destruction per court order.', '2025-03-17 15:45:00'),
(1012, 'INV016', 'Memory analysis via Volatility confirms skimmer presence.', '2025-03-18 12:00:00'),
(1013, 'INV017', 'Victim consented to full extraction of the mobile device.', '2025-03-18 17:15:00'),
(1014, 'INV018', 'ISP logs successfully parsed. Preparing visualization.', '2025-03-19 10:30:00'),
(1015, 'INV020', 'Laptop imaging complete; calculating post-acquisition hash.', '2025-03-19 14:00:00'),
(1016, 'INV004', 'Destruction logged and verified by secondary officer.', '2025-03-20 11:00:00'),
(1017, 'INV005', 'Email export ingested into eDiscovery platform.', '2025-03-20 15:30:00'),
(1018, 'INV008', 'Burner phone lacks SIM card. Extracting internal storage.', '2025-03-21 08:30:00'),
(1019, 'INV010', 'RAM image reveals active SSH session during capture.', '2025-03-21 12:30:00'),
(1020, 'INV012', 'Drive cloned to working copy. Original in Secure Server 03.', '2025-03-22 16:00:00');

SELECT * FROM Case_Notes;


-- Pasion

-- Select
SELECT Case_Number, Case_Title, Date_Opened 
FROM Cases 
WHERE Status = 'Archived';

SELECT * FROM Cases;


-- Insert
INSERT INTO Investigators (Badge_Number, First_Name, Last_Name, Rank_Pos, Jurisdiction, Account_Status) 
VALUES ('INV021', 'Roberto', 'Garcia', 'Digital Examiner', 'NCR', 1);
SELECT * FROM Investigators WHERE Badge_Number = 'INV021';

SELECT * FROM Investigators;

-- Pt2
INSERT INTO Evidence_Items (Case_ID, Item_Description, Serial_Number, Evidence_type, Original_Hash, Date_Acquired) 
VALUES (1012, 'Suspect USB Flash Drive', 'SN-USB-0099', 'HDD', 'hash_val_999xyz', NOW());
SELECT * FROM Evidence_Items WHERE Case_Id = '1012';


-- CASE NOTE 
INSERT INTO Case_Notes (Case_ID, Author_Badge, Note_Text, Date_Stamp) 
VALUES (1012 , 'INV019', 'Suspect confessed during initial interrogation at the precinct.', NOW());
SELECT * FROM Case_Notes;



INSERT INTO Cases (Case_Number, Case_Title, Date_Opened, Priority, Status, Lead_Investigator_ID) 
VALUES

-- Update
UPDATE Investigators
SET Rank_Pos = 'Senior Digital Examiner', Jurisdiction = 'NCR' WHERE Badge_Number = 'INV021';
SELECT * FROM Investigators;
SELECT * FROM Investigators WHERE Badge_Number = 'INV021';
    
UPDATE Evidence_Items 
SET Original_Hash = 'a9b8c7d6e5f4g3h2i1', Item_Description = 'Verified Suspect USB Flash Drive' WHERE Serial_Number = 'SN-USB-0099' AND Case_ID = 1012; 
SELECT * FROM Evidence_Items WHERE Original_Hash = 'a9b8c7d6e5f4g3h2i1';

-- Delete
DELETE FROM Case_Notes 
WHERE Note_ID = 109;
SELECT * FROM Case_Notes WHERE Note_ID = 109;


-- ROQUE
--  Inner join
SELECT Evidence_Items.Item_Description, Forensic_Findings.Finding_Detail
FROM Evidence_Items
INNER JOIN Forensic_Findings
ON Evidence_Items.Evidence_ID = Forensic_Findings.Evidence_ID;


-- Left join
SELECT Cases.Case_Title, Case_Notes.Note_Text
FROM Cases
LEFT JOIN Case_Notes
ON Cases.Case_ID = Case_Notes.Case_ID;


-- Right join
SELECT Evidence_Items.Item_Description, Storage_Locations.Site_Name
FROM Evidence_Items
RIGHT JOIN Storage_Locations
ON Evidence_Items.Evidence_ID = Storage_Locations.Evidence_ID;


-- Cross join
SELECT * FROM Investigators
CROSS JOIN Cases
WHERE Investigators.Badge_Number = Cases.Lead_Investigator_ID;

-- Naluz

-- SubQ1
SELECT First_Name, Last_Name, Rank_Pos
FROM Investigators
WHERE Badge_Number NOT IN(
SELECT Lead_Investigator_ID
FROM cases
WHERE Lead_Investigator_ID IS NOT NULL);



-- SubQ2
SELECT Item_Description, Evidence_type
FROM Evidence_Items 
WHERE Case_ID IN (
SELECT Case_ID
FROM Cases
WHERE Priority = 'Critical');

-- Connections/proof
SELECT Case_ID, Priority
FROM Cases
WHERE Priority = 'Critical';

-- Display:
SELECT Case_ID, Item_Description, Evidence_Type
FROM Evidence_Items
WHERE Case_ID IN (1004,1008,1009,1015,1018);


-- SubQ3
SELECT Case_Number, Case_Title
FROM Cases
WHERE Case_ID NOT IN (
    SELECT Case_ID 
    FROM Case_Notes 
    WHERE Case_ID IS NOT NULL
);

-- proof/connection:
-- ALL OF THEM HAVE CASE NOTES
SELECT Case_ID
FROM Case_Notes
WHERE Case_ID BETWEEN 1001 AND 1020;


-- BOHOLANO

SELECT Case_ID, COUNT(Evidence_ID) AS Total_Evidence 
FROM Evidence_Items
GROUP BY Case_ID;

SELECT AVG(Security_Level) AS Avg_Security_Level
FROM Storage_Locations
WHERE Storage = 'Physical';

SELECT * FROM Storage_Locations;


SELECT Lead_Investigator_ID, COUNT(Case_ID) AS Open_Cases
FROM Cases
WHERE Status = 'Open'
GROUP BY Lead_Investigator_ID;

SELECT Evidence_ID, MAX(Log_Timestamp) AS Latest_Movement
FROM Custody_Logs
GROUP BY Evidence_ID;

SELECT Evidence_Items.Case_ID, GROUP_CONCAT(Forensic_Findings.Category SEPARATOR ', ') AS Categories
FROM Forensic_Findings
JOIN Evidence_Items ON Forensic_Findings.Evidence_ID = Evidence_Items.Evidence_ID
GROUP BY Evidence_Items.Case_ID;




-- Euken & Naluz

-- Example A: Violating a Foreign Key
INSERT INTO Cases (Case_Number, Case_Title, Lead_Investigator_ID) 
VALUES ('2025-FAIL-01', 'Test Case', 'INV-FAKE');

-- Example B: Violating an ENUM
INSERT INTO Cases (Case_Number, Case_Title, Priority) 
VALUES ('2025-FAIL-02', 'Test Case', 'Super High');

-- Example C: FOREIGN KEY Violation
DELETE FROM Investigators WHERE Badge_Number = 'INV001';
