USE `kinopoisk`;

DELIMITER //

-- триггер на добавление новой новости, если рубрика не определена

CREATE TRIGGER `check_rubric_id` BEFORE INSERT ON `news`
FOR EACH ROW
BEGIN 
	SET NEW.rubric_id = COALESCE(NEW.rubric_id, 1);
END//

-- процедура на получение количества отзывов на фильм. нужно ввести название фильмаalter

CREATE PROCEDURE `count_feedbacks` (IN `movie_name` VARCHAR(50))
BEGIN
	SELECT
		(SELECT count(*)
	FROM `reviews` WHERE `type_review` = 'positive' AND `movie_id` = (SELECT `id` FROM `movies` WHERE `name` = `movie_name`)
    ) AS 'positive_rewiews',
    (SELECT
		count(*)
    FROM `reviews` WHERE `type_review` = 'negative' AND `movie_id` = (SELECT `id` FROM `movies` WHERE `name` = `movie_name`)
    ) AS 'negative_rewiews',
    (SELECT
		count(*)
    FROM `reviews` WHERE `type_review` = 'nitral' AND `movie_id` = (SELECT `id` FROM `movies` WHERE `name` = `movie_name`)
    ) AS 'nitral_rewiews'
    ;
end//