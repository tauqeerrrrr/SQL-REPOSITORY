use ecommerce;
-- 1. List all unique cities where customers are located.
select count(customer_city) from customers;
-- 2. Count the number of orders placed in 2017.
 select count(order_id) from orders where year(order_purchase_timestamp) = 2017;
--  3. Find the total sales per category.

select products.product_category ,  sum(payments.payment_value)  from 
products join order_items
 on products.product_id=order_items.products_id join payments
 on payments.order_id=order_items.order_id
 group by products.product_category;

-- . Count the number of customers from each state.
select  customers.customer_state, count(customers.customer_unique_id) from customers group by customers.customer_state; 
-- . Calculate the number of orders per month in 2018.
 select count(order_id) from orders where monthname(order_purchase_timestamp) = 2018;
 
 select * from orders
 where not order_status =credit_card;
 select * from order_items;
 