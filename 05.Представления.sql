-- представление, которе покажет нам фильмы и соответсвующих им режиссеров

CREATE OR REPLACE VIEW `producers` AS
SELECT 
	`movies`.`name` AS 'movie_name',
    `movies`.`release_date`,
    `cynicalities`.`name` AS 'producer'
	FROM `movies`
JOIN `cynicalities_in_movies` ON `movies`.`id` = `cynicalities_in_movies`.`movie_id` 
	AND `cynicalities_in_movies`.`role_id` = 1
JOIN
	`cynicalities` ON `cynicalities`.`id` = `cynicalities_in_movies`.`cynicality_id`;
    
-- представление с актуальными ценами на фильмы из магазина    

CREATE OR REPLACE VIEW `actual_prices` AS
SELECT 
	ROUND(`shop`.`price` - (`shop`.`price` * `shop`.`discount` / 100)) as `actual`,
    `shop`.`price`,
    `shop`.`discount`,
    `movies`.`name`
FROM `shop`
JOIN `movies` ON `movies`.`id` = `shop`.`movie_id`;