/*184. Department Highest Salary

Table: Employee
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference columns) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

Table: Department
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
Each row of this table indicates the ID of a department and its name.

Write a solution to find employees who have the highest salary in each of the departments.
Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.*/

Question Link: https://leetcode.com/problems/department-highest-salary/description/

select d.name as  Department, e1.name as Employee, e1.salary as Salary
from employee e1
inner join (select departmentId, max(salary)as Salary
                from employee
                group by departmentId)e2
on e1.departmentId = e2.departmentId and e1.salary = e2. Salary 
inner join department d
on e2.departmentId = d.id; 

WITH Ranking AS (
    SELECT
        E.name AS Employee
        ,E.salary AS Salary
        ,D.name AS Department
        ,RANK() OVER(PARTITION BY E.departmentId ORDER BY E.salary DESC) ranks
    FROM Employee E
    JOIN Department D ON D.id = E.departmentId 
)

SELECT
    Department,
    Employee,
    Salary
FROM Ranking
WHERE ranks = 1;