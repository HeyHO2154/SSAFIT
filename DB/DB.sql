DROP DATABASE IF EXISTS ssafit;
CREATE DATABASE ssafit;

USE ssafit;

CREATE TABLE users (
    userId VARCHAR(255) NOT NULL PRIMARY KEY,
    userPw VARCHAR(255) NOT NULL,
    nickname VARCHAR(255) NOT NULL
);

CREATE TABLE videos (
    videoId VARCHAR(255) NOT NULL PRIMARY KEY,
    category VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    views int default 0
);

UPDATE videos SET views = videos.views+1 WHERE videoId = "브베뮤직비디오 2 - 매일 같은 하루";

INSERT INTO videos (videoId, category, url) VALUES 
('브베뮤직비디오 1 - 할수있어 넌 너니까 (선택 자막)', '브베', 'https://www.youtube.com/watch?v=2hMNx5PCpGg&list=PLPY5X004VxTr33YKUKV5cKlqqxzunyO7i'),
('브베뮤직비디오 2 - 매일 같은 하루', '브베', 'https://www.youtube.com/watch?v=xY4v7ZI2jsM'),
('브베뮤직비디오 3 - 힘찬 스텝, 하나! 둘! 셋! 넷!', '브베', 'https://www.youtube.com/watch?v=GDc_W-urbiQ'),
('브베뮤직비디오 4 - 발명가의 하루', '브베', 'https://www.youtube.com/watch?v=ehuOJmJMP8g'),
('브베뮤직비디오 5 - 마음을 비우면 행복해져요', '브베', 'https://www.youtube.com/watch?v=nnfhy29sG7M');
SELECT * FROM videos;

CREATE TABLE comments (
    userId VARCHAR(255) NOT NULL,
    videoId VARCHAR(255) NOT NULL PRIMARY KEY,
    contexts VARCHAR(255) NOT NULL,
    FOREIGN KEY (videoId) REFERENCES videos(videoId) ON DELETE CASCADE
);