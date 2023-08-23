/*
4. (по желанию) Пусть имеется любая таблица с календарным полем created_at.
Создайте запрос, который удаляет устаревшие записи из таблицы,
оставляя только 5 самых свежих записей.
*/

USE example;

DROP TABLE IF EXISTS task_4;
CREATE TABLE task_4 (
	created_at DATE
);

INSERT INTO task_4 
VALUES ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17'),
('2015-01-01'), ('2013-02-12'), ('2023-05-15'), ('2019-09-28');

SELECT * FROM task_4
ORDER BY created_at DESC;

PREPARE dlt FROM 'DELETE FROM task_4 ORDER BY created_at limit ?';
SET @cnt = (SELECT COUNT(*) - 5 FROM task_4);
EXECUTE dlt USING @cnt;

SELECT * FROM task_4
ORDER BY created_at DESC;
