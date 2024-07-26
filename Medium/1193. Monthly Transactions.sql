/*1193. Monthly Transactions I

Table: Transactions
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].

Write an SQL query to find for each month and country, the number of transactions and their total amount,
the number of approved transactions and their total amount.
Return the result table in any order.

The query result format is in the following example.

Example 1:

Input: 
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+*/

Question Link: https://leetcode.com/problems/monthly-transactions-i/

select CAST(DATEPART(year, trans_date) AS VARCHAR(4)) + '-' + RIGHT('0' + CAST(DATEPART(month, trans_date) AS VARCHAR(2)), 2) AS month,
        country, count(id) as trans_count,
        sum(case when state = 'approved' then 1 else 0 end) as approved_count,
        sum(amount) trans_total_amount,
        sum(case when state = 'approved' then 1*amount else 0 end) as approved_total_amount
from transactions
group by CAST(DATEPART(year, trans_date) AS VARCHAR(4)) + '-' + RIGHT('0' + CAST(DATEPART(month, trans_date) AS VARCHAR(2)), 2),
country;

SELECT SUBSTRING(CAST(trans_date AS varchar),1,7) as month,
country,COUNT(*) as trans_count,
SUM(IIF(state = 'approved',1,0)) as approved_count,
SUM(amount) as trans_total_amount,
SUM(IIF(state = 'approved',amount,0)) as approved_total_amount
FROM Transactions
GROUP BY SUBSTRING(CAST(trans_date AS varchar),1,7),country;