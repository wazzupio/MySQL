/*
3. (по желанию) Пусть имеется таблица с календарным полем created_at.
В ней размещены разреженные календарные записи за август 2018 года
'2018-08-01', '2018-08-04', '2018-08-16' и 2018-08-17.
Составьте запрос, который выводит полный список дат за август,
выставляя в соседнем поле значение 1,
если дата присутствует в исходной таблице и 0, если она отсутствует.
*/

USE example;

DROP TABLE IF EXISTS task_3;
CREATE TABLE task_3 (
	created_at DATE
);

INSERT INTO task_3 
VALUES ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17');

SELECT time_period.selected_date AS my_period,
CASE 
	WHEN time_period.selected_date = task_3.created_at 
		THEN '1'
	WHEN ISNULL (task_3.created_at) 
		THEN '0'	
END AS my_case
FROM
(SELECT v.* FROM 
  (SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) selected_date FROM
   (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
   (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
   (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
   (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
   (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
  WHERE selected_date BETWEEN '2018-08-01' AND '2018-08-31') AS time_period
LEFT JOIN task_3
ON time_period.selected_date = task_3.created_at
ORDER BY my_period;
