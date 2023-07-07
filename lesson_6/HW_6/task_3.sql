/*
3. Определить, кто больше поставил лайков (всего) - мужчины или женщины?
 */

USE vk;

SELECT * FROM profiles;

SELECT * FROM posts_likes;

-- Выводим id пользователей которые ставили лайки.
SELECT user_id FROM posts_likes
WHERE like_type = 1
GROUP BY user_id;

-- Выводим пол пользователей которые ставили лайки.
SELECT gender FROM profiles
WHERE user_id IN (
	SELECT user_id FROM posts_likes
	WHERE like_type = 1
	GROUP BY user_id);

-- Отредактируем данные по половому признаку
SELECT gender FROM profiles
WHERE user_id IN (
	SELECT user_id FROM posts_likes
	WHERE like_type = 1
	GROUP BY user_id) AND gender = 'm' OR gender = 'f';

-- Выводим количество лайков поставленных мужчинами или женищами
-- а так же кол-во поставленных лайков, и видим что женщины поставили лайков
-- больше чем мужчины
SELECT gender, COUNT(*) AS total FROM profiles
WHERE user_id IN (
	SELECT user_id FROM posts_likes
	WHERE like_type = 1
	GROUP BY user_id) AND gender = 'm' OR gender = 'f'
GROUP BY gender
ORDER BY total DESC;


