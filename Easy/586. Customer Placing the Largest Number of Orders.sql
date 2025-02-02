/*586. Customer Placing the Largest Number of Orders

Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.
 

Write a solution to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

The result format is in the following example.

Example 1:

Input: 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output: 
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+
Explanation: 
The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order. 
So the result is customer_number 3.
 

Follow up: What if more than one customer has the largest number of orders, can you find all the customer_number in this case?*/

Question link: https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/description/

select customer_number
from orders
group by customer_number
having count(*)=
        (select max(order_count) 
            from
            (select count(customer_number) as order_count 
                from orders
                group by customer_number)a);

select top 1 customer_number
from orders
group by customer_number
order by count(customer_number) desc;

with largest_orders_number as (
    select customer_number , count(customer_number)  as order_count,
    dense_rank() over(order by count(customer_number) desc) as rnk
    from orders
    group by customer_number
)

select customer_number
from largest_orders_number
where rnk= 1;

select customer_number from orders
Group by customer_number
having count(*) >= all (select count(*) from orders group by customer_number;