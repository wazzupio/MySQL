/*
 1.Составьте список пользователей users,
 которые осуществили хотя бы один заказ orders в интернет магазине.
 */

USE x;

-- Список id пользователей которые сделали хоты один заказ.
SELECT user_id FROM orders
GROUP BY user_id;

-- Список пользователей которые сделали хоты один заказ.
SELECT * FROM users
WHERE id IN (
	SELECT user_id FROM orders
	GROUP BY user_id
);



