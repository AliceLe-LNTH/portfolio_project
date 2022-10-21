-- Show Revenue of each product type

SELECT product_name, product_type, size, colour, total_price as Revenue
FROM
 (select product_id, product_name,product_type, size, colour from products) a 
left join 
  (select product_id, total_price from sales )b 
on a.product_id = b.product_id;

---- Show top 5 products with the highest orders

SELECT top 5 b.product_name, count (distinct order_id) as total_order
FROM
(select order_id, product_id from sales) a 
inner join 
 ( select product_id, product_name from products) b  
on a.product_id = b.product_id
group by product_name
order by total_order desc;

 ---- Count the number of customers group by age group

 select 
case when age >= 20 and age <= 25 then 'new_to_industry'
    when age >= 26 and age <= 35 then 'young_professionals'
    when age >= 36 and age <= 49 then 'middle_age'
    else 'pre-retiree' end nhom_kh, 
count (customer_id) slkh
from
    ((select customer_id, customer_name, age 
    from customers
    where age >= 20 and age <= 40) 
    union 
    (select customer_id, customer_name, age
    from customers
    where age >= 30 and age <= 60)) as abc
group by 
case when age >= 20 and age <= 25 then 'new_to_industry'
    when age >= 26 and age <= 35 then 'young_professionals'
    when age >= 36 and age <= 49 then 'middle_age'
    else 'pre-retiree' end;

---- Create View

create view purchase_details as;

select customer_id, product_type, product_name, b.product_id
FROM
(select customer_id, order_id from orders) a
left join 
(select order_id, product_id from sales ) b 
on a.order_id = b.order_id
left join 
(select product_type, product_name, product_id from products) c
on b.product_id = c.product_id;

select * from purchase_details;

---- Create Temp Table 

create table #purchase_details 
(customer_id smallint,
product_type varchar(50),
product_name varchar(50),
product_id smallint);

insert into #purchase_details
select customer_id, product_type, product_name, b.product_id
from 
(select customer_id, order_id from orders) a 
left join 
(select order_id, product_id from sales) b 
on a.order_id = b.order_id 
left join
(select product_id, product_name, product_type from products) c 
on b.product_id = c.product_id
 
select * from #purchase_details;

