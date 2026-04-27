CREATE DATABASE DBMS_FINALS;
USE DBMS_FINALS;


-- =========================
-- DROP TABLES (for rerun)
-- =========================
DROP TABLE IF EXISTS TestCases;
DROP TABLE IF EXISTS Bugs;
DROP TABLE IF EXISTS Sprints;
DROP TABLE IF EXISTS ProjectDevelopers;
DROP TABLE IF EXISTS Developers;
DROP TABLE IF EXISTS Projects;

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE Developers (
    developer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL
);

CREATE TABLE ProjectDevelopers (
    developer_id INT,
    project_id INT,
    PRIMARY KEY (developer_id, project_id),
    FOREIGN KEY (developer_id) REFERENCES Developers(developer_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE Sprints (
    sprint_id INT PRIMARY KEY,
    sprint_name VARCHAR(100) NOT NULL,
    project_id INT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE Bugs (
    bug_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL,
    sprint_id INT NOT NULL,
    developer_id INT NOT NULL,
    FOREIGN KEY (sprint_id) REFERENCES Sprints(sprint_id),
    FOREIGN KEY (developer_id) REFERENCES Developers(developer_id)
);

CREATE TABLE TestCases (
    testcase_id INT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    result VARCHAR(50) NOT NULL,
    bug_id INT NOT NULL,
    FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id)
);

-- =========================
-- INSERT DATA (20+ each)
-- =========================

-- Developers (20)
INSERT INTO Developers VALUES
(1,'Dev1','dev1@mail.com'),
(2,'Dev2','dev2@mail.com'),
(3,'Dev3','dev3@mail.com'),
(4,'Dev4','dev4@mail.com'),
(5,'Dev5','dev5@mail.com'),
(6,'Dev6','dev6@mail.com'),
(7,'Dev7','dev7@mail.com'),
(8,'Dev8','dev8@mail.com'),
(9,'Dev9','dev9@mail.com'),
(10,'Dev10','dev10@mail.com'),
(11,'Dev11','dev11@mail.com'),
(12,'Dev12','dev12@mail.com'),
(13,'Dev13','dev13@mail.com'),
(14,'Dev14','dev14@mail.com'),
(15,'Dev15','dev15@mail.com'),
(16,'Dev16','dev16@mail.com'),
(17,'Dev17','dev17@mail.com'),
(18,'Dev18','dev18@mail.com'),
(19,'Dev19','dev19@mail.com'),
(20,'Dev20','dev20@mail.com');

-- Projects (20)
INSERT INTO Projects VALUES
(1,'System A'),(2,'System B'),(3,'System C'),(4,'System D'),
(5,'System E'),(6,'System F'),(7,'System G'),(8,'System H'),
(9,'System I'),(10,'System J'),(11,'System K'),(12,'System L'),
(13,'System M'),(14,'System N'),(15,'System O'),(16,'System P'),
(17,'System Q'),(18,'System R'),(19,'System S'),(20,'System T');

-- ProjectDevelopers (M:N)
INSERT INTO ProjectDevelopers VALUES
(1,1),(2,1),(3,2),(4,2),(5,3),(6,3),(7,4),(8,4),
(9,5),(10,5),(11,6),(12,6),(13,7),(14,7),(15,8),(16,8),
(17,9),(18,9),(19,10),(20,10);

-- Sprints (20)
INSERT INTO Sprints VALUES
(1,'Sprint1',1),(2,'Sprint2',2),(3,'Sprint3',3),(4,'Sprint4',4),
(5,'Sprint5',5),(6,'Sprint6',6),(7,'Sprint7',7),(8,'Sprint8',8),
(9,'Sprint9',9),(10,'Sprint10',10),(11,'Sprint11',11),(12,'Sprint12',12),
(13,'Sprint13',13),(14,'Sprint14',14),(15,'Sprint15',15),(16,'Sprint16',16),
(17,'Sprint17',17),(18,'Sprint18',18),(19,'Sprint19',19),(20,'Sprint20',20);

-- Bugs (20)
INSERT INTO Bugs VALUES
(1,'Bug1','Open',1,1),(2,'Bug2','Closed',2,2),(3,'Bug3','Open',3,3),
(4,'Bug4','Closed',4,4),(5,'Bug5','Open',5,5),(6,'Bug6','Closed',6,6),
(7,'Bug7','Open',7,7),(8,'Bug8','Closed',8,8),(9,'Bug9','Open',9,9),
(10,'Bug10','Closed',10,10),(11,'Bug11','Open',11,11),(12,'Bug12','Closed',12,12),
(13,'Bug13','Open',13,13),(14,'Bug14','Closed',14,14),(15,'Bug15','Open',15,15),
(16,'Bug16','Closed',16,16),(17,'Bug17','Open',17,17),(18,'Bug18','Closed',18,18),
(19,'Bug19','Open',19,19),(20,'Bug20','Closed',20,20);

-- TestCases (20)
INSERT INTO TestCases VALUES
(1,'Test1','Pass',1),(2,'Test2','Fail',2),(3,'Test3','Pass',3),
(4,'Test4','Fail',4),(5,'Test5','Pass',5),(6,'Test6','Fail',6),
(7,'Test7','Pass',7),(8,'Test8','Fail',8),(9,'Test9','Pass',9),
(10,'Test10','Fail',10),(11,'Test11','Pass',11),(12,'Test12','Fail',12),
(13,'Test13','Pass',13),(14,'Test14','Fail',14),(15,'Test15','Pass',15),
(16,'Test16','Fail',16),(17,'Test17','Pass',17),(18,'Test18','Fail',18),
(19,'Test19','Pass',19),(20,'Test20','Fail',20);

-- =========================
-- BASIC OPERATIONS
-- =========================

SELECT * FROM Bugs;

INSERT INTO Bugs VALUES (21,'New Bug','Open',1,1);

UPDATE Bugs SET status='Closed' WHERE bug_id=1;

DELETE FROM Bugs WHERE bug_id=21;

-- =========================
-- JOIN QUERIES (3)
-- =========================

-- 1
SELECT b.title, d.name
FROM Bugs b
JOIN Developers d ON b.developer_id = d.developer_id;

-- 2
SELECT b.title, s.sprint_name
FROM Bugs b
JOIN Sprints s ON b.sprint_id = s.sprint_id;

-- 3
SELECT d.name, p.project_name
FROM ProjectDevelopers pd
JOIN Developers d ON pd.developer_id = d.developer_id
JOIN Projects p ON pd.project_id = p.project_id;

-- =========================
-- SUBQUERIES (2)
-- =========================

SELECT name FROM Developers
WHERE developer_id IN (SELECT developer_id FROM Bugs);

SELECT title FROM Bugs
WHERE sprint_id IN (
    SELECT sprint_id FROM Sprints WHERE project_id = 1
);

-- =========================
-- AGGREGATE FUNCTIONS (2)
-- =========================

SELECT developer_id, COUNT(*) AS total_bugs
FROM Bugs
GROUP BY developer_id;

SELECT bug_id, COUNT(*) AS total_tests
FROM TestCases
GROUP BY bug_id;

SELECT 
    s.project_id,
    COUNT(b.bug_id) AS total_bugs,
    SUM(CASE WHEN b.status = 'Open' THEN 1 ELSE 0 END) AS open_bugs,
    SUM(CASE WHEN b.status = 'Closed' THEN 1 ELSE 0 END) AS closed_bugs
FROM Bugs b
JOIN Sprints s ON b.sprint_id = s.sprint_id
GROUP BY s.project_id;

-- =========================
-- CONSTRAINT VIOLATION DEMO
-- =========================

-- FOREIGN KEY ERROR (should fail)
INSERT INTO Bugs VALUES (99,'Invalid Bug','Open',999,1);

-- NOT NULL ERROR (should fail)
INSERT INTO Developers VALUES (21,NULL,'invalid@mail.com');