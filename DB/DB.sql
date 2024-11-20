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
<<<<<<< Updated upstream
('브베뮤직비디오 1 - 할수있어 넌 너니까 (선택 자막)', '브베', 'https://www.youtube.com/watch?v=2hMNx5PCpGg&list=PLPY5X004VxTr33YKUKV5cKlqqxzunyO7i'),
('브베뮤직비디오 2 - 매일 같은 하루', '브베', 'https://www.youtube.com/watch?v=xY4v7ZI2jsM'),
('브베뮤직비디오 3 - 힘찬 스텝, 하나! 둘! 셋! 넷!', '브베', 'https://www.youtube.com/watch?v=GDc_W-urbiQ'),
('브베뮤직비디오 4 - 발명가의 하루', '브베', 'https://www.youtube.com/watch?v=ehuOJmJMP8g'),
('브베뮤직비디오 5 - 마음을 비우면 행복해져요', '브베', 'https://www.youtube.com/watch?v=nnfhy29sG7M'),
('The Amazing Digital Circus - Your New Home (Extended)', '음악', 'https://www.youtube.com/watch?v=Hk-p6xcDUVE');
SELECT * FROM videos;
=======
('주말에 하면 딱 좋은 팔 운동 루틴', '팔', 'https://www.youtube.com/watch?v=jhioxpxkces'),
(':fire:출렁이는 팔뚝살:fire:빨리 빼려면 1달만 이 루틴하세요', '팔', 'https://www.youtube.com/watch?v=T-bVqdhqW2U'),
(':sports_medal:요일별운동:sports_medal: 금요일 형님 조직으로 돌아오십쇼..', '팔', 'https://www.youtube.com/watch?v=URVOrAxBDq0'),
('국가대표 선수한테 팔 운동 배워봤습니다.', '팔', 'https://www.youtube.com/watch?v=P7laCgKeu3M'),
('피지크, 보디빌딩 다 해보고 알려주는 프로의 어깨 운동', '어깨', 'https://www.youtube.com/watch?v=v7FCNMQfJwI'),
('승모근 소멸:fire: 오프숄더 여신되는 ‘제니어깨’ 루틴', '어깨', 'https://www.youtube.com/watch?v=M3bVPN42Kdo'),
('하루10분! 어깨 근육을 키우는 덤벨운동 ', '어깨', 'https://www.youtube.com/watch?v=Lts-ddUgSFQ'),
('노래 한 곡으로 끝나는 어깨 운동 루틴', '어깨', 'https://www.youtube.com/watch?v=jOt1Dz3XT78'),
('누워서 5분 복부운동!! 효과보장! (매일 2주만 해보세요!)', '복부', 'https://www.youtube.com/watch?v=7TLk7pscICk'),
('(층간소음X, 설명O) :fire:짧고 굵게:fire: 복근만들기 2주 챌린지', '복부', 'https://www.youtube.com/watch?v=QSZ0mUGO_CA'),
('2주만에 복근 만드는 운동 2 MIN ABS WORKOUT', '복부', 'https://www.youtube.com/watch?v=PoYzxj8Iy5M'),
('휴식없는 - 악마의 7분 복부운동 - 짧고 굵게 복부를 꽉 조여주는', '복부', 'https://www.youtube.com/watch?v=ee1alaQgE9U'),
('하루 한 번! 꼭 해야하는 10분 기본 하체근력 운동 홈트', '하체', 'https://www.youtube.com/watch?v=C4_2puAkxfs'),
(':sports_medal:요일별운동:sports_medal: 금요일 하체집중 근력운동 15분 루틴!', '하체', 'https://www.youtube.com/watch?v=pDFuLG0xrsU'),
('앞벅지 볼록, 뒷벅지 셀룰라이트, 허벅지 안쪽살 모조리 불태우고:fire: [여리탄탄 일자 허벅지] 되는 7일 루틴', '하체', 'https://www.youtube.com/watch?v=dpBYYEhdofI'),
('국가대표 선수한테 하체 운동 배워봤습니다.', '하체', 'https://www.youtube.com/watch?v=Y8yfOBz9tYY'),
('넓은 프레임을 원하는 사람들을 위한 5가지 상부 등 운동 루틴', '등', 'https://www.youtube.com/watch?v=Uw-65lRrGAo'),
('짧고 굵게 5분도 충분한 등운동. 효과최고!', '등', 'https://www.youtube.com/watch?v=cfioLE83by0'),
(':sports_medal:요일별운동:sports_medal: 화요일 등/허리 군살 모조리 파.괴.한.다:boom: 등운동 루틴', '등', 'https://www.youtube.com/watch?v=4t9u85AHQR0'),
('하루10분! 등 근육을 키우는 덤벨운동 (등운동, 벤치없이)', '등', 'https://www.youtube.com/watch?v=BGd4sKOcl5I'),
('볼륨과 너비 둘 다 잡으려면 이렇게 가슴운동 해야합니다.', '가슴', 'https://www.youtube.com/watch?v=fpOlHY2W7bQ'),
(':sports_medal:요일별운동:sports_medal: 수요일 탄력있는 가슴, 겨드랑이 군살타파! 가슴 운동루틴', '가슴', 'https://www.youtube.com/watch?v=-V-Rdcn_ok8'),
('Lv.4 10분 만에 집에서 가슴 작살내는 루틴 (누구나 쉽게 가능)', '가슴', 'https://www.youtube.com/watch?v=c_5ENJWekbQ'),
('【가슴루틴】 가슴이 커지는 여자가슴 운동루틴! 헬스장 기구+덤벨 프로그램', '가슴', 'https://www.youtube.com/watch?v=TuqxAV6lzfg');
>>>>>>> Stashed changes

CREATE TABLE comments (
    userId VARCHAR(255) NOT NULL,
    videoId VARCHAR(255) NOT NULL PRIMARY KEY,
    contexts VARCHAR(255) NOT NULL,
    FOREIGN KEY (videoId) REFERENCES videos(videoId) ON DELETE CASCADE
);