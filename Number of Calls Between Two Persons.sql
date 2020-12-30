```
Table: Calls
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| from_id     | int     |
| to_id       | int     |
| duration    | int     |
+-------------+---------+
This table does not have a primary key, it may contain duplicates.
This table contains the duration of a phone call between from_id and to_id.
from_id != to_id
 

Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.

Return the result table in any order.

The query result format is in the following example:

Calls table:
+---------+-------+----------+
| from_id | to_id | duration |
+---------+-------+----------+
| 1       | 2     | 59       |
| 2       | 1     | 11       |
| 1       | 3     | 20       |
| 3       | 4     | 100      |
| 3       | 4     | 200      |
| 3       | 4     | 200      |
| 4       | 3     | 499      |
+---------+-------+----------+

Result table:
+---------+---------+------------+----------------+
| person1 | person2 | call_count | total_duration |
+---------+---------+------------+----------------+
| 1       | 2       | 2          | 70             |
| 1       | 3       | 1          | 20             |
| 3       | 4       | 4          | 999            |
+---------+---------+------------+----------------+
Users 1 and 2 had 2 calls and the total duration is 70 (59 + 11).
Users 1 and 3 had 1 call and the total duration is 20.
Users 3 and 4 had 4 calls and the total duration is 999 (100 + 200 + 200 + 499).
```
# Write your MySQL query statement below
WITH tmp AS
(
    SELECT
    from_id,
    to_id,
    COUNT(*) AS call_count,
    SUM(duration) AS total_duration
    FROM Calls
    GROUP BY 1,2
)

SELECT 
t3.from_id AS person1,
t3.to_id AS person2,
SUM(t3.call_count) AS call_count,
SUM(t3.total_duration) AS total_duration
FROM
(
    SELECT 
        t1.to_id AS from_id,
        t1.from_id AS to_id,
        call_count,
        total_duration
    FROM 
    tmp t1
    UNION ALL
    SELECT t2.* FROM tmp t2
)t3
GROUP BY 1,2
HAVING t3.from_id < t3.to_id






