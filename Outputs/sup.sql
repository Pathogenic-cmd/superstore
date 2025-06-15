# ALL under the question, Who are the most reliable customers.

#Customers who order most frequently
SELECT Customer_ID , count(Order_ID) as Total_Orders
from orders
group by Customer_ID
order by Total_Orders desc limit 10;


#Customers with the highest total spend (loyal, high-value)
SELECT r.Customer_ID, ROUND(SUM(d.Sales), 2) AS Total_Spent
FROM orders r
JOIN orderdetails d ON r.Order_ID = d.Order_ID
GROUP BY r.Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10;

# Customers with consistent order behavior over time (e.g., every month)
select Customer_ID, count(distinct DATE_FORMAT(Order_Date, '%Y-%m')) as Active_months
from orders
group by Customer_ID
order by Active_months Desc;

#Customers with high profit contribution and repeat purchases
select r.Customer_ID,
count(distinct r.Order_ID) as Order_Count,
round(sum(d.Profit),2) as Total_Profit
from orders r
join orderdetails d 
on d.Order_ID = r.Order_ID
group by Customer_ID
order by Total_Profit desc;

#Is there a pattern in purchasing behaviour among different customer segments?
SELECT c.Segment,
       COUNT(DISTINCT r.Order_ID) AS Total_Orders,
       COUNT(DISTINCT c.Customer_ID) AS Unique_Customers,
       ROUND(SUM(d.Sales), 2) AS Total_Sales,
       ROUND(SUM(d.Profit), 2) AS Total_Profit,
       ROUND(AVG(d.Sales), 2) AS Avg_Order_Value
FROM customers c
JOIN orders r ON r.Customer_ID = c.Customer_ID
JOIN orderdetails d ON d.Order_ID = r.Order_ID
GROUP BY c.Segment
ORDER BY Total_Sales DESC;

#Are there customers or segments with consistently unprofitable orders?

#Customers with Unprofitable Orders
WITH order_profit AS (
    SELECT r.Order_ID, r.Customer_ID, c.Segment,
           SUM(d.Profit) AS Order_Profit
    FROM orders r
    JOIN customers c ON r.Customer_ID = c.Customer_ID
    JOIN orderdetails d ON d.Order_ID = r.Order_ID
    GROUP BY r.Order_ID, r.Customer_ID, c.Segment
)

SELECT Customer_ID,
       Segment,
       COUNT(*) AS Total_Orders,
       SUM(CASE WHEN Order_Profit <= 0 THEN 1 ELSE 0 END) AS Unprofitable_Orders,
       ROUND(100.0 * SUM(CASE WHEN Order_Profit <= 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Unprofitable_Order_Percentage
FROM order_profit
GROUP BY Customer_ID, Segment
HAVING Unprofitable_Orders > 0
ORDER BY Unprofitable_Order_Percentage DESC;

#Unprofitable Orders by Segment and Month

WITH order_profit AS (
    SELECT r.Order_ID,
           c.Segment,
           DATE_FORMAT(r.Order_Date, '%Y-%m') AS Order_Month,
           SUM(d.Profit) AS Order_Profit
    FROM orders r
    JOIN customers c ON r.Customer_ID = c.Customer_ID
    JOIN orderdetails d ON d.Order_ID = r.Order_ID
    GROUP BY r.Order_ID, c.Segment, DATE_FORMAT(r.Order_Date, '%Y-%m')
)

SELECT Segment,
       Order_Month,
       COUNT(*) AS Total_Orders,
       SUM(CASE WHEN Order_Profit <= 0 THEN 1 ELSE 0 END) AS Unprofitable_Orders,
       ROUND(100.0 * SUM(CASE WHEN Order_Profit <= 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Unprofitable_Order_Percentage
FROM order_profit
GROUP BY Segment, Order_Month
ORDER BY Segment, Order_Month;


#Orders per Day

SELECT DATE(Order_Date) AS Order_Day,
       COUNT(*) AS Total_Orders
FROM orders
GROUP BY Order_Day
ORDER BY Order_Day;

#Orders per week

SELECT YEAR(Order_Date) AS Order_Year,
       WEEK(Order_Date, 1) AS Order_Week,  -- mode 1: weeks start on Monday
       COUNT(*) AS Total_Orders
FROM orders
GROUP BY Order_Year, Order_Week
ORDER BY Order_Year, Order_Week;

#Orders per Month

SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
       COUNT(*) AS Total_Orders
FROM orders
GROUP BY Order_Month
ORDER BY Order_Month;

#Orders per Year

SELECT YEAR(Order_Date) AS Order_Year,
       COUNT(*) AS Total_Orders
FROM orders
GROUP BY Order_Year
ORDER BY Order_Year;

#Monthly Order Trends by Segment

SELECT c.Segment,
       DATE_FORMAT(r.Order_Date, '%Y-%m') AS Order_Month,
       COUNT(*) AS Total_Orders
FROM orders r
JOIN customers c ON r.Customer_ID = c.Customer_ID
GROUP BY c.Segment, Order_Month
ORDER BY Order_Month, c.Segment;


#Yearly Order Trends by Segment

SELECT c.Segment,
       YEAR(r.Order_Date) AS Year,
       COUNT(*) AS Total_Orders
FROM orders r
JOIN customers c ON r.Customer_ID = c.Customer_ID
GROUP BY c.Segment, Year
ORDER BY Year, c.Segment;








