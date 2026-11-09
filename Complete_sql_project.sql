show databases;
CREATE DATABASE blood_bank_db;
USE blood_bank_db;
SHOW DATABASES;

CREATE TABLE BLOOD_GROUP (
    Blood_Group_ID INT PRIMARY KEY AUTO_INCREMENT,
    Blood_Type VARCHAR(5) NOT NULL UNIQUE
);
CREATE TABLE PATIENT (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_Name VARCHAR(50) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Phone VARCHAR(15),
    Hospital_Name VARCHAR(100)
);
CREATE TABLE STAFF (
    Staff_ID INT PRIMARY KEY AUTO_INCREMENT,
    Staff_Name VARCHAR(50) NOT NULL,
    Role VARCHAR(30),
    Phone VARCHAR(15)
);
CREATE TABLE DONOR (
    Donor_ID INT PRIMARY KEY AUTO_INCREMENT,
    Donor_Name VARCHAR(50) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Blood_Group_ID INT,
    
    FOREIGN KEY (Blood_Group_ID)
    REFERENCES BLOOD_GROUP(Blood_Group_ID)
);
CREATE TABLE DONATION (
    Donation_ID INT PRIMARY KEY AUTO_INCREMENT,
    Donor_ID INT,
    Donation_Date DATE,
    Units_Donated INT,
    Blood_Group_ID INT,

    FOREIGN KEY (Donor_ID)
    REFERENCES DONOR(Donor_ID),

    FOREIGN KEY (Blood_Group_ID)
    REFERENCES BLOOD_GROUP(Blood_Group_ID),

    CHECK (Units_Donated > 0)
);
CREATE TABLE BLOOD_STOCK (
    Stock_ID INT PRIMARY KEY AUTO_INCREMENT,
    Blood_Group_ID INT UNIQUE,
    Available_Units INT DEFAULT 0,
    Last_Updated DATE,

    FOREIGN KEY (Blood_Group_ID)
    REFERENCES BLOOD_GROUP(Blood_Group_ID),

    CHECK (Available_Units >= 0)
);
CREATE TABLE BLOOD_REQUEST (
    Request_ID INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID INT,
    Blood_Group_ID INT,
    Required_Units INT,
    Request_Date DATE,
    Status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (Patient_ID)
    REFERENCES PATIENT(Patient_ID),

    FOREIGN KEY (Blood_Group_ID)
    REFERENCES BLOOD_GROUP(Blood_Group_ID),

    CHECK (Required_Units > 0)
);
CREATE TABLE DISTRIBUTION (
    Distribution_ID INT PRIMARY KEY AUTO_INCREMENT,
    Request_ID INT,
    Staff_ID INT,
    Units_Issued INT,
    Distribution_Date DATE,

    FOREIGN KEY (Request_ID)
    REFERENCES BLOOD_REQUEST(Request_ID),

    FOREIGN KEY (Staff_ID)
    REFERENCES STAFF(Staff_ID),

    CHECK (Units_Issued > 0)
);
SHOW TABLES;

DESC DONOR;
DESC DONATION;
DESC BLOOD_STOCK;

INSERT INTO BLOOD_GROUP (Blood_Type)
VALUES
('O+'),
('O-'),
('A+'),
('A-'),
('B+'),
('B-'),
('AB+'),
('AB-');
SELECT * FROM BLOOD_GROUP;

INSERT INTO PATIENT
(Patient_Name, Age, Gender, Phone, Hospital_Name)
VALUES
('Kiran Babu', 35, 'Male', '9876543210', 'City Hospital'),
('Sita Devi', 28, 'Female', '9876543211', 'Apollo Hospital'),
('Rahul Verma', 42, 'Male', '9876543212', 'Care Hospital'),
('Anjali Rao', 30, 'Female', '9876543213', 'Rainbow Hospital'),
('Arjun Kumar', 50, 'Male', '9876543214', 'Government Hospital');

INSERT INTO STAFF
(Staff_Name, Role, Phone)
VALUES
('Ramesh', 'Manager', '9123456780'),
('Divya', 'Technician', '9123456781'),
('Karthik', 'Assistant', '9123456782');

INSERT INTO DONOR
(Donor_Name, Age, Gender, Phone, City, Blood_Group_ID)
VALUES
('Ravi Kumar', 28, 'Male', '9000000001', 'Guntur', 1),
('Anita Rao', 34, 'Female', '9000000002', 'Hyderabad', 3),
('Suresh Reddy', 41, 'Male', '9000000003', 'Vijayawada', 5),
('Meena Devi', 25, 'Female', '9000000004', 'Chennai', 7),
('Arun Sharma', 30, 'Male', '9000000005', 'Guntur', 2),
('Priya Singh', 27, 'Female', '9000000006', 'Hyderabad', 4),
('Vikram Rao', 38, 'Male', '9000000007', 'Vizag', 6),
('Sneha Reddy', 29, 'Female', '9000000008', 'Vijayawada', 8);

INSERT INTO DONATION
(Donor_ID, Donation_Date, Units_Donated, Blood_Group_ID)
VALUES
(1, '2026-01-12', 1, 1),
(2, '2026-02-03', 1, 3),
(3, '2026-03-15', 1, 5),
(4, '2026-04-10', 1, 7),
(5, '2026-05-20', 1, 2),
(6, '2026-06-15', 1, 4),
(7, '2026-07-18', 1, 6),
(8, '2026-08-22', 1, 8);

INSERT INTO BLOOD_STOCK
(Blood_Group_ID, Available_Units, Last_Updated)
VALUES
(1, 10, '2026-11-01'),
(2, 4, '2026-11-01'),
(3, 12, '2026-11-01'),
(4, 3, '2026-11-01'),
(5, 8, '2026-11-01'),
(6, 2, '2026-11-01'),
(7, 5, '2026-11-01'),
(8, 1, '2026-11-01');

INSERT INTO BLOOD_REQUEST
(Patient_ID, Blood_Group_ID, Required_Units, Request_Date, Status)
VALUES
(1, 1, 2, '2026-11-01', 'Completed'),
(2, 3, 1, '2026-11-02', 'Approved'),
(3, 5, 3, '2026-11-03', 'Pending'),
(4, 2, 1, '2026-11-03', 'Completed'),
(5, 7, 2, '2026-11-04', 'Pending');

INSERT INTO DISTRIBUTION
(Request_ID, Staff_ID, Units_Issued, Distribution_Date)
VALUES
(1, 1, 2, '2026-11-01'),
(2, 2, 1, '2026-11-02'),
(4, 3, 1, '2026-11-03');

SELECT * FROM BLOOD_GROUP;

SELECT * FROM PATIENT;

SELECT * FROM STAFF;

SELECT * FROM DONOR;

SELECT * FROM DONATION;

SELECT * FROM BLOOD_STOCK;

SELECT * FROM BLOOD_REQUEST;

SELECT * FROM DISTRIBUTION;



SELECT Donor_Name, Phone
FROM DONOR;

SELECT *
FROM DONOR
WHERE City = 'Guntur';

SELECT *
FROM DONOR
ORDER BY Donor_Name ASC;

SELECT *
FROM DONOR
ORDER BY Age DESC;

SELECT *
FROM DONOR
WHERE Gender = 'Female';

SELECT *
FROM DONOR
WHERE Age > 30;

SELECT *
FROM PATIENT
WHERE Hospital_Name = 'Apollo Hospital';

SELECT *
FROM BLOOD_REQUEST
WHERE Status = 'Pending';

SELECT *
FROM BLOOD_REQUEST
ORDER BY Required_Units DESC;

SELECT *
FROM BLOOD_STOCK
WHERE Available_Units > 0;




SELECT COUNT(*) AS Total_Donors
FROM DONOR;

SELECT SUM(Units_Donated) AS Total_Units_Donated
FROM DONATION;

SELECT AVG(Age) AS Average_Age
FROM DONOR;

SELECT MAX(Age) AS Maximum_Age
FROM DONOR;

SELECT MIN(Age) AS Minimum_Age
FROM DONOR;

SELECT SUM(Available_Units) AS Total_Stock
FROM BLOOD_STOCK;




SELECT 
    D.Donor_ID,
    D.Donor_Name,
    B.Blood_Type
FROM DONOR D
INNER JOIN BLOOD_GROUP B
ON D.Blood_Group_ID = B.Blood_Group_ID;

SELECT
    D.Donor_Name,
    DN.Donation_Date,
    DN.Units_Donated
FROM DONOR D
INNER JOIN DONATION DN
ON D.Donor_ID = DN.Donor_ID;

SELECT
    P.Patient_Name,
    B.Blood_Type,
    R.Required_Units,
    R.Status
FROM PATIENT P
INNER JOIN BLOOD_REQUEST R
ON P.Patient_ID = R.Patient_ID
INNER JOIN BLOOD_GROUP B
ON R.Blood_Group_ID = B.Blood_Group_ID;

SELECT
    B.Blood_Type,
    S.Available_Units,
    S.Last_Updated
FROM BLOOD_GROUP B
INNER JOIN BLOOD_STOCK S
ON B.Blood_Group_ID = S.Blood_Group_ID;

SELECT
    R.Request_ID,
    P.Patient_Name,
    S.Staff_Name,
    D.Units_Issued,
    D.Distribution_Date
FROM DISTRIBUTION D
INNER JOIN BLOOD_REQUEST R
ON D.Request_ID = R.Request_ID
INNER JOIN PATIENT P
ON R.Patient_ID = P.Patient_ID
INNER JOIN STAFF S
ON D.Staff_ID = S.Staff_ID;

SELECT
    D.Donor_Name,
    B.Blood_Type
FROM DONOR D
LEFT JOIN BLOOD_GROUP B
ON D.Blood_Group_ID = B.Blood_Group_ID;

SELECT
    D.Donor_Name,
    B.Blood_Type
FROM DONOR D
RIGHT JOIN BLOOD_GROUP B
ON D.Blood_Group_ID = B.Blood_Group_ID;




use blood_bank_db;
SELECT *
FROM DONOR
WHERE Age > (
    SELECT AVG(Age)
    FROM DONOR
);

SELECT *
FROM DONOR
WHERE Blood_Group_ID = (
    SELECT Blood_Group_ID
    FROM BLOOD_GROUP
    WHERE Blood_Type = 'O+'
);

SELECT *
FROM PATIENT
WHERE Patient_ID IN (
    SELECT Patient_ID
    FROM BLOOD_REQUEST
    WHERE Required_Units > (
        SELECT AVG(Required_Units)
        FROM BLOOD_REQUEST
    )
);

SELECT *
FROM BLOOD_GROUP
WHERE Blood_Group_ID IN (
    SELECT Blood_Group_ID
    FROM BLOOD_STOCK
    WHERE Available_Units > (
        SELECT AVG(Available_Units)
        FROM BLOOD_STOCK
    )
);

SELECT *
FROM STAFF
WHERE Staff_ID IN (
    SELECT Staff_ID
    FROM DISTRIBUTION
);

SELECT *
FROM DONOR
WHERE Donor_ID IN (
    SELECT Donor_ID
    FROM DONATION
);





CREATE VIEW Donor_Details AS
SELECT
    D.Donor_ID,
    D.Donor_Name,
    D.Age,
    D.Phone,
    D.City,
    B.Blood_Type
FROM DONOR D
JOIN BLOOD_GROUP B
ON D.Blood_Group_ID = B.Blood_Group_ID;

SELECT * FROM Donor_Details;

CREATE VIEW Blood_Stock_Details AS
SELECT
    B.Blood_Type,
    S.Available_Units,
    S.Last_Updated
FROM BLOOD_GROUP B
JOIN BLOOD_STOCK S
ON B.Blood_Group_ID = S.Blood_Group_ID;

SELECT * FROM Blood_Stock_Details;

CREATE VIEW Patient_Request_Details AS
SELECT
    P.Patient_Name,
    B.Blood_Type,
    R.Required_Units,
    R.Request_Date,
    R.Status
FROM PATIENT P
JOIN BLOOD_REQUEST R
ON P.Patient_ID = R.Patient_ID
JOIN BLOOD_GROUP B
ON R.Blood_Group_ID = B.Blood_Group_ID;

SELECT * FROM Patient_Request_Details;

CREATE VIEW Completed_Requests AS
SELECT *
FROM BLOOD_REQUEST
WHERE Status = 'Completed';

SELECT * FROM Completed_Requests;
CREATE VIEW Distribution_Details AS
SELECT
    P.Patient_Name,
    S.Staff_Name,
    B.Blood_Type,
    D.Units_Issued,
    D.Distribution_Date
FROM DISTRIBUTION D
JOIN BLOOD_REQUEST R
ON D.Request_ID = R.Request_ID
JOIN PATIENT P
ON R.Patient_ID = P.Patient_ID
JOIN STAFF S
ON D.Staff_ID = S.Staff_ID
JOIN BLOOD_GROUP B
ON R.Blood_Group_ID = B.Blood_Group_ID;

SELECT * FROM Distribution_Details;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

DROP VIEW Completed_Requests;




DELIMITER //

CREATE PROCEDURE GetAllDonors()
BEGIN
    SELECT * FROM DONOR;
END //

DELIMITER ;

CALL GetAllDonors();

DELIMITER //

CREATE PROCEDURE GetDonorsByBloodGroup(IN group_name VARCHAR(5))
BEGIN
    SELECT D.Donor_ID, D.Donor_Name, D.Age, D.Phone, B.Blood_Type
    FROM DONOR D
    JOIN BLOOD_GROUP B
    ON D.Blood_Group_ID = B.Blood_Group_ID
    WHERE B.Blood_Type = group_name;
END //

DELIMITER ;

CALL GetDonorsByBloodGroup('O+');

DELIMITER //

CREATE PROCEDURE GetBloodStock()
BEGIN
    SELECT B.Blood_Type, S.Available_Units
    FROM BLOOD_GROUP B
    JOIN BLOOD_STOCK S
    ON B.Blood_Group_ID = S.Blood_Group_ID;
END //

DELIMITER ;

CALL GetBloodStock();

DELIMITER //

CREATE PROCEDURE GetPendingRequests()
BEGIN
    SELECT * FROM BLOOD_REQUEST
    WHERE Status = 'Pending';
END //

DELIMITER ;

CALL GetPendingRequests();

DELIMITER //

CREATE PROCEDURE GetPatientRequests(IN patient_id INT)
BEGIN
    SELECT
        P.Patient_Name,
        B.Blood_Type,
        R.Required_Units,
        R.Status
    FROM PATIENT P
    JOIN BLOOD_REQUEST R
    ON P.Patient_ID = R.Patient_ID
    JOIN BLOOD_GROUP B
    ON R.Blood_Group_ID = B.Blood_Group_ID
    WHERE P.Patient_ID = patient_id;
END //

DELIMITER ;

CALL GetPatientRequests(1);

SHOW PROCEDURE STATUS
WHERE Db = 'blood_bank_db';

DROP PROCEDURE GetAllDonors;




DELIMITER //

CREATE TRIGGER After_Donation_Insert
AFTER INSERT ON DONATION
FOR EACH ROW
BEGIN
    UPDATE BLOOD_STOCK
    SET Available_Units = Available_Units + NEW.Units_Donated,
        Last_Updated = NEW.Donation_Date
    WHERE Blood_Group_ID = NEW.Blood_Group_ID;
END //

DELIMITER ;

SELECT * FROM BLOOD_STOCK;

INSERT INTO DONATION
(Donor_ID, Donation_Date, Units_Donated, Blood_Group_ID)
VALUES
(1, '2026-11-06', 2, 1);

SELECT * FROM BLOOD_STOCK
WHERE Blood_Group_ID = 1;

DELIMITER //

CREATE TRIGGER Before_Donation_Insert
BEFORE INSERT ON DONATION
FOR EACH ROW
BEGIN
    IF NEW.Units_Donated <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Donation units must be greater than zero';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER Before_Stock_Update
BEFORE UPDATE ON BLOOD_STOCK
FOR EACH ROW
BEGIN
    IF NEW.Available_Units < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Blood stock cannot be negative';
    END IF;
END //

DELIMITER ;

UPDATE BLOOD_STOCK
SET Available_Units = -5
WHERE Blood_Group_ID = 1;

SHOW TRIGGERS;

DROP TRIGGER Before_Stock_Update;





START TRANSACTION;

UPDATE BLOOD_STOCK
SET Available_Units = Available_Units + 5
WHERE Blood_Group_ID = 1;

COMMIT;

SELECT * FROM BLOOD_STOCK
WHERE Blood_Group_ID = 1;

START TRANSACTION;

UPDATE BLOOD_STOCK
SET Available_Units = Available_Units - 2
WHERE Blood_Group_ID = 1;

ROLLBACK;

SELECT * FROM BLOOD_STOCK
WHERE Blood_Group_ID = 1;

START TRANSACTION;

UPDATE BLOOD_STOCK
SET Available_Units = Available_Units + 3
WHERE Blood_Group_ID = 1;

SAVEPOINT SP1;

UPDATE BLOOD_STOCK
SET Available_Units = Available_Units + 5
WHERE Blood_Group_ID = 2;

ROLLBACK TO SP1;

COMMIT;






SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SHOW PROCEDURE STATUS
WHERE Db = 'blood_bank_db';

SHOW TRIGGERS;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'blood_bank_db'
AND REFERENCED_TABLE_NAME IS NOT NULL;

commit;
