CREATE DATABASE IF NOT EXISTS healthmonitoring;
USE healthmonitoring;

DROP TABLE IF EXISTS devicetest;
DROP TABLE IF EXISTS alertlogs;
DROP TABLE IF EXISTS patientdoctor_assignment;
DROP TABLE IF EXISTS wearabledevices;
DROP TABLE IF EXISTS doctor;
DROP TABLE IF EXISTS patients;

CREATE TABLE patients (
    patients_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    currentcondition VARCHAR(200),
    contact VARCHAR(20)
);

CREATE TABLE doctor (
    doctor_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(200),
    speciality VARCHAR(200),
    role VARCHAR(200),
    email_id VARCHAR(200),
    contact_no VARCHAR(200)
);

CREATE TABLE wearabledevices (
    device_id VARCHAR(200) PRIMARY KEY,  -- Required for foreign key reference
    patient_id VARCHAR(200),
    device_type VARCHAR(200),
    status VARCHAR(200),
    assigned_date DATE,
    FOREIGN KEY(patient_id) REFERENCES patients(patients_id)
);

CREATE TABLE patientdoctor_assignment (
    assignment_id VARCHAR(200) PRIMARY KEY,
    patient_id VARCHAR(200),
    doctor_id VARCHAR(200),
    assigned_date DATE,
    FOREIGN KEY(patient_id) REFERENCES patients(patients_id),
    FOREIGN KEY(doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE alertlogs (
    alert_id VARCHAR(200) PRIMARY KEY,
    device_id VARCHAR(300),
    alert_type VARCHAR(200),
    alert_time TIMESTAMP,
    status VARCHAR(200),
    FOREIGN KEY(device_id) REFERENCES wearabledevices(device_id)
);

CREATE TABLE devicetest (
    test_id VARCHAR(200) PRIMARY KEY,
    patient_id VARCHAR(200),
    test_date DATE,
    result VARCHAR(200),
    FOREIGN KEY(patient_id) REFERENCES patients(patients_id)
);

INSERT INTO patients VALUES 
('1', 'Yakesh', '1994-09-23', 'diabetes', '9944117753'),
('2', 'Meena', '1988-05-14', 'hypertension', '8877665544'),
('3', 'Rahul', '1992-11-30', 'cardiac', '9988776655'),
('4', 'Divya', '1990-01-18', 'diabetes', '7766554433'),
('5', 'Arjun', '1985-07-25', 'asthma', '6655443322');

INSERT INTO doctor VALUES 
('1A', 'Dr. Kumar', 'Endocrinology', 'Remote Monitoring', 'kumar3@gmail.com', '9788744651'),
('2B', 'Dr. Shalini', 'Cardiology', 'On-site', 'shalini.md@gmail.com', '9898989898'),
('3C', 'Dr. Ramesh', 'Pulmonology', 'Remote Monitoring', 'ramesh@gmail.com', '9888777666'),
('4D', 'Dr. Priya', 'General Medicine', 'Remote Monitoring', 'priya.doc@gmail.com', '9777666555'),
('5E', 'Dr. Naveen', 'Endocrinology', 'Remote Monitoring', 'naveen.e@gmail.com', '9666555444');

INSERT INTO wearabledevices VALUES 
('D1', '1', 'Heart Monitor', 'Active', CURRENT_DATE),
('D2', '2', 'Blood Pressure Monitor', 'Active', CURRENT_DATE),
('D3', '3', 'ECG Tracker', 'Active', CURRENT_DATE),
('D4', '4', 'Heart Monitor', 'Active', CURRENT_DATE),
('D5', '5', 'Oxygen Saturation Monitor', 'Active', CURRENT_DATE);

INSERT INTO patientdoctor_assignment VALUES
('A001', '1', '1A', CURRENT_DATE),
('A002', '2', '2B', CURRENT_DATE),
('A003', '3', '3C', CURRENT_DATE),
('A004', '4', '1A', CURRENT_DATE),
('A005', '5', '3C', CURRENT_DATE);

INSERT INTO alertlogs VALUES
('AL001', 'D1', 'High Heart Rate', CURRENT_TIMESTAMP, 'Pending'),
('AL002', 'D2', 'High Blood Pressure', CURRENT_TIMESTAMP, 'Pending'),
('AL003', 'D3', 'Arrhythmia Detected', CURRENT_TIMESTAMP, 'Pending'),
('AL004', 'D4', 'Low Heart Rate', CURRENT_TIMESTAMP, 'Pending'),
('AL005', 'D5', 'Low Oxygen Level', CURRENT_TIMESTAMP, 'Pending');

INSERT INTO devicetest VALUES
('T001', '1', CURRENT_DATE, 'Normal'),
('T002', '2', CURRENT_DATE, 'High BP'),
('T003', '3', CURRENT_DATE, 'Abnormal ECG'),
('T004', '4', CURRENT_DATE, 'Normal'),
('T005', '5', CURRENT_DATE, 'Low SpO2');

SELECT DISTINCT p.patients_id, p.name, p.dob, p.currentcondition, p.contact
FROM patients p
JOIN wearabledevices w ON p.patients_id = w.patient_id
WHERE w.status = 'Active';

SELECT DISTINCT d.name AS doctor_name, d.speciality
FROM doctor d
JOIN patientdoctor_assignment pda ON d.doctor_id = pda.doctor_id
JOIN patients p ON pda.patient_id = p.patients_id
WHERE p.currentcondition = 'diabetes';

SELECT *
FROM alertlogs
WHERE device_id = 'D1'
  AND DATE(alert_time) = '2025-08-04';
  
  SELECT *
FROM devicetest
WHERE patient_id = '1'
  AND test_date >= CURDATE() - INTERVAL 7 DAY;

SELECT email_id, contact_no
FROM doctor
WHERE role = 'Remote Monitoring';


