CREATE DATABASE HospitalDB;

-- Using the HospitalDB database
USE HospitalDB;

-- Drop tables if they exist 
DROP TABLE IF EXISTS Prescriptions, MedicalRecords, Appointments, Patients, Doctors, Departments;

-- 1. Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);
INSERT INTO Departments (name) VALUES
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Orthopedics');
Select * from Departments;


-- 2. Doctors
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
INSERT INTO Doctors (name, specialization, department_id) VALUES
('Dr. Sameer Khan', 'Cardiologist', 1),
('Dr. Neha Patel', 'Neurologist', 2),
('Dr. Ravi Verma', 'Pediatrician', 3),
('Dr. Sunita Joshi', 'Orthopedic Surgeon', 4);
Select * from Doctors;

-- 3. Patients
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    phone VARCHAR(15)
);
INSERT INTO Patients (name, gender, date_of_birth, phone) VALUES
('Aarav Mehta', 'Male', '1995-03-14', '9876543210'),
('Diya Singh', 'Female', '2002-07-22', '9123456789'),
('Rehan Shaikh', 'Male', '1988-01-11', '9012345678');
Select * from Patients;

-- 4. Appointments
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason) VALUES
(1, 1, '2025-06-20', 'Chest pain and fatigue'),
(2, 2, '2025-06-21', 'Frequent headaches'),
(3, 3, '2025-06-22', 'Fever and cough');
Select * from Appointments;

-- 5. MedicalRecords
CREATE TABLE MedicalRecords (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT UNIQUE,
    diagnosis TEXT,
    treatment TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);
INSERT INTO MedicalRecords (appointment_id, diagnosis, treatment) VALUES
(1, 'Mild heart arrhythmia', 'Lifestyle changes, medication'),
(2, 'Migraine', 'Painkillers, avoid triggers'),
(3, 'Viral infection', 'Rest, fluids, paracetamol');
Select * from MedicalRecords;

-- 6. Prescriptions
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT UNIQUE,
    medication TEXT,
    dosage TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);
INSERT INTO Prescriptions (appointment_id, medication, dosage) VALUES
(1, 'Atenolol', '50mg once daily'),
(2, 'Sumatriptan', '25mg during headache'),
(3, 'Paracetamol', '500mg every 6 hours');
Select * from Prescriptions;

-- 7.  Rooms
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type ENUM('General', 'Semi-Private', 'Private', 'ICU') NOT NULL,
    status ENUM('Available', 'Occupied') DEFAULT 'Available'
);
INSERT INTO Rooms (room_number, room_type, status) VALUES
('G101', 'General', 'Available'),
('P202', 'Private', 'Occupied'),
('S303', 'Semi-Private', 'Available'),
('ICU1', 'ICU', 'Occupied');
Select * from Rooms;

-- 8.  Patient_Rooms
CREATE TABLE Patient_Rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    room_id INT,
    admission_date DATE,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);
INSERT INTO Patient_Rooms (patient_id, room_id, admission_date, discharge_date) VALUES
(1, 2, '2025-06-19', NULL),
(2, 4, '2025-06-18', '2025-06-21');
Select * from Patient_Rooms;

-- 9.  Nurses
CREATE TABLE Nurses (
    nurse_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
INSERT INTO Nurses (name, phone, department_id) VALUES
('Nurse Riya Sharma', '9898989898', 1),
('Nurse Alok Das', '9789789789', 2),
('Nurse Meera Iqbal', '9123412341', 3);
Select * from Nurses;

-- 10.  Nurse_Assignments 
CREATE TABLE Nurse_Assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    nurse_id INT,
    patient_id INT,
    shift ENUM('Morning', 'Afternoon', 'Night'),
    date DATE,
    FOREIGN KEY (nurse_id) REFERENCES Nurses(nurse_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
INSERT INTO Nurse_Assignments (nurse_id, patient_id, shift, date) VALUES
(1, 1, 'Morning', '2025-06-20'),
(2, 2, 'Night', '2025-06-21'),
(3, 3, 'Afternoon', '2025-06-22');
Select * from Nurse_Assignments;

-- 11.  Billing
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    appointment_id INT,
    room_charge DECIMAL(10,2),
    consultation_fee DECIMAL(10,2),
    medicine_charge DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    billing_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);
INSERT INTO Billing (patient_id, appointment_id, room_charge, consultation_fee, medicine_charge, total_amount, billing_date) VALUES
(1, 1, 1500.00, 500.00, 200.00, 2200.00, '2025-06-20'),
(2, 2, 2000.00, 600.00, 150.00, 2750.00, '2025-06-21'),
(3, 3, 0.00, 400.00, 100.00, 500.00, '2025-06-22');
Select * from Billing;
