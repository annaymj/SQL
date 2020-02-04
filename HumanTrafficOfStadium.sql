X city built a new stadium, each day many people visit it and the stats are saved as these columns: id, visit_date, people

Please write a query to display the records which have 3 or more consecutive rows and the amount of people more than 100(inclusive).

For example, the table stadium:
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
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+
For the sample data above, the output is:

+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+
Note:
Each day only have one row record, and the dates are increasing with id increasing.

# Write your MySQL query statement below
# s2 is 1 day before, s3 is 2 days before
# s4 is 1 day after, s5 is 2 days after


select s1.id, s1.visit_date, s1.people
from stadium s1 
left join stadium s2 on s1.id = s2.id + 1
left join stadium s3 on s1.id = s3.id + 2
left join stadium s4 on s1.id = s4.id - 1
left join stadium s5 on s1.id = s5.id - 2
where (s1.people >=100 and s2.people >=100 and s3.people >=100)
or (s1.people >=100 and s4.people >=100 and s5.people >=100)
or (s1.people >=100 and s2.people >=100 and s4.people >=100)
