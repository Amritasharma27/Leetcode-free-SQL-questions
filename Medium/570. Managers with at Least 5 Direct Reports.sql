/* 570. Managers with at Least 5 Direct Reports

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 
Write a solution to find managers with at least five direct reports.
Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output: 
+------+
| name |
+------+
| John |
+------+*/

Question Link: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

select m.name
from employee e
join employee m
on m.id = e.managerId
group by m.name, e.managerId
having count(e.managerId)>= 5;

with temp as
(
select managerid,count(1) as count_v
from
employee
group by managerid
having count(1)>=5
)
select 
e2.name as name
from temp e1
inner join
employee e2
on
e1.managerid=e2.id;

Select name
From Employee
Where id in 
(Select managerId From Employee Group By managerId Having Count(*) >= 5);