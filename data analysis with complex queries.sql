create database if not exists my_practice_db;
use my_practice_db;
drop table if exists sales;
CREATE TABLE if not exists Sales (
    sale_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    sale_date DATE,
    amount DECIMAL(10, 2)
);
INSERT INTO Sales (sale_id, employee_name, sale_date, amount) VALUES 
(1, 'Aysha', '2023-01-01', 500),
(3, 'Sugndha', '2023-01-03', 700),
(5, 'Isha',   '2023-01-05', 600),
(2, 'Ridhi',   '2023-01-02', 300),
(4, 'Sumit', '2023-01-04', 200),
(6, 'Amit', '2023-01-06', 400);
WITH EmployeeStats AS (
    -- CTE: Summarize sales per employee
    SELECT 
        employee_name, 
        SUM(amount) AS total_sales,
        COUNT(sale_id) AS sale_count
    FROM Sales
    GROUP BY employee_name
)
SELECT 
    employee_name,
    total_sales,
    -- Subquery: Compare against overall average
    (SELECT AVG(amount) FROM Sales) AS company_avg_per_sale,
    -- Window Function: Rank employees by sales
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank,
    -- Window Function: Cumulative total
    SUM(total_sales) OVER (ORDER BY total_sales DESC) AS running_total
FROM EmployeeStats
WHERE total_sales > (SELECT AVG(total_sales) FROM EmployeeStats); -- Filter Subquery