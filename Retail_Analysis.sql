CREATE DATABASE retail_analysis;

USE retail_analysis;

SHOW TABLES;

-- RENAME table names for convience

ALTER TABLE sales_transactions
RENAME TO sales;

ALTER TABLE product_inventory
RENAME TO products;

ALTER TABLE customer_profiles
RENAME TO customers;

DESC sales;   -- ï»¿TransactionID
DESC products; -- ï»¿ProductID
DESC customers;  -- ï»¿CustomerID

ALTER TABLE sales
RENAME COLUMN ï»¿TransactionID TO TransactionID;

ALTER TABLE products
RENAME COLUMN ï»¿ProductID TO ProductID;

ALTER TABLE customers
RENAME COLUMN ï»¿CustomerID TO CustomerID;

-- DATA CLEANING --

SELECT * FROM customers;    
SELECT * FROM products;
SELECT * FROM sales;

-- Removing Duplicates

SELECT
	TransactionID,
    count(*)
FROM sales
GROUP BY TransactionID
HAVING count(*) > 1;

CREATE TABLE salesnew AS
	SELECT DISTINCT * FROM sales;
    
DROP TABLE sales;

ALTER TABLE salesnew
RENAME TO sales;

SELECT * FROM sales;

SELECT * FROM products;

-- Identifying Price Discrepancies 

SELECT
	TransactionID,
    s.Price AS TrasactionPrice,
    p.price AS InventoryPrice
FROM sales s
JOIN products p ON s.ProductID = p.ProductID
WHERE s.Price != p.Price;

-- Fixing Price inconsistencies

SET SQL_SAFE_UPDATES =0;

UPDATE sales s 
JOIN products p ON s.ProductID = p.ProductID
SET s.Price = p.Price
WHERE s.Price <> p.Price;

SELECT * FROM sales;

-- Fixing Null Values 

SELECT * FROM customers;

SELECT
	SUM(CASE WHEN CustomerID IS NULL OR CustomerID LIKE '' THEN 1 ELSE 0 END) AS id_nulls,
    SUM(CASE WHEN age IS NULL OR age LIKE '' THEN 1 ELSE 0 END) AS age_nulls,
    SUM(CASE WHEN gender IS NULL OR gender LIKE '' THEN 1 ELSE 0 END) AS gender_nulls,
    SUM(CASE WHEN location IS NULL OR location LIKE '' THEN 1 ELSE 0 END) AS location_nulls,
    SUM(CASE WHEN JoinDate IS NULL OR JoinDate LIKE '' THEN 1 ELSE 0 END) AS date_nulls
FROM customers;

SELECT
	count(*)
FROM customers
WHERE Location LIKE "";

UPDATE customers
SET Location='Unknown'
WHERE Location LIKE "";

SELECT * FROM customers;

-- Cleaning of Date format

SELECT * FROM sales;

CREATE TABLE sales1 AS
	SELECT
		*,
		STR_TO_DATE(TransactionDate,'%d/%m/%y') AS TransactionDate_updated
	FROM sales;

DROP TABLE sales;

ALTER TABLE sales1
RENAME TO sales;

SELECT * FROM sales;

-- Summary of Total Sales 

SELECT
	ProductID,
    SUM(QuantityPurchased) AS TotalUnitsSold,
    ROUND(SUM(QuantityPurchased*Price),2) AS TotalSales
FROM sales
GROUP BY ProductID
ORDER BY 3 DESC;

-- Customer Purchase Frequency

SELECT
	CustomerID,
    count(*) AS NumberOfTransactions
FROM sales
GROUP BY CustomerID
ORDER BY 2 DESC;

-- Category Wise Unitssold and Sales 

SELECT * FROM sales;
SELECT * FROM products;

SELECT
	p.Category,
    SUM(s.QuantityPurchased) AS TotalUnitsSold,
    ROUND(SUM(s.QuantityPurchased* s.Price),2) AS TotalSales
FROM products p
JOIN sales s ON p.ProductID = s.ProductID
GROUP BY 1
ORDER BY 3 DESC;

-- Most Selling Products

SELECT
	ProductID,
    ROUND(SUM(QuantityPurchased*Price),2) AS TotalRevenue
FROM sales
GROUP BY ProductID
ORDER BY 2 DESC
LIMIT 10;

-- Least Selling Products

SELECT
	ProductID,
    ROUND(SUM(QuantityPurchased*Price),2) AS TotalRevenue
FROM sales
GROUP BY ProductID
HAVING 2 > 0
ORDER BY 2
LIMIT 10;

-- Sales Trend 

SELECT
	TransactionDate_updated AS DATETRANS,
    count(*) AS Transaction_count,
    SUM(QuantityPurchased) AS TotalUnitsSold,
    ROUND(SUM(QuantityPurchased * Price),2) AS TotalSales
FROM sales
GROUP BY 1
ORDER BY 1 DESC;

-- Monthly Sales Trend

SELECT
	DATE_FORMAT(TransactionDate_updated, '%b') AS DATETRANS,
    count(*) AS Transaction_count,
    SUM(QuantityPurchased) AS TotalUnitsSold,
    ROUND(SUM(QuantityPurchased * Price),2) AS TotalSales
FROM sales
GROUP BY 1;

-- Month on Month Growth Rate of Sales

With cte AS(
	SELECT
		Month(TransactionDate_updated) AS Month,
        ROUND(SUM(QuantityPurchased*Price),2) AS total_sales
	FROM sales
    GROUP BY 1
),
cs AS(
	SELECT
		Month,
        total_sales,
		LAG(total_sales) OVER (ORDER BY Month) AS previous_month_sales
	FROM cte
)
SELECT
	*,
    ROUND(((total_sales-previous_month_sales) / previous_month_sales) *100 ,2) AS mom_growth_percentage
FROM cs
ORDER BY Month;

-- Most Purchasing Customers (Atleast more than 10 transactions and total spent more than 1K)

SELECT
	CustomerID,
    count(*) AS NumberOfTransactions,
    ROUND(SUM(QuantityPurchased*Price),2) AS TotalSpent
FROM sales
GROUP BY CustomerID
HAVING count(*) > 10 AND TotalSpent > 1000
ORDER BY 3 DESC;

-- Occasional Customers  (transactions <=2 ) - Low purchase Frequency

SELECT
	CustomerID,
    count(*) AS NumberOfTransactions,
    ROUND(SUM(QuantityPurchased * Price),2) AS TotalSpent
FROM Sales
GROUP BY CustomerID
HAVING count(*) <= 2
ORDER BY count(*), TotalSpent DESC;

-- Product wise most purchasing customers (Repeat of Purchases) 

SELECT
	CustomerID,
    ProductID,
    count(*) AS TimesPurchased
FROM sales
GROUP BY 1,2
HAVING count(*) > 1
ORDER BY count(*) DESC;

-- Loyalty of the customers (purchasing the products within some or few days)

With cte AS(
	SELECT
		CustomerID,
		MIN(TransactionDate_updated) AS FirstPurchase,
		MAX(TransactionDate_updated) AS LastPurchase
	FROM sales
    GROUP BY CustomerID
)
SELECT
	*,
    DATEDIFF(LastPurchase,FirstPurchase) AS DaysBetweenPurchases
FROM cte
GROUP BY customerID
ORDER BY DaysBetweenPurchases DESC;

-- Customer Segmentation 
/*
	segment           totalproductsquantity
    low	 					 1-10
    Med						11-30
    High					>30
*/

SELECT * FROM sales;

With cte AS (
	SELECT
		CustomerID,
		SUM(QuantityPurchased) AS TotalQuantity,
		CASE
			WHEN SUM(QuantityPurchased) BETWEEN 1 AND 10 THEN 'Low'
			WHEN SUM(QuantityPurchased) BETWEEN 11 AND 30 THEN 'Med'
			ELSE 'High'
		END AS CustomerSegment
	FROM sales
	GROUP BY CustomerID
)
SELECT
	CustomerSegment,
    Count(*)
FROM cte
GROUP BY CustomerSegment;