/*
 2. Выведите список товаров products и разделов catalogs,
 который соответствует товару.
 Имейте ввиду, у продукта может не быть каталога,
 однако выводить такой продукт все равно необходимо.
 */

USE x;

SELECT * FROM products;
SELECT * FROM catalogs;

SELECT
	products.id , products.name AS 'Продукт', catalogs.name AS 'Каталог'
FROM
	products
LEFT JOIN
	catalogs
ON
	products.catalog_id = catalogs.id;





