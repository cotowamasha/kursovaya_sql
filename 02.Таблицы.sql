DROP SCHEMA IF EXISTS `kinopoisk`;
CREATE SCHEMA `kinopoisk`;

USE `kinopoisk`;

CREATE TABLE IF NOT EXISTS `genres` (
	`id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(20) NOT NULL
) COMMENT 'таблица жанров';

CREATE TABLE IF NOT EXISTS `movies` (
	`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `release_date` INT NOT NULL
) COMMENT 'таблица всех фильмов';

CREATE TABLE IF NOT EXISTS `movies_and_genres` (
	`movie_id` BIGINT UNSIGNED NOT NULL,
    `genre_id` TINYINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
) COMMENT 'фильмы и их жанры';
    

CREATE TABLE IF NOT EXISTS `cynicalities` (
	`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(70) NOT NULL,
    `birthday` DATE, 
    `country_of_birth` VARCHAR(20)
) COMMENT 'киноличности';

CREATE TABLE IF NOT EXISTS `roles` (
	`id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `role` VARCHAR(20) NOT NULL
) COMMENT 'чем занималась киноличность в конкретном фильме';

CREATE TABLE IF NOT EXISTS `cynicalities_in_movies` (
	`movie_id` BIGINT UNSIGNED NOT NULL,
    `cynicality_id` BIGINT UNSIGNED NOT NULL,
    `role_id` TINYINT UNSIGNED NOT NULL,
    
    PRIMARY KEY (movie_id, cynicality_id, role_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (cynicality_id) REFERENCES cynicalities(id),
    FOREIGN KEY (role_id) REFERENCES roles(id)
) COMMENT 'киноличности в кино и чем они занимались';

CREATE TABLE IF NOT EXISTS `users` (
	`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(70) NOT NULL,
    `e-mail` VARCHAR(100) NOT NULL UNIQUE,
    `hash_passwor` CHAR(32) NOT NULL
) COMMENT 'данные зарегестрированных пользователей';

CREATE TABLE IF NOT EXISTS `marks` (
	`movie_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `mark` ENUM('1', '2', '3', '4', '5', '6', '7', '8', '9', '10'),
    
    PRIMARY KEY (movie_id, user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT 'оценки пользователей к фильмам';

CREATE TABLE IF NOT EXISTS `reviews` (
	`movie_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(100),
    `content` VARCHAR(5000) NOT NULL,
    `type_review` ENUM('negative', 'nitral', 'positive'),
    `statys_review` ENUM('considered', 'approved', 'deleted'),
    
    PRIMARY KEY (movie_id, user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT 'рецензии пользователей к фильмам';


CREATE TABLE IF NOT EXISTS `rubrics` (
	`id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `rubric` VARCHAR(20) NOT NULL
) COMMENT 'рубрики новостей';

CREATE TABLE IF NOT EXISTS `news` (
	`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(150) NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT NOW(),
    `rubric_id` TINYINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (rubric_id) REFERENCES rubrics(id)
) COMMENT 'новости кинопоиска';

CREATE TABLE IF NOT EXISTS `shop` (
	`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`movie_id` BIGINT UNSIGNED NOT NULL,
	`price` SMALLINT NOT NULL,
    `discount` TINYINT,
    
    FOREIGN KEY (movie_id) REFERENCES movies(id)
) COMMENT 'фильмы в магазине кинопоиска';

CREATE TABLE IF NOT EXISTS `orders` (
    `user_id` BIGINT UNSIGNED NOT NULL,
    `shop_id` BIGINT UNSIGNED NOT NULL,
    `actual_price` SMALLINT COMMENT 'цена на момент покупки',
    
    PRIMARY KEY (user_id, shop_id),
    FOREIGN KEY (shop_id) REFERENCES shop(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT 'покупки пользователей';


    
    
    
    
    