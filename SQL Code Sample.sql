-- Show top 10 data in customers table

select top 10 * from customers;

 ---- Show Customers's Order details in Victoria  

 select order_id, payment, order_date
from 
 (select order_id, customer_id, payment, order_date from orders) a
left JOIN
 (select customer_id, state from customers) b
on a.customer_id = b.customer_id
where state = 'Victoria' ;

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

