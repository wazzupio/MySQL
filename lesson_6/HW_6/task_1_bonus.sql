/*
1. (по желанию: можете найти друга, с которым пользователь больше всего общался)
 */

USE vk;

-- Выводим все сообщения которые были отправленны друзьям от нашего пользователя.
-- Я объединил две таблицы и вывел данные где request_type = 1, т.е. друзей.

SELECT * FROM messages JOIN friend_requests USING (from_user_id)
WHERE messages.from_user_id = 1 AND friend_requests.request_type = 1;

-- Сгруппируем данные по messages.to_user_id и выведем кол-во отправленных сообщений COUNT(*)
SELECT *, COUNT(*)  FROM messages JOIN friend_requests USING (from_user_id)
WHERE messages.from_user_id = 1 AND friend_requests.request_type = 1
GROUP BY messages.to_user_id;

-- Отсортируем данные по количеству сообщений и выведем только первую строку.
SELECT *, COUNT(*)  FROM messages JOIN friend_requests USING (from_user_id)
WHERE messages.from_user_id = 1 AND friend_requests.request_type = 1
GROUP BY messages.to_user_id
ORDER BY COUNT(*) DESC LIMIT 1;

-- Выводим id пользователя которому наш пользователь отравил больше всего сообщений,
-- а так же который являемся другом.
SELECT messages.to_user_id FROM messages JOIN friend_requests USING (from_user_id)
WHERE messages.from_user_id = 1 AND friend_requests.request_type = 1
GROUP BY messages.to_user_id
ORDER BY COUNT(*) DESC LIMIT 1;

-- Выводим всю информацию о данном пользователе передав id через запрос который написали выше.
SELECT * FROM users
WHERE id = (
	SELECT messages.to_user_id FROM messages JOIN friend_requests USING (from_user_id)
	WHERE messages.from_user_id = 1 AND friend_requests.request_type = 1
	GROUP BY messages.to_user_id
	ORDER BY COUNT(*) DESC LIMIT 1);
