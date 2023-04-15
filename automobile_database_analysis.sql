-- database from https://www.kaggle.com/datasets/kaushiksuresh147/customer-segmentation

-- Creating Household Customer Segmentation
CREATE TABLE Family_Cust AS

SELECT 
	ID,
	Buying_Power,
	Model,
	COUNT (*) N_Customers
FROM Customers
WHERE Model IS NOT NULL AND Ever_Married = "Yes" AND Family_Size >= 2.0
GROUP BY 2,3
ORDER BY 4 DESC

-- Creating Single Customer Segmentation
CREATE TABLE Single_Cust AS

SELECT 
	ID,
	Buying_Power,
	Model,
	COUNT (*) N_Customers
FROM Customers
WHERE Model IS NOT NULL AND Ever_Married = "No"
GROUP BY 2,3
ORDER BY 4 DESC

-- Creating Generation Segmentation

-- Beginning with querying customer age range
SELECT
	MIN (Age),
	MIN(Age)
FROM Customers

-- Post-War Generation
CREATE TABLE PostWar_Cust AS

WITH sub AS (
	SELECT * FROM Customers
	WHERE Age BETWEEN 78 AND 95
)

SELECT
	ID,
	Gender,
	Buying_Power,
	Model,
	COUNT (*) N_Customers,
	'PostWars' AS Generation
FROM sub
WHERE Model IS NOT NULL
GROUP BY 2,3,4
ORDER BY 5 DESC

-- Creating other generations by changing WITH sub AS query
CREATE TABLE Boomers_Cust AS

WITH sub AS (
	SELECT * FROM Customers
	WHERE Age BETWEEN 69 AND 77
)

CREATE TABLE Jones_Cust AS

WITH sub AS (
	SELECT * FROM Customers
	WHERE Age BETWEEN 59 AND 68
)

CREATE TABLE X_Cust AS

WITH sub AS (
	SELECT * FROM Customers
	WHERE Age BETWEEN 43 AND 58
)

CREATE TABLE Y_Cust AS

WITH sub AS (
	SELECT * FROM Customers
	WHERE Age BETWEEN 27 AND 42
)

CREATE TABLE Z_Cust AS

WITH sub AS (
	SELECT * FROM Customers
	WHERE Age BETWEEN 11 AND 26
)

-- Using CASE WHEN function to query in one table
CREATE TABLE Generation AS

SELECT
	ID,
	CASE WHEN Age BETWEEN 18 and 26 THEN "Z"
				WHEN Age BETWEEN 27 and 42 THEN "Y"
				WHEN Age BETWEEN 43 and 58 THEN "X"
				WHEN Age BETWEEN 59 and 68 THEN "Jones"
				WHEN Age BETWEEN 69 and 77 THEN "Boomers"
				WHEN Age BETWEEN 78 and 95 THEN "PostWar"
	ELSE "NULL"
	END "Generation",
	Buying_Power,
	Model,
	COUNT (*) N_Customers
FROM Customers
WHERE Model IS NOT NULL
GROUP BY 2,3,4
ORDER BY 5 DESC

-- Creating Profession Segmentation

SELECT 
	ID,
	COALESCE(Graduated, "Not Specified") Graduation,
	Profession,
	Buying_Power,
	Model,
	COUNT (*) N_Customers
FROM Customers
WHERE Profession IS NOT NULL AND Model IS NOT NULL
GROUP BY 2,3,4,5 
ORDER BY 6 DESC
