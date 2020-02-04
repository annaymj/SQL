Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
 

We define the install date of a player to be the first login day of that player.

We also define day 1 retention of some date X to be the number of players whose install date is X and they logged back in on the day right after X, divided by the number of players whose install date is X, rounded to 2 decimal places.

Write an SQL query that reports for each install date, the number of players that installed the game on that day and the day 1 retention.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-01 | 0            |
| 3         | 4         | 2016-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+------------+----------+----------------+
| install_dt | installs | Day1_retention |
+------------+----------+----------------+
| 2016-03-01 | 2        | 0.50           |
| 2017-06-25 | 1        | 0.00           |
+------------+----------+----------------+
Player 1 and 3 installed the game on 2016-03-01 but only player 1 logged back in on 2016-03-02 so the day 1 retention of 2016-03-01 is 1 / 2 = 0.50
Player 2 installed the game on 2017-06-25 but didn't log back in on 2017-06-26 so the day 1 retention of 2017-06-25 is 0 / 1 = 0.00

/*
* first, I want to get the first date log in date for each player as table a3
"player_id" | "install_dt" | 
1  | 2016-03-01
2  | 2017-06-25
3  | 2016-03-01

second, generate table a4
"player_id" | "event_date" | "next_day"
1,"2016-03-01","2016-03-02",
1,"2016-03-02",null,
2,"2017-06-25",null,
3,"2016-03-01",null,
3,"2018-07-03",null

third, join table a3 and a4 and get the following table
"player_id" | "install_dt"| "next_day"
1 | "2016-03-01" | "2016-03-02"
2 | "2017-06-25" | null
3 | "2016-03-01" | null

Fourth, calculate the retention rate
"install_dt"|"installs"|"Day1_retention"
"2016-03-01",2,0.5
"2017-06-25",1,0.0
*/


select a3.install_dt, count(a3.player_id) as installs, 
round(sum(case when a4.next_day is not null then 1 else 0 end)/count(a3.player_id),2) as Day1_retention
	from
	(
		select player_id, min(event_date) as install_dt
		from Activity
		group by player_id
	) a3 join
     (
        select a1.player_id, a1.event_date, a2.event_date as "next_day"
        from Activity a1 
		left join Activity a2 on a1.player_id = a2.player_id and date_add(a1.event_date, interval 1 day) = a2.event_date
    )a4
on a3.player_id = a4.player_id and a3.install_dt = a4.event_date
group by a3.install_dt