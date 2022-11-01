--- INSPECTING DATA
select * from [dbo].[sales_data_sample 2]

--- CHECKING UNIQUE 
select distinct status from [dbo].[sales_data_sample 2]
select distinct year_id from [dbo].[sales_data_sample 2]
select distinct PRODUCTLINE from [dbo].[sales_data_sample 2]
select distinct COUNTRY from [dbo].[sales_data_sample 2]
select distinct DEALSIZE from [dbo].[sales_data_sample 2]
select distinct TERRITORY from [dbo].[sales_data_sample 2]

--- ANALYSIS 
---GROUPING SALES BY PRODUCTLINE
select PRODUCTLINE, sum(sales) Revenue
from [dbo].[sales_data_sample 2]
group by PRODUCTLINE
order by 2 desc

select YEAR_ID, sum(sales) Revenue
from [dbo].[sales_data_sample 2]
group by YEAR_ID
order by 2 desc

select  DEALSIZE,  sum(sales) Revenue
from [dbo].[sales_data_sample 2]
group by  DEALSIZE
order by 2 desc

--- WHAT WAS THE BEST MONTH FOR A SALES IN A SPECIFIC YEAR? HOW MUCH WAS EARNED THAT MONTH?
select  MONTH_ID, sum(sales) Revenue, count(ORDERNUMBER) Frequency
from [dbo].[sales_data_sample 2]
where YEAR_ID = 2003 --change year to see the rest
group by  MONTH_ID
order by 2 desc

--- NOVEMBER SEEMS TO BE THE MONTH,WHAT PRODUCT DO THEY SELL IN MOVEMBER?
select  MONTH_ID, PRODUCTLINE, sum(sales) Revenue, count(ORDERNUMBER)
from [dbo].[sales_data_sample 2]
where YEAR_ID = 2004 and MONTH_ID = 11 --change year to see the rest
group by  MONTH_ID, PRODUCTLINE
order by 3 desc

--- WHO IS OUR BEST CUSTOMER?
select 
		CUSTOMERNAME, 
		sum(sales) MonetaryValue,
		avg(sales) AvgMonetaryValue,
		count(ORDERNUMBER) Frequency,
		max(ORDERDATE) last_order_date,
		(select max(ORDERDATE) from [dbo].[sales_data_sample 2]) max_order_date,
		DATEDIFF(DD, max(ORDERDATE), (select max(ORDERDATE) from [dbo].[sales_data_sample 2])) Recency
	from [dbo].[sales_data_sample 2]
	group by CUSTOMERNAME

	--- WHICH CITY HAS THE HIGHEST NUMBER OF SALES IN A SPECIFIC COUNTRY?
	select city, sum (sales) Revenue
from [dbo].[sales_data_sample 2]
where country = 'UK'
group by city
order by 2 desc

---WHICH IS THE BEST PRODUCT IN UNITED STATES?
select country, YEAR_ID, PRODUCTLINE, sum(sales) Revenue
from [dbo].[sales_data_sample 2]
where country = 'USA'
group by  country, YEAR_ID, PRODUCTLINE
order by 4 desc