/*
Практическое задание по теме “Управление БД”
1. Установите СУБД MySQL. Создайте в домашней директории файл
.my.cnf, задав в нем логин и пароль, который указывался при установке.
*/


/*
2. Создайте базу данных example, разместите в ней таблицу users,
состоящую из двух столбцов, числового id и строкового name.
*/

DROP DATABASE IF EXISTS example;
CREATE DATABASE example;

USE example;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Имя'
);

/*
3. Создайте дамп базы данных example из предыдущего задания,
разверните содержимое дампа в новую базу данных sample.
*/

-- Создаем дамп -> mysqldump example > sample.sql

-- Создаем БД sample чтобы развернуть в неё дамп example
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

-- Разворачиваем дамп -> mysql sample < example.sql

/*
4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump.
Создайте дамп единственной таблицы help_keyword базы данных mysql.
Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
*/

-- mysqldump mysql help_keyword --where="1 = 1 order by 1 limit 100" > help_keyword_100.sql