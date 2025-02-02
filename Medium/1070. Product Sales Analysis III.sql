/*1070. Product Sales Analysis III

Table: Sales
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.

Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.

Write a solution to select the product id, year, quantity, and price for the first year of every product sold.
Return the resulting table in any order.

The result format is in the following example.

Example 1:

Input: 
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+
Product table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+
Output: 
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+*/

Question Link: https://leetcode.com/problems/product-sales-analysis-iii/description/

Select product_id, 
    (select min(year) from sales where product_id= s.product_id)first_year, 
    quantity,price
from sales s
where year in (select min(year) from sales where product_id= s.product_id)

select product_id, year first_year, quantity, price
from (
    select *, 
        rank() over (partition by product_id order by year) rk 
    from Sales
) t
where rk = 1;

SELECT s1.product_id, s1.year AS first_year, s1.quantity, s1.price
FROM Sales s1
LEFT JOIN Sales s2 ON s1.product_id = s2.product_id AND s1.year > s2.year
WHERE s2.product_id IS NULL; 