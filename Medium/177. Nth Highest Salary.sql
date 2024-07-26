/*177. Nth Highest Salary

Table: Employee
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.

Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary, return null.
The result format is in the following example.

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+*/

Question Link: https://leetcode.com/problems/nth-highest-salary/description/

CREATE FUNCTION getNthHighestSalary(@N INT) 
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;
    
    WITH RankedSalaries AS (
        SELECT DISTINCT Salary,
               DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
        FROM Employee
    )
    SELECT @Result = Salary
    FROM RankedSalaries
    WHERE SalaryRank = @N;
    
    RETURN @Result;
END;


CREATE FUNCTION getNthHighestSalary(@N INT) 
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    WITH RankedSalaries AS (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rank
    FROM (
        SELECT DISTINCT Salary
        FROM Employee
    ) AS DistinctSalaries
)
SELECT @Result= salary
FROM RankedSalaries
WHERE Rank = @n;

    RETURN @Result;
END;