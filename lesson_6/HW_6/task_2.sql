/*
2. 2. Подсчитать общее количество лайков на посты,
которые получили пользователи младше 18 лет.
 */

USE vk;

-- Выводим id пользователей и полных лет
SELECT user_id, (YEAR(NOW()) - YEAR(birthday)) FROM profiles;

-- Выводим id пользователей которые младше 18 лет.
SELECT user_id FROM profiles
WHERE (YEAR(NOW()) - YEAR(birthday)) < 18;

-- Выводим id постов пользователей которым меньше 18 лет у которых стоят лайки на постах.
SELECT * FROM posts_likes
WHERE post_id IN (
	SELECT user_id FROM profiles
	WHERE (YEAR(NOW()) - YEAR(birthday)) < 18) AND like_type = 1;

-- Выводим кол-во лайков на посты пользователей которым меньше 18 лет
SELECT COUNT(*) AS total FROM posts_likes
WHERE post_id IN (
	SELECT user_id FROM profiles
	WHERE (YEAR(NOW()) - YEAR(birthday)) < 18) AND like_type = 1;
