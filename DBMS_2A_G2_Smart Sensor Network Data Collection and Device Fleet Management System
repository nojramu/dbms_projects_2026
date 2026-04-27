DROP DATABASE IF EXISTS sensor_device_management;
CREATE DATABASE sensor_device_management;
USE sensor_device_management;

CREATE TABLE locations (
location_id INT AUTO_INCREMENT PRIMARY KEY,
site_name VARCHAR(100) NOT NULL,
building_name VARCHAR(100) NOT NULL,
floor_number INT NOT NULL,
room VARCHAR(50) 
);

CREATE TABLE firmwares (
firmware_id INT AUTO_INCREMENT PRIMARY KEY, 
version_number VARCHAR(20) NOT NULL, 
device_type ENUM('gateway', 'sensor') NOT NULL,
file_path VARCHAR(255) NOT NULL, 
release_date DATE NOT NULL,
check_sum VARCHAR(100) NOT NULL,
is_stable BOOLEAN DEFAULT TRUE
); 

CREATE TABLE deployments ( 
deployment_id INT AUTO_INCREMENT PRIMARY KEY,
location_id INT NOT NULL, 
environment ENUM('indoor', 'outdoor', 'industrial', 'residential'), 
deployment_date DATE NOT NULL, 
deployment_status ENUM('planned', 'active', 'inactive', 'maintenance', 'decommissioned'), 
FOREIGN KEY (location_id) REFERENCES locations(location_id)
); 

CREATE TABLE gateways ( 
gateway_id INT AUTO_INCREMENT PRIMARY KEY,
gateway_name VARCHAR(50) NOT NULL, 
deployment_id INT NOT NULL, 
firmware_id INT NOT NULL, 
ip_address VARCHAR(50) UNIQUE NOT NULL, 
gateway_status ENUM('online', 'offline', 'maintenance', 'error'),
created_at DATETIME,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
FOREIGN KEY (firmware_id) REFERENCES firmwares(firmware_id),
FOREIGN KEY (deployment_id) REFERENCES deployments(deployment_id)
); 


CREATE TABLE sensor_models (
model_id INT AUTO_INCREMENT PRIMARY KEY,
model_name VARCHAR(50) NOT NULL,
sensor_type VARCHAR(50) NOT NULL,
accuracy DECIMAL(5,2) NOT NULL,
range_min DECIMAL(10,2) NOT NULL,
range_max DECIMAL(10,2) NOT NULL,
sensor_unit VARCHAR(20) NOT NULL
);

CREATE TABLE sensors (
sensor_id INT AUTO_INCREMENT PRIMARY KEY, 
model_id INT NOT NULL, 
firmware_id INT NOT NULL,
gateway_id INT NOT NULL,
status ENUM('active', 'inactive', 'maintenance', 'faulty') NOT NULL,
installation_date DATE,
last_active DATETIME,
created_at DATETIME NOT NULL,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (model_id) REFERENCES sensor_models(model_id),
FOREIGN KEY (firmware_id) REFERENCES firmwares(firmware_id),
FOREIGN KEY (gateway_id) REFERENCES gateways(gateway_id)
);

CREATE TABLE readings ( 
reading_id BIGINT AUTO_INCREMENT PRIMARY KEY,
sensor_id INT,
recorded_at DATETIME NOT NULL,
value DECIMAL(10,4) NOT NULL,
quality_flag ENUM('good', 'bad', 'estimated'),
ingested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
ON DELETE CASCADE
);

CREATE TABLE sensor_gateway_history (
sg_id INT AUTO_INCREMENT PRIMARY KEY,
sensor_id INT NOT NULL,
gateway_id INT NOT NULL,
connected_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
disconnected_at DATETIME, 
connection_status ENUM('active', 'disconnected') DEFAULT 'active',
UNIQUE KEY unique_active_connection (sensor_id, disconnected_at),
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id),
FOREIGN KEY (gateway_id) REFERENCES gateways(gateway_id)
);

CREATE TABLE sensor_firmware_history (
sf_id INT AUTO_INCREMENT PRIMARY KEY,
sensor_id INT NOT NULL,
firmware_id INT NOT NULL,
sf_previous_firmware_id INT NOT NULL, 
installed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
sf_status ENUM('success', 'failed', 'pending') NOT NULL,
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id),
FOREIGN KEY (firmware_id) REFERENCES firmwares(firmware_id)
);

CREATE TABLE gateway_firmware_history (  
gf_id INT AUTO_INCREMENT PRIMARY KEY,
gateway_id INT NOT NULL,              
firmware_id INT NOT NULL,
gf_previous_firmware_id INT NOT NULL, 
installed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
gf_status ENUM('success', 'failed', 'pending') NOT NULL,
FOREIGN KEY (gateway_id) REFERENCES gateways(gateway_id),    
FOREIGN KEY (firmware_id) REFERENCES firmwares(firmware_id)
);

CREATE TABLE alerts (
alert_id INT AUTO_INCREMENT PRIMARY KEY,
sensor_id INT,
alert_type VARCHAR(50),
message TEXT,
severity ENUM('low','medium','high','critical'),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
is_resolved BOOLEAN DEFAULT FALSE,
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
);

INSERT INTO locations (site_name, building_name, floor_number, room)
VALUES
('Main Campus', 'Engineering Building', 2, 'EN EEPL 4'),
('Main Campus', 'Engineering Building', 1, 'EN 103'),
('Main Campus', 'Tan Yan Kee Building', 8, 'TYK 807'),
('City Center Site', 'Control Tower', 5, 'Server Room'),
('Residential Area A', 'Community Hall', 1, 'Storage Room'),
('Industrial Park Zone A', 'Factory A', 2, 'Monitoring Room'),
('Industrial Park Zone B', 'Factory B', 3, 'Control Room'),
('Remote Station Alpha', 'Weather Tower', 1, 'Base Unit'),
('Sunrise Village', 'Residence Unit A3', 1, 'Kitchen'),
('Riverbank Monitoring Site', 'Sensor Post A', 4, 'Control Box'),
('Community Evacuation Center', 'Relief Operations Room', 1, 'Monitoring Area'),
('Community Evacuation Center', 'Relief Operations Room', 1, 'Monitoring Area'),
('Residential Block 12', 'House Block 12 Lot 8', 2, 'Living Room'),
('Residential Block 14', 'House Block 14 Lot 1', 1, 'Garage'),
('City Drainage Monitoring Site', 'Drainage Control Station', 1, 'Sensor Cabinet'),
('Neighborhood Playground Area', 'Lighting Control Unit', 1, 'Control Panel'),
('Subdivision Phase 5', 'House Block 5 Lot 11', 2, 'Bedroom'),
('River Flood Monitoring Sector C', 'Flood Warning Station', 1, 'Equipment Shelter'),
('Public Transport Terminal', 'Environmental Sensor Booth', 1, 'Monitoring Desk'),
('Residential Cluster D', 'House Block 2 Lot 4', 1, 'Kitchen'),
('Open Field Weather Observation Area', 'Weather Monitoring Post', 1, 'Base Unit');

INSERT INTO firmwares (version_number, device_type, file_path, release_date, check_sum, is_stable) 
VALUES 
('v1.3.0', 'sensor', '/updates/bin/s_v130.bin', '2026-04-21', 'sha256:a1a1', TRUE),
('v1.3.1', 'sensor', '/updates/bin/s_v131.bin', '2026-04-25', 'sha256:a1a2', TRUE),
('v2.2.0', 'sensor', '/updates/bin/s_v220.bin', '2026-05-01', 'sha256:b2b1', TRUE),
('v2.2.1', 'sensor', '/updates/bin/s_v221.bin', '2026-05-05', 'sha256:b2b2', TRUE),
('v2.3.0', 'sensor', '/updates/bin/s_v230_beta.bin', '2026-05-10', 'sha256:b2b3', FALSE),
('v1.4.0', 'sensor', '/updates/bin/s_v140.bin', '2026-05-15', 'sha256:a1a3', TRUE),
('v2.4.0', 'sensor', '/updates/bin/s_v240.bin', '2026-05-20', 'sha256:b2b4', TRUE),
('v1.5.0', 'sensor', '/updates/bin/s_v150.bin', '2026-05-25', 'sha256:a1a4', TRUE),
('v2.5.0', 'sensor', '/updates/bin/s_v250.bin', '2026-06-01', 'sha256:b2b5', TRUE),
('v1.6.0', 'sensor', '/updates/bin/s_v160.bin', '2026-06-05', 'sha256:a1a5', TRUE),
('v4.2.0', 'gateway', '/updates/bin/g_v420.bin', '2026-04-22', 'sha256:c3c1', TRUE),
('v4.2.1', 'gateway', '/updates/bin/g_v421.bin', '2026-04-26', 'sha256:c3c2', TRUE),
('v4.3.0', 'gateway', '/updates/bin/g_v430_beta.bin', '2026-05-02', 'sha256:c3c3', FALSE),
('v5.0.0', 'gateway', '/updates/bin/g_v500.bin', '2026-05-08', 'sha256:d4d1', TRUE),
('v5.0.1', 'gateway', '/updates/bin/g_v501.bin', '2026-05-12', 'sha256:d4d2', TRUE),
('v3.3.0', 'gateway', '/updates/bin/g_v330.bin', '2026-05-16', 'sha256:e5e1', TRUE),
('v3.3.1', 'gateway', '/updates/bin/g_v331.bin', '2026-05-21', 'sha256:e5e2', TRUE),
('v3.4.0', 'gateway', '/updates/bin/g_v340_dev.bin', '2026-05-26', 'sha256:e5e3', FALSE),
('v4.4.0', 'gateway', '/updates/bin/g_v440.bin', '2026-06-02', 'sha256:c3c4', TRUE),
('v5.1.0', 'gateway', '/updates/bin/g_v510.bin', '2026-06-06', 'sha256:d4d3', TRUE);

INSERT INTO deployments (location_id, environment, deployment_date, deployment_status)
VALUES
(1, 'indoor', '2023-01-15', 'active'),  
(2, 'indoor', '2023-01-20', 'active'), 
(3, 'indoor', '2023-02-10', 'active'),    
(4, 'industrial', '2024-05-01', 'active'), 
(5, 'residential', '2024-06-12', 'active'), 
(6, 'industrial', '2024-08-15', 'maintenance'), 
(7, 'industrial', '2024-08-20', 'active'), 
(8, 'outdoor', '2025-01-05', 'active'),    
(9, 'residential', '2025-02-14', 'active'), 
(10, 'outdoor', '2025-03-20', 'active'),   
(11, 'indoor', '2025-04-01', 'active'),  
(12, 'indoor', '2025-04-01', 'planned'),   
(13, 'residential', '2025-06-10', 'active'), 
(14, 'residential', '2025-06-12', 'active'), 
(15, 'industrial', '2025-09-01', 'active'), 
(16, 'outdoor', '2025-10-15', 'active'),   
(17, 'residential', '2025-11-20', 'maintenance'), 
(18, 'outdoor', '2026-01-10', 'active'),    
(19, 'industrial', '2026-02-01', 'active'), 
(20, 'residential', '2026-03-15', 'active'), 
(21, 'outdoor', '2026-04-10', 'active');    

INSERT INTO gateways (gateway_name, deployment_id, firmware_id, ip_address, gateway_status, created_at, updated_at)
VALUES
('GW-MAIN-ENG-01', 1, 1, '10.0.1.11', 'online', '2023-01-16 09:30:00', '2025-12-10 14:20:00'),
('GW-MAIN-TYK-01', 3, 2, '10.0.1.12', 'online', '2023-02-12 11:00:00', '2026-01-05 08:45:00'),
('GW-CITY-CTRL-01', 4, 5, '10.0.2.11', 'online', '2024-05-02 14:15:00', '2025-11-20 16:30:00'),
('GW-IND-FACT-A', 6, 6, '10.0.3.11', 'maintenance', '2024-08-16 08:00:00', '2026-04-15 10:00:00'),
('GW-IND-FACT-B', 7, 9, '10.0.3.12', 'online', '2024-08-22 10:30:00', '2026-02-28 13:15:00'),
('GW-REMOTE-ALPHA', 8, 10, '10.0.4.11', 'online', '2025-01-06 12:00:00', '2026-03-12 09:00:00'),
('GW-RIVER-POST', 10, 1, '10.0.4.50', 'online', '2025-03-22 15:45:00', '2026-04-01 11:20:00'),
('GW-EVAC-MAIN', 11, 2, '10.0.5.11', 'online', '2025-04-05 09:00:00', '2026-03-30 17:00:00'),
('GW-DRAIN-STN', 15, 5, '10.0.6.11', 'error', '2025-09-05 13:20:00', '2026-04-18 22:10:00'),
('GW-FLOOD-SEC-C', 18, 6, '10.0.7.11', 'online', '2026-01-12 08:30:00', '2026-04-10 14:00:00'),
('GW-TERMINAL-X', 19, 9, '10.0.8.11', 'offline', '2026-02-05 11:15:00', '2026-04-19 09:45:00'),
('GW-WEATHER-FIELD', 21, 10, '10.0.9.11', 'online', '2026-04-12 10:00:00', '2026-04-20 08:00:00'),
('GW-LAB-SENS-01', 2, 1, '10.0.1.20', 'maintenance', '2023-03-12 10:15:00', '2026-01-15 09:00:00'),
('GW-RES-COMM-01', 5, 2, '10.0.5.50', 'online', '2024-06-15 14:00:00', '2025-12-05 11:30:00'),
('GW-SUNRISE-VILL', 9, 5, '10.0.5.60', 'online', '2025-02-16 08:45:00', '2026-02-10 16:20:00'),
('GW-EVAC-NORTH', 12, 6, '10.0.5.22', 'offline', '2025-04-05 13:10:00', '2025-11-12 10:00:00'),
('GW-BLOCK12-GATE', 13, 9, '10.0.5.80', 'online', '2025-06-15 11:00:00', '2026-04-05 15:45:00'),
('GW-BLOCK14-GATE', 14, 10, '10.0.5.90', 'online', '2025-06-18 09:30:00', '2026-03-22 08:15:00'),
('GW-PLAYGROUND-X', 16, 1, '10.0.9.55', 'online', '2025-10-18 16:20:00', '2026-04-18 11:00:00'),
('GW-PHASE5-CTRL', 17, 2, '10.0.5.101', 'maintenance', '2025-11-25 10:45:00', '2026-04-19 13:00:00'),
('GW-CLUSTER-D-HUB', 20, 5, '10.0.5.150', 'online', '2026-03-18 09:00:00', '2026-04-10 17:30:00'),
('GW-ENG-BACKUP', 1, 9, '10.0.1.15', 'online', '2023-04-01 08:00:00', '2026-04-01 10:20:00');

INSERT INTO sensor_models (model_name, sensor_type, accuracy, range_min, range_max, sensor_unit)
VALUES
('TMP-X100', 'Temperature', 0.50, -40.00, 125.00, '°C'),
('HMD-200', 'Humidity', 1.20, 0.00, 100.00, '%'),
('PRS-330', 'Pressure', 0.80, 300.00, 1100.00, 'hPa'),
('MOT-A1', 'Motion', 0.95, 0.00, 1.00, 'Boolean'),
('GAS-900', 'Gas', 2.50, 0.00, 500.00, 'ppm'),
('LGT-50', 'Light', 1.10, 0.00, 10000.00, 'Lux'),
('SLM-120', 'Soil Moisture', 1.50, 0.00, 100.00, '%'),
('VIB-77', 'Vibration', 0.70, 0.00, 16.00, 'm/s²'),
('CO2-PRO', 'Carbon Dioxide', 2.00, 400.00, 5000.00, 'ppm'),
('WND-SPD-01', 'Wind Speed', 0.50, 0.00, 60.00, 'm/s'),
('TMP-Z300', 'Temperature', 0.25, -60.00, 180.00, '°C'),
('HMD-400', 'Humidity', 0.90, 0.00, 100.00, '%'),
('GAS-1500', 'Gas', 1.80, 0.00, 1500.00, 'ppm'),
('AQI-BASE', 'Air Quality', 5.00, 0.00, 500.00, 'Index'),
('UV-INDEX-1', 'UV Radiation', 0.10, 0.00, 15.00, 'Index'),
('FLW-MTR-X', 'Water Flow', 1.00, 0.00, 100.00, 'L/min'),
('SND-LVL-88', 'Sound Level', 1.50, 30.00, 130.00, 'dB'),
('PWR-MON-2', 'Power Usage', 0.05, 0.00, 5000.00, 'Watts'),
('DIST-ULTRA', 'Distance', 0.20, 0.02, 4.00, 'm'),
('GPS-NEO-7', 'Location', 2.50, -180.00, 180.00, 'Degrees');

INSERT INTO sensors (model_id, firmware_id, gateway_id, status, installation_date, last_active, created_at, updated_at)
VALUES
(1, 3, 1, 'active', '2023-01-18', '2026-04-20 08:00:00', '2023-01-15 10:00:00', '2026-04-20 08:00:00'),
(2, 4, 1, 'active', '2023-03-10', '2026-04-20 07:45:00', '2023-03-05 09:00:00', '2026-04-20 07:45:00'),
(3, 7, 2, 'active', '2024-11-01', '2026-04-20 08:15:00', '2024-10-25 14:30:00', '2026-04-20 08:15:00'),
(4, 8, 3, 'inactive', '2021-07-05', '2026-04-18 18:30:00', '2021-06-30 11:00:00', '2026-04-18 18:30:00'),
(5, 3, 4, 'faulty', '2025-09-05', '2026-04-17 14:00:00', '2025-08-29 12:00:00', '2026-04-17 14:00:00'),
(6, 4, 5, 'active', '2025-10-20', '2026-04-20 08:20:00', '2025-10-15 08:30:00', '2026-04-20 08:20:00'),
(7, 7, 6, 'active', '2024-11-15', '2026-04-20 06:30:00', '2024-11-12 09:10:00', '2026-04-20 06:30:00'),
(8, 8, 7, 'maintenance', '2025-01-10', '2026-04-19 12:00:00', '2024-12-20 10:00:00', '2026-04-19 12:00:00'),
(9, 3, 8, 'active', '2025-02-20', '2026-04-20 08:10:00', '2025-02-15 08:45:00', '2026-04-20 08:10:00'),
(10, 4, 10, 'active', '2025-03-25', '2026-04-20 08:05:00', '2025-03-20 07:30:00', '2026-04-20 08:05:00'),
(11, 7, 11, 'active', '2025-04-10', '2026-04-20 07:50:00', '2025-04-01 09:00:00', '2026-04-20 07:50:00'),
(12, 8, 15, 'active', '2025-09-10', '2026-04-20 08:25:00', '2025-09-01 06:00:00', '2026-04-20 08:25:00'),
(13, 3, 18, 'inactive', '2026-01-15', '2026-04-18 16:10:00', '2026-01-10 08:00:00', '2026-04-18 16:10:00'),
(14, 4, 19, 'active', '2026-02-10', '2026-04-20 08:00:00', '2026-02-05 09:30:00', '2026-04-20 08:00:00'),
(15, 7, 21, 'active', '2026-04-15', '2026-04-20 08:35:00', '2026-04-10 10:10:00', '2026-04-20 08:35:00'),
(16, 8, 1, 'active', '2025-07-15', '2026-04-20 08:40:00', '2025-07-08 07:00:00', '2026-04-20 08:40:00'),
(17, 3, 3, 'faulty', '2021-07-15', '2026-04-17 13:40:00', '2021-07-10 12:00:00', '2026-04-17 13:40:00'),
(18, 4, 5, 'active', '2024-07-20', '2026-04-20 07:15:00', '2024-07-12 08:15:00', '2026-04-20 07:15:00'),
(19, 7, 7, 'maintenance', '2026-03-01', '2026-04-18 15:00:00', '2026-02-20 09:00:00', '2026-04-18 15:00:00'),
(20, 8, 2, 'active', '2021-07-20', '2026-04-20 08:10:00', '2021-07-16 07:45:00', '2026-04-20 08:10:00');


INSERT INTO readings (sensor_id, recorded_at, value, quality_flag, ingested_at) 
VALUES
(1, '2026-04-15 08:00:00', 25.4000, 'good', '2026-04-15 08:00:05'),
(1, '2026-04-16 09:00:00', 26.1200, 'good', '2026-04-16 09:00:04'),
(1, '2026-04-17 10:00:00', 27.0500, 'good', '2026-04-17 10:00:03'),
(1, '2026-04-18 11:00:00', 28.3000, 'good', '2026-04-18 11:00:04'),
(2, '2026-04-15 08:05:00', 60.2000, 'good', '2026-04-15 08:05:06'),
(2, '2026-04-16 09:05:00', 58.9000, 'good', '2026-04-16 09:05:05'),
(2, '2026-04-17 10:05:00', 57.4000, 'good', '2026-04-17 10:05:04'),
(2, '2026-04-18 11:05:00', 56.8000, 'good', '2026-04-18 11:05:05'),
(3, '2026-04-15 08:10:00', 1013.2500, 'good', '2026-04-15 08:10:05'),
(3, '2026-04-16 09:10:00', 1009.5000, 'good', '2026-04-16 09:10:04'),
(3, '2026-04-17 10:10:00', 1011.1000, 'good', '2026-04-17 10:10:03'),
(3, '2026-04-18 11:10:00', 1007.5000, 'good', '2026-04-18 11:10:04'),
(4, '2026-04-15 08:15:00', 1.0000, 'good', '2026-04-15 08:15:07'),
(4, '2026-04-16 09:15:00', 0.0000, 'good', '2026-04-16 09:15:06'),
(4, '2026-04-17 10:15:00', 1.0000, 'good', '2026-04-17 10:15:05'),
(4, '2026-04-18 11:15:00', 1.0000, 'estimated', '2026-04-18 11:15:06'),
(5, '2026-04-15 08:20:00', 120.8000, 'good', '2026-04-15 08:20:04'),
(5, '2026-04-16 09:20:00', 450.6500, 'bad', '2026-04-16 09:20:03'),
(5, '2026-04-17 10:20:00', 125.5500, 'good', '2026-04-17 10:20:05'),
(5, '2026-04-18 11:20:00', 122.4000, 'good', '2026-04-18 11:20:05');


INSERT INTO sensor_gateway_history (sensor_id, gateway_id, connected_at, disconnected_at, connection_status)
VALUES
(1, 3, '2023-01-18 10:00:00', '2025-01-15 08:30:00', 'disconnected'),
(1, 1, '2025-01-15 09:00:00', NULL, 'active'),
(2, 1, '2023-03-10 09:30:00', NULL, 'active'),
(4, 8, '2021-07-05 11:30:00', '2026-04-10 14:00:00', 'disconnected'),
(4, 3, '2026-04-10 14:15:00', NULL, 'active'),
(6, 12, '2025-10-20 08:45:00', '2026-01-10 10:20:00', 'disconnected'),
(6, 5, '2026-01-10 10:45:00', NULL, 'active'),
(3, 2, '2024-11-01 15:00:00', NULL, 'active'),
(5, 4, '2025-09-05 12:30:00', NULL, 'active'),
(7, 6, '2024-11-15 09:45:00', NULL, 'active');

INSERT INTO sensor_firmware_history (sensor_id, firmware_id, sf_previous_firmware_id, installed_at, sf_status)
VALUES
(1, 2, 1, '2024-06-01 02:00:00', 'success'),
(1, 3, 2, '2025-12-10 03:15:00', 'success'),
(2, 4, 1, '2026-01-15 04:00:00', 'success'),
(4, 8, 6, '2023-08-11 23:30:00', 'failed'),
(4, 8, 6, '2023-08-12 01:15:00', 'success'),
(3, 7, 5, '2025-05-20 02:45:00', 'success'),
(5, 3, 2, '2026-02-28 03:00:00', 'success'),
(7, 7, 4, '2025-08-22 01:20:00', 'success'),
(8, 8, 7, '2026-04-10 02:10:00', 'success'),
(6, 4, 3, '2026-04-19 23:55:00', 'pending');

INSERT INTO gateway_firmware_history (gateway_id, firmware_id, gf_previous_firmware_id, installed_at, gf_status)
VALUES
(1, 2, 1, '2024-01-10 01:00:00', 'success'),
(1, 5, 2, '2025-11-20 02:30:00', 'success'),
(3, 2, 1, '2024-05-15 03:15:00', 'success'),
(4, 5, 3, '2025-06-10 04:00:00', 'failed'),
(4, 5, 3, '2025-06-11 02:45:00', 'success'),
(6, 6, 4, '2025-12-01 01:50:00', 'success'),
(7, 9, 6, '2026-01-20 02:10:00', 'success'),
(8, 10, 8, '2026-02-15 03:30:00', 'success'),
(11, 2, 1, '2026-04-18 01:20:00', 'success'),
(10, 2, 1, '2026-04-20 08:30:00', 'pending');

INSERT INTO alerts (sensor_id, alert_type, message, severity, created_at, is_resolved)
VALUES
(5, 'threshold_breach', 'High gas concentration detected (450.65 ppm)', 'critical', '2026-04-16 09:20:05', FALSE),
(5, 'hardware_fault', 'Sensor calibration error - Readings erratic', 'high', '2026-04-17 14:00:00', FALSE),
(4, 'connection_lost', 'Heartbeat timeout - Sensor unresponsive for 12 hours', 'high', '2026-04-18 18:35:00', FALSE),
(8, 'maintenance_required', 'Scheduled preventative maintenance and calibration due', 'medium', '2026-04-15 08:00:00', FALSE),
(8, 'threshold_breach', 'Temperature baseline shifted - manual inspection needed', 'medium', '2026-04-18 12:00:00', FALSE),
(17, 'hardware_fault', 'Power supply voltage drop detected - Suspected battery failure', 'critical', '2026-04-17 13:40:00', FALSE),
(19, 'maintenance_required', 'Manual reboot required post-firmware issue', 'medium', '2026-04-18 15:00:00', FALSE),
(6, 'firmware_event', 'Firmware update OTA started', 'low', '2026-04-19 23:55:00', TRUE),
(13, 'connection_lost', 'Sensor offline for > 48 hours', 'medium', '2026-04-18 16:15:00', FALSE),
(1, 'threshold_breach', 'Minor temperature spike to 30.5°C', 'medium', '2026-04-10 14:20:00', TRUE),
(1, 'network_warning', 'Gateway 1 uplink latency high', 'low', '2026-04-15 08:30:00', TRUE),
(2, 'threshold_breach', 'Humidity exceeded 80% threshold', 'medium', '2026-04-11 09:10:00', TRUE),
(3, 'threshold_breach', 'Rapid atmospheric pressure drop detected', 'high', '2026-04-12 11:45:00', TRUE),
(7, 'threshold_breach', 'Soil moisture below 15% - Irrigation check recommended', 'medium', '2026-04-19 06:30:00', FALSE),
(20, 'security', 'Enclosure tamper switch activated', 'critical', '2026-04-20 08:15:00', FALSE),
(10, 'network_warning', 'High packet loss on gateway uplink', 'medium', '2026-04-20 07:00:00', TRUE),
(11, 'threshold_breach', 'Pressure reading anomaly - flatlining data profile', 'low', '2026-04-19 14:00:00', TRUE),
(12, 'threshold_breach', 'Minor gas leak suspected (105 ppm)', 'high', '2026-04-19 22:10:00', FALSE),
(15, 'battery_warning', 'Battery level below 20%', 'medium', '2026-04-18 09:00:00', FALSE),
(18, 'hardware_fault', 'Checksum mismatch in telemetry payload', 'high', '2026-04-20 07:15:00', FALSE);


SELECT * FROM locations;
SELECT * FROM gateways;
SELECT * FROM firmwares;
SELECT * FROM sensors;
SELECT * FROM readings;
SELECT * FROM sensor_firmware_history;
SELECT * FROM sensor_gateway_history;
SELECT * FROM gateway_firmware_history;
SELECT * FROM alerts;

-- SELECT 
SELECT sensor_id, alert_type, severity
FROM alerts
WHERE is_resolved = FALSE; 

-- UPDATE 
UPDATE gateways
SET gateway_status = 'online'
WHERE gateway_id = 10; 

-- DELETE 
DELETE FROM deployments
WHERE deployment_status = 'planned'; 

-- AGGREGATE FUNCTIONS 
SELECT is_stable, 
	COUNT(*) AS total_stable_firmwares
    FROM FIRMWARES
	GROUP BY is_stable;

SELECT sensor_id,
	AVG(value) AS average_reading
	FROM readings
	GROUP BY sensor_id;

-- JOIN
SELECT g.gateway_name, f.version_number, h.installed_at
FROM gateways g
JOIN gateway_firmware_history h ON g.gateway_id = h.gateway_id
JOIN firmwares f ON h.firmware_id = f.firmware_id
WHERE h.gf_status = 'success';

SELECT l.site_name, l.building_name, d.environment, s.sensor_id, s.status
FROM locations l
JOIN deployments d ON l.location_id = d.deployment_id
JOIN gateways g ON d.deployment_id = g.deployment_id
JOIN sensors s ON g.gateway_id = s.gateway_id;

SELECT r.sensor_id, sm.model_name, sm.sensor_type, r.recorded_at, r.value, sm.sensor_unit
FROM readings r
LEFT JOIN sensors s ON r.sensor_id = s.sensor_id
LEFT JOIN sensor_models sm ON s.model_id = sm.model_id;

-- SUBQUERY
SELECT *
FROM sensors
WHERE sensor_id IN (
    SELECT sensor_id
    FROM readings
    WHERE quality_flag = 'bad'
);

SELECT *
FROM sensors
WHERE gateway_id IN (
    SELECT gateway_id
    FROM gateways
    WHERE deployment_id IN (
        SELECT deployment_id
        FROM deployments
        WHERE environment = 'industrial'
    )
);

-- VIOLATION
INSERT INTO gateways (gateway_name, deployment_id, firmware_id, ip_address, gateway_status, created_at, updated_at) 
VALUES
('GW-SEC-GATE-01', 1, 1, '10.0.3.12', 'online', '2023-01-16 09:30:00', '2025-12-10 14:20:00'); 

INSERT INTO sensors (model_id, firmware_id, gateway_id, status, created_at, updated_at) 
VALUES
(8, 1, 31, 'active', '2024-11-15', '2026-04-20 06:30:00', '2024-11-12 09:10:00', '2026-04-20 06:30:00');

INSERT INTO firmwares (version_number, device_type, file_path, release_date, check_sum, is_stable)
VALUES 
('v3.1.0', 'gateway', '/updates/bin/s_v130.bin', '2026-04-21', 'sha256:a1a1', TRUE);

SELECT deployment_id 
FROM deployments
WHERE deployment_status = 'maintenance';

SELECT COUNT(*) AS deployments_in_maintenance
FROM deployments
WHERE deployment_status = 'maintenance';




