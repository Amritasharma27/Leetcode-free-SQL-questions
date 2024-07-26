/*601. Human Traffic of Stadium

Table: Stadium
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.
 																  
Write a solution to display the records with three or more rows with consecutive id's, 
and the number of people is greater than or equal to 100 for each.
Return the result table ordered by visit_date in ascending order.

The result format is in the following example.
																  
Example 1:

Input: 
Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Output: 
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Explanation: 
The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. 
Note that row 8 was included even though the visit_date was not the next day after row 7.
The rows with ids 2 and 3 are not included because we need at least three consecutive ids.*/

Question Link: https://leetcode.com/problems/human-traffic-of-stadium/

WITH
  StadiumNeighbors AS (
    SELECT
      id,
      visit_date,
      people,
      LAG(people, 1) OVER(ORDER BY id) AS prev_people_1,
      LAG(people, 2) OVER(ORDER BY id) AS prev_people_2,
      LEAD(people, 1) OVER(ORDER BY id) AS next_people_1,
      LEAD(people, 2) OVER(ORDER BY id) AS next_people_2
    FROM Stadium
  )
SELECT
  id,
  visit_date,
  people
FROM StadiumNeighbors
WHERE
  people >= 100 AND (
    prev_people_1 >= 100 AND prev_people_2 >= 100
    OR prev_people_1 >= 100 AND next_people_1 >= 100
    OR next_people_1 >= 100 AND next_people_2 >= 100
  )
ORDER BY visit_date;


WITH
  StadiumWithGroupId AS (
    SELECT
      id,
      visit_date,
      people,
      id - ROW_NUMBER() OVER(ORDER BY id) AS group_id
    FROM Stadium
    WHERE people >= 100
  )
SELECT id, visit_date, people
FROM StadiumWithGroupId
WHERE group_id IN (
    SELECT group_id
    FROM StadiumWithGroupId
    GROUP BY group_id
    HAVING COUNT(*) >= 3
  )
ORDER BY visit_date;