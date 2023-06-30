/*
 Практическое задание теме «Агрегация данных»

5. Подсчитайте произведение чисел в столбце таблицы.
*/

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

USE sample;

DROP TABLE IF EXISTS x;
CREATE TABLE x (id INT PRIMARY KEY);

INSERT INTO x VALUES (1), (2), (3), (4), (5);

SELECT * FROM x;

SELECT EXP(SUM(log(id))) FROM x;
