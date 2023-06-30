/*
 Практическое задание теме «Агрегация данных»

3. Подсчитайте средний возраст пользователей в таблице users.
*/

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at)
VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '2006-08-29');
 
-- Добавляем колонку years для данных (полных лет пользователю).
ALTER TABLE users ADD years INT UNSIGNED;

-- Заполняем колонку users данными
UPDATE users SET years = TIMESTAMPDIFF(YEAR, birthday_at, NOW());
SELECT * FROM users;

-- Считаем и выводим средний возраст пользователей.
SELECT 'Cредний возраст пользователей в таблице users', ROUND(AVG(years), 1) AS avg_years FROM users; 
