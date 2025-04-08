/*
Land Registry Case Study
This uses public data of property sales in England from the Land Registry at https://www.gov.uk/government/statistical-data-sets/price-paid-data-downloads
The data has been filtered to properties in the London SW12 postcode  
*/

-- The whole table
SELECT * FROM PricePaidSW12

-- Just the column names from the table
SELECT 
    COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'PricePaidSW12'
 
-- How many sales?
SELECT COUNT(*) AS TotalNumberOfSales FROM PricePaidSW12
 
/*
How many sales in each property type?
Order the rows in the result set by number of sales (highest first)
*/
SELECT
    pp.PropertyType,
    COUNT(*) as NumberOfSales
FROM
    PricePaidSW12 pp
GROUP BY pp.PropertyType
ORDER BY NumberOfSales DESC

/*
How many sales in each year?
Since the year of the sales is not a column in the table, calculate it with the YEAR() function
Order the rows in the result set by Year (earliest first)
*/
SELECT YEAR('2022-09-21') AS TheYear;
SELECT TOP 5 YEAR(P.TransactionDate) YearSold FROM PricePaidSW12 p;

SELECT
    YEAR(pp.TransactionDate) AS TransactionYear,
    COUNT(*) AS NumberOfSales
FROM 
    PricePaidSW12 pp
GROUP BY YEAR(pp.TransactionDate)
ORDER BY TransactionYear ASC
 
-- What was the total market value in £ Millions of all the sales each year?
SELECT
    YEAR(pp.TransactionDate) AS TransactionYear,
    COUNT(*) AS NumberOfSales,
    SUM(pp.Price) / CAST(1000000 AS FLOAT) AS TotalMarketValueInMillions
FROM 
    PricePaidSW12 pp
GROUP BY YEAR(pp.TransactionDate)
ORDER BY TransactionYear ASC
 
-- What are the earliest and latest dates of a sale?

-- Method 1
SELECT TOP 1
    pp.TransactionDate AS EarliestSaleDate
FROM 
    PricePaidSW12 pp
ORDER BY TransactionDate ASC

-- Method 2
SELECT
    MIN(pp.TransactionDate) AS EarliestSaleDate
FROM 
    PricePaidSW12 pp

-- Method 1
SELECT TOP 1
    pp.TransactionDate AS LatestSaleDate
FROM 
    PricePaidSW12 pp
ORDER BY TransactionDate DESC

-- Method 2
-- Method 2
SELECT
    MAX(pp.TransactionDate) AS EarliestSaleDate
FROM 
    PricePaidSW12 pp
 
-- How many different property types are there?
SELECT
    COUNT(DISTINCT pp.PropertyType) AS NumberOfPropertyTypes
FROM
    PricePaidSW12 pp
 
-- List all the sales in 2018 between £400,000 and £500,000 in Cambray Road (a street in SW12)
SELECT
    *
FROM
    PricePaidSW12 pp
WHERE
    pp.TransactionDate BETWEEN '2018-01-01' AND '2018-12-31' 
AND pp.Price BETWEEN 400000 AND 500000
AND pp.Street = 'Cambray Road'

/*
1. List the 25 latest sales in Ormeley Road with the following fields: TransactionDate, Price, PostCode, PAON
2. Join on PropertyTypeLookup to get the PropertyTypeName
3. Use a CASE statement for PropertyTypeName column
*/
SELECT TOP 25
    pp.TransactionDate,
    pp.Price,
    pp.PostCode,
    pp.PAON,
    ptl.PropertyTypeName
FROM PricePaidSW12 pp
    LEFT JOIN PropertyTypeLookup ptl
    ON PropertyType = PropertyTypeCode
WHERE pp.Street = 'Ormeley Road'
ORDER BY TransactionDate DESC