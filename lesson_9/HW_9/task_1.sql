/*
1.  В базе данных shop и sample присутствуют одни  и те же таблицы,
учебной базы данных. Переместите запись id = 1 из таблицы shop.users
в таблицу sample.users. Используйте транзакции.
*/

-- В моем случае БД shop и БД х.

START TRANSACTION;

INSERT INTO x.users (name, birthday_at, created_at, updated_at)
SELECT name, birthday_at, created_at, updated_at
FROM shop.users WHERE id = 1;

SELECT * FROM x.users;

COMMIT;
