Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.

+---------+------------------+------------------+
| Id(INT) | RecordDate(DATE) | Temperature(INT) |
+---------+------------------+------------------+
|       1 |       2015-01-01 |               10 |
|       2 |       2015-01-02 |               25 |
|       3 |       2015-01-03 |               20 |
|       4 |       2015-01-04 |               30 |
+---------+------------------+------------------+
For example, return the following Ids for the above Weather table:

+----+
| Id |
+----+
|  2 |
|  4 |
+----+

# Write your MySQL query statement below
/* First, I want to create a column with yesterday's temp

"Id" | "RecordDate" | "Temperature" | "temp_yesterday"
1 | "2015-01-01" | 10 | null
2 | "2015-01-02" | 25 | 10
3 | 2015-01-03" | 20 | 25
4 | "2015-01-04"| 30 | 20
*/

select tmp.Id from
(
    select w1.*, ifnull(w2.Temperature,null) as "temp_yesterday"
    from Weather w1 left join Weather w2
    on w1.RecordDate = DATE_ADD(w2.RecordDate, interval 1 DAY)
)tmp
where tmp.Temperature > tmp.temp_yesterday