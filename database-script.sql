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

-- Inserts

-- Inserimento dati nella tabella game
INSERT INTO game (name, description, rating) VALUES 
('The Witcher 3: Wild Hunt', 'An open-world action role-playing game developed by CD Projekt Red.', 9),
('Red Dead Redemption 2', 'An action-adventure game developed and published by Rockstar Games.', 9),
('The Legend of Zelda: Breath of the Wild', 'An action-adventure game developed and published by Nintendo.', 10);

-- Inserimento dati nella tabella user
INSERT INTO user (username, password, email, role) VALUES 
('admin', 'adminpass', 'admin@example.com', 'admin'),
('john_doe', 'john123', 'john.doe@example.com', 'user'),
('jane_smith', 'smith456', 'jane.smith@example.com', 'user'),
('game_master', 'game123', 'master.gamer@example.com', 'operator');

-- Inserimento dati nella tabella game_images
INSERT INTO game_images (image_name, image, game_id, order_number) VALUES 
('Witcher3_cover', 'BLOB1', 1, 1),
('RDR2_cover', 'BLOB2', 2, 1),
('Zelda_cover', 'BLOB3', 3, 1);

-- Inserimento dati nella tabella rating
INSERT INTO rating (user_id, game_id, rating) VALUES
(2, 1, 8),  -- John Doe ha valutato The Witcher 3: Wild Hunt con un 8
(3, 1, 9),  -- Jane Smith ha valutato The Witcher 3: Wild Hunt con un 9
(2, 2, 9),  -- John Doe ha valutato Red Dead Redemption 2 con un 9
(3, 2, 8),  -- Jane Smith ha valutato Red Dead Redemption 2 con un 8
(4, 3, 10); -- Game Master ha valutato The Legend of Zelda: Breath of the Wild con un 10


-- Inserimento dati nella tabella comment
INSERT INTO comment (user_id, game_id, description) VALUES
(2, 1, 'One of the best RPGs ever!'),
(3, 1, 'I love the story and characters.'),
(2, 2, 'Amazing open-world experience.'),
(3, 2, 'Great storyline and immersive gameplay.'),
(4, 3, 'A masterpiece of game design.');

-- Inserimento dati nella tabella reply
INSERT INTO reply (comment_id, user_id, reply_content) VALUES
(1, 4, 'Glad you enjoyed it!'),
(2, 4, 'Yes, it\'s fantastic!'),
(3, 4, 'Absolutely, it\'s breathtaking!');

-- Inserimento dati nella tabella genre
INSERT INTO genre (name, description) VALUES
('Action RPG', 'Role-playing games with emphasis on real-time combat.'),
('Open-world', 'Games with vast, open environments to explore.'),
('Adventure', 'Games focused on narrative and exploration.');

-- Inserimento dati nella tabella game_genre
INSERT INTO game_genre (genre_id, game_id) VALUES
(1, 1), -- The Witcher 3: Wild Hunt è un Action RPG
(2, 1), -- The Witcher 3: Wild Hunt è anche un Open-world
(1, 2), -- Red Dead Redemption 2 è un Action RPG
(2, 2), -- Red Dead Redemption 2 è anche un Open-world
(3, 3); -- The Legend of Zelda: Breath of the Wild è un Adventure

-- Inserimento dati nella tabella console
INSERT INTO console (name) VALUES
('PlayStation 4'),
('Xbox One'),
('Nintendo Switch');

-- Inserimento dati nella tabella game_console
INSERT INTO game_console (console_id, game_id) VALUES
(1, 1), -- The Witcher 3: Wild Hunt è disponibile su PlayStation 4
(2, 2), -- Red Dead Redemption 2 è disponibile su Xbox One
(3, 3); -- The Legend of Zelda: Breath of the Wild è disponibile su Nintendo Switch

-- Inserimento dati nella tabella user_follower
INSERT INTO user_follower (user_id, follower_id) VALUES
(2, 3), -- John Doe segue Jane Smith
(3, 2), -- Jane Smith segue John Doe
(4, 2); -- Game Master segue John Doe
