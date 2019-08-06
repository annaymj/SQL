/* Write your T-SQL query statement below

Table point holds the x coordinate of some points on x-axis in a plane, which are all integers.
 

Write a query to find the shortest distance between two points in these points.
 

| x   |
|-----|
| -1  |
| 0   |
| 2   |
 

The shortest distance is '1' obviously, which is from point '-1' to '0'. So the output is as below:
 

| shortest|
|---------|
| 1       |
 

Note: Every point is unique, which means there is no duplicates in table point.

I want to get the following table
a.x | a.ord | b.x | b.ord
-1  | 1     | null | null
0   | 2     | -1   | 1
2   | 3     | 0    | 2 

then, I want to get the following table
a.x | a.ord | b.x | b.ord | shortest
0   | 2     | -1   | 1    | abs(0-1)
2   | 2     | 0    | 0    | abs(2-0)
*/



with x_ord as(select x, row_number() over (order by x desc) as ord
from point)

select min(abs(a.x - b.x)) as shortest
from x_ord a left join x_ord b
on a.ord = b.ord + 1
where b.x is not null