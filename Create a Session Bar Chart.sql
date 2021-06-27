```
Write an SQL query to report the (bin, total) in any order.

The query result format is in the following example.

Sessions table:
+-------------+---------------+
| session_id  | duration      |
+-------------+---------------+
| 1           | 30            |
| 2           | 199           |
| 3           | 299           |
| 4           | 580           |
| 5           | 1000          |
+-------------+---------------+

Result table:
+--------------+--------------+
| bin          | total        |
+--------------+--------------+
| [0-5>        | 3            |
| [5-10>       | 1            |
| [10-15>      | 0            |
| 15 or more   | 1            |
+--------------+--------------+

For session_id 1, 2 and 3 have a duration greater or equal than 0 minutes and less than 5 minutes.
For session_id 4 has a duration greater or equal than 5 minutes and less than 10 minutes.
There are no session with a duration greater or equial than 10 minutes and less than 15 minutes.
For session_id 5 has a duration greater or equal than 15 minutes.
```

# Write your MySQL query statement below

SELECT '[0-5>' AS bin, (SELECT COUNT(*) FROM Sessions WHERE duration/60 < 5) AS total
UNION 
SELECT '[5-10>' AS bin, (SELECT COUNT(*) FROM Sessions WHERE duration/60 >= 5 AND duration/60 < 10) AS total
UNION
SELECT '[10-15>' AS bin, (SELECT COUNT(*) FROM Sessions WHERE duration/60 >= 10 AND duration/60 < 15) AS total
UNION
SELECT '15 or more' AS bin, (SELECT COUNT(*) FROM Sessions WHERE duration/60 >= 15) AS total

