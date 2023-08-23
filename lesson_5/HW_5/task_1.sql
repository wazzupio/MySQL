/*
 Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»

1. (по желанию) Из таблицы users необходимо извлечь пользователей,
родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august) 

SELECT * FROM users WHERE birthday = may and birthday = august;
*/

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '2006-08-29', NULL, NULL);
  
 SELECT * FROM users WHERE LOWER(DATE_FORMAT(birthday_at, '%M')) = 'may' OR LOWER(DATE_FORMAT(birthday_at, '%M')) = 'august';
