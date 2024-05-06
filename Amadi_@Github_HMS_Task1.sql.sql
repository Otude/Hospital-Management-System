-- Creating Hospital Management System Database

CREATE DATABASE HospitalManagementSystem;
GO
USE HospitalManagementSystem;
GO


-- Creating Patient Table

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    AddressID INT,
    DateOfBirth DATE NOT NULL,
    Insurance NVARCHAR(50) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    DateLeft DATE
);

-- Creating Addresses Table

CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY IDENTITY(1, 1),
    PatientID INT,
    Address1 NVARCHAR(50) NOT NULL,
    Address2 NVARCHAR(50),
    City NVARCHAR(50) NOT NULL,
    Postcode NVARCHAR(10) NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Creating Doctors Table

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    EmailAddress NVARCHAR(50),
    TelephoneNumber NVARCHAR(15),
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Specialty NVARCHAR(50),
	FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Creating Departments Table

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1, 1),
    DepartmentName NVARCHAR(50) NOT NULL
);

-- Creating Appointments Table

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY IDENTITY(1, 1),
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Status VARCHAR(10) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Cancelled', 'Completed')),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Creating MedicalRecords Table

CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY IDENTITY(1, 1),
    PatientID INT,
	Allergies NVARCHAR(100),
    DateOfVisit DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);


-- Creating Updates Table

CREATE TABLE Updates (
    UpdateID INT PRIMARY KEY IDENTITY(1, 1),
    RecordID INT,
    DoctorID INT,
    Diagnoses NVARCHAR(500) NOT NULL,
    Medicines NVARCHAR(500) NOT NULL,
    MedicinePrescribedDate DATETIME DEFAULT GETDATE() NOT NULL,
    FOREIGN KEY (RecordID) REFERENCES MedicalRecords(RecordID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Creating Availability Table

CREATE TABLE Availability (
    AvailabilityID INT PRIMARY KEY IDENTITY(1, 1),
    DoctorID INT,
    Date DATE NOT NULL,
    TimeSlot TIME NOT NULL,
    AvailabilityStatus VARCHAR(15) NOT NULL,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Creating Reviews Table

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1, 1),
    DoctorID INT,
    PatientID INT,
    Review NVARCHAR(500) NOT NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5) NOT NULL,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Creating Feedback Table

CREATE TABLE Feedbacks (
    FeedbackID INT PRIMARY KEY IDENTITY(1, 1),
    PatientID INT,
    Feedback NVARCHAR(500) NOT NULL,
    FeedbackDate DATETIME DEFAULT GETDATE() NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- InsertDML Hospital Management System

-- Populating Patients Table
INSERT INTO Patients (FirstName, LastName, AddressID, DateOfBirth, Insurance, Username, Password, DateLeft)
VALUES 
('John', 'Doe', 1, '1990-05-15', 'ABC Insurance', 'johndoe123', 'password123', NULL),
('Jane', 'Smith', 2, '1985-09-20', 'XYZ Insurance', 'janesmith456', 'securepassword', NULL),
('Michael', 'Johnson', 3, '1978-11-10', '123 Insurance', 'michaelj', 'pass123', NULL),
('Emily', 'Williams', 4, '1995-03-25', 'Insurance Co.', 'emilyw', 'password1234', NULL),
('David', 'Brown', 5, '1982-07-08', 'Insurance Group', 'davidb', 'abc123', NULL),
('Sarah', 'Miller', 6, '1970-12-03', 'Health Insurance', 'sarahm', 'mypass', NULL),
('Ryan', 'Wilson', 7, '1988-06-18', 'Medical Insurance', 'ryanw', 'password321', NULL),
('Jessica', 'Taylor', 8, '1992-09-30', 'Insurance Corp.', 'jessicat', 'taylor123', NULL),
('Christopher', 'Anderson', 9, '1980-04-12', 'Insure Inc.', 'chrisa', 'pass1234', NULL),
('Amanda', 'Martinez', 10, '1975-01-22', 'Healthcare Insurance', 'amandam', 'securepass', NULL);
Go
SELECT * FROM Patients;

-- Populating Addresses Table
INSERT INTO Addresses (PatientID, Address1, City, Postcode)
VALUES
(1, '123 Main St', 'Cityville', '12345'),
(2, '456 Elm St', 'Townsville', '54321'),
(3, '789 Oak St', 'Villagetown', '67890'),
(4, '111 Pine St', 'Hamlet', '13579'),
(5, '222 Maple St', 'Ruraltown', '97531'),
(6, '333 Cedar St', 'Suburbia', '24680'),
(7, '444 Birch St', 'Metropolis', '86420'),
(8, '555 Walnut St', 'Smalltown', '64208'),
(9, '666 Spruce St', 'Citytown', '37589'),
(10, '777 Ash St', 'Hometown', '90876');
Go
SELECT * FROM Addresses

-- Populating Departments Table
INSERT INTO Departments (DepartmentName)
VALUES 
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Pediatrics'),
('Oncology'),
('Dermatology'),
('ENT'),
('Gastroenterology'),
('Urology'),
('Ophthalmology');
Go
SELECT * FROM Departments

-- Populating Doctors Table
INSERT INTO Doctors (FirstName, LastName, DepartmentID, EmailAddress, TelephoneNumber, Username, Password, Specialty)
VALUES 
('Michael', 'Smith', 1, 'michaelsmith@example.com', '123-456-7890', 'michaels', 'pass4321', 'Cardiologist'),
('Emily', 'Johnson', 2, 'emilyjohnson@example.com', '987-654-3210', 'emilyj', 'pass9876', 'Neurologist'),
('David', 'Brown', 3, 'davidbrown@example.com', '456-789-0123', 'davidb', 'pass6543', 'Orthopedic Surgeon'),
('Sarah', 'Wilson', 4, 'sarahwilson@example.com', '789-012-3456', 'sarahw', 'pass2109', 'Pediatrician'),
('Ryan', 'Taylor', 5, 'ryantaylor@example.com', '321-654-9870', 'ryant', 'pass7654', 'Oncologist'),
('Jessica', 'Martinez', 6, 'jessicamartinez@example.com', '654-987-0123', 'jessicam', 'pass0987', 'Dermatologist'),
('Christopher', 'Garcia', 7, 'christophergarcia@example.com', '987-012-3456', 'christopherg', 'pass5432', 'ENT Specialist'),
('Amanda', 'Anderson', 8, 'amandaanderson@example.com', '210-543-8765', 'amandaa', 'pass3210', 'Gastroenterologist'),
('Taylor', 'Hernandez', 9, 'taylorhernandez@example.com', '543-876-2109', 'taylorh', 'pass8765', 'Urologist'),
('Andrew', 'Lopez', 10, 'andrewlopez@example.com', '876-210-5432', 'andrewl', 'pass21098', 'Ophthalmologist');
GO
SELECT * FROM Doctors

-- Populating Appointments Table
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime, Status)
VALUES 
(1, 1, '2024-04-15', '09:00:00', 'Pending'),
(2, 2, '2024-04-16', '10:00:00', 'Pending'),
(3, 3, '2024-04-17', '11:00:00', 'Pending'),
(4, 4, '2024-04-18', '12:00:00', 'Pending'),
(5, 5, '2024-04-19', '13:00:00', 'Pending'),
(6, 6, '2024-04-20', '14:00:00', 'Pending'),
(7, 7, '2024-04-21', '15:00:00', 'Pending'),
(8, 8, '2024-04-22', '16:00:00', 'Pending'),
(9, 9, '2024-04-23', '17:00:00', 'Pending'),
(10, 10, '2024-04-24', '18:00:00', 'Pending');
GO
SELECT * FROM Appointments

-- Populating MedicalRecords Table
INSERT INTO MedicalRecords (PatientID, Allergies, DateOfVisit)
VALUES 
(1, 'Peanuts', '2024-04-10'),
(2, 'Penicillin', '2024-04-11'),
(3, 'Shellfish', '2024-04-12'),
(4, 'Dust', '2024-04-13'),
(5, 'Eggs', '2024-04-14'),
(6, 'Mold', '2024-04-15'),
(7, 'Pollen', '2024-04-16'),
(8, 'Cats', '2024-04-17'),
(9, 'Grass', '2024-04-18'),
(10, 'Insect stings', '2024-04-19');
GO
SELECT * FROM MedicalRecords

-- Populating Updates Table
INSERT INTO Updates (RecordID, DoctorID, Diagnoses, Medicines, MedicinePrescribedDate)
VALUES 
(1, 1, 'Hypertension', 'Lisinopril', '2024-04-15 09:30:00'),
(2, 2, 'Migraine', 'Sumatriptan', '2024-04-16 10:30:00'),
(3, 3, 'Fractured leg', 'Cast', '2024-04-17 11:30:00'),
(4, 4, 'Strep throat', 'Amoxicillin', '2024-04-18 12:30:00'),
(5, 5, 'Lung cancer', 'Chemotherapy', '2024-04-19 13:30:00'),
(6, 6, 'Eczema', 'Hydrocortisone', '2024-04-20 14:30:00'),
(7, 7, 'Sinusitis', 'Antibiotics', '2024-04-21 15:30:00'),
(8, 8, 'Gastritis', 'Proton pump inhibitors', '2024-04-22 16:30:00'),
(9, 9, 'Kidney stones', 'Pain relievers', '2024-04-23 17:30:00'),
(10, 10, 'Cataracts', 'Surgery', '2024-04-24 18:30:00');
GO
SELECT * FROM Updates

-- Populating Availability Table
INSERT INTO Availability (DoctorID, Date, TimeSlot, AvailabilityStatus)
VALUES 
(1, '2024-04-15', '09:00:00', 'Available'),
(2, '2024-04-16', '10:00:00', 'Available'),
(3, '2024-04-17', '11:00:00', 'Available'),
(4, '2024-04-18', '12:00:00', 'Available'),
(5, '2024-04-19', '13:00:00', 'Available'),
(6, '2024-04-20', '14:00:00', 'Available'),
(7, '2024-04-21', '15:00:00', 'Available'),
(8, '2024-04-22', '16:00:00', 'Available'),
(9, '2024-04-23', '17:00:00', 'Available'),
(10, '2024-04-24', '18:00:00', 'Available');
GO
SELECT * FROM Availability

-- Populating Reviews Table
INSERT INTO Reviews (DoctorID, PatientID, Review, Rating)
VALUES 
(1, 1, 'Great doctor, very informative', 5),
(2, 2, 'Helped me manage my migraines', 4),
(3, 3, 'Excellent care for my fractured leg', 5),
(4, 4, 'Quick recovery from strep throat', 4),
(5, 5, 'Compassionate oncologist', 5),
(6, 6, 'Effective treatment for my eczema', 4),
(7, 7, 'Relieved my sinus infection', 4),
(8, 8, 'Professional and caring gastroenterologist', 5),
(9, 9, 'Knowledgeable urologist', 4),
(10, 10, 'Vision restored after cataract surgery', 5);
GO
SELECT * FROM Reviews

-- Populating Feedbacks Table
INSERT INTO Feedbacks (PatientID, Feedback, FeedbackDate)
VALUES 
(1, 'Overall, I had a good experience', '2024-04-16 10:30:00'),
(2, 'Satisfied with the service provided', '2024-04-17 11:30:00'),
(3, 'Thank you for the excellent care', '2024-04-18 12:30:00'),
(4, 'Friendly staff and efficient service', '2024-04-19 13:30:00'),
(5, 'Highly recommend this hospital', '2024-04-20 14:30:00'),
(6, 'Improved my quality of life', '2024-04-21 15:30:00'),
(7, 'Grateful for the treatment received', '2024-04-22 16:30:00'),
(8, 'Very pleased with the outcome', '2024-04-23 17:30:00'),
(9, 'Professional and caring staff', '2024-04-24 18:30:00'),
(10, 'Excellent surgical team', '2024-04-25 19:30:00');
GO
SELECT * FROM Feedbacks


-- Q2. Adding constraint to ensure appointment date is not in the past

-- Altering Appointments Table to Add CHECK Constraint for AppointmentDate
ALTER TABLE Appointments
ADD CONSTRAINT CHK_AppointmentDate_NotInPast 
CHECK (AppointmentDate >= CAST(GETDATE() AS DATE));
GO
SELECT * FROM Appointments


-- Q3. Patients older than 40 who have a diagnosis of cancer

SELECT DISTINCT P.*
FROM Patients P
JOIN MedicalRecords MR ON P.PatientID = MR.PatientID
JOIN Updates U ON MR.RecordID = U.RecordID
WHERE DATEDIFF(YEAR, P.DateOfBirth, GETDATE()) > 40
AND U.Diagnoses LIKE '%Cancer%';


-- Q4. The Hospital stored procedures and user-defined functions for the specified tasks:

-- a) Search the database for matching character strings by name of medicine:

CREATE PROCEDURE SearchMedicineByName
    @MedicineName NVARCHAR(100)
AS
BEGIN
    SELECT P.FirstName, P.LastName, U.Medicines, U.MedicinePrescribedDate
    FROM Patients P
    JOIN MedicalRecords MR ON P.PatientID = MR.PatientID
    JOIN Updates U ON MR.RecordID = U.RecordID
    WHERE U.Medicines LIKE '%' + @MedicineName + '%'
    ORDER BY U.MedicinePrescribedDate DESC;
END;


-- b) Return a full list of diagnoses and allergies for a specific patient who has an appointment today:

CREATE PROCEDURE GetPatientDiagnosisAndAllergiesForToday
    @PatientID INT
AS
BEGIN
    DECLARE @Today DATE = CAST(GETDATE() AS DATE);

    SELECT MR.Allergies, U.Diagnoses
    FROM MedicalRecords MR
    JOIN Updates U ON MR.RecordID = U.RecordID
    JOIN Appointments A ON MR.PatientID = A.PatientID
    WHERE A.AppointmentDate = @Today
    AND MR.PatientID = @PatientID;
END;

-- c) Update the details for an existing doctor:

CREATE PROCEDURE UpdateDoctorDetails
    @DoctorID INT,
    @NewEmailAddress NVARCHAR(50),
    @NewTelephoneNumber NVARCHAR(15),
    @NewSpecialty NVARCHAR(50)
AS
BEGIN
    UPDATE Doctors
    SET EmailAddress = @NewEmailAddress,
        TelephoneNumber = @NewTelephoneNumber,
        Specialty = @NewSpecialty
    WHERE DoctorID = @DoctorID;
END;

-- d) Delete the appointment whose status is already completed:

CREATE PROCEDURE DeleteCompletedAppointments
AS
BEGIN
    DELETE FROM Appointments
    WHERE Status = 'Completed';
END;


-- Q5. creating a view that displays appointment details along with information about the doctor's department, 
-- specialty, and any associated reviews/feedback, the following SQL query can be used:

CREATE VIEW AllAppointmentsDetails AS
SELECT A.AppointmentID,
       A.AppointmentDate,
       A.AppointmentTime,
       D.FirstName + ' ' + D.LastName AS DoctorName,
       DP.DepartmentName AS Department,
       D.Specialty AS DoctorSpecialty,
       R.Review AS DoctorReview,
       R.Rating AS DoctorRating
FROM Appointments A
JOIN Doctors D ON A.DoctorID = D.DoctorID
JOIN Departments DP ON D.DepartmentID = DP.DepartmentID
LEFT JOIN Reviews R ON D.DoctorID = R.DoctorID;
SELECT * FROM AllAppointmentsDetails


-- Q6. Creating a trigger to automatically change the current state of an appointment to "Available" when it is canceled. 

CREATE TRIGGER UpdateAppointmentStatus
ON Appointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status) -- Check if the Status column was updated
    BEGIN
        UPDATE Appointments
        SET Status = 'Available'
        FROM inserted
        WHERE Appointments.AppointmentID = inserted.AppointmentID
        AND inserted.Status = 'Cancelled';
    END
END;


-- Q7. identifying the number of completed appointments with the specialty of doctors as 'Gastroenterologists',
-- The following SQL query is used:

SELECT COUNT(*) AS CompletedAppointments
FROM Appointments A
JOIN Doctors D ON A.DoctorID = D.DoctorID
JOIN Departments DP ON D.DepartmentID = DP.DepartmentID
WHERE A.Status = 'Completed'
AND D.Specialty = 'Gastroenterologists';