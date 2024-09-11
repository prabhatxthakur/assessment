CREATE DATABASE target;

USE target;

SELECT * FROM table_a;

SELECT * FROM table_c;

-- Q2. Write a sql query to retrieve volume of each pyramid by week. Result : Pyramid, week, Actual_volume

SELECT ta.acct_wk_i as week, tc.Pyramid, SUM(actual_qty) as Actual_Volume
FROM table_a ta
JOIN table_c tc
ON ta.dept_id = tc.dept
GROUP BY ta.acct_wk_i, tc.Pyramid;

-- Q3. Write a sql query to get list of departments from "Home" pyramid with more than 20,000 units in a week

SELECT tc.dept_n as department, tc.Pyramid, ta.acct_wk_i as week, SUM(actual_qty) as Actual_Volume
FROM table_a ta
JOIN table_c tc
ON ta.dept_id = tc.dept
WHERE tc.Pyramid = 'Home'
GROUP BY tc.dept_n, ta.acct_wk_i, tc.Pyramid
HAVING Actual_Volume > 20000 ;

-- Q4. Write a sql query to get unique count of stores for each dc by week.

SELECT ta.dc_id, ta.acct_wk_i as week, COUNT(DISTINCT ta.store_id) as unique_store_count
FROM table_a ta
GROUP BY ta.dc_id, ta.acct_wk_i;

-- Q5. Write a sql query to rank store in each DC by week and determine 3rd highest store for each DC

WITH cte as (
SELECT ta.dc_id, ta.store_id, ta.acct_wk_i as week, SUM(actual_qty) as Actual_Volume
FROM table_a ta
GROUP BY ta.dc_id, ta.store_id, ta.acct_wk_i),
cte2 as (
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY dc_id ORDER BY Actual_Volume DESC) as store_rank
FROM cte)
SELECT * FROM cte2
WHERE store_rank = 3;


