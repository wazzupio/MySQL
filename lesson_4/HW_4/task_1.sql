/*
 1. Повторить все действия по доработке БД vk (скрипт в материалах к уроку, les-4.sql).
 */

USE vk;

SHOW tables;

SHOW CREATE TABLE friend_requests;

-- Добавим ограничение для запросов в друзья.
-- Отправитель запросов не может быть получателем.
ALTER TABLE friend_requests
ADD CONSTRAINT semder_not_reciever_check
CHECK (from_user_id != to_user_id);

INSERT INTO friend_requests VALUES (1, 1, DEFAULT)

SHOW CREATE TABLE users;

-- Добавим ограничение для пользователей.
-- Номер телефона должен состоять из 11 цифр.

ALTER TABLE users
ADD CONSTRAINT phone_check
CHECK (REGEXP_LIKE(phone, '^[0-9]{11}$'));

-- Делаем photo_id в таблице profiles уникальным.
ALTER TABLE profiles MODIFY COLUMN photo_id BIGINT UNSIGNED DEFAULT NULL UNIQUE;

-- Добавим первичный ключ в таблицу profiles.
-- Номер телефона должен состоять из 11 цифр.
ALTER TABLE profiles
ADD CONSTRAINT fk_profiles_media
FOREIGN KEY (photo_id) REFERENCES media (id);

-- Добавление данных в таблицу users с явным указанием столбцов
INSERT INTO users (id, first_name, last_name, email, phone, password_hash)
VALUES (DEFAULT, 'Alex', 'Stepanov', 'alex@mail.com', '89213546566', 'aaa');

-- Добавление данных без указания некоторых столбцов
INSERT INTO users (first_name, last_name, email, phone)
VALUES ('Lena', 'Stepanova', 'lena@mail.com', '89213546568');

-- Добавление данных с определенным номером id
INSERT INTO users (id, first_name, last_name, email, phone)
VALUES (55, 'Jane', 'Kvanov', 'jane@mail.com', '89293546568');

-- Добавление пользователей через запятую
INSERT INTO users (first_name, last_name, email, phone)
VALUES ('Igor', 'Petrov', 'igor@mail.com', '89213549560'),
('Oksana', 'Petrova', 'oksana@mail.com', '89213549561');

-- Добавление данных через SET
INSERT INTO users;
SET first_name = 'Iren',
	last_name = 'Sidorova',
	email = 'iren@mail.com',
	phone = '8913541560';

-- Добавление данных через SELECT из БД vk2 таблицы users
# INSERT INTO users (first_name, last_name, email, phone)
# SELECT (first_name, last_name, email, phone) FROM vk2.users

-- Добавляем через SELECT и производную таблицу
INSERT INTO users (first_name, last_name, email, phone)
SELECT * FROM (
	SELECT 'Alina', 'Kobrina', 'alina@mail.com', '89210549561'
) AS default_user;


SELECT 1;

SELECT 10+1;

-- Выбираем все данные в таблице users
SELECT * FROM users;

-- Выбираем данные в столбце first_name в таблице users
SELECT first_name FROM users;

-- Выбираем данные в столбце first_name в таблице users
SELECT DISTINCT first_name FROM users;

-- Выбираем пользователей у которых нет пароля
SELECT * FROM users WHERE password_hash IS NULL;

-- Выбираем пользователей у которых есть паролем
SELECT * FROM users WHERE password_hash IS NOT NULL;

SELECT * FROM messages;

-- Обновление данных в таблице messages. В колонке is_delivered
-- приравниваем значение FALSE
UPDATE messages SET is_delivered = FALSE;

-- Обновление данных в таблице messages. В колонке is_delivered
-- приравниваем значение FALSE
UPDATE messages SET txt = 'qq' WHERE id = 5;

-- Удаление пользователя с id = 3.
DELETE FROM users WHERE id = 3;

-- Удаление пользователей с фамилией Kvanov.
DELETE FROM users WHERE last_name = 'Kvanov';
