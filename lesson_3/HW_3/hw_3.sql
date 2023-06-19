DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;

USE vk;

CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(145) NOT NULL,
	last_name VARCHAR(145) NOT NULL,
	email VARCHAR(145) NOT NULL,
	phone CHAR(11) NOT NULL,
	password_hash CHAR(65) DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	UNIQUE INDEX users_email_idx (email),
	UNIQUE INDEX users_phone_idx (phone)
);

INSERT INTO users VALUES (DEFAULT, 'Petya', 'Petukhov', 'petya@mail.com', '89212223334', DEFAULT, DEFAULT);
INSERT INTO users VALUES (DEFAULT, 'Vasya', 'Vasilkov', 'vasya@mail.com', '89212023334', DEFAULT, DEFAULT);

CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	gender ENUM('f', 'm', 'x') NOT NULL,
	birthday DATE NOT NULL,
	photo_id INT UNSIGNED,
	user_status VARCHAR(30),
	city VARCHAR(130),
	country VARCHAR(130),
	CONSTRAINT fk_profiles_users FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO profiles VALUES (1, 'm', '1997-12-01', NULL, NULL, 'Moscow', 'Russia'); -- профиль Пети
INSERT INTO profiles VALUES (2, 'm', '1988-11-02', NULL, NULL, 'Moscow', 'Russia'); -- профиль Васи

CREATE TABLE messages( -- Отправка сообщений
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL, -- Петя
	to_user_id BIGINT UNSIGNED NOT NULL, -- Вася
	txt TEXT NOT NULL,
	is_delivered BOOLEAN DEFAULT FALSE,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	INDEX messages_from_user_idx (from_user_id),
	INDEX messages_to_user_idx (to_user_id),
	CONSTRAINT fk_messages_from_user FOREIGN KEY (from_user_id) REFERENCES users(id),
	CONSTRAINT fk_messages_to_user FOREIGN KEY (to_user_id) REFERENCES users(id)
);

INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Hi!', 1, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 1
INSERT INTO messages VALUES (DEFAULT, 1, 2, 'Vasya!', 1, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 2
INSERT INTO messages VALUES (DEFAULT, 2, 1, 'Hi, Petya', 1, DEFAULT, DEFAULT); -- сообщение от Пети к Васе номер 2

CREATE TABLE friend_requests( -- Заявки в друзья
	from_user_id BIGINT UNSIGNED NOT NULL, -- Петя
	to_user_id BIGINT UNSIGNED NOT NULL, -- Вася
	PRIMARY KEY (from_user_id, to_user_id),
	accepted BOOLEAN DEFAULT FALSE,
	INDEX friend_requests_from_user_id_idx (from_user_id),
	INDEX friend_requests_to_user_id_idx (to_user_id),
	CONSTRAINT fk_friend_requests_from_user FOREIGN KEY (from_user_id) REFERENCES users(id),
	CONSTRAINT fk_friend_requests_to_user FOREIGN KEY (to_user_id) REFERENCES users(id)
);

INSERT INTO friend_requests VALUES (1, 2, 1);

CREATE TABLE communities(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(145) NOT NULL,
	description VARCHAR(245) DEFAULT NULL,
	admin_id BIGINT UNSIGNED NOT NULL,
	INDEX communities_users_admin_id_idx (admin_id),
	CONSTRAINT fk_communities_users FOREIGN KEY (admin_id) REFERENCES users(id)
);

INSERT INTO communities VALUES (DEFAULT, 'Number1', 'I am number one', 1);

CREATE TABLE communities_users (
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (community_id, user_id),
	INDEX communities_users_community_id_idx (community_id),
	INDEX communities_users_user_id_idx (user_id),
	CONSTRAINT fk_communities_users_comm FOREIGN KEY (community_id) REFERENCES communities(id),
	CONSTRAINT fk_communities_users_user_id FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO communities_users VALUES (1, 2, DEFAULT);

CREATE TABLE media_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR (45) NOT NULL UNIQUE -- изображение, музыка, документ
);

INSERT INTO media_types VALUES (DEFAULT, 'Изображение');
INSERT INTO media_types VALUES (DEFAULT, 'Музыка');
INSERT INTO media_types VALUES (DEFAULT, 'Документ');

CREATE TABLE media (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	type_id INT UNSIGNED NOT NULL,
	file_name VARCHAR(245) DEFAULT NULL COMMENT '/files/folder/img.png',
	file_size BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX media_user_id_idx (user_id),
	CONSTRAINT fk_media_user_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_media_type_id FOREIGN KEY (type_id) REFERENCES media_types(id)
);

INSERT INTO media VALUES (DEFAULT, 1, 1, 'im.jpg', 100, DEFAULT);
INSERT INTO media VALUES (DEFAULT, 1, 1, 'im1.jpg', 78, DEFAULT);
INSERT INTO media VALUES (DEFAULT, 2, 3, 'doc.docx', 1024, DEFAULT);

-- Домашнее Задание №3.
/*Придумать 2-3 таблицы для БД vk,
 * которую мы создали на занятии (с перечнем полей, указанием индексов и внешних ключей).
 * Прислать результат в виде скрипта *.sql.

Возможные таблицы:
a. Посты пользователя
b. Лайки на посты пользователей, лайки на медиафайлы
c. Черный список
d. Школы, университеты для профиля пользователя
e. Чаты (на несколько пользователей)
f. Посты в сообществе*/

CREATE TABLE posts ( -- Таблица посты с возможностью выложить пост с медиафайлом
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_type_id INT UNSIGNED DEFAULT NULL,
	txt TEXT NOT NULL,
	file_name VARCHAR(245) DEFAULT NULL COMMENT '/files/folder/img.png',
	file_size BIGINT UNSIGNED DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT fk_posts_user_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_posts_media_type_id FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

INSERT INTO posts VALUES (DEFAULT, 2, 2, 'Зацените клевый трек', 'music.mp3', 1024, DEFAULT, DEFAULT);
INSERT INTO posts VALUES (DEFAULT, 1, DEFAULT, 'Как я провел лето: ...', DEFAULT, DEFAULT, DEFAULT, DEFAULT);

CREATE TABLE likes_on_posts ( -- Лайки на посты
	user_id BIGINT UNSIGNED NOT NULL,
	post_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, post_id),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX likes_on_posts_user_id_idx (user_id),
	CONSTRAINT fk_likes_on_posts_user_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_likes_on_posts_post_id FOREIGN KEY (post_id) REFERENCES posts(id)
);

INSERT INTO likes_on_posts VALUES (1, 1, DEFAULT);
INSERT INTO likes_on_posts VALUES (2, 2, DEFAULT);

CREATE TABLE likes_on_mediafiles ( -- Лайки на медиафайлы
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, media_id),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX likes_on_mediafiles_user_id_idx (user_id),
	CONSTRAINT fk_likes_on_mediafiles_user_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT fk_likes_on_mediafiles_media_id FOREIGN KEY (media_id) REFERENCES media(id)
);

INSERT INTO likes_on_mediafiles VALUES (1, 3, DEFAULT);
INSERT INTO likes_on_mediafiles VALUES (2, 1, DEFAULT);