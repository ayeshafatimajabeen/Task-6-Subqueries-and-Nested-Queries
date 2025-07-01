#  Task 6: Subqueries and Nested Queries – Hospital Management System

##  Objective
The goal of this task was to explore and implement **subqueries and nested SQL logic** within a hospital database system. Subqueries are powerful tools that allow queries to be embedded within other queries to perform complex data retrieval, filtering, and analysis.

---

##  Tools Used
- **MySQL Workbench**
- SQL (Structured Query Language)

---

##  Key Concepts Learned

###  1. Scalar Subqueries
Returns a **single value**. Used in `SELECT`, `WHERE`, or `HAVING` clauses.

#### Example: Total billed amount per patient
```sql
SELECT 
    name AS patient_name,
    (SELECT SUM(total_amount) 
     FROM Billing 
     WHERE Billing.patient_id = Patients.patient_id) AS total_billed
FROM 
    Patients;
```

---

###  2. Subqueries with `IN`
Filters rows based on a **list of values** returned by the subquery.

#### Example: Doctors in Cardiology or Pediatrics
```sql
SELECT name
FROM Doctors
WHERE department_id IN (
    SELECT department_id
    FROM Departments
    WHERE name IN ('Cardiology', 'Pediatrics')
);
```

---

###  3. Subqueries with `EXISTS`
Checks if the subquery returns **at least one row**.

#### Example: Departments with at least one nurse
```sql
SELECT name
FROM Departments d
WHERE EXISTS (
    SELECT 1
    FROM Nurses n
    WHERE n.department_id = d.department_id
);
```

---

###  4. Scalar Subqueries with `=`
Compares a value with the **result of a single-value subquery**.

#### Example: Patient with the highest bill
```sql
SELECT name
FROM Patients
WHERE patient_id = (
    SELECT patient_id
    FROM Billing
    ORDER BY total_amount DESC
    LIMIT 1
);
```

---

###  5. Correlated Subqueries
Refers to outer query’s column and is executed for **each row** of the outer query.

#### Example: Patients whose total bill is above the average
```sql
SELECT name
FROM Patients p
WHERE (
    SELECT SUM(total_amount)
    FROM Billing b
    WHERE b.patient_id = p.patient_id
) > (
    SELECT AVG(total_amount) FROM Billing
);
```

---

###  6. Subqueries in `FROM` Clause (Derived Tables)
Subqueries can act as **temporary tables** within a `FROM` clause.

#### Example: Doctors and their appointment counts
```sql
SELECT d.name, a.appt_count
FROM Doctors d
JOIN (
    SELECT doctor_id, COUNT(*) AS appt_count
    FROM Appointments
    GROUP BY doctor_id
) a ON d.doctor_id = a.doctor_id;
```

---


-  **Patients prescribed 'Paracetamol':**
```sql
SELECT name
FROM Patients
WHERE patient_id IN (
    SELECT patient_id
    FROM Appointments
    WHERE appointment_id IN (
        SELECT appointment_id
        FROM Prescriptions
        WHERE medication = 'Paracetamol'
    )
);
```

-  **Doctors with no appointments:**
```sql
SELECT name
FROM Doctors
WHERE doctor_id NOT IN (
    SELECT DISTINCT doctor_id
    FROM Appointments
);
```

-  **Currently occupied rooms:**
```sql
SELECT room_number
FROM Rooms
WHERE status = 'Occupied';
```

-  **Doctors with same specialization as 'Dr. Neha Patel':**
```sql
SELECT name
FROM Doctors
WHERE specialization = (
    SELECT specialization
    FROM Doctors
    WHERE name = 'Dr. Neha Patel'
);
```

---

##  Summary

This task strengthened understanding of:

- Scalar and correlated subqueries
- Logical operations with `IN`, `EXISTS`, `=`
- Nesting subqueries inside `SELECT`, `FROM`, and `WHERE`
- Querying real-world data efficiently using modular SQL

Subqueries are **essential for writing powerful, clean, and advanced SQL queries**, especially in relational databases like a hospital management system.

---
