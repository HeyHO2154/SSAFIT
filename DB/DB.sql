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

#UPDATE users SET nickname = 'as', crew = '미림이팬클럽' WHERE userId = 'as';
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




CREATE TABLE comments (
    userId VARCHAR(255) NOT NULL,
    videoId VARCHAR(255) NOT NULL PRIMARY KEY,
    contexts VARCHAR(255) NOT NULL,
    FOREIGN KEY (videoId) REFERENCES videos(videoId) ON DELETE CASCADE
);

INSERT INTO videos (videoId, category, url, difficulty) VALUES
('승모근 소멸:fire: 오프숄더 여신되는 ‘제니어깨’ 루틴', '어깨', 'https://www.youtube.com/watch?v=M3bVPN42Kdo', 1),
('딱 2가지 운동만으로, \'어깨\'는 무조건 벌크업 됩니다!! (헬스초보자 삼각근 루틴? 밀리터리 프레스 / 사이드레터럴레이즈 / 케이블 리버스플라이)', '어깨', 'https://www.youtube.com/watch?v=vMLYQm2Q_q0', 2),
(':fire:어깨 운동 루틴:fire:헬스 초보 헬린이 필수 종목 BEST 4', '어깨', 'https://www.youtube.com/watch?v=8URvHKlhE1s', 3),
('승모근 안쓰는 :muscle:직각어깨 만들기 10분 따라하기', '어깨', 'https://www.youtube.com/watch?v=dpFqSZ52jGk', 4),
('피지크, 보디빌딩 다 해보고 알려주는 프로의 어깨 운동', '어깨', 'https://www.youtube.com/watch?v=v7FCNMQfJwI', 8),
('하루10분! 어깨 근육을 키우는 덤벨운동 ', '어깨', 'https://www.youtube.com/watch?v=Lts-ddUgSFQ', 9),
('노래 한 곡으로 끝나는 어깨 운동 루틴', '어깨', 'https://www.youtube.com/watch?v=jOt1Dz3XT78', 10),
('【어깨루틴】 어깨 넓어지려면 \'프레스 운동이\' 가장 효과적입니다!! (숄더프레스&밀리터리 프레스 정석)', '어깨', 'https://www.youtube.com/watch?v=JUgKh7i406o', 15),
('어깨 운동만 \'한\' 남자', '어깨', 'https://www.youtube.com/watch?v=8thMw9JyxBE', 16),
('【어깨루틴】 이게 사람 어깨야?? 말도안되는 \'어깨 사이즈\' 만드는 운동루틴 feat.이준호', '어깨', 'https://www.youtube.com/watch?v=WUmPp8cci_o', 17),
('시즌 초반, 어깨 운동 루틴 총정리', '어깨', 'https://www.youtube.com/watch?v=nqCKoVckXCM', 18),
('짧고 굵게 5분도 충분한 등운동. 효과최고!', '등', 'https://www.youtube.com/watch?v=cfioLE83by0', 1),
('요일별운동: 화요일 등/허리 군살 모조리 파.괴.한.다:boom: 등운동 루틴', '등', 'https://www.youtube.com/watch?v=4t9u85AHQR0', 2),
('넓은 프레임을 원하는 사람들을 위한 5가지 상부 등 운동 루틴', '등', 'https://www.youtube.com/watch?v=Uw-65lRrGAo', 8),
('하루10분! 등 근육을 키우는 덤벨운동 (등운동, 벤치없이)', '등', 'https://www.youtube.com/watch?v=BGd4sKOcl5I', 9),
('프리웨이트로 수행할 수 있는 등 운동은 무엇이 있을까? 6종목 알려드리겠습니다!', '등', 'https://www.youtube.com/watch?v=LeHBFe0jeYI', 10),
('김명섭이 제안하는 등운동루틴영상(랫풀다운,시티드로우,데드리프트..가장 쉽게 설명해줍니다!)', '등', 'https://www.youtube.com/watch?v=OB1w-oGKTX8', 15),
('프레임 넓어지는 등운동 상급 노하우(IFBB 내츄럴 프로 박명수)', '등', 'https://www.youtube.com/watch?v=QXd3sHSc_5k', 16),
('등운동은 복잡하게 할 필요가 없습니다. 이렇게만 하세요!!(등 운동 방법, 등 운동 루틴)', '등', 'https://www.youtube.com/watch?v=Q-hMXli85QA', 17),
(':fire:등 운동 루틴 :fire:상부부터 하부 광배근까지 다 털어주는 5종목 18세트', '등', 'https://www.youtube.com/watch?v=G8SdIDNBiEA', 18),
('요일별운동: 수요일 탄력있는 가슴, 겨드랑이 군살타파! 가슴 운동루틴', '가슴', 'https://www.youtube.com/watch?v=-V-Rdcn_ok8', 1),
('【가슴루틴】 가슴이 커지는 여자가슴 운동루틴! 헬스장 기구+덤벨 프로그램', '가슴', 'https://www.youtube.com/watch?v=TuqxAV6lzfg', 2),
('볼륨과 너비 둘 다 잡으려면 이렇게 가슴운동 해야합니다.', '가슴', 'https://www.youtube.com/watch?v=fpOlHY2W7bQ', 8),
('Lv.4 10분 만에 집에서 가슴 작살내는 루틴 (누구나 쉽게 가능)', '가슴', 'https://www.youtube.com/watch?v=c_5ENJWekbQ', 9),
('고중량 벤치프레스를 버리고 안크던 가슴근육이 커졌습니다. (초중급자 가슴 운동 루틴)', '가슴', 'https://www.youtube.com/watch?v=MLaGDsN2MVw', 10),
('가슴운동 따라해보세요! 설기관 루틴공개.', '가슴', 'https://www.youtube.com/watch?v=qrt2fy_wmtU', 15),
('가슴 상부를 채우는 4가지 가슴 운동', '가슴', 'https://www.youtube.com/watch?v=3DfhLE7oLfU', 16),
('가슴 운동 정보 총모음집', '가슴', 'https://www.youtube.com/watch?v=1NfRfwcxbdI', 17),
('가슴운동 팁 모든 걸 담았다 :fire: I 나바 프로 최재상 가슴운동', '가슴', 'https://www.youtube.com/watch?v=fjIeyvsN8Fk', 18),
('요일별운동: 금요일 형님 조직으로 돌아오십쇼..', '팔', 'https://www.youtube.com/watch?v=URVOrAxBDq0', 1),
('주말에 하면 딱 좋은 팔 운동 루틴', '팔', 'https://www.youtube.com/watch?v=jhioxpxkces', 2),
('출렁이는 팔뚝살:fire:빨리 빼려면 1달만 이 루틴하세요', '팔', 'https://www.youtube.com/watch?v=T-bVqdhqW2U', 3),
('국가대표 선수한테 팔 운동 배워봤습니다.', '팔', 'https://www.youtube.com/watch?v=P7laCgKeu3M', 8),
('누워서 5분 복부운동!! 효과보장! (매일 2주만 해보세요!)', '복부', 'https://www.youtube.com/watch?v=7TLk7pscICk', 1),
('(층간소음X, 설명O) :fire:짧고 굵게:fire: 복근만들기 2주 챌린지', '복부', 'https://www.youtube.com/watch?v=QSZ0mUGO_CA', 2),
('2주만에 복근 만드는 운동 2 MIN ABS WORKOUT', '복부', 'https://www.youtube.com/watch?v=PoYzxj8Iy5M', 8),
('하루 한 번! 꼭 해야하는 10분 기본 하체근력 운동 홈트', '하체', 'https://www.youtube.com/watch?v=C4_2puAkxfs', 9),
('요일별운동: 금요일 하체집중 근력운동 15분 루틴!', '하체', 'https://www.youtube.com/watch?v=pDFuLG0xrsU', 1),
('앞벅지 볼록, 뒷벅지 셀룰라이트, 허벅지 안쪽살 모조리 불태우고:fire: [여리탄탄 일자 허벅지] 되는 7일 루틴', '하체', 'https://www.youtube.com/watch?v=dpBYYEhdofI', 2),
('국가대표 선수한테 하체 운동 배워봤습니다.', '하체', 'https://www.youtube.com/watch?v=Y8yfOBz9tYY', 8);

SELECT * FROM videos;