DROP DATABASE IF EXISTS ssafit;
CREATE DATABASE ssafit;

USE ssafit;

CREATE TABLE users (
    userId VARCHAR(255) NOT NULL PRIMARY KEY,
    userPw VARCHAR(255) NOT NULL,
    nickname VARCHAR(255) NOT NULL,
    crews VARCHAR(255) DEFAULT NULL,
	login_first TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    login_recent TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE custom (
	userId VARCHAR(255) NOT NULL PRIMARY KEY,
    hair INT DEFAULT 0,
    shirts INT DEFAULT 0,
    pants INT DEFAULT 0,
    shoes INT DEFAULT 0,
    hat INT DEFAULT 0,
    glasses INT DEFAULT 0,
    bag INT DEFAULT 0,
    FOREIGN KEY (userId) REFERENCES users(userId) ON DELETE CASCADE
);

CREATE TABLE exercise (
	userId VARCHAR(255) NOT NULL PRIMARY KEY,
	chest INT DEFAULT 0,
    back INT DEFAULT 0,
    shoulder INT DEFAULT 0,
    arm INT DEFAULT 0,
    leg INT DEFAULT 0,
    abdominal INT DEFAULT 0,
    FOREIGN KEY (userId) REFERENCES users(userId) ON DELETE CASCADE
);

CREATE TABLE liked (
	userId VARCHAR(255) NOT NULL PRIMARY KEY,
	videoId VARCHAR(255) NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(userId) ON DELETE CASCADE
);

#팔로우 누르면 그사람 진척도도 화면에 표시됨
CREATE TABLE follow (
	userId VARCHAR(255) NOT NULL PRIMARY KEY,
	FollowuserId VARCHAR(255) NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(userId) ON DELETE CASCADE
);

CREATE TABLE videos (
    videoId VARCHAR(255) NOT NULL PRIMARY KEY,
    category VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    levels INT DEFAULT 0, 
    views INT DEFAULT 0,
    likes INT DEFAULT 0
);

CREATE TABLE comments (
    userId VARCHAR(255) NOT NULL,
    videoId VARCHAR(255) NOT NULL PRIMARY KEY,
    contexts VARCHAR(255) NOT NULL,
    likes INT DEFAULT 0,
    FOREIGN KEY (videoId) REFERENCES videos(videoId) ON DELETE CASCADE
);

# 첫 화면 가면, 설문조사 해서 (초급~고급) 판별해서 그에 맞는 페이지 오픈
# 페이즈 우측에는 카테고리(초급 고급 말고, 부위나 운동 종류같은)
# 각 페이지에는 1~10단계 같은 느낌으로 단계들이 있음
# 단계를 클릭하면 해당 영상 페이지로 이동(댓글, 영상)
#-> 영상페이지 우측에는 지금까지 열린 영상과 잠금된 영상 보게끔(단계에 대하여)
# 캐릭터 커스텀 페이지로 이동 가능(거기서의 옷이나 이런건 영상 단계 해금으로 얻음)