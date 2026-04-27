DROP DATABASE IF EXISTS sensor_fleet_db;
CREATE DATABASE sensor_fleet_db;
USE sensor_fleet_db;

CREATE TABLE firmware (
    firmware_id INT PRIMARY KEY AUTO_INCREMENT,
    version VARCHAR(20) NOT NULL,
    release_date DATE NOT NULL,
    description TEXT
);

CREATE TABLE deployments (
    deployment_id INT PRIMARY KEY AUTO_INCREMENT,
    site_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    start_date DATE,
    end_date DATE
);

CREATE TABLE gateways (
    gateway_id INT PRIMARY KEY AUTO_INCREMENT,
    gateway_name VARCHAR(100),
    ip_address VARCHAR(50) UNIQUE,
    location VARCHAR(100),
    firmware_id INT,
    status VARCHAR(20) CHECK (status IN ('active','inactive','maintenance')),
    FOREIGN KEY (firmware_id) REFERENCES firmware(firmware_id)
);

CREATE TABLE sensors (
    sensor_id INT PRIMARY KEY AUTO_INCREMENT,
    sensor_name VARCHAR(100),
    sensor_type VARCHAR(50),
    serial_number VARCHAR(100) UNIQUE,
    firmware_id INT,
    gateway_id INT,
    deployment_id INT,
    status VARCHAR(20) CHECK (status IN ('active','inactive','maintenance')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (firmware_id) REFERENCES firmware(firmware_id),
    FOREIGN KEY (gateway_id) REFERENCES gateways(gateway_id),
    FOREIGN KEY (deployment_id) REFERENCES deployments(deployment_id)
);

CREATE TABLE readings (
    reading_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    sensor_id INT,
    timestamp DATETIME,
    value DECIMAL(10,2),
    unit VARCHAR(20),
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
);

INSERT INTO firmware (version, release_date, description) VALUES
('1.0','2023-01-01','Initial'),('1.1','2023-02-01','Bug fixes'),
('1.2','2023-03-01','Improved stability'),('1.3','2023-04-01','Security patch'),
('1.4','2023-05-01','Performance update'),('1.5','2023-06-01','Minor fixes'),
('1.6','2023-07-01','Sensor calibration'),('1.7','2023-08-01','Gateway sync'),
('1.8','2023-09-01','UI update'),('1.9','2023-10-01','Optimization'),
('2.0','2023-11-01','Major release'),('2.1','2023-12-01','Patch'),
('2.2','2024-01-01','Enhancement'),('2.3','2024-02-01','Fix'),
('2.4','2024-03-01','Upgrade'),('2.5','2024-04-01','Patch'),
('2.6','2024-05-01','Improvement'),('2.7','2024-06-01','Security'),
('2.8','2024-07-01','Stability'),('2.9','2024-08-01','Latest');

INSERT INTO deployments (site_name, location, latitude, longitude, start_date, end_date) VALUES
('Site A','Manila',14.5995,120.9842,'2023-01-01',NULL),
('Site B','Cebu',10.3157,123.8854,'2023-01-01',NULL),
('Site C','Davao',7.1907,125.4553,'2023-01-01',NULL),
('Site D','Laguna',14.1700,121.2400,'2023-01-01',NULL),
('Site E','Baguio',16.4023,120.5960,'2023-01-01',NULL),
('Site F','Iloilo',10.7202,122.5621,'2023-01-01',NULL),
('Site G','Batangas',13.7565,121.0583,'2023-01-01',NULL),
('Site H','Pampanga',15.0794,120.6200,'2023-01-01',NULL),
('Site I','Zamboanga',6.9214,122.0790,'2023-01-01',NULL),
('Site J','Cagayan',18.1647,121.7430,'2023-01-01',NULL),
('Site K','Quezon',14.1000,121.6000,'2023-01-01',NULL),
('Site L','Rizal',14.5800,121.2000,'2023-01-01',NULL),
('Site M','Palawan',9.8349,118.7384,'2023-01-01',NULL),
('Site N','Samar',11.2433,125.0000,'2023-01-01',NULL),
('Site O','Leyte',10.8625,124.8811,'2023-01-01',NULL),
('Site P','Mindoro',13.1532,121.1800,'2023-01-01',NULL),
('Site Q','Negros',9.3068,123.3054,'2023-01-01',NULL),
('Site R','Tarlac',15.4755,120.5963,'2023-01-01',NULL),
('Site S','Bulacan',14.7943,120.8799,'2023-01-01',NULL),
('Site T','Albay',13.1775,123.5280,'2023-01-01',NULL);

INSERT INTO gateways (gateway_name, ip_address, location, firmware_id, status) VALUES
('GW1','192.168.1.1','Manila',1,'active'),
('GW2','192.168.1.2','Cebu',2,'active'),
('GW3','192.168.1.3','Davao',3,'maintenance'),
('GW4','192.168.1.4','Laguna',4,'active'),
('GW5','192.168.1.5','Baguio',5,'inactive'),
('GW6','192.168.1.6','Iloilo',6,'active'),
('GW7','192.168.1.7','Batangas',7,'active'),
('GW8','192.168.1.8','Pampanga',8,'active'),
('GW9','192.168.1.9','Zamboanga',9,'maintenance'),
('GW10','192.168.1.10','Cagayan',10,'active'),
('GW11','192.168.1.11','Quezon',11,'active'),
('GW12','192.168.1.12','Rizal',12,'active'),
('GW13','192.168.1.13','Palawan',13,'inactive'),
('GW14','192.168.1.14','Samar',14,'active'),
('GW15','192.168.1.15','Leyte',15,'active'),
('GW16','192.168.1.16','Mindoro',16,'active'),
('GW17','192.168.1.17','Negros',17,'active'),
('GW18','192.168.1.18','Tarlac',18,'maintenance'),
('GW19','192.168.1.19','Bulacan',19,'active'),
('GW20','192.168.1.20','Albay',20,'active');

INSERT INTO sensors (sensor_name, sensor_type, serial_number, firmware_id, gateway_id, deployment_id, status) VALUES
('Temp1','Temperature','SN001',1,1,1,'active'),
('Temp2','Temperature','SN002',2,2,2,'active'),
('Hum1','Humidity','SN003',3,3,3,'inactive'),
('Hum2','Humidity','SN004',4,4,4,'active'),
('Pres1','Pressure','SN005',5,5,5,'active'),
('Pres2','Pressure','SN006',6,6,6,'maintenance'),
('Light1','Light','SN007',7,7,7,'active'),
('Light2','Light','SN008',8,8,8,'active'),
('Temp3','Temperature','SN009',9,9,9,'active'),
('Temp4','Temperature','SN010',10,10,10,'inactive'),
('Hum3','Humidity','SN011',11,11,11,'active'),
('Hum4','Humidity','SN012',12,12,12,'active'),
('Pres3','Pressure','SN013',13,13,13,'active'),
('Pres4','Pressure','SN014',14,14,14,'active'),
('Light3','Light','SN015',15,15,15,'active'),
('Light4','Light','SN016',16,16,16,'maintenance'),
('Temp5','Temperature','SN017',17,17,17,'active'),
('Temp6','Temperature','SN018',18,18,18,'active'),
('Hum5','Humidity','SN019',19,19,19,'inactive'),
('Hum6','Humidity','SN020',20,20,20,'active');

INSERT INTO readings (sensor_id, timestamp, value, unit) VALUES
(1,NOW(),25.5,'C'),(2,NOW(),26.1,'C'),(3,NOW(),60,'RH'),
(4,NOW(),58,'RH'),(5,NOW(),101.3,'kPa'),(6,NOW(),100.8,'kPa'),
(7,NOW(),300,'Lux'),(8,NOW(),320,'Lux'),(9,NOW(),24.9,'C'),
(10,NOW(),27.2,'C'),(11,NOW(),62,'RH'),(12,NOW(),59,'RH'),
(13,NOW(),102.1,'kPa'),(14,NOW(),101.7,'kPa'),
(15,NOW(),310,'Lux'),(16,NOW(),330,'Lux'),
(17,NOW(),26.5,'C'),(18,NOW(),25.8,'C'),
(19,NOW(),61,'RH'),(20,NOW(),57,'RH');

SELECT * from firmware;
SELECT * from deployments;
SELECT * from gateways;
SELECT * from sensors;
SELECT * from readings;

-- JOIN QUERIES (3)
SELECT s.sensor_name, g.gateway_name, d.site_name
FROM sensors s
JOIN gateways g ON s.gateway_id = g.gateway_id
JOIN deployments d ON s.deployment_id = d.deployment_id;

-- 2. Sensors with firmware version
SELECT s.sensor_name, f.version
FROM sensors s
JOIN firmware f ON s.firmware_id = f.firmware_id;

-- 3. Readings with sensor info
SELECT s.sensor_name, r.value, r.unit
FROM readings r
JOIN sensors s ON r.sensor_id = s.sensor_id;


-- SUBQUERIES (2)
-- Sensors using latest firmware
SELECT sensor_name
FROM sensors
WHERE firmware_id = (SELECT MAX(firmware_id) FROM firmware);

-- Sensors with readings above average
SELECT sensor_id, value
FROM readings
WHERE value > (SELECT AVG(value) FROM readings);


-- AGGREGATE FUNCTIONS
-- Count sensors per status
SELECT status, COUNT(*) FROM sensors GROUP BY status;

-- Average reading value
SELECT AVG(value) AS avg_reading FROM readings;

-- Sum of all readings
SELECT SUM(value) AS total_value FROM readings;


-- CONSTRAINT TEST (should fail)
-- Duplicate serial number (violates UNIQUE)
-- INSERT INTO sensors (sensor_name, sensor_type, serial_number)
-- VALUES ('Test','Temp','SN001');


-- timestamp to 04-26-2026 to all values below 100


SELECT 
	g.gateway_name AS gateway_name, 
    d.site_name AS deployment_name
FROM sensors s
JOIN gateways g ON s.gateway_id = g.gateway_id
JOIN deployments d ON s.deployment_id = d.deployment_id
WHERE s.status = 'active';

SELECT 
	d.site_name AS site_name,
    d.location AS location
FROM deployments d
JOIN sensors s ON d.deployment_id  = s.deployment_id
WHERE s.sensor_type = 'Light';

UPDATE readings
SET timestamp = '2026-04-26'
WHERE value < 100;

SELECT * from readings;