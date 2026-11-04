
select *
from SuperstoreAnalysis;

select *, count(*)
from SuperstoreAnalysis
group by 
	Row_ID,
	Order_ID,
	Order_Date,
	Ship_Date,
	Ship_Mode,
	Customer_ID,
	Customer_Name,
	Segment,
	Country,
	City,
	State,
	Postal_Code,
	Region,
	Product_ID,
	Category,
	Sub_Category,
	Product_Name,
	Sales,
	Quantity,
	Discount,
	Profit
having count(*)>1;

alter Table SuperstoreAnalysis
alter column Row_ID integer;
alter Table SuperstoreAnalysis
alter column Order_Date date;
alter Table SuperstoreAnalysis
alter column Ship_Date date;
alter Table SuperstoreAnalysis
alter column Postal_Code nvarchar(5);
alter Table SuperstoreAnalysis
alter column sales decimal(10,2);
alter Table SuperstoreAnalysis
alter column Quantity integer;
alter Table SuperstoreAnalysis
alter column discount decimal(10,2);
alter Table SuperstoreAnalysis
alter column Profit decimal(10,2);

SELECT *
FROM SuperstoreAnalysis
WHERE
   Row_ID IS NULL,
	OR Order_ID IS NULL,
	OR Order_Date IS NULL,
	OR Ship_Date IS NULL,
	OR Ship_Mode IS NULL,
	OR Customer_ID IS NULL,
	OR Customer_Name IS NULL,
	OR Segment IS NULL,
	OR Country IS NULL,
	OR City IS NULL,
	OR State IS NULL,
	OR Postal_Code IS NULL,
	OR Region IS NULL,
	OR Product_ID IS NULL,
	OR Category IS NULL,
	OR Sub_Category IS NULL,
	OR Product_Name IS NULL,
	OR Sales IS NULL,
	OR Quantity IS NULL,
	OR Discount IS NULL,
	OR Profit IS NULL;

select sum(Profit) as Profits_sum, sum(Sales) as Sales_sum
FROM SuperstoreAnalysis;
select count(distinct(Order_ID)) as NUM_OF_ORDERS
FROM SuperstoreAnalysis;
select Product_Name, Product_ID, sum(Quantity) as UNITS_SOLD
FROM SuperstoreAnalysis
Group by Product_Name, Product_ID
Order by UNITS_SOLD desc;
select Category, sum(Profit) as Profit_by_Cat
FROM SuperstoreAnalysis
group by Category;
select Region, sum(Sales)
FROM SuperstoreAnalysis
group by Region;
select year(Order_Date) as ORDER_YEAR, month(Order_Date) as ORDER_MONTH, sum(Sales) as MONTHLY_SALES
FROM SuperstoreAnalysis
group by Year(Order_Date), month(Order_Date)
order by year(Order_Date), month(Order_Date) asc;
select top (10) 
	Customer_Name,
	Customer_ID,
	sum(Profit)
FROM SuperstoreAnalysis
Group by Customer_Name, Customer_ID
order by sum(Profit) desc
;with Discount_Analysis as(
	select 
		Sales,
		Profit,
		Discount,
			case
				when Discount = 0 then 'No discount'
				when Discount <=0.10 then 'Low discount'
				when Discount <=0.20 then 'Medium discount'
				when Discount <=0.30 then 'high discount'
				else 'Very high discount'
			end as Discount_Category
	from SuperstoreAnalysis)
Select Discount_Category, count(*) as NUMBER_OF_RECORDS, sum(Profit) as TOTAL_PROFIT, sum(Sales) as TOTAL_SALES, avg(Profit) as AVG_PROFIT
from Discount_Analysis
Group by Discount_Category
Order by TOTAL_PROFIT desc;







