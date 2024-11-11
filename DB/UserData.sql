DROP DATABASE IF EXISTS hsj;
DROP DATABASE ssafit;
CREATE DATABASE ssafit;

USE ssafit;

#users < videos < videos_comment
#예를들어, 유저에 대해 열려있는 비디오를 조인하고, 그 비디오에 해당하는 댓글들을 조인한다

CREATE TABLE users (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    point INT DEFAULT 0
);

CREATE TABLE videos (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    point INT DEFAULT 0
);

CREATE TABLE videos_comment (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    point INT DEFAULT 0
);

INSERT INTO users (user_id, point) VALUES ('이미림', 100);

#SET SQL_SAFE_UPDATES = 0;
#DELETE FROM users;
#SET SQL_SAFE_UPDATES = 1;

SELECT * FROM users;

#SET SQL_SAFE_UPDATES = 0;
#UPDATE users SET point = 0 WHERE id = 1;
#SET SQL_SAFE_UPDATES = 1;

