DROP DATABASE IF EXISTS NETWORK;
CREATE DATABASE IF NOT EXISTS NETWORK;
USE NETWORK;

CREATE TABLE IF NOT EXISTS Devices (
device_id INT PRIMARY KEY,
hostname VARCHAR(100) NOT NULL,
ip_address VARCHAR(45) UNIQUE NOT NULL,
device_type VARCHAR(50),
location VARCHAR(100),
status VARCHAR(20)
CHECK (status IN ('active','inactive','compromised'))
);

CREATE TABLE IF NOT EXISTS Analysts (
analyst_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
availability_status VARCHAR(20)
CHECK (availability_status IN ('available','busy','offline'))
);

CREATE TABLE IF NOT EXISTS Incidents (
incident_id INT PRIMARY KEY,
title VARCHAR(150) NOT NULL,
status VARCHAR(20)
CHECK (status IN ('open','in_progress','resolved','closed')),
priority VARCHAR(20)
CHECK (priority IN ('low','medium','high','very high')),
created_at DATETIME NOT NULL,
closed_at DATETIME
);

CREATE TABLE IF NOT EXISTS Alerts (
alert_id INT PRIMARY KEY,
timestamp DATETIME NOT NULL,
severity VARCHAR(20)
CHECK (severity IN ('low','medium','high','very high')),
alert_type VARCHAR(50),
device_id INT,
FOREIGN KEY (device_id) REFERENCES Devices(device_id)
);

CREATE TABLE IF NOT EXISTS IncidentAssignment (
incident_id INT,
analyst_id INT,
assigned_at DATETIME,
FOREIGN KEY (incident_id) REFERENCES Incidents(incident_id),
FOREIGN KEY (analyst_id) REFERENCES Analysts(analyst_id)
);

CREATE TABLE IF NOT EXISTS Response_Actions (
action_id INT PRIMARY KEY,
action_type VARCHAR(50),
executed_at DATETIME,
outcome VARCHAR(50),
incident_id INT,
analyst_id INT,
FOREIGN KEY (incident_id) REFERENCES Incidents(incident_id),
FOREIGN KEY (analyst_id) REFERENCES Analysts(analyst_id)
);

INSERT INTO Devices VALUES
(1,'FW-1','192.168.1.1','Firewall','Data Center','active'),
(2,'SRV-DB','192.168.1.2','Server','Data Center','active'),
(3,'RTR-1','192.168.1.3','Router','HQ','active'),
(4,'PC-101','192.168.1.10','Workstation','Office','active'),
(5,'PC-102','192.168.1.11','Workstation','Office','inactive'),
(6,'IDS-1','192.168.1.20','IDS','Data Center','active'),
(7,'VPN-1','192.168.1.30','VPN','HQ','active'),
(8,'SRV-WEB','192.168.1.40','Server','Cloud','active'),
(9,'SRV-APP','192.168.1.41','Server','Cloud','active'),
(10,'PC-103','192.168.1.12','Workstation','Office','active'),
(11,'PC-104','192.168.1.13','Workstation','Office','active'),
(12,'PC-105','192.168.1.14','Workstation','Office','compromised'),
(13,'RTR-2','192.168.2.1','Router','Branch','active'),
(14,'FW-2','192.168.2.2','Firewall','Branch','active'),
(15,'SRV-LOG','192.168.2.3','Server','Data Center','active'),
(16,'IDS-2','192.168.2.4','IDS','Branch','active'),
(17,'PC-106','192.168.2.10','Workstation','Branch','inactive'),
(18,'PC-107','192.168.2.11','Workstation','Branch','active'),
(19,'PC-108','192.168.2.12','Workstation','Branch','active'),
(20,'PC-109','192.168.2.13','Workstation','Branch','active');

INSERT INTO Alerts VALUES
(1,'2026-04-01 10:00','high','Malware',12),
(2,'2026-04-02 11:00','medium','Phishing',4),
(3,'2026-04-03 12:00','very high','DDoS',3),
(4,'2026-04-04 13:00','high','Login',2),
(5,'2026-04-05 14:00','very high','Data Leak',2),
(6,'2026-04-06 15:00','medium','Brute Force',7),
(7,'2026-04-07 16:00','very high','Ransomware',12),
(8,'2026-04-08 17:00','low','Scan',3),
(9,'2026-04-09 18:00','high','SQL Injection',8),
(10,'2026-04-10 19:00','medium','XSS',8),
(11,'2026-04-11 20:00','high','Privilege',2),
(12,'2026-04-12 21:00','very high','Zero-Day',6),
(13,'2026-04-13 22:00','high','Botnet',6),
(14,'2026-04-14 23:00','high','Insider',4),
(15,'2026-04-15 09:00','medium','DNS',3),
(16,'2026-04-16 10:30','very high','MITM',7),
(17,'2026-04-17 11:30','high','Session',9),
(18,'2026-04-18 12:30','very high','Backdoor',12),
(19,'2026-04-19 13:30','high','Worm',10),
(20,'2026-04-20 14:30','medium','Leak',2);

INSERT INTO Incidents VALUES
(1,'Malware Infection','open','high','2026-04-01',NULL),
(2,'Phishing Attack','resolved','medium','2026-04-02','2026-04-03'),
(3,'DDoS Attempt','in_progress','very high','2026-04-03',NULL),
(4,'Unauthorized Access','open','high','2026-04-04',NULL),
(5,'Data Exfiltration','open','very high','2026-04-05',NULL),
(6,'Brute Force','resolved','medium','2026-04-06','2026-04-07'),
(7,'Ransomware','in_progress','very high','2026-04-07',NULL),
(8,'Port Scan','closed','low','2026-04-08','2026-04-08'),
(9,'SQL Injection','open','high','2026-04-09',NULL),
(10,'XSS Attack','resolved','medium','2026-04-10','2026-04-11'),
(11,'Privilege Escalation','open','high','2026-04-11',NULL),
(12,'Zero-Day','in_progress','very high','2026-04-12',NULL),
(13,'Botnet Activity','open','high','2026-04-13',NULL),
(14,'Insider Threat','open','high','2026-04-14',NULL),
(15,'DNS Poisoning','resolved','medium','2026-04-15','2026-04-16'),
(16,'MITM','open','very high','2026-04-16',NULL),
(17,'Session Hijack','open','high','2026-04-17',NULL),
(18,'Backdoor','in_progress','very high','2026-04-18',NULL),
(19,'Worm Spread','open','high','2026-04-19',NULL),
(20,'Credential Leak','resolved','medium','2026-04-20','2026-04-20');

INSERT INTO Analysts VALUES
(1,'Alice Cruz','alice@email.com','available'),
(2,'Bob Reyes','bob@email.com','busy'),
(3,'Charlie Tan','charlie@email.com','available'),
(4,'Dana Lim','dana@email.com','offline'),
(5,'Evan Yu','evan@email.com','available'),
(6,'Faith Ong','faith@email.com','busy'),
(7,'George Co','george@email.com','available'),
(8,'Hannah Sy','hannah@email.com','available'),
(9,'Ian Go','ian@email.com','available'),
(10,'Jane Lim','jane@email.com','busy'),
(11,'Karl Dy','karl@email.com','available'),
(12,'Liza Tan','liza@email.com','available'),
(13,'Mark Co','mark@email.com','offline'),
(14,'Nina Ong','nina@email.com','busy'),
(15,'Omar Yu','omar@email.com','available'),
(16,'Paula Lim','paula@email.com','available'),
(17,'Quinn Go','quinn@email.com','available'),
(18,'Rina Cruz','rina@email.com','busy'),
(19,'Sam Tan','sam@email.com','available'),
(20,'Tina Sy','tina@email.com','available');

INSERT INTO IncidentAssignment VALUES
(7,3,'2026-04-01'),
(12,8,'2026-04-02'),
(3,15,'2026-04-03'),
(18,1,'2026-04-04'),
(5,9,'2026-04-05'),
(14,6,'2026-04-06'),
(1,11,'2026-04-07'),
(9,20,'2026-04-08'),
(16,2,'2026-04-09'),
(11,17,'2026-04-10'),
(20,5,'2026-04-11'),
(4,13,'2026-04-12'),
(8,7,'2026-04-13'),
(13,10,'2026-04-14'),
(2,18,'2026-04-15'),
(15,4,'2026-04-16'),
(10,12,'2026-04-17'),
(17,14,'2026-04-18'),
(6,19,'2026-04-19'),
(19,16,'2026-04-20');

INSERT INTO Response_Actions VALUES
(1,'Isolate Device','2026-04-01 11:00','successful',1,5),
(2,'Block IP','2026-04-02 12:00','successful',2,10),
(3,'Traffic Filtering','2026-04-03 13:00','successful',3,15),
(4,'Reset Password','2026-04-04 14:00','successful',4,20),
(5,'Terminate Session','2026-04-05 15:00','successful',5,6),
(6,'Account Lock','2026-04-06 16:00','successful',6,11),
(7,'Restore Backup','2026-04-07 17:00','partial',7,16),
(8,'Close Ports','2026-04-08 18:00','successful',8,1),
(9,'Patch System','2026-04-09 19:00','successful',9,7),
(10,'Sanitize Input','2026-04-10 20:00','successful',10,12),
(11,'Revoke Access','2026-04-11 21:00','successful',11,17),
(12,'Deploy Patch','2026-04-12 22:00','successful',12,2),
(13,'Block Domain','2026-04-13 23:00','successful',13,8),
(14,'Audit Logs','2026-04-14 09:00','successful',14,13),
(15,'Flush DNS','2026-04-15 10:00','successful',15,18),
(16,'Encrypt Traffic','2026-04-16 11:00','successful',16,3),
(17,'Invalidate Tokens','2026-04-17 12:00','successful',17,9),
(18,'Remove Backdoor','2026-04-18 13:00','successful',18,14),
(19,'Quarantine System','2026-04-19 14:00','successful',19,19),
(20,'Reset Credentials','2026-04-20 15:00','successful',20,4);

SELECT * FROM Devices;
SELECT * FROM Analysts;
SELECT * FROM Alerts;
SELECT * FROM Incidents;
SELECT * FROM IncidentAssignment;
SELECT * FROM Response_Actions;


INSERT INTO Devices (device_id, hostname, ip_address, device_type, location, status)
VALUES (21, 'PC-110', '192.168.1.50', 'Workstation', 'Office', 'active');
SELECT * FROM Devices;

UPDATE Devices
SET status = 'inactive'
WHERE device_id = 21;
SELECT * FROM Devices;

DELETE FROM Devices
WHERE device_id = 21;
SELECT * FROM Devices;


SELECT alert_id AS ID,
alert_type AS Type,
severity AS Severity,
hostname AS Hostname,
location AS Location
FROM Alerts A
JOIN Devices D ON A.device_id = D.device_id;

SELECT title AS Title,
status AS Status,
name AS Analyst,
assigned_at AS 'Assigned At'
FROM Incidents I
JOIN IncidentAssignment IA ON I.incident_id = IA.incident_id
JOIN Analysts AN ON IA.analyst_id = AN.analyst_id;

SELECT action_type AS 'Action Taken',
outcome AS Outcome,
title AS 'Incident Title',
name AS Analyst
FROM Response_Actions RA
JOIN Incidents I ON RA.incident_id = I.incident_id
JOIN Analysts AN ON RA.analyst_id = AN.analyst_id;


SELECT hostname,
ip_address
FROM Devices
WHERE device_id IN
(SELECT device_id
FROM Alerts
WHERE severity = 'very high');

SELECT name,
email
FROM Analysts
WHERE analyst_id IN
(SELECT analyst_id
FROM IncidentAssignment
WHERE incident_id IN
(SELECT incident_id
FROM Incidents
WHERE priority = 'very high') );


SELECT severity,
COUNT(*) AS 'Total Alerts'
FROM Alerts
GROUP BY severity;

SELECT device_id,
COUNT(*) AS 'Total Alerts'
FROM Alerts
GROUP BY device_id;


INSERT INTO Devices
VALUES (21, 'PC-111', NULL, 'Workstation', 'Office', 'broken');



-- Number 1
SELECT A.name AS 'Analyst Name',
I.title AS 'Incident',
IA.assigned_at AS 'Assigned at'
FROM Analysts A
JOIN Incidentassignment IA ON A.analyst_id = IA.analyst_id
JOIN Incidents I ON IA.incident_id = I.incident_id
WHERE EXTRACT(DAY FROM assigned_at)>=15
ORDER BY EXTRACT(DAY FROM assigned_at);


-- Number 2
UPDATE incidents
SET status = 'resolved', closed_at = CURDATE()
WHERE status = 'in_progress';

SELECT * FROM incidents;


-- Number 3
UPDATE Analysts
SET availability_status = 'busy'
WHERE availability_status = 'available';

SELECT A.name AS 'Analyst Name',
I.title  AS 'Assigned Incidents',
availability_status AS 'Availability'
FROM Analysts A
JOIN IncidentAssignment IA ON A.analyst_id = IA.analyst_id
JOIN Incidents I ON I.incident_id = IA.incident_id;
