/*
2. Создайте представление, которое выводит название name товарной позиции
из таблицы products и
соответствующее название каталога name из таблицы catalogs.
*/

DROP VIEW IF EXISTS name_cat_prod;
CREATE VIEW name_cat_prod AS
	(SELECT products.name AS name_prod, catalogs.name AS name_cat FROM products
	LEFT JOIN catalogs
	ON products.catalog_id = catalogs.id);

SELECT * FROM name_cat_prod;
