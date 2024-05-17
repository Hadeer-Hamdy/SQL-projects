create table retail_sales (Transaction_ID int , Date varchar, Customer_ID varchar , Gender varchar , Age int, Product_Category varchar, Quantity int , Price_per_Unit int ,Total_Amount int );
copy retail_sales from 'D:\retail_sales_dataset.csv' delimiter ',' csv header  encoding 'windows-1251';
select * from retail_sales;
**********1
select  sum (total_amount) as total_sales ,date from retail_sales group by date ;

**********2
select Product_Category, avg (Quantity)  as avg_quan from retail_sales group by Product_Category;

**********3
select  customer_id,
RANK() over (order by total_amount desc) as customerRank 
from retail_sales;
SELECT *, RANK() over(order by Total_Amount) 
FROM retail_sales
ORDER BY  Total_Amount;
************4

SELECT SUM(Quantity) AS Sold from retail_sales ;
************5

select coalesce (product_category,'total') as category,
sum(total_amount)as total,
round(sum(total_amount)/ sum(sum(total_amount)) * 100 )as percentag,
concat(format ( (sum (total_amount)/ sum (sum(total_amount)) over()) *100, '0.00'), '%') as percentag
from retail_sales
group by product_category;
************6
select top (3) from retail_sales order by Total_Amount desc;

************7
sELECT avg(Price_per_Unit)  as count FROM retail_sales GROUP BY  date  ;
select avg (Price_per_Unit) as avg_price
from retail_sales
where Product_Category= 'Clothing'
group by month(date);

***********8

Select Sum(total_amount) Over ( Order by customer_id ) , date As Cu_Id From retail_sales;
Select Sum(total_amount) Over ( Order by customer_id )  As Cu_Id From retail_sales;

***********9

SELECT MIN(date) as EarliestDate
FROM retail_sales
group by customer_id;

select Max(date) as EarliestDate
from retail_sales
group by customer_id;

***********10
	 
select customer_id , total_amount,
sum(total_amount) as total1 over (partition by customer_id) as customer_total,
total_amount / sum(total_amount) over(partition by customer_id) as customer_percentage 
from retail_sales;
SELECT customer_id, 
	SUM(Total_amount) AS Total ,  
	CONCAT(format((SUM(Total_amount) / SUM(SUM(Total_amount)) OVER ()) * 100, '0.00'), '%') AS Percentage1 
				FROM retail_sales;
select total_amount,
total_amount * 100/(select sum (total_amount) from retail_sales) as Percentage_of_Total
From retail_sales;				
******************11
select avg(Price_per_Unit)  From retail_sales
group by Product_Category;				


******************12

select sum(total_amount) AS "total" , gender
   from retail_sales
   group by gender;


-----------------------------------------------------------
-----------------------------------------------------------


**********************((RFM))******************************


*****Recency (R)
with dataset as(
select 
(customer_id, max(date)) as recency
from retail_sales 
group by customer_id
where recency like 'cus%';

)


****** Frequency (F)

select 
count(customer_id)  over (partition by max(date) )as Frequency
FROM retail_sales
GROUP BY customer_id;


******* Monetary (m)
select Customer_ID,SUM(Total_amount) as monetary
FROM retail_sales
GROUP BY Customer_ID;
select Customer_ID,SUM(Price_per_Unit * Quantity) as monetary
FROM retail_sales
GROUP BY Customer_ID;

--------------------RFM SCORE-----------------

select * ,

ntile(5) over (order by recency desc) as r_score,
ntile(5) over (order by frequency desc) as f_score,
ntile(5) over (order by monetary desc) as m_score,
from retail_sales ;

    



	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   





























































































	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 