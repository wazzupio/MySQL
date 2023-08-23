/*
1. Создайте таблицу logs типа Archive.
Пусть при каждом создании записи в таблицах users,
catalogs и products в таблицу logs помещается время и дата создания записи,
название таблицы, идентификатор первичного ключа и содержимое поля name. 
*/

USE shop;

-- Создаем таблицу logs
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	table_name varchar(255) DEFAULT NULL COMMENT 'Название таблицы',
	id BIGINT NOT NULL,
	name_in_column varchar(255) DEFAULT NULL COMMENT 'Содержимое поля name'
) ENGINE=ARCHIVE;

DELIMITER //
 
-- Триггер для логов таблицы users
DROP TRIGGER IF EXISTS add_logs_users//
CREATE TRIGGER add_logs_users AFTER INSERT ON users
FOR EACH ROW 
BEGIN
	INSERT INTO logs VALUES (DEFAULT, 'users', NEW.id, NEW.name);
END//

-- Триггер для логов таблицы catalogs
DROP TRIGGER IF EXISTS add_logs_catalogs//
CREATE TRIGGER add_logs_catalogs AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN
	INSERT INTO logs VALUES (DEFAULT, 'catalogs', NEW.id, NEW.name);
END//

-- Триггер для логов таблицы products
DROP TRIGGER IF EXISTS add_logs_products//
CREATE TRIGGER add_logs_products AFTER INSERT ON products
FOR EACH ROW 
BEGIN
	INSERT INTO logs VALUES (DEFAULT, 'products', NEW.id, NEW.name);
END//

DELIMITER ;


INSERT INTO users
VALUES (DEFAULT, 'Вася3', '1999-01-01', DEFAULT, DEFAULT);
INSERT INTO catalogs
VALUES (DEFAULT, 'Мышь');
INSERT INTO products
VALUES (DEFAULT, 'Мышь', 'Беспроводная', 9999, 7, DEFAULT, DEFAULT);

SELECT * FROM users;
SELECT * FROM catalogs;
SELECT * FROM products;
SELECT * FROM logs;
