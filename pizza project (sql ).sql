use kaggle_project

select *
from [kaggle_project].[dbo].[pizza]

SELECT 
    COUNT(*) - COUNT(order_id) AS Missing_Orders,
    COUNT(*) - COUNT(pizza_name) AS Missing_Names,
    COUNT(*) - COUNT(total_price) AS Missing_Prices
FROM [kaggle_project].[dbo].[pizza];

--Exploration and Core KPIs.
SELECT 
    ROUND(SUM(total_price), 2) AS Total_Revenue,
    COUNT(DISTINCT order_id) AS Total_Orders,
    SUM(quantity) AS Total_Pizzas_Sold,
    ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS Average_Order_Value
FROM [kaggle_project].[dbo].[pizza];




SELECT COUNT(order_id) AS Count_With_Duplicates
FROM [kaggle_project].[dbo].[pizza];

select AVG(total_price)
FROM [kaggle_project].[dbo].[pizza];

select round(SUM(total_price)/COUNT(distinct order_id),2)
FROM [kaggle_project].[dbo].[pizza];

select order_date,avg(order_time)
FROM [kaggle_project].[dbo].[pizza]

--Total Orders by Day of the Week
select datename(dw,order_date) as day_of_week,
count(distinct order_id) as total_orders 
FROM [kaggle_project].[dbo].[pizza]
group by datename(dw,order_date) 
order by total_orders desc;

--Percentage of Sales by Pizza Category
SELECT 
    pizza_category, 
    ROUND(SUM(total_price), 2) AS Total_Revenue,
    ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM [kaggle_project].[dbo].[pizza]), 2) AS Percentage_Of_Sales
FROM [kaggle_project].[dbo].[pizza]
GROUP BY pizza_category
ORDER BY Total_Revenue DESC;

--Which pizza size (L, M, S, XL) comes out as the top seller?
SELECT 
    pizza_size, 
    ROUND(SUM(total_price), 2) AS Total_Revenue,
    ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM [kaggle_project].[dbo].[pizza]), 2) AS Percentage_Of_Sales
FROM [kaggle_project].[dbo].[pizza]
GTop 5 Pizzas by Quantity SoldROUP BY pizza_size
ORDER BY Total_Revenue DESC;

--Top 5 Pizzas by Quantity Sold
select top 5 
pizza_name,
sum(quantity) AS Total_Pizzas_Sold
FROM [kaggle_project].[dbo].[pizza]
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC;

--Bottom 5 (Worst Sellers) by Quantity Sold
select top 5 pizza_name,
sum(quantity) AS Total_Pizzas_Sold
FROM [kaggle_project].[dbo].[pizza]
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC ;

--Monthly Trend Analysis (Seasonality)
select datename(mm,order_date) as Month_name,
count(distinct order_id) As Total_orders
from [kaggle_project].[dbo].[pizza]
GROUP BY DATENAME(mm, order_date)
ORDER BY Total_Orders DESC;

SELECT 
    order_id, 
    pizza_name, 
    pizza_size, 
    COUNT(*) AS Row_Count
FROM [kaggle_project].[dbo].[pizza]
GROUP BY order_id, pizza_name, pizza_size
HAVING COUNT(*) > 1;