/*180. Consecutive Numbers

Table: Logs
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.

Find all numbers that appear at least three times consecutively.
Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.*/

Question Link: https://leetcode.com/problems/consecutive-numbers/description/

SELECT DISTINCT l1.Num as ConsecutiveNums
FROM Logs l1, Logs l2, Logs l3
WHERE (l2.Id = l1.Id - 1 
	and l3.Id = l1.Id - 2) 
	and (l1.Num = l2.Num 
	and l3.Num = l1.Num);

select distinct num  as ConsecutiveNums
from ( select * ,
        lead(num, 1) over (order by id) as num1,
        lead(num, 2) over (order by id) as num2,
        lead(id, 1) over (order by id) as id1,
        lead(id, 2) over (order by id) as id2
        from logs
) as Consecutive_Nums
where num= num1 and num=num2
    and id=  id1- 1
     and  id1 =  id2-1; 

select distinct num  as ConsecutiveNums
from ( select * ,
        lead(num, 1) over (order by id) as num1,
        lead(num, 2) over (order by id) as num2,
        lead(id, 1) over (order by id) as id1,
        lead(id, 2) over (order by id) as id2
        from logs
) as Consecutive_Nums
where num= num1 and num=num2
    and id=  id1- 1
     and  id = id2-2; -- only where condition is changed on the basis of id 



