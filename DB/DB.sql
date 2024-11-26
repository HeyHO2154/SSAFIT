DROP DATABASE IF EXISTS ssafit;
CREATE DATABASE ssafit;

USE ssafit;

CREATE TABLE users (
    userId VARCHAR(255) NOT NULL PRIMARY KEY,
    userPw VARCHAR(255) NOT NULL,
    nickname VARCHAR(255) NOT NULL,
    exp int default 0,
    crew VARCHAR(255) default '없음',
    state VARCHAR(255) default '상태메시지'
);

UPDATE users SET nickname = 'as', crew = '미림이팬클럽' WHERE userId = 'as';
SELECT * FROM users;

CREATE TABLE follower (
    leaderId VARCHAR(255) NOT NULL,
    followerId VARCHAR(255) NOT NULL,
    PRIMARY KEY (leaderId, followerId),
    CONSTRAINT fk_leader FOREIGN KEY (leaderId) REFERENCES users(userId) ON DELETE CASCADE,
    CONSTRAINT fk_follower FOREIGN KEY (followerId) REFERENCES users(userId) ON DELETE CASCADE
);

#INSERT INTO follower (leaderId, followerId) VALUES ('as', 'ass');

SELECT * FROM follower;

CREATE TABLE videos (
    videoId VARCHAR(255) NOT NULL PRIMARY KEY,
    category VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    views int default 0,
    difficulty int default 0
);

UPDATE videos SET views = videos.views+1 WHERE videoId = "브베뮤직비디오 2 - 매일 같은 하루";



CREATE TABLE comments (
    userId VARCHAR(255) NOT NULL,
    videoId VARCHAR(255) NOT NULL PRIMARY KEY,
    contexts VARCHAR(255) NOT NULL,
    FOREIGN KEY (videoId) REFERENCES videos(videoId) ON DELETE CASCADE
);

INSERT INTO videos (videoId, category, url) VALUES 
('주말에 하면 딱 좋은 팔 운동 루틴', '팔', 'https://www.youtube.com/watch?v=jhioxpxkces');

SELECT * FROM videos;