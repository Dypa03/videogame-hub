DROP SCHEMA IF EXISTS videogame_hub;
CREATE SCHEMA videogame_hub;
USE videogame_hub;

CREATE TABLE game (
    game_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE,
    description TEXT,
    rating INTEGER
);

CREATE TABLE user (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(24) UNIQUE,
    password VARCHAR(16),
    email VARCHAR(50) UNIQUE,
    role ENUM('admin', 'user','operator'),
    profile_picture BLOB,
    favorite_game BIGINT,
    FOREIGN KEY (favorite_game) REFERENCES game(game_id)
);

CREATE TABLE game_images (
    game_image_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    image_name VARCHAR(50),
    image BLOB,
    game_id BIGINT,
    order_number INTEGER,
    FOREIGN KEY (game_id) REFERENCES game(game_id)
);

CREATE TABLE rating (
    user_id BIGINT,
    game_id BIGINT,
    rating INTEGER,
    PRIMARY KEY (user_id, game_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id)
);

CREATE TABLE comment (
    comment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    game_id BIGINT,
    description VARCHAR(200),
    FOREIGN KEY (user_id, game_id) REFERENCES rating(user_id, game_id)
);

CREATE TABLE reply (
    reply_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    comment_id BIGINT,
    user_id BIGINT,
    reply_content VARCHAR(100),
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE genre (
    genre_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    description VARCHAR(200)
);

CREATE TABLE game_genre (
    genre_id BIGINT,
    game_id BIGINT,
    PRIMARY KEY (genre_id, game_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id)
);

CREATE TABLE console (
    console_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) UNIQUE
);

CREATE TABLE game_console (
    console_id BIGINT,
    game_id BIGINT,
    PRIMARY KEY (console_id, game_id),
    FOREIGN KEY (console_id) REFERENCES console(console_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id)
);

CREATE TABLE user_follower (
    relation_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    follower_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (follower_id) REFERENCES user(user_id)
);

CREATE TABLE favorite_game (
    user_id BIGINT,
    game_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id)
);

-- Error Code: 3734. Failed to add the foreign key constraint. Missing column 'comment_id' for constraint 'comment_ibfk_1' in the referenced table 'rating'
