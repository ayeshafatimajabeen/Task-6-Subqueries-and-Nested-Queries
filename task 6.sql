USE HospitalDB;
-- Query: Show each patient's name along with their total billed amount (from Billing table).
SELECT 
    name AS patient_name,
    (SELECT SUM(total_amount) 
     FROM Billing 
     WHERE Billing.patient_id = Patients.patient_id) AS total_billed
FROM 
    Patients;
    
-- Query: List doctors who belong to departments named either 'Cardiology' or 'Pediatrics'.
SELECT name AS doctor_name
FROM Doctors
WHERE department_id IN (
    SELECT department_id
    FROM Departments
    WHERE name IN ('Cardiology', 'Pediatrics')
);

-- Query: Show departments that have at least one nurse assigned.
SELECT name AS department_name
FROM Departments d
WHERE EXISTS (
    SELECT 1
    FROM Nurses n
    WHERE n.department_id = d.department_id
);

-- Query: Show the patient who has the highest total bill.
SELECT name, patient_id
FROM Patients
WHERE patient_id = (
    SELECT patient_id
    FROM Billing
    ORDER BY total_amount DESC
    LIMIT 1
);

-- Query: List patients whose total bill is greater than the average bill of all patients.
SELECT name
FROM Patients p
WHERE (
    SELECT SUM(total_amount)
    FROM Billing b
    WHERE b.patient_id = p.patient_id
) > (
    SELECT AVG(total_amount) FROM Billing
);

-- Query: Show each doctor's name and number of appointments.
SELECT d.name AS doctor_name, appt_count
FROM Doctors d
JOIN (
    SELECT doctor_id, COUNT(*) AS appt_count
    FROM Appointments
    GROUP BY doctor_id
) AS a ON d.doctor_id = a.doctor_id;


-- Query: List patient names who were prescribed Paracetamol.
SELECT name AS patient_name
FROM Patients
WHERE patient_id IN (
    SELECT a.patient_id
    FROM Appointments a
    JOIN Prescriptions p ON a.appointment_id = p.appointment_id
    WHERE p.medication = 'Paracetamol'
);

-- Query: Show doctors who haven’t had any appointments.
SELECT name AS doctor_name
FROM Doctors d
WHERE NOT EXISTS (
    SELECT 1 
    FROM Appointments a 
    WHERE a.doctor_id = d.doctor_id
);

-- List All Rooms That Are Currently Occupied by a Patient
SELECT room_number
FROM Rooms
WHERE room_id IN (
    SELECT room_id
    FROM Patient_Rooms
    WHERE discharge_date IS NULL
);
-- Show Doctor Names with Specialization Same as the One Assigned to ‘Dr. Sameer Khan’
SELECT name
FROM Doctors
WHERE specialization = (
    SELECT specialization
    FROM Doctors
    WHERE name = 'Dr. Sameer Khan'
);





