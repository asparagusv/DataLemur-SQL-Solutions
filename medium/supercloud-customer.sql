-- https://datalemur.com/questions/supercloud-customer
-- Goal: identify the customer IDs who has purchased at least one product from every product category
-- Approach: count the distinct product categories for each customer

SELECT customer_id FROM customer_contracts
LEFT JOIN products
ON customer_contracts.product_id = products.product_id
group by customer_id
having count(distinct products.product_category) = 3