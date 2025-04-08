-- SELECT * FROM PatientStay

-- SELECT PatientId,AdmittedDate,DischargeDate FROM PatientStay

/*
SELECT 
	PatientId,
	AdmittedDate,
	DischargeDate 
FROM PatientStay
*/

/*
SELECT 
	ps.PatientId,
	ps.AdmittedDate,
	ps.DischargeDate
FROM PatientStay ps
*/

/*
SELECT 
	ps.PatientId,
	ps.AdmittedDate,
	ps.DischargeDate
FROM PatientStay ps
WHERE ps.Hospital = 'Kingston'
*/

/*
SELECT 
	ps.PatientId,
	ps.AdmittedDate,
	ps.DischargeDate,
    ps.Hospital
FROM PatientStay ps
WHERE ps.Hospital = 'Kingston'
OR ps.Hospital = 'PRUH'
*/

/*
SELECT
    ps.PatientId,
    ps.AdmittedDate,
    ps.DischargeDate,
    ps.Hospital
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
*/

/*
SELECT
    ps.PatientId,
    ps.AdmittedDate,
    ps.DischargeDate,
    ps.Hospital
FROM PatientStay ps
WHERE ps.Hospital NOT IN ('Kingston', 'PRUH')
*/

/*
SELECT
	ps.PatientId,
	ps.Ward,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital
FROM PatientStay ps
WHERE ps.Hospital NOT IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
*/

/*
SELECT
	ps.PatientId,
	ps.Ward,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital, 
	ps.Tariff
FROM PatientStay ps
WHERE ps.Hospital NOT IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
AND ps.Tariff >= 6
*/

/*
SELECT
	ps.PatientId,
	ps.Ward,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital, 
	ps.Tariff
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%surgery%'
AND ps.Tariff BETWEEN 3 AND 6
*/

/*
SELECT
	ps.PatientId,
	ps.Ward,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital, 
	ps.Tariff
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%surgery%'
ORDER BY ps.AdmittedDate DESC
*/

/*
SELECT
	ps.PatientId,
	ps.Ward,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital, 
	ps.Tariff
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
ORDER BY 
	ps.AdmittedDate DESC,
	ps.PatientId DESC
*/

/*
SELECT
	ps.PatientId,
	ps.Ward,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital, 
	ps.Tariff,
	'Dummy' AS LengthOfStay
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
ORDER BY 
	ps.AdmittedDate DESC,
	ps.PatientId DESC
*/

-- SELECT DATEDIFF(DAY, '2025-03-12', '2025-04-08')

/*
SELECT
	ps.PatientId,
	ps.Ward,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital, 
	ps.Tariff,
	DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) AS LengthOfStay
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
ORDER BY 
	ps.AdmittedDate DESC,
	ps.PatientId DESC
*/

/*
SELECT
	ps.PatientId,
	ps.Ward,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital, 
	ps.Tariff,
	DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) AS LengthOfStay,
	DATEADD(MONTH, -1, ps.AdmittedDate) AS ReminderDate
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
ORDER BY 
	ps.AdmittedDate DESC,
	ps.PatientId DESC
*/

/*
SELECT COUNT(*) AS NumberOfPatients FROM PatientStay
*/

/*
SELECT
	ps.Hospital,
	COUNT(*) AS NumberOfPatients 
FROM PatientStay ps
GROUP BY ps.Hospital
*/

/*
SELECT
	ps.Hospital, 
	ps.Ward,
	COUNT(*) AS NumberOfPatients,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY ps.Hospital, ps.Ward
*/

/*
SELECT
	ps.Hospital,
	ps.Ward,
	MAX(ps.Tariff) AS MaxTariff,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY 
	ps.Hospital, 
	ps.Ward
*/

/*
SELECT
	ps.Hospital,
	ps.Ward,
	MAX(ps.Tariff) AS MaxTariff,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY 
	ps.Hospital, 
	ps.Ward
ORDER BY TotalTariff DESC
*/

/*
SELECT TOP 3
	ps.Hospital,
	ps.Ward,
	MAX(ps.Tariff) AS MaxTariff,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY 
	ps.Hospital, 
	ps.Ward
ORDER BY TotalTariff DESC
*/

/*
SELECT
	ps.Hospital,
	ps.Ward,
	MAX(ps.Tariff) AS MaxTariff,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY 
	ps.Hospital, 
	ps.Ward
HAVING COUNT(*) < 13
ORDER BY TotalTariff DESC
*/

/*
SELECT
	ps.PatientId,
	dh.Hospital,
	ps.Hospital,
	ps.AdmittedDate,
	dh.HospitalType
FROM PatientStay ps
	LEFT JOIN DimHospitalBad dh
	ON ps.Hospital = dh.Hospital
WHERE dh.Hospital IS NULL
*/

