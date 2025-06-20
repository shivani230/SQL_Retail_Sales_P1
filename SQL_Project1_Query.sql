select * from RetailSales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from RetailSales
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select 
transactions_id,
category,
sale_date,
quantiy,
FORMAT(CAST(sale_date AS DATE), 'MMM-yyyy') as formatted_date
from RetailSales
where category = 'Clothing'
and quantiy >= 4 and 
FORMAT(CAST(sale_date AS DATE), 'MMM-yyyy') = 'Nov-2022'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
category,
sum(quantiy) as  total_sales
from RetailSales
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
avg(age) as avg_age
from retailsales
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from RetailSales
where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select
count(transactions_id) total_transactions,
gender,
category
from RetailSales
group by category,
gender
order by Category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from
(
select 
month(sale_date) as monthofsales,
year(sale_date) as yearsofales,
avg(total_sale) avg_sales,
rank() over(partition by year(sale_date) order by month(sale_date) desc) best_selling
from RetailSales
group by month(sale_date),
year(sale_date) 
)t
where best_selling = 1
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select top 5 customer_id,
total_sale
from RetailSales
order by total_sale desc
 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
category,
count(distinct(customer_id)) as distinct_customers
from RetailSales
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with shift_time as
(
select *,
case when datepart(hour,sale_time) < '12' Then 'Morning'
     when datepart(hour,sale_time) between '12' and '17' then 'Afternoon'
     else  'Evening'
     end shifttime
from RetailSales
)
select 
count(*) as total_orders,
shifttime
from shift_time
group by shifttime
