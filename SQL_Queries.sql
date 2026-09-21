-- E-Commerce Sales & Customer Analytics
-- SQL Analysis
-- Database: SQLite
-- Table: sales

-- 1. Preview the data
SELECT *
FROM sales
LIMIT 10;


-- 2. Total Revenue
SELECT
    SUM(Revenue) AS Total_Revenue
FROM sales;


-- 3. Total Orders
SELECT
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM sales;


-- 4. Revenue by Country
SELECT
    Country,
    SUM(Revenue) AS Total_Revenue
FROM sales
GROUP BY Country
ORDER BY Total_Revenue DESC
LIMIT 10;


-- 5. Top 10 Products by Revenue
SELECT
    Description,
    SUM(Quantity) AS Units_Sold,
    SUM(Revenue) AS Total_Revenue
FROM sales
GROUP BY Description
ORDER BY Total_Revenue DESC
LIMIT 10;


-- 6. Top 10 Customers by Revenue
SELECT
    CustomerID,
    SUM(Revenue) AS Total_Revenue
FROM sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Total_Revenue DESC
LIMIT 10;


-- 7. Orders per Customer
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS Number_of_Orders
FROM sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Number_of_Orders DESC
LIMIT 10;


-- 8. Number of Repeat Customers
SELECT
    COUNT(*) AS Repeat_Customers
FROM (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS Number_of_Orders
    FROM sales
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
    HAVING COUNT(DISTINCT InvoiceNo) > 1
);


-- 9. Repeat Customer Rate
SELECT
    COUNT(*) AS Total_Customers,
    SUM(
        CASE
            WHEN Number_of_Orders > 1 THEN 1
            ELSE 0
        END
    ) AS Repeat_Customers,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN Number_of_Orders > 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS Repeat_Customer_Rate
FROM (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS Number_of_Orders
    FROM sales
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
);


-- 10. Average Order Value
SELECT
    SUM(Revenue) / COUNT(DISTINCT InvoiceNo) AS Average_Order_Value
FROM sales;
