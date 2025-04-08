## Introduction

SQL stands for Structured (English) Query Language.

SQL is the language for retrieving (querying) data from a database and teach how to craft simple SQL statements to retrieve data then do some calculations and summaries.

We think of SQL in relation to relational databases, for example, Microsoft’s SQL Server and lots of other databases: Oracle, IBM’s DB2, Postgres, Maria, BiqQuery, Snowflake, MySQL and others. But SQL is also used to retrieve for data lakes e.g. lots of large CSV files, via with a “SQL end-point”. SQL is also used to read data from large data warehouses e.g. the SparkSQL language is based on SQL.

SQL goes hand in glove with the de-facto pattern of organising data:

- Data is stored in a table - an arrangement of data with rows and columns. No data can exist in a database outside of a table.
- A database is a collection of tables.
- These tables may be related - two tabes may have each have a column with values from the same domain. For example, an Invoice table and a Customer table may both have a column named CustomerId.

The database builder can constrain the data in the database, e.g., column datatypes, primary and foreign keys (which provide referential integrity), check constraints. Used properly, these contribute to enforcing good data quality.

For completeness, relational databases also contain:

- some parcels of SQL code to organise and manage the tasks we want the database to perform, e.g., views, stored procedures and functions.
- some structures to improve the performance of the database e.g., indexes make retrieval quicker

SMSS is what Microsoft SQL Server uses to write and return SQL queries. There is a database explorer on the left side, your SQL query in the main view and the results at the bottom. 

## Databases

A common column across tables/databases allows linking together of tables/databases - what's important is that the values are the same.

Primary keys need to be unique and the rest of the attributes in the table can be linked back to the primary key. 

Referential integrity can be used to ensure that values entered into a database ensure that values are already present within a table for that value to be entered. For example, a patient can only be entered into the database if the hospital name that the patient is being added with is already present within a hospitals table. 

You can see how tables are related together with entity relationship diagrams which are basically database maps. 

## Basics of SQL queries

Use the SELECT keyword to return some data. 

```sql
-- The following brings back the whole table
SELECT * FROM PatientStay
-- You can get back specific columns in the dataset
SELECT PatientId,AdmittedDate,DischargeDate FROM PatientStay
```

SQL doesn't care about whitespace but there is a convention that is useful to use for formatting. Of course, there are auto-formatters available for code styles too. 

```sql
-- This is the same query as above but formatted correctly 
SELECT 
	PatientId,
	AdmittedDate,
	DischargeDate 
FROM PatientStay
```

You can use aliases for tables that makes it easier to use autocomplete for column headings when writing and reading column headings. This is actually best practice.

```sql
-- The alias in this case is ps and goes after the table name PatientStay
SELECT
	ps.PatientId,
	ps.AdmittedDate,
	ps.DischargeDate
FROM PatientStay ps
```

You can filter data too using the WHERE keyword. 

```sql
-- Note that the equality operator is one equals sign
-- Additionally note that the fixed string is in single quotes, another SQL convention. Fixed strings are known as 'string literals'
-- If the SQL database is case insensitive, then the case within the fixed string does not matter
SELECT
	ps.PatientId,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital
FROM PatientStay ps
WHERE ps.Hospital = 'Kingston'
```

You can choose multiple clauses where you are filtering. 

```sql
-- In this case we are using the OR keyword
SELECT
	ps.PatientId,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital
FROM PatientStay ps
WHERE ps.Hospital = 'Kingston'
OR ps.Hospital = 'PRUH'
```

You can use lists as well.

```sql
-- Note the use of brackets and the IN keyword
SELECT
	ps.PatientId,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
```

You can also use negative keywords like NOT.

```sql
SELECT
	ps.PatientId,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital
FROM PatientStay ps
WHERE ps.Hospital NOT IN ('Kingston', 'PRUH')
```

You can use the AND keyword for queries which involve multiple filters.

```sql
-- Note how the % sign can be used like a wildcard (like * in regex)
SELECT
	ps.PatientId,
	ps.Ward,
	ps.AdmittedDate,
	ps.DischargeDate,
	ps.Hospital
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
```

You can use 'or more' as a concept within filters too. 

```sql
-- Note use of the >= operator 
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
AND ps.Tariff >= 6
```

You can also use the BETWEEN keyword. 

```sql
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
AND ps.Tariff BETWEEN 3 AND 6
```

Multiline comments can be done using the conventional `/* code in between */`.

You can order results from the table as well using the ORDER keyword. 

```sql
-- Ascending order is the default
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
ORDER BY ps.AdmittedDate

-- You can specify descending order too
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
ORDER BY ps.AdmittedDate DESC
```

You can also order with multiple columns, with the first ordering variable taking priority in terms of what is ordered first and then within that ordering, the other variables that you mention are ordered. 

```sql
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
```

You can create a new column with your query for the data you will get back - as so called "calculated column".

```sql
-- Note the value within the column goes first and then using the AS keyword, the column is named "LengthOfStay"
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
```

SQL functions can be used to create calculated columns. You can look up SQL functions/keywords on w3schools if you want to check the reference as to how to use these functions. Here we use the "DATEDIFF" function. 

```sql
SELECT DATEDIFF(DAY, '2025-03-12', '2025-04-08')
```

Now applying the above "DATEDIFF" function to create a calculated column. 

```sql
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
```

You can use functions in different ways. Here is the "DATEADD" function being used to create a calculated column in which a ReminderDate occurs 1 month before the AdmittedDate.

```sql
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
```

You can use the COUNT keyword to count number of rows in a table

```sql
SELECT COUNT(*) AS NumberOfPatients FROM PatientStay
```

You can also use the GROUP BY keyword in order to count per "group" within a variable.

```sql
SELECT
	ps.Hospital,
	COUNT(*) AS NumberOfPatients
FROM PatientStay ps
GROUP BY ps.Hospital
```

You can use SUM keywords too. 

```sql
SELECT
	ps.Hospital,
	COUNT(*) AS NumberOfPatients,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY ps.Hospital
```

There are other aggregation functions too, like MAX, MIN, etc. 

You can group by multiple columns.

```sql
SELECT
	ps.Hospital,
	ps.Ward,
	MAX(pas.Tariff) as MaxTariff,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY ps.Hospital, ps.Ward
```

Note that when you use a column name that you have calculated within the query, you can't use the alias you created for a table in the query to reference that column name.

```sql
SELECT
	ps.Hospital,
	ps.Ward,
	MAX(pas.Tariff) as MaxTariff,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY ps.Hospital, ps.Ward
ORDER BY TotalTariff DESC
```

You can get the top few results only, by using the TOP keyword. 

```sql
SELECT TOP 3
	ps.Hospital,
	MAX(pas.Tariff) as MaxTariff,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY ps.Hospital
ORDER BY TotalTariff DESC
```

If you want to filter an aggregated column, you have to use the HAVING keyword. It needs to go after the GROUP BY keyword line.

```sql
SELECT
	ps.Hospital,
	COUNT(*) as NumberOfPatients,
	MAX(pas.Tariff) as MaxTariff,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY ps.Hospital
HAVING SUM(ps.Tariff) > 80
ORDER BY TotalTariff DESC

-- All the hospitals with fewer than 13 patients in them
SELECT
	ps.Hospital,
	COUNT(*) as NumberOfPatients,
	MAX(pas.Tariff) as MaxTariff,
	SUM(ps.Tariff) AS TotalTariff
FROM PatientStay ps
GROUP BY ps.Hospital
HAVING COUNT(*) < 13
ORDER BY TotalTariff DESC
```

SQL uses an order of execution. 

```sql
-- For the above example
1. FROM PatientStay ps
2. GROUP BY ps.Hospital
3. HAVING COUNT(*) < 13
4. SELECT
		ps.Hospital,
		COUNT(*) as NumberOfPatients,
		MAX(pas.Tariff) as MaxTariff,
		SUM(ps.Tariff) AS TotalTariff
1. ORDER BY TotalTariff DESC
-- Of course, the above is not valid SQL syntax
```

You can join two tables together, where a column can be used to match using the JOIN and ON keywords.

```sql
-- Note how aliases ps and dh are given to the tables
SELECT * FROM PatientStay ps 
JOIN DimHospitalBad dh ON ps.Hospital = dh.Hospital
```

Sometimes you can have ambiguous column names when you are joining two tables. In this case, you must use the column name from a specific named table. 

```sql
-- This won't work
SELECT
	PatientId,
	Hospital,
	AdmittedDate,
	HospitalType
FROM PatientStay ps 
JOIN DimHospitalBad dh ON ps.Hospital = dh.Hospital

-- This will work
SELECT
	ps.PatientId,
	dh.Hospital,
	ps.AdmittedDate,
	dh.HospitalType
FROM PatientStay ps 
JOIN DimHospitalBad dh ON ps.Hospital = dh.Hospital
```

JOIN is by default an INNER JOIN. You may wish to use a LEFT JOIN instead. This is similar to the concept of joins used with dplyr in R. 

```sql
-- The left table after ON is the 'left' sided table used in the join
SELECT
	ps.PatientId,
	dh.Hospital,
	ps.Hospital,
	ps.AdmittedDate,
	dh.HospitalType
FROM PatientStay ps
LEFT JOIN DimHospitalBad dh
	ON ps.Hospital = dh.Hospital
```

You can find where values are null using the NULL keyword.

```sql
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
```

In SQL, where you are doing calculations with certain data types, don't fall victim to integer arithmetic. Ensure you have the correct data types in order to do the calculations you need to. 

```sql
-- You can use the CAST keyword
-- The following would treat it not as an integer, but as a float
CAST(1000000 AS FLOAT)
```

Interestingly, some queries are computationally faster than others. For example, using the BETWEEN rather than YEAR function. You can use an 'Estimated Plan' to see how the query will logically be constructed from the database and compare different queries to see what would be fastest. This is relevant for large databases. 

```sql
-- Instead of this:
SELECT
	*
FROM
	PricePaidSW12 pp
WHERE
	YEAR(pp.TransactionDate) = 2018
AND pp.Price BETWEEN 400000 AND 500000
AND pp.Street = 'Cambray Road'

-- Try this, which will likely be faster, especially with large tables:
SELECT
	*
FROM
	PricePaidSW12 pp
WHERE
	pp.TransactionDate BETWEEN '2018-01-01' AND '2018-12-31'
AND pp.Price BETWEEN 400000 AND 500000
AND pp.Street = 'Cambray Road'
```

There are other keywords which may be worth exploring such as CASE and NULL. 
