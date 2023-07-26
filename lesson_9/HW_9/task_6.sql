/*
6. (по желанию) Пусть имеется таблица accounts содержащая три столбца
id, name, password, содержащие первичный ключ, имя пользователя и его пароль.
Создайте представление username таблицы accounts,
предоставляющий доступ к столбца id и name.
Создайте пользователя user_read, который бы не имел доступа к таблице accounts,
однако, мог бы извлекать записи из представления username.
*/

USE shop;

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts(
	id BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) DEFAULT NULL COMMENT 'Имя',
	pwd VARCHAR(255) DEFAULT '' COMMENT 'Пароль'
);

INSERT INTO accounts
VALUES (DEFAULT, 'Xxx', 'xxx');

CREATE VIEW username AS SELECT id, name FROM accounts;

SELECT * FROM username;

CREATE USER user_read;
GRANT SELECT ON shop.username TO user_read;
