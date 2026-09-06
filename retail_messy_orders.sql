use Projectda;
select * from retail_orders_messy_dataset;
-- copying table to create a duplicate
create table retailorders like retail_orders_messy_dataset;
insert retailorders select * from retail_orders_messy_dataset;


-- Remove Duplicates
Create table retail_orders as
select * from (
    select s.*,
           row_number() over (partition by order_id order by order_id) as rn
    from retailorders s
) t
WHERE rn = 1;

alter table retail_orders rename column customer_first_name to first_name;
alter table retail_orders rename column customer_last_name to last_name;

update retail_orders
set first_name=trim(first_name);

update retail_orders
set last_name=trim(last_name);


select count(*) as total_rows, count(distinct order_id) as unqiue_id from retail_orders;

-- phone
update retail_orders
set phone = replace(phone, '+91-', '')
where phone like '+91-%';


-- quantity
update retail_orders
set quantity= abs(quantity);


-- payment_method
update retail_orders
set payment_method = trim(upper(payment_method)),sales_channel= trim(upper(sales_channel));

update retail_orders
set payment_method = replace(payment_method,'NETBANKING','NET BANKING'),
sales_channel= replace(sales_channel,'IN STORE','IN-STORE');

 
-- email
update retail_orders o
join retail_orders c
on o.customer_id=c.customer_id
set o.email = c.email
where (o.email is null or o.email = '') and (c.email is not null and c.email!= '');

update retail_orders 
set email='UNKNOWN'
where email='';

update retail_orders
set email=replace(email,'@gmail.co','@gmail.com')
where email like "%@gmail.co";

update retail_orders
set email=replace(email,'@gmial.com','@gmail.com')
where email like "%@gmial.com";

-- order_date
update retail_orders
set order_date = date_format(str_to_date(order_date, '%d/%m/%Y'),'%Y-%m-%d')
where order_date like '__/__/____';

update retail_orders
set order_date = date_format(str_to_date(order_date, '%Y/%m/%d'),'%Y-%m-%d')
where order_date like '____/__/__';

update retail_orders
set order_date = date_format(str_to_date(order_date, '%d-%b-%Y'),'%Y-%m-%d')
where order_date like '__-___-____';

update retail_orders
set order_date = date_format(str_to_date(order_date, '%m-%d-%Y'),'%Y-%m-%d')
where order_date like '__-__-____';

update retail_orders
set order_date= 'missing'
where order_date='';

-- city
update retail_orders o
join retail_orders c
on o.customer_id=c.customer_id
set o.city = c.city
where (o.city is null or o.city = '') and (c.city is not null and c.city!= '');

update retail_orders set city =trim(upper(city));

update retail_orders
set city = case
when city ='BOMBAY' then 'MUMBAI'
when city ='BANGALORE' then 'BENGALURU'
when city ='BANGALURU' then 'BENGALURU'
else city
end;


-- customer_rating
update retail_orders
set customer_rating= (select avg_rating from (select avg(customer_rating) as avg_rating from retail_orders)as temp)
where customer_rating='';

update retail_orders
set customer_rating= round(customer_rating);


------------------------------------------------------------------------------------------------------------------------------
-- BUSINESS PERFORMANCEE ---

-- 1.What is the total revenue generated?
select round(sum(total_amount),2) as Total_Revenue from retail_orders;
-- Total Revenue:- 5801308.31

-- 2.How many orders were placed?
select count(order_id) as total_orders_placed from retail_orders;
-- Total Orders Placed:- 1026

-- 3.How many customers purchased?
select count(distinct(customer_id)) as total_customers from retail_orders;
-- Total Customers :- 292

-- 4. What is the total quantity of products sold?
select sum(quantity) as total_quantity from retail_orders;
-- Total Quantity of Product Sold :- 2418

-- 5. What is the average order value?
select round(sum(total_amount)/ count(order_id),2) as avg_order_value from retail_orders;
-- Average Order Value :- 5654.3 


----------------------------------------------------------------------------------------------------------------------------
-- SALES TREND ANALYSIS ---

-- 6. How does revenue change month by month?
select date_format(order_date,'%Y-%m') as month, round(sum(total_amount),2) as revenue from retail_orders
group by date_format(order_date,'%Y-%m') order by month;

-- 7. Which month generated the highest revenue?
select date_format(order_date,'%Y-%m') as month, round(sum(total_amount),2) as revenue from retail_orders
group by date_format(order_date,'%Y-%m') order by revenue desc limit 1;
-- Month generated highest revenue is march-2024 :-431544.47

-- 8. Which month generated the lowest revenue?
select date_format(order_date,'%Y-%m') as month, round(sum(total_amount),2) as revenue from retail_orders where order_date !='missing'
group by date_format(order_date,'%Y-%m') order by revenue limit 1;
-- Month generated lowest revenue is aug-2025 :- 147008.18

-- 9. How many orders are placed each month?
select date_format(order_date,'%Y-%m') as month, count(total_amount) as orders from retail_orders
group by date_format(order_date,'%Y-%m') order by orders;


-- 10. What is the average order value by month?
select date_format(order_date,'%Y-%m') as month, round(sum(total_amount)/ count(order_id),2) as avg_order_value from retail_orders
group by date_format(order_date,'%Y-%m') order by avg_order_value;


-- PRODUCT ANALYSIS ---

-- 11. Which product category generates the most revenue?
select product_category, round(sum(total_amount),2) as revenue from retail_orders 
group by product_category order by revenue desc limit 1;
-- Home & Kitchen generates the most revenue :- 1250735.82


-- 12. Which product category sells the most units?
select product_category, sum(quantity) as units from retail_orders 
group by product_category order by units desc limit 1;
-- Beauty sells the most unit :- 529


-- 13. Which individual products generate the most revenue?
select product_name, round(sum(total_amount),2) as revenue from retail_orders 
group by product_name order by revenue desc limit 1;
-- 		LED Lamp generate the most revenue:- 354435.57


-- 14. Which products have the highest quantity sold?
select product_name, sum(quantity) as units from retail_orders 
group by product_name order by units desc limit 1;
-- Sunscreen SPF50 have the highest quantity sold :- 129


-- 15. Which products have the highest average selling price?
select product_name, round(avg(unit_price),2)as avg_selling_price 
from retail_orders group by product_name order by avg_selling_price desc;
-- Power bank have the highest average selling price:- 3087.5


-- 16. Which products receive the highest average customer ratings?
select product_name, round(avg(customer_rating),2) as avg_customer_rating 
from retail_orders group by product_name order by avg_customer_rating desc;
-- Wireless Earbuds has receive the highest average customer ratings :- 3.71


-- 17. Which products are selling well but have low ratings?
select product_name,sum(quantity) as total_quantity,avg(customer_rating) as avg_rating from retail_orders
group by product_name
having sum(quantity)>60 and avg(customer_rating)<3 order by total_quantity desc;
-- products are selling well but have low ratings is Smartwatch 

-----------------------------------------------------------------------------------------------------------------------------
-- CUSTOMER ANALYSIS ---

-- 18. Who are the top customers by revenue?
select customer_id, first_name,last_name,round(sum(total_amount),2) as money_spend from retail_orders
group by customer_id, first_name,last_name
order by money_spend desc limit 10;
-- 19. Which customers placed the most orders?
select customer_id, first_name,last_name,count(order_id) as orders from retail_orders
group by customer_id, first_name,last_name
order by orders desc limit 1;
-- Neha Pillai have ordered 10 time


-- 20. What is the average order value for each customer?
select customer_id, first_name,last_name,round(avg(total_amount),2) as avg_revenue from retail_orders
group by customer_id, first_name,last_name
order by avg_revenue desc ;


-- 21. Which cities generate the most revenue?
select city,round(sum(total_amount),2) as total_revenue from retail_orders
group by city
order by total_revenue desc limit 1;
-- DELHI generate the most revenue


-- 22. Which cities have the most customers?
select city, count(distinct customer_id) as customer_count from retail_orders
group by city
order by customer_count desc limit 1;
-- DELHI have the most customers


-- 23. Which cities have the highest average order value?
select city, round(avg(total_amount),2) as avg_value  from retail_orders
group by city
order by avg_value desc limit 1;
-- HYDERABAD have the highest average order value


------------------------------------------------------------------------------------------------------------------------------
-- SALES CHANNEL & PAYMENT ANALYSIS ---

-- 24. Which sales channel generates the most revenue?
select sales_channel, round(sum(total_amount),2) as total_revenue from retail_orders
group by sales_channel 
order by total_revenue desc limit 1;
-- ONLINE sales channel generates the most revenue


-- 25. Which channel receives the most orders?
select sales_channel, count(order_id) as order_count from retail_orders
group by sales_channel 
order by order_count desc limit 1;
-- ONLINE channel receives the most orders :- 647


-- 26. What is the average order value for each channel?
select sales_channel, round(avg(total_amount),2) as avg_value from retail_orders
group by sales_channel 
order by avg_value desc;


-- 27. Which payment method is most commonly used?
select payment_method, count(order_id) as orders from retail_orders
group by payment_method
order by orders desc limit 1;
-- UPI payment method is most commonly used


-- 28. Does online or offline sales have higher average order value?
select sales_channel, round(avg(total_amount),2) as avg_value from retail_orders
group by sales_channel 
order by avg_value desc;
-- ONLINE sales have higher average order value

-- DISCOUNT ANALYSIS ---

-- 29. How much revenue is generated at each discount level?
select discount_pct, round(sum(total_amount),2) as total_revenue from retail_orders
group by discount_pct 
order by total_revenue desc;


-- 30. Do higher discounts result in more sales?
select discount_pct, count(order_id) as orders,round(sum(total_amount),2) as total_revenue,
sum(quantity) as total_quantity from retail_orders
group by discount_pct 
order by discount_pct desc;
-- No, higher discounts do not appear to result in more sales


-- 31. Which product categories receive the highest discounts?
select round(avg(discount_pct),2) as avg_discount , product_category  from retail_orders
group by product_category
order by avg_discount desc limit 1;
-- Beauty product categories receive the highest discounts


-- 32. Which discount level has the highest average order value?
select discount_pct, round(avg(total_amount),2) as avg_value from retail_orders
group by discount_pct 
order by avg_value desc limit 1;
-- 5% discount level has the highest average order value


------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMERS RATING ANALYSIS ---

-- 33. What is the average customer rating?
select round(avg(customer_rating),2) as avg_rating from retail_orders;
-- 3.3 is the average customer rating

-- 34. What is the average rating by product category?
select product_category,round(avg(customer_rating),2) as avg_rating from retail_orders
group by product_category
order by avg_rating desc;


-- 35. What is the average rating by product?
select product_name,round(avg(customer_rating),2) as avg_rating from retail_orders
group by product_name
order by avg_rating desc;


-- 36. What is the average rating by sales channel?
select sales_channel,round(avg(customer_rating),2) as avg_rating from retail_orders
group by sales_channel
order by avg_rating desc;


-- 37. Are high-revenue products also highly rated?
select product_name,round(avg(customer_rating),2) as avg_rating,
round(sum(total_amount),2) as total_revenue from retail_orders
group by product_name
order by total_revenue desc;
/*
High revenue does not necessarily correspond to high customer ratings. 
Some high-revenue products have relatively low ratings, indicating potential opportunities 
to improve product quality or customer satisfaction
*/
