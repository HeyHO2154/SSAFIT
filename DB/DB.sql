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
('브베뮤직비디오 5 - 마음을 비우면 행복해져요', '브베', 'https://www.youtube.com/watch?v=nnfhy29sG7M'),
('sexy 푸드섹서 공혁준의 피자 & 스파게티 & 스파게티 먹방','먹방','https://www.youtube.com/watch?v=45rCI5jEJKY&t=447s'),
('sexy 푸드섹서 공혁준의 스시 & 우동 먹방','먹방','https://www.youtube.com/watch?v=nqzmobqNQB8'),
('sexy 푸드섹서 공혁준의 해물찜 먹방','먹방','https://www.youtube.com/watch?v=u61TlWYWmaQ'),
('(먹방) 돌아온 푸드섹서 공혁준','먹방','https://www.youtube.com/watch?v=frLO9hWAPgw'),
('(먹방) 차돌박이 짬뽕 X 짜장 게살 볶음밥 마시기!','먹방','https://www.youtube.com/watch?v=lxMtXEaGK10'),
('QWER - 고민중독 l Guitar Cover','아이돌','https://www.youtube.com/watch?v=V6gUaMZGyUo'),
('QWER 내 이름 맑음 Official MV','아이돌','https://www.youtube.com/watch?v=AlirzLFEHUI'),
('ROSÉ & Bruno Mars - APT. (Official Music Video)','아이돌','https://www.youtube.com/watch?v=ekr2nIex040'),
('「더 월드」 풀버전 - 히키킹 작곡캠프 【엘시 쇼케이스&미니콘서트 ver.】','아이돌','https://www.youtube.com/watch?v=1w-RPKXVx2Y'),
('융터르 - 우왁굳 반응','아이돌','https://www.youtube.com/watch?v=PBDsj8V83vc&t=56s'),
('The Amazing Digital Circus - Your New Home (Extended)', '음악', 'https://www.youtube.com/watch?v=Hk-p6xcDUVE'),
('[Playlist] 쇠질하다 덤벨 던져버려도 난 몰라','음악','https://www.youtube.com/watch?v=ZjXp9b1ZbqA&t=38s'),
('I Want to Break Free (Queen) Performed In North Korea','음악','https://www.youtube.com/watch?v=jYvcdhCbzJw'),
('THERE IS NOTHING WE CAN DO - NAPOLEON MEME (1 HOUR) ‪@provsoo‬','음악','https://www.youtube.com/watch?v=WvlCV4b9R1w'),
('𝐏𝐥𝐚𝐲𝐥𝐢𝐬𝐭 | 심장이 쿵쾅거려도... 끝까지 강한 척한다. 더 퍼스트 슬램덩크 OST','음악','https://www.youtube.com/watch?v=I33sYkoxNhY');
SELECT * FROM videos;

CREATE TABLE comments (
    userId VARCHAR(255) NOT NULL,
    videoId VARCHAR(255) NOT NULL PRIMARY KEY,
    contexts VARCHAR(255) NOT NULL,
    FOREIGN KEY (videoId) REFERENCES videos(videoId) ON DELETE CASCADE
);