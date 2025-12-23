--SQL retail sales analysis

-- Create Table
CREATE TABLE Retail_sales
   (
      transactions_id  INT PRIMARY KEY,
      sale_date  DATE,
      sale_time  TIME,
      customer_id INT,
      gender  VARCHAR(15),
      age INT,
      category VARCHAR(15),
      quantiy INT,
      price_per_unit FLOAT, 
      cogs FLOAT,
      total_sale FLOAT	
   );
SELECT *FROM retail_sales
limit 10
--
SELECT *FROM retail_sale
WHERE transactions_id is null

SELECT *FROM retail_sales
WHERE
   transactions_id is null
   or
   sale_date is null
   or
   sale_time is null
   or
   gender is null
   or 
   category is null
   or
   cogs is null
   or
   total_sale is null;

-- Data cleaning
DELETE FROM retail_sales
WHERE
   transactions_id is null
   or
   sale_date is null
   or
   sale_time is null
   or
   gender is null
   or 
   category is null
   or
   cogs is null
   or
   total_sale is null;

-- Data Exploration
-- How many sales we have?
SELECT COUNT(*)total_sale FROM retail_sales

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id)AS total_sale FROM retail_sales

--Data analytics & business key problems an answers
-- Q1. Write Sql query to retrieve all columns for sales made on '2022-11-05
SELECT*
FROM retail_sales
WHERE sale_date ='2022-11-05';

-- Q2. Write a sql query to retrieve all the transactions where the category is clothing and the quantity sold is more than 10 in the month of nov- 2022
SELECT*
FROM retail_sales
WHERE category ='Clothing'
  AND
  TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
  AND
  quantiy>10

-- Write a sql query to calculate the total sales for each category
SELECT
   category,
    COUNT(*) as total_orders
   SUM(total_sale) as net_sale
FROM retail_sales
GROUP BY 1

-- Write a sql query to find the average age of customers who purchased from the 'BEAUTY ' category
SELECT
   round (AVG(age), 2) as avg_age
FROM retail_sales
WHERE category ='Beauty'


-- Q . Write a sql query to find all transactions where the total salaes is greater than 1000 
SELECT *FROM retail_sales 
where total_sale >1000

-- write a sql query to find the total number of transactions (transaction_id) made by each gender i each category.
SELECT
    category,
	gender,
	COUNT(*) AS total_trans
FROM retail_sales
GROUP
    BY
	category,
	gender

--  Write sql query to calculate the average sale for each month. find out the best selling item
SELECT 
    EXTRACT (YEAR FROM sale_date)as year,
	EXTRACT (MONTH FROM sale_date)as month,
	SUM(total_sale) as avg_sale
 FROM retail_sales
 GROUP BY 1,2
 ORDER BY 1,3 DESC

 -- Write a sql query to find the top 5 customers based on the highest total sales
 SELECT
    customer_id,
	SUM(total_sale) as total_sales
 FROM retail_sales
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 5


 -- Write sql query to find the number of unique customers WHO PURCHASED ITEMS from each category
SELECT
    category,
    COUNT(DISTINCT customer_id) as count_of_unique customer
 FROM retail_sales
 GROUP BY category 

 -- Write sql query to create ech shift and number of orders (example morning <=12, afternoon btwn 12&17 evening >17)
 WITH hourly_sale
 AS
 (
 SELECT*, 
    CASE 
	   WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
	   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	   ELSE 'Evening'
	 end as shift
from retail_sales
)
SELECT
  shift,
  COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

---end