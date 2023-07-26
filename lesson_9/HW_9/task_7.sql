/*
7. (по желанию) Напишите хранимую функцию для вычисления произвольного числа
Фибоначчи. Числами Фибоначчи называется последовательность в которой число
равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10)
должен возвращать число 55.
*/

DELIMITER //

DROP FUNCTION IF EXISTS fibonacci//
CREATE FUNCTION fibonacci (num INT)
RETURNS INT DETERMINISTIC
BEGIN
	
	DECLARE i INT DEFAULT 0;
	DECLARE num_1 INT DEFAULT 0;
	DECLARE num_2 INT DEFAULT 1;
	DECLARE res_1 INT DEFAULT 0;
	DECLARE res_2 INT DEFAULT 1;
	DECLARE res_total INT DEFAULT 0;

	cycle: WHILE i <= num DO
		IF (i = 0) THEN
			SET res_1 = num_1;
			SET i = i + 1;
			ITERATE cycle;
		END IF;
		IF (i = 1) THEN
			SET res_total = res_1 + num_2;
			SET res_2 = res_total;
			SET i = i + 1;
			ITERATE cycle;
		END IF;
		
		SET res_total = res_1 + res_2;
		SET res_1 = res_2;
		SET res_2 = res_total;
	
		SET i = i + 1;
	END WHILE cycle;
	
	RETURN res_total;

END//

SELECT fibonacci(5);
