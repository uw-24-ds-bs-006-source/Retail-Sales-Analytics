create database  super_store_sales_data
use super_store_sales_data

select * from raw_sales

create table Backup_raw_sales as select * from raw_sales;
select * from Backup_raw_sales

select count(*) total_rows from Backup_raw_sales

select Order_ID,count(*) as Duplicate_Count From Backup_raw_sales
group by Order_ID having count(*)>1

select sum(Duplicate_Count-1) as Extra_Duplicate_Rows From
(Select Order_ID,count(*) as Duplicate_Count from Backup_raw_sales
group by Order_ID Having count(*)>1) as duplicates

create table Clean_sales as select distinct* from Backup_raw_sales

select count(*) as total_rows from Clean_sales

Select Order_ID,count(*) as Duplicate_Count from Clean_sales
group by Order_ID having count(*)>1

select*from Clean_sales where Order_ID = 'ORD-10170'

select count(*) as Remaining_Duplicate_Order_IDs from (select Order_ID
from Clean_sales group by Order_ID having count(*)>1) as d

select*From Clean_sales where Order_ID in('ORD-10170','ORD-10355','ORD-10411')

select SUM(CASE WHEN Customer_Name IS NULL OR TRIM(Customer_Name)=''THEN 1 ELSE 0 END) AS Missing_Customer_Name,
SUM(CASE WHEN Region Is NULL OR Trim(Region)=''THEN 1 ELSE 0 END) AS Missing_Region,
SUM(CASE WHEN City iS NULL OR Trim(City)=''THEN 1 ELSE 0 END) AS Missing_City,
SUM(CASE WHEN Ship_Mode is null OR TRIM(Ship_Mode)=''THEN 1 ELSE 0 END) AS Missing_Ship_Mode,
SUM(CASE WHEN Discount is Null OR Trim(Discount)=''THEN 1 ELSE 0 END) AS Missing_Discount,
SUM(CASE WHEN Profit Is Null OR Trim(Profit)=''THEN 1 ELSE 0 END) AS Missing_Profit
from Clean_sales

Select*from Clean_sales where Customer_Name Is null

select*from Clean_sales where Customer_Name=''

SET SQL_SAFE_UPDATES = 0;
update Clean_sales set Customer_Name='Unknown Customer' where Customer_Name is null;

Select count(*)as Missing_Customer_Name from Clean_sales where Customer_Name is null

select*from Clean_sales where Customer_Name='Unknown Customer'

select*FROM Clean_sales where Region is null

select count(*) As Missing_Region From Clean_sales where Region is null

select*FROM Clean_sales where Region=''

Select Order_ID,Customer_Name,Region,City,Category,Sales,Profit from Clean_sales
where Region is null

Select City,count(*) as City_Count from Clean_sales where Region is null group by City

UPDATE Clean_sales SET Region = CASE WHEN City = 'Multan' THEN 'Central'
WHEN City = 'Quetta' THEN 'West' WHEN City = 'Karachi' THEN 'South'
WHEN City = 'Faisalabad' THEN 'Central' WHEN City = 'Islamabad' THEN 'North'
WHEN City = 'Peshawar' THEN 'West' WHEN City = 'Hyderabad' THEN 'South'
WHEN City = 'Sialkot' THEN 'East' WHEN City = 'Gujranwala' THEN 'East'
END WHERE Region IS NULL AND City IS NOT NULL AND City <> ''

select count(*) as Missing_Region from Clean_sales where Region is null

select Order_ID,Customer_Name,Region,City,Category,Sales,Profit from Clean_sales
where Region is null

select count(*) as Missing_City from Clean_sales where City is null

Select Order_ID,Customer_Name,Region,City,Category,Sales,Profit from Clean_sales where
 City is null
 
 Select c1.Order_ID,c1.Region,c1.City as Missing_City,c2.City as Available_City
from Clean_sales c1 join Clean_sales c2 on c1.Order_ID=c2.Order_ID where c1.City is null
and c2.City is not null

Update Clean_sales c1 join Clean_sales c2 on c1.Order_ID = c2.Order_ID
Set c1.City = c2.City Where c1.City is null and c2.City is not null

select count(*) as Missing_City from Clean_sales where City is null

Select c1.Order_ID,c1.Customer_Name,c1.Region,c1.City as Missing_City,
c2.City as Available_City from Clean_sales c1 join Clean_sales c2 on 
c1.Customer_Name = c2.Customer_Name and c1.Region = c2.Region where c1.City is null
and c2.City is not null

Select Order_ID,Customer_Name,Region,City,Category,Sales,Profit from Clean_sales
where City is null and Order_ID is not null

Update Clean_sales set City='Unknown City' where City is null and Order_ID is not null

Select count(*) as Missing_City from Clean_sales where City is null

Select count(*) as Unknown_City from Clean_sales where City='Unknown City'

select count(*) as Missing_Ship_Mode from Clean_sales where Ship_Mode is null

Select Order_ID,Customer_Name,Region,City,Ship_Mode,Order_Date,Ship_Date
from Clean_sales where Ship_Mode is null

Select c1.Order_ID,c1.Customer_Name,c1.Ship_Mode as Missing_Ship_Mode,
c2.Ship_Mode as Available_Ship_Mode from Clean_sales c1 join Clean_sales c2
on c1.Order_ID = c2.Order_ID where c1.Ship_Mode is null and c2.Ship_Mode is not null

UPDATE Clean_sales c1 join Clean_sales c2 on c1.Order_ID = c2.Order_ID
set c1.Ship_Mode = c2.Ship_Mode where c1.Ship_Mode is null and c2.Ship_Mode is not null

Select Order_ID,Customer_Name,Ship_Mode from Clean_sales
Where Order_ID in ('ORD-10355', 'ORD-10820')

Select c1.Order_ID,c1.Customer_Name,c1.Ship_Mode AS Missing_Ship_Mode,c2.Ship_Mode AS Available_Ship_Mode
From Clean_sales c1 join Clean_sales c2 on c1.Order_ID = c2.Order_ID
Where c1.Ship_Mode is null and c2.Ship_Mode is not null

UPDATE Clean_sales set Ship_Mode='Unknown Ship Mode' where Ship_Mode is null
and Order_ID is not null

Select COUNT(*) as Unknown_Ship_Mode from Clean_sales where Ship_Mode='Unknown Ship Mode'

SelecT COUNT(*) as Remaining_Missing_Ship_Mode from Clean_sales where Ship_Mode is null

Select count(*) as Empty_Ship_Mode from Clean_sales where trim(Ship_Mode)=''

Select Ship_Mode, count(*) as Total_Rows from Clean_sales group by Ship_Mode

Select distinct Customer_Name from Clean_sales order by Customer_Name

update Clean_sales set Customer_Name=trim(Customer_Name) where Customer_Name is not null

select distinct Customer_Name from Clean_sales where Customer_Name LIKE ' %'or
 Customer_Name LIKE '% '
 
select distinct Customer_Name from Clean_sales
where LOWER(Customer_Name) IN('fatima farooq','hina qureshi','imran khan','omar iqbal')

Update Clean_sales set Customer_Name = CASE
WHEN LOWER(Customer_Name)='imran khan' THEN 'Imran Khan'
WHEN LOWER(Customer_Name) = 'hina qureshi' THEN 'Hina Qureshi'
WHEN LOWER(Customer_Name) = 'omar iqbal' THEN 'Omar Iqbal'
WHEN LOWER(Customer_Name) = 'fatima farooq' THEN 'Fatima Farooq'
ELSE Customer_Name END WHERE LOWER(Customer_Name) IN ('imran khan','hina qureshi','omar iqbal',
'fatima farooq')

Select distinct Customer_Name from Clean_sales where lower(Customer_Name) IN ('fatima farooq',
'hina qureshi','imran khan','omar iqbal')

select distinct Region from Clean_sales order by Region

select Region,count(*) as Total_Rows from Clean_sales where LOWER(Region)='centeral'
group by Region

Select Region,count(*) as Total_Rows from Clean_sales where lower(Region)='nort'
group by Region

select Region,count(*) as Total_Rows from Clean_sales where Region='NORTH' group by Region

SET SQL_SAFE_UPDATES = 0;
update Clean_sales set Region=CASE when Region='Centeral' then 'Central'
when Region='central' then 'Central' WHEN Region='Nort' THEN 'North'
when Region='NORTH' then 'North' else Region end
where Region in ('Centeral', 'central', 'Nort', 'NORTH')
SET SQL_SAFE_UPDATES = 1;

Select distinct Region from Clean_sales order by Region

select count(*) as Negative_Quantity_Rows from Clean_sales where cast(Quantity AS SIGNED)<0

Select Order_ID,Product_Name,Quantity from Clean_sales where cast(Quantity AS SIGNED)<0

SET SQL_SAFE_UPDATES = 0;
update Clean_sales set Quantity=abs(cast(Quantity AS DECIMAL(10,2)))where 
cast(Quantity as decimal(10,2))<0

select count(*) as Remaining_Negative_Quantity from Clean_sales where 
CAST(Quantity as decimal(10,2))<0

select Order_ID,Product_Name,Discount from Clean_sales where cast(Discount as decimal(10,2))>1

Select count(*) As Invalid_Discount_Rows from Clean_sales where CAST(Discount 
as decimal(10,2))>1

Select Order_ID,Product_Name,Discount,length(Discount) as Discount_Length from Clean_sales
where Discount in ('10', '10.0', '15', '15.0')

select Discount from Clean_sales order by Discount

update Clean_sales set Discount=cast(cast(Discount as decimal(10,2))/100 as char)
where Discount in ('10.0','15.0')

select Order_ID,Product_Name,Discount from Clean_sales

Select count(*) as Invalid_Discount_Rows from Clean_sales
where CAST(Discount AS DECIMAL(10,2)) > 1;

select Order_ID,Product_Name,Quantity,Unit_Price,Sales from Clean_sales
where trim(Sales)='N/A'

select Order_ID,Product_Name,Quantity,Unit_Price,Sales from Clean_sales
where Sales is not null and Sales NOT REGEXP '^[0-9]+(\.[0-9]+)?$'

Select Order_ID,Order_Date from Clean_sales where Order_Date LIKE '%/%'

Select Order_ID,Order_Date,STR_TO_DATE(Order_Date, '%d/%m/%Y') AS Converted_Date
from Clean_sales where Order_Date LIKE '%/%'

Update Clean_sales set Order_Date=DATE_FORMAT(STR_TO_DATE(Order_Date, '%d/%m/%Y'),'%Y-%m-%d')
WHERE Order_Date LIKE '%/%';

select Order_ID,Order_Date from Clean_sales where Order_Date like '%/%'

Select Order_ID,Order_Date from Clean_sales limit 10

Select Order_ID,Ship_Date from Clean_sales where Ship_Date LIKE '%/%'

select*from Clean_sales where Order_ID is null and Order_Date is null
and Ship_Date is null and Customer_Name='Unknown Customer' and Region is null
and City is null and Ship_Mode is null

delete from Clean_sales where Order_ID is null and Order_Date is null
and Ship_Date is null and Customer_Name='Unknown Customer' and Segment is null
and Region is null and City is null and Category is null and Sub_Category is null
and Product_Name is null and Quantity is null and Unit_Price is null and Discount is null
and Sales is null and Profit is null

select*from Clean_sales where Order_ID is null

SELECT count(*) as Total_Clean_Rows from Clean_sales

Select SUM(Customer_Name IS NULL OR TRIM(Customer_Name)='') AS Missing_Customer,
SUM(Region IS NULL OR TRIM(Region)='') AS Missing_Region,
SUM(City IS NULL OR TRIM(City)='') AS Missing_City,
SUM(Ship_Mode IS NULL OR TRIM(Ship_Mode)='') AS Missing_Ship_Mode FROM Clean_sales

SELECT SUM(Quantity IS NULL OR TRIM(Quantity)='') AS Missing_Quantity,
SUM(Unit_Price IS NULL OR TRIM(Unit_Price)='') AS Missing_Unit_Price,
SUM(Discount IS NULL OR TRIM(Discount)='') AS Missing_Discount,
SUM(Sales IS NULL OR TRIM(Sales)='') AS Missing_Sales,
SUM(Profit IS NULL OR TRIM(Profit)='') AS Missing_Profit FROM Clean_sales

select Order_ID,Product_Name,Quantity,Unit_Price,Discount from Clean_sales
where Discount is null or trim(Discount)=''

Select c1.Order_ID,c1.Product_Name,c1.Discount as Missing_Discount,c2.Discount as
Available_Discount from Clean_sales c1 join Clean_sales c2 on c1.Order_ID = c2.Order_ID
where c1.Discount is null and c2.Discount is not null

SET SQL_SAFE_UPDATES = 0;
Update Clean_sales c1 join Clean_sales c2 on c1.Order_ID = c2.Order_ID set 
c1.Discount=c2.Discount where c1.Discount is null and c2.Discount is not null

Select Order_ID,Product_Name,Discount from Clean_sales where Order_ID='ORD-10170'

select c1.Order_ID,c1.Product_Name,c1.Discount AS Missing_Discount,c2.Discount as 
Existing_Discount from Clean_sales c1 join Clean_sales c2 on c1.Product_Name = c2.Product_Name
where c1.Discount is null and c2.Discount is not null order by c1.Product_Name

select Order_ID,Product_Name,Quantity,Unit_Price,Discount,Sales,Profit from Clean_sales
where Discount is null

select Order_ID,Product_Name,Quantity,Unit_Price,Sales,round(1-(cast(Sales AS DECIMAL(10,2))/
(CAST(Quantity AS DECIMAL(10,2))*CAST(Unit_Price AS DECIMAL(10,2)))),2) AS Calculated_Discount
FROM Clean_sales WHERE Discount IS NULL;

update Clean_sales set Discount='0.0' where Discount is null

select count(*) as Missing_Discount from Clean_sales where Discount is null or
 TRIM(Discount)=''
 
select distinct Discount from Clean_sales order by Discount

UPDATE Clean_sales SET Discount = ROUND(CAST(Discount AS DECIMAL(10,6)),2)

select distinct Discount from Clean_sales order by Discount

Select Order_ID,Product_Name,Quantity,Unit_Price,Discount,Sales,Profit from Clean_sales
where Sales is null or trim(Sales)=''

SELECT Order_ID,Product_Name,Quantity,Unit_Price,Discount,Sales,ROUND
(CAST(Quantity AS DECIMAL(10,2))*CAST(Unit_Price AS DECIMAL(10,2))
*(1 - CAST(Discount AS DECIMAL(10,2))),2) AS Calculated_Sales from Clean_sales
where Sales is null or TRIM(Sales)=''

SET SQL_SAFE_UPDATES = 0;
UPDATE Clean_sales SET Sales = ROUND(CAST(Quantity AS DECIMAL(10,2))
*CAST(Unit_Price AS DECIMAL(10,2))*(1 - CAST(Discount AS DECIMAL(10,2))),2)
WHERE Sales IS NULL OR TRIM(Sales) = '';

select count(*) as Missing_Sales from Clean_sales where Sales is null or trim(Sales)=''

Select Order_ID,Product_Name,Quantity,Unit_Price,Discount,Sales,Profit
from Clean_sales where Profit is null or TRIM(Profit)=''

select Product_Name,Quantity,Unit_Price,Discount,Sales,Profit from Clean_sales
where Product_Name in ('Label Maker','Round Conference Table','Wall Clock',
'Corner Table','Corner Bookcase','Office Desk Phone','Pen Set','Coffee Table',
'Wall-Mount Bookcase','Laser Printer','Floor Mat','Folding Chair','Storage Box',
'Executive Leather Chair','USB Cable','Sticky Notes','Wireless Mouse')
and Profit is not null order by Product_Name

select c1.Order_ID,c1.Product_Name,c1.Profit as Missing_Profit,c2.Profit as Available_Profit
from Clean_sales c1 join Clean_sales c2 on c1.Order_ID = c2.Order_ID
WHERE (c1.Profit IS NULL OR TRIM(c1.Profit)='')and c2.Profit is not null

update Clean_sales c1 join Clean_sales c2 on c1.Order_ID = c2.Order_ID
set c1.Profit = c2.Profit where (c1.Profit IS NULL OR TRIM(c1.Profit)='')
and c2.Profit is not null

select Order_ID,Product_Name,Profit from Clean_sales
where Order_ID in ('ORD-10652','ORD-10427','ORD-10044')

select count(*) as Missing_Profit from Clean_sales where Profit is null
or TRIM(Profit)=''

SELECT c1.Order_ID,c1.Product_Name,c1.Quantity,c1.Unit_Price,c1.Discount,c1.Sales,
c2.Profit AS Available_Profit FROM Clean_sales c1 JOIN Clean_sales c2
ON c1.Order_ID = c2.Order_ID WHERE (c1.Profit IS NULL OR TRIM(c1.Profit)='')
AND c2.Profit IS NOT NULL;

SELECT Order_ID,Product_Name,Quantity,Unit_Price,Discount,Sales,Profit
FROM Clean_sales WHERE Profit IS NULL OR TRIM(Profit) = '';

SELECT Product_Name,COUNT(*) AS Records,MIN(CAST(Profit AS DECIMAL(10,2))) AS Min_Profit,
MAX(CAST(Profit AS DECIMAL(10,2))) AS Max_Profit,ROUND(AVG(CAST(Profit AS DECIMAL(10,2))), 2) AS Avg_Profit
FROM Clean_sales WHERE Profit IS NOT NULL
AND TRIM(Profit) <> '' GROUP BY Product_Name HAVING Product_Name IN (
'Label Maker','Round Conference Table','Wall Clock','Corner Table','Corner Bookcase',
'Office Desk Phone','Pen Set','Coffee Table','Wall-Mount Bookcase','Laser Printer',
'Floor Mat','Folding Chair','Storage Box','USB Cable','Sticky Notes','Wireless Mouse')
ORDER BY Product_Name;

select distinct Region from Clean_sales order by Region

update Clean_sales set Order_ID=TRIM(Order_ID),Order_Date=TRIM(Order_Date),
Ship_Date=TRIM(Ship_Date),Ship_Mode=TRIM(Ship_Mode),Customer_Name=TRIM(Customer_Name),
Segment=TRIM(Segment),Region=TRIM(Region),City=TRIM(City),Category=TRIM(Category)
,Sub_Category=TRIM(Sub_Category),Product_Name=TRIM(Product_Name),Quantity=TRIM(Quantity),
Unit_Price=TRIM(Unit_Price),Discount=TRIM(Discount),Sales=TRIM(Sales),
Profit=TRIM(Profit)

select distinct Region from Clean_sales order by Region

select Region,COUNT(*) AS Total_Rows FROM Clean_sales GROUP BY Region ORDER BY Region

select Order_ID,Product_Name,Quantity from Clean_sales
where CAST(Quantity AS DECIMAL(10,2))<0

select Order_ID,count(*) as Duplicate_Count from Clean_sales group by Order_ID
having count(*)>1 order by Duplicate_Count desc

SELECT Order_ID,COUNT(*) AS Duplicate_Count FROM Clean_sales GROUP BY Order_ID,
Order_Date,Ship_Date,Ship_Mode,Customer_Name,Segment,Region,City,Category,Sub_Category,
Product_Name,Quantity,Unit_Price,Discount,Sales,Profit HAVING COUNT(*)>1 ORDER BY Order_ID

create table Clean_sales_temp as select distinct*FROM Clean_sales

SELECT COUNT(*) AS Total_Rows FROM Clean_sales_temp;

SELECT Order_ID,COUNT(*) AS Duplicate_Count FROM Clean_sales_temp


GROUP BY Order_ID,Order_Date,Ship_Date,Ship_Mode,Customer_Name,Segment,Region,City,Category,
Sub_Category,Product_Name,Quantity,Unit_Price,Discount,Sales,Profit HAVING COUNT(*)>1

DROP TABLE Clean_sales;

RENAME TABLE Clean_sales_temp TO Clean_sales;

select count(*) as Total_Rows from Clean_sales

SELECT SUM(Order_ID IS NULL OR TRIM(Order_ID) = '') AS Missing_Order_ID,
SUM(Order_Date IS NULL OR TRIM(Order_Date) = '') AS Missing_Order_Date,
SUM(Ship_Date IS NULL OR TRIM(Ship_Date) = '') AS Missing_Ship_Date,
SUM(Ship_Mode IS NULL OR TRIM(Ship_Mode) = '') AS Missing_Ship_Mode,
SUM(Customer_Name IS NULL OR TRIM(Customer_Name) = '') AS Missing_Customer_Name,
SUM(Segment IS NULL OR TRIM(Segment) = '') AS Missing_Segment,
SUM(Region IS NULL OR TRIM(Region) = '') AS Missing_Region,
SUM(City IS NULL OR TRIM(City) = '') AS Missing_City,
SUM(Category IS NULL OR TRIM(Category) = '') AS Missing_Category,
SUM(Sub_Category IS NULL OR TRIM(Sub_Category) = '') AS Missing_Sub_Category,
SUM(Product_Name IS NULL OR TRIM(Product_Name) = '') AS Missing_Product_Name,
SUM(Quantity IS NULL OR TRIM(Quantity) = '') AS Missing_Quantity,
SUM(Unit_Price IS NULL OR TRIM(Unit_Price) = '') AS Missing_Unit_Price,
SUM(Discount IS NULL OR TRIM(Discount) = '') AS Missing_Discount,
SUM(Sales IS NULL OR TRIM(Sales) = '') AS Missing_Sales,
SUM(Profit IS NULL OR TRIM(Profit) = '') AS Missing_Profit FROM Clean_sales

select distinct Discount FROM Clean_sales ORDER BY CAST(Discount AS DECIMAL(10,2))

SELECT Order_ID,Product_Name,Sales FROM Clean_sales WHERE Sales IS NOT NULL
AND TRIM(Sales) <> '' AND Sales NOT REGEXP '^[0-9]+(\.[0-9]+)?$'

SELECT Order_ID,Product_Name,Quantity,Unit_Price FROM Clean_sales
WHERE CAST(Quantity AS DECIMAL(10,2))<=0 OR CAST(Unit_Price AS DECIMAL(10,2))<=0

SELECT Order_ID,Order_Date FROM Clean_sales WHERE 
Order_Date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

select Order_ID,Ship_Date from Clean_sales where Ship_Date
 NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
 
select distinct Customer_Name FROM Clean_sales
WHERE Customer_Name <> TRIM(Customer_Name);

select distinct Segment from Clean_sales order by Segment

select distinct Category from Clean_sales order by Category

select distinct Sub_Category from Clean_sales order by Sub_Category

select Ship_Mode from Clean_sales order by Ship_Mode

select Ship_Mode,LENGTH(Ship_Mode) AS Length,COUNT(*) AS Total_Rows FROM Clean_sales
GROUP BY Ship_Mode, LENGTH(Ship_Mode)ORDER BY Ship_Mode;

select Order_ID,Product_Name,Quantity,Unit_Price,Discount,Sales,Profit from Clean_sales
where Profit is null order by Order_ID;

select COUNT(*) as Missing_Profit from Clean_sales where Profit IS NULL OR TRIM(Profit)=''

/* final check */
SELECT SUM(Order_ID IS NULL OR TRIM(Order_ID) = '') AS Missing_Order_ID,
SUM(Order_Date IS NULL OR TRIM(Order_Date) = '') AS Missing_Order_Date,
SUM(Ship_Date IS NULL OR TRIM(Ship_Date) = '') AS Missing_Ship_Date,
SUM(Ship_Mode IS NULL OR TRIM(Ship_Mode) = '') AS Missing_Ship_Mode,
SUM(Customer_Name IS NULL OR TRIM(Customer_Name) = '') AS Missing_Customer_Name,
SUM(Segment IS NULL OR TRIM(Segment) = '') AS Missing_Segment,
SUM(Region IS NULL OR TRIM(Region) = '') AS Missing_Region,
SUM(City IS NULL OR TRIM(City) = '') AS Missing_City,
SUM(Category IS NULL OR TRIM(Category) = '') AS Missing_Category,
SUM(Sub_Category IS NULL OR TRIM(Sub_Category) = '') AS Missing_Sub_Category,
SUM(Product_Name IS NULL OR TRIM(Product_Name) = '') AS Missing_Product_Name,
SUM(Quantity IS NULL OR TRIM(Quantity) = '') AS Missing_Quantity,
SUM(Unit_Price IS NULL OR TRIM(Unit_Price) = '') AS Missing_Unit_Price,
SUM(Discount IS NULL OR TRIM(Discount) = '') AS Missing_Discount,
SUM(Sales IS NULL OR TRIM(Sales) = '') AS Missing_Sales,
SUM(Profit IS NULL OR TRIM(Profit) = '') AS Missing_Profit FROM Clean_sales;

SELECT SUM(CAST(Quantity AS DECIMAL(10,2))<0) AS Negative_Quantity,
SUM(CAST(Unit_Price AS DECIMAL(10,2))<0) AS Negative_Unit_Price,
SUM(CAST(Discount AS DECIMAL(10,2))<0 OR CAST(Discount AS DECIMAL(10,2))>1)AS Invalid_Discount,
SUM(CAST(Sales AS DECIMAL(10,2))<0) AS Negative_Sales, SUM(CAST(Profit 
AS DECIMAL(10,2))<0) AS Negative_Profit FROM Clean_sales;

SELECT SUM(Order_Date IS NULL OR TRIM(Order_Date) = '') AS Missing_Order_Date,
SUM(Ship_Date IS NULL OR TRIM(Ship_Date) = '') AS Missing_Ship_Date,
SUM(Order_Date LIKE '%/%') AS Wrong_Order_Date_Format,
SUM(Ship_Date LIKE '%/%') AS Wrong_Ship_Date_Format FROM Clean_sales

select Order_ID,Order_Date,Ship_Date,Ship_Mode,Customer_Name,Segment,Region,City,Category,
Sub_Category,Product_Name,Quantity,Unit_Price,Discount,Sales,Profit,COUNT(*) as Duplicate_Count
from Clean_sales group by Order_ID,Order_Date,Ship_Date,Ship_Mode,Customer_Name,Segment,Region,
City,Category,Sub_Category,Product_Name,Quantity,Unit_Price,Discount,Sales,Profit
having count(*)>1

select count(*) as Total_Clean_Rows from Clean_sales

/* final clean dataset backup */

create table Final_Clean_sales as select*from Clean_sales

select count(*) as Total_Rows from Final_Clean_sales

select*from Final_Clean_sales limit 10