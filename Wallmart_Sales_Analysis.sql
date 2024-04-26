SELECT * 
FROM walmartsalesdata;

SELECT `Date`,
str_to_date(`Date`,'%d/%m/%Y')
FROM walmartsalesdata;

UPDATE walmartsalesdata
SET `date` = str_to_date(`date`,'%d/%m/%Y');

-- Change the Data type of date to date format 

ALTER TABLE walmartsalesdata
MODIFY COLUMN `date` DATE;

SELECT `Time`,
str_to_date(`Time`,'%h:%i:%s %p')
FROM walmartsalesdata;

UPDATE walmartsalesdata
SET `Time` = str_to_date(`Time`,'%h:%i:%s %p');

ALTER TABLE walmartsalesdata
MODIFY COLUMN `Time` TIME NULL;

SELECT * 
FROM walmartsalesdata;

SELECT DISTINCT Rating
FROM walmartsalesdata;

CREATE TABLE  sales 
LIKE walmartsalesdata;

SELECT * 
FROM Sales;

INSERT INTO sales 
SELECT * 
FROM walmartsalesdata;
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------FEATURE ENGINEERING -----------------------------------------------------------------------------

-- 1. Time of day 

SELECT time,
	(CASE 
		WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `Time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening "
	END
	) AS time_of_day
    FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day Varchar(20);

UPDATE sales
SET time_of_day = (
	CASE 
		WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `Time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening "
	END
	);
    
-- 2.day_name 

SELECT `date`,DAYNAME(`date`) AS day_name
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(20);

UPDATE sales
SET day_name = DAYNAME(`date`);

-- 3.Month_name

SELECT `DATE`,MONTHNAME(`date`) as Month_name
FROM sales;

ALTER TABLE sales ADD COLUMN Month_name VARCHAR(20);

UPDATE sales
SET Month_name=MONTHNAME(`date`);
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------EXPLORATORY DATA ANALYSIS ----------------------------------------------------------------

SELECT *
FROM Sales;

-- 1.How many unique cities does the data have?

SELECT DISTINCT(city)
FROM sales;

SELECT COUNT(DISTINCT city)
FROM sales;

-- 2.In which city is each branch?

SELECT DISTINCT City,BRANCH
FROM sales;

-- 3. How many unique product lines does the data have?

SELECT DISTINCT `Product line`
FROM sales;

SELECT COUNT(DISTINCT `Product line`)
FROM sales;

-- 4.What is the most common payment method?

SELECT DISTINCT Payment,COUNT(Payment) as Payment_Count
FROM sales
GROUP BY Payment;

-- 5.What is the most selling product line?

SELECT `Product line`,SUM(TOTAL) as Total_Sales
FROM sales
GROUP BY `Product line`
ORDER BY Total_Sales Desc;

-- 6.What is the total revenue by month?

SELECT Month_name,SUM(TOTAL) as Revenue
FROM sales
GROUP BY Month_name;

-- 7.What month had the largest COGS?

SELECT Month_name,SUM(cogs) as Total_Cogs
FROM sales
GROUP BY Month_name;

-- 8.What product line had the largest revenue?

SELECT `Product line`,SUM(Total) as Total_Revenue
FROM sales
GROUP BY `Product line`
ORDER BY Total_Revenue DESC ;

-- 9.What is the city with the largest revenue?

SELECT City,SUM(Total) as Total_Revenue
FROM sales
GROUP BY City
ORDER BY Total_Revenue DESC ;

-- 10.What product line had the largest VAT?

SELECT `Product line`,SUM(Total) as Total_Revenue
FROM sales
GROUP BY `Product line`
ORDER BY Total_Revenue DESC ;

-- 11.Which branch sold more products than average product sold?

SELECT Branch ,AVG(Quantity) as qty
FROM sales
GROUP BY Branch
HAVING qty>(SELECT AVG(Quantity) FROM sales);

-- 12.What is the most common product line by gender?

SELECT Gender,`Product line`,COUNT(Gender)
FROM sales 
WHERE GENDER='Female'
GROUP BY GENDER ,`Product line`
ORDER BY COUNT(GENDER) DESC;

-- 13.What is the average rating of each product line?

SELECT `Product line`,AVG(Rating)
FROM sales
GROUP BY `Product line`
ORDER BY AVG(Rating) DESC ;

SELECT `Product line`,AVG(Rating)
FROM sales
GROUP BY `Product line`
HAVING AVG(Rating)>7
ORDER BY AVG(Rating) DESC ;

-- 14. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

SELECT `Product line`,AVG(Total) as Avg_total,
CASE 
	WHEN AVG(Total)>300 THEN "GOOD"
    WHEN AVG(Total)<300 THEN "BAD"
END as OUTCOME
FROM sales
GROUP BY `Product line`;

SELECT COUNT(*),AVG(Total)
FROM SALES;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------SALES ANALYSIS --------------------------------------------------------------------------

-- 15. Number of sales made in each time of the day per weekday

SELECT *
FROM sales;

SELECT time_of_day,day_name,AVG(TOTAL) avg_total
FROM sales
GROUP BY time_of_day,day_name
HAVING day_name IN ('Saturday','Sunday')
ORDER by avg_total DESC;

-- 16.Which of the customer types brings the most revenue?

SELECT `Customer type`,SUM(Total),AVG(Total)
FROM Sales
GROUP BY `Customer type`
ORDER BY SUM(TOTAL) DESC ;

-- 17.Which city has the largest tax percent/ VAT (Value Added Tax)?


ALTER TABLE sales
CHANGE COLUMN `Tax 5%` TAX_VAT DOUBLE;

SELECT City,MAX(TAX_VAT),AVG(TAX_VAT)
FROM sales
Group by City
ORDER BY MAX(TAX_VAT) DESC;

SELECT 
 
 -- 18.Which customer type pays the most in VAT?

SELECT `Customer type`,MAX(TAX_VAT),AVG(TAX_VAT)
FROM sales
Group by `Customer type`
ORDER BY MAX(TAX_VAT) DESC;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------- CUSTOMER ANALYSIS ------------------------------------

SELECT * 
FROM sales;

-- 19.How many unique customer types does the data have?

ALTER TABLE sales
CHANGE COLUMN `Customer type` Customer_type VARCHAR(20);

SELECT DISTINCT Customer_type
FROM sales;

-- 20.How many unique payment methods does the data have?

SELECT DISTINCT Payment
FROM sales;

-- What is the most common customer type?

SELECT Customer_type,COUNT(Customer_type)
FROM sales
GROUP BY Customer_type;

-- Which customer type buys the most?

SELECT Customer_type,SUM(TOTAL)
FROM sales
GROUP BY Customer_type;

-- What is the gender of most of the customers?

SELECT GENDER,COUNT(GENDER)
FROM sales
GROUP BY GENDER;

-- What is the gender distribution per branch?

SELECT Branch,Gender,COUNT(Gender)
FROM sales
GROUP BY Branch,Gender
ORDER BY BRANCH;

SELECT Branch,Gender,COUNT(Gender)
FROM sales
GROUP BY Branch,Gender
ORDER BY BRANCH;

-- Which time of the day do customers give most ratings?

SELECT time_of_day,COUNT(Rating)
FROM sales
GROUP BY time_of_day;

-- Which time of the day do customers give most ratings per branch?

SELECT time_of_day,Branch,COUNT(Rating)
FROM sales
GROUP BY time_of_day,Branch
ORDER BY Branch;


-- Which day of the week has the best avg ratings?

SELECT day_name,AVG(Rating) avg_ratings
FROM sales
GROUP BY day_name 
ORDER BY avg_ratings desc;

-- Which day of the week has the best average ratings per branch?
 
SELECT day_name,Branch,AVG(Rating) avg_ratings
FROM sales
GROUP BY day_name ,Branch
ORDER BY avg_ratings desc;













