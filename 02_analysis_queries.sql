USE super_store_sales_data

create view Sales_Analysis_View as select Order_ID,STR_TO_DATE(Order_Date, '%Y-%m-%d') 
as Order_Date, STR_TO_DATE(Ship_Date, '%Y-%m-%d') as Ship_Date,Ship_Mode,Customer_Name,
Segment,Region,City,Category,Sub_Category,Product_Name,CAST(Quantity as decimal(10,2))
as Quantity,CAST(Unit_Price as decimal(10,2)) as Unit_Price,CAST(Discount 
as decimal(10,2)) as Discount,CAST(Sales as decimal(12,2)) as Sales,
CAST(Profit as decimal(12,2)) as Profit from Clean_sales

Select round(sum(Sales), 2) as Total_Sales from Sales_Analysis_View
select round(sum(Profit), 2) as Total_Profit from Sales_Analysis_View
select count(distinct Order_ID) as Total_Orders from Sales_Analysis_View

select Region,count(distinct Order_ID) as Total_Orders,round(sum(Sales),2) as Total_Revenue,
round(sum(Profit),2) as Total_Profit,round(sum(Profit)*100.0/sum(Sales),2) as
Profit_Margin_Pct from Sales_Analysis_View group by Region order by Total_Revenue desc

select Product_Name,Category,sum(Quantity) as Units_Sold, round(sum(Sales),2) as Total_Revenue,
ROUND(SUM(Profit),2) as Total_Profit from Sales_Analysis_View group by Product_Name,Category
order by Total_Revenue desc limit 10

select Category,Sub_Category,round(sum(Sales),2) as Revenue,
RANK() OVER (PARTITION BY Category ORDER BY SUM(Sales) DESC) AS Rank_In_Category from
Sales_Analysis_View group by Category,Sub_Category order by Category,Rank_In_Category

select DATE_FORMAT(Order_Date,'%Y-%m') as Order_Month,ROUND(SUM(Sales), 2) AS Monthly_Revenue,
ROUND(SUM(SUM(Sales)) over(ORDER BY DATE_FORMAT(Order_Date,'%Y-%m')), 2) as 
Running_Total_Revenue from Sales_Analysis_View group by Order_Month order by Order_Month

with Yearly as(select Region,YEAR(Order_Date) as Yr,sum(Sales) as Revenue from 
Sales_Analysis_View group by Region,year(Order_Date)) select Region,Yr,ROUND(Revenue,2)
AS Revenue,round((Revenue-LAG(Revenue) OVER (PARTITION BY Region ORDER BY
Yr))*100.0/NULLIF(LAG(Revenue) OVER (PARTITION BY Region ORDER BY Yr),0),2) as
YoY_Growth_Pct FROM Yearly ORDER BY Region,Yr

select Customer_Name,count(distinct Order_ID) as Orders_Placed,ROUND(SUM(Sales),2) 
as Lifetime_Revenue,round(avg(Sales),2) as Avg_Order_Value from Sales_Analysis_View
where Customer_Name<>'Unknown Customer' GROUP BY Customer_Name
ORDER BY Lifetime_Revenue DESC LIMIT 5

select Segment,Ship_Mode,count(*) as Order_Count,round(sum(Sales),2) as Revenue,
round(avg(DATEDIFF(Ship_Date,Order_Date)),1) as Avg_Days_To_Ship from Sales_Analysis_View
where Ship_Mode<>'Unknown Ship Mode'
GROUP BY Segment, Ship_Mode ORDER BY Segment, Revenue DESC

select case when Discount= 0 then'No Discount' when Discount<= 0.15 then 'Low (1-15%)'
when Discount<=0.25 then 'Medium (16-25%)'ELSE 'High (26%+)'END AS Discount_Band,
COUNT(*) AS Order_Count,ROUND(SUM(Sales),2) AS Total_Revenue,ROUND(SUM(Profit),2) AS 
Total_Profit,ROUND(SUM(Profit)*100.0/SUM(Sales),2) as Profit_Margin_Pct FROM 
Sales_Analysis_View GROUP BY Discount_Band ORDER BY Total_Revenue DESC

