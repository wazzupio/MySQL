/*
1. Пусть задан некоторый пользователь.
Найдите человека, который больше всех общался с нашим пользователем,
иначе, кто написал пользователю наибольшее число сообщений.
(можете взять пользователя с любым id).
 */

USE vk;

-- наш пользователь
SELECT * FROM users WHERE id = 1;

-- вывод всех id пользователей,
-- которые отправляли сообщения нашему пользователю.
SELECT from_user_id FROM messages WHERE to_user_id = 1;

-- вывод id пользователей которые отправляли сообщения нашему пользователю
-- и количество сообщений.
SELECT from_user_id, COUNT(*) AS count_to_user_messages FROM messages
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY count_to_user_messages DESC;

-- вывод id пользователя который отправил наибольшее кол-во сообщений нашему пользователю
-- и количества сообщений отпровленныъ нашему пользователю
SELECT from_user_id, COUNT(*) AS count_to_user_messages FROM messages
WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY count_to_user_messages DESC LIMIT 1;

-- вывод пользователя который отправил наибольшее кол-во сообщений нашему пользователю
SELECT * FROM users
WHERE id = (SELECT from_user_id FROM messages
			WHERE to_user_id = 1
			GROUP BY from_user_id
			ORDER BY COUNT(*) DESC LIMIT 1);
