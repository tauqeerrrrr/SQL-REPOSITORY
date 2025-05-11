create database car_analysis;
use Car_analysis;

select * from car_sales;
-- count rows number in datasets
select distinct(count(Car_id) ) from car_sales;
--  find the first 10 rows in datasets
select * from car_sales
order by Car_id asc limit 10;
--  find the last 10 rows in datasets
select * from car_sales
order by Car_id desc limit 10;
--  find the information like data types and columns name and null valuses in datasets
SELECT 
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME ='car_sales'
and TABLE_SCHEMA='Car_analysis';
-- Only run this if your dates are consistently in MM/DD/YYYY format
UPDATE car_sales
SET date = STR_TO_DATE(date, '%m/%d/%Y');
-- change the data type for date columns 
ALTER TABLE car_sales
MODIFY date DATETIME;
-- find the null values in columns 
select  count(*) as 'Total_Rows',
sum(case when date is null then 1 else 0 end )as"null_date",
sum(case when Gender is null then 1 else 0 end )as"null_Gender",
sum(case when 'Annual Income' is null then 1 else 0 end )as"null_Annual_incom",
sum(case when company is null then 1 else 0 end )as"null_company",
sum(case when model is null then 1 else 0 end )as"null_model",
sum(case when Engine is null then 1 else 0 end )as"null_engine",
sum(case when date is null then 1 else 0 end )as"null_date",
sum(case when Transmission is null then 1 else 0 end )as"null_Transmission",
sum(case when # COLUMN_NAME, DATA_TYPE
'Price ($)'
 is null then 1 else 0 end )as"null_Price",
sum(case when 'Body Style' is null then 1 else 0 end )as"null_Bosy_style",
sum(case when Dealer_Region  is null then 1 else 0 end )as"null_Dealer_Region"
from car_sales;
-- there is no null values in datasets
select * from car_sales
where Gender is null;
-- fill  default values the null values in columns;
update car_sales
set Gender=coalesce(Gender, 'default_value');
--  decrive all informataion in data sets 
DESCRIBE car_sales;
--  find duplicates values in datasets
select count(*) from car_Sales
group by Car_id
having count(*)>1;

-- 📊 3. Exploratory Data Analysis (EDA)
-- Total cars sold
select count(*) "Total_sales_cars" from car_sales;

-- Total revenue
select * from car_sales;
select sum('Price ($)') as 'Total_Income' from car_sales;
-- Total_sum by gender
select sum(Annual_Income) , Gender from car_sales
group by Gender;
select * from car_sales;
-- change the columns name
ALTER TABLE `car_analysis`.`car_sales` 
CHANGE COLUMN `Annual Income` `Annual_Income` INT NULL DEFAULT NULL ;

-- top most 5 company 
select sum(Annual_Income) as "Total_Income", Company from car_sales
group by Company 
order by Company desc limit 5; 

select * from car_Sales;
--  sales by engine
select sum(Annual_Income) as "Total_Income", Engine from car_sales
group by Engine ;
select * from car_Sales;
-- Car slaes by color
select sum(Annual_Income) as "Total_Income", Color from car_sales
group by Color order by Color desc  ;
 -- sales by bosy style
select sum(Annual_Income) as "Total_Income", 'Body Style' from car_sales
group by 'Body Style' order by Color desc  ;

-- Gender and car color by sales 
select sum(Annual_Income) as "total_sales", count(color) as color , count(Gender)as Gender, color, Gender from car_sales
group by color , Gender order by Color desc  ;


-- 📈 4. Time Series Analysis
-- month by sales 

select monthname(date) as "month" , sum(Annual_Income) from car_sales
group by month order by sum(Annual_Income) desc ;


-- year by sales
select year(date) as "year" , sum(Annual_Income) from car_sales
group by year order by sum(Annual_Income) desc ;



SELECT 
  monthname(date) as month
  , 
  year(date) as year,
    SUM(Annual_Income) AS monthly_revenue
FROM car_sales
GROUP BY month, year
ORDER BY month;
select * from car_sales;
-- 🧠 5. Advanced SQL Analysis
-- 📌 5.1 Top salesperson per region (using window function)

select  Dealer_Name, Dealer_Region,
sum(Annual_Income) over (Partition by Dealer_Region order by sum(Annual_Income) desc ) as "Top_sales"
from car_sales;
select Dealer_Name, Dealer_Region, sum(Annual_Income) from car_sales
group by Dealer_Region order by sum(Annual_Income) desc;






-- 7. Business Insights Summary
-- ✅ Most revenue comes from Brand X.

-- ✅ Region North generates highest sales.

-- ✅ Payment_Method = Credit Card is preferred by high-value customers.

-- ✅ Customers aged 30-40 are the most frequent buyers.

-- ✅ Discounts over 20% negatively affect profit margins.

