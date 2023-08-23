/*
 3. (по желанию)
Пусть имеется таблица рейсов flights (id, from, to)
и таблица городов cities (label, name).
Поля from, to и label содержат английские названия городов,
поле name — русское.
Выведите список рейсов flights с русскими названиями городов.
*/

USE x;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	from_city varchar(255) DEFAULT NULL COMMENT 'Откуда',
	to_city varchar(255) DEFAULT NULL COMMENT 'Куда'
);

INSERT INTO flights
VALUES
	(DEFAULT, 'moscow', 'omsk'),
	(DEFAULT, 'novgorod', 'kazan'),
	(DEFAULT, 'irkutsk', 'moscow'),
	(DEFAULT, 'omsk', 'irkutsk'),
	(DEFAULT, 'moscow', 'kazan');


DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	lable varchar(255) DEFAULT NULL COMMENT 'Откуда',
	name varchar(255) DEFAULT NULL COMMENT 'Куда'
);

INSERT INTO cities
VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');

-- Выводим id таблицы flights с переводом from_city на русский язык.
SELECT flights.id, cities.name AS from_city FROM cities
JOIN flights
WHERE flights.from_city = cities.lable
ORDER BY flights.id;

-- Выводим id таблицы flights с переводом to_city на русский язык.
SELECT flights.id, cities.name AS to_city FROM cities
JOIN flights
WHERE flights.to_city = cities.lable
ORDER BY flights.id;

-- Объединяем по id два предыдущих результата в одну таблицу и сортируем так же по id.
SELECT new_flights.id, new_flights.from_city, new_cities.to_city FROM
(
	SELECT flights.id, cities.name AS from_city FROM cities
	JOIN flights
	WHERE flights.from_city = cities.lable
	ORDER BY flights.id
) AS new_flights
JOIN 
(
	SELECT flights.id, cities.name AS to_city FROM cities
	JOIN flights
	WHERE flights.to_city = cities.lable
	ORDER BY flights.id
) AS new_cities
ON new_flights.id = new_cities.id
ORDER BY new_flights.id;
