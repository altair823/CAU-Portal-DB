# INSERT dummy user data
USE cauportal;

# undergraduate
CALL insert_user(1, '김태현', 'Kim Tae Hyun', '1998-08-23', '강원도 춘천시', '010-2015-7768', '1234-5678-9012', 'kimth0734@gmail.com',
    TRUE, FALSE, FALSE, FALSE, FALSE);
CALL insert_user(2, '최다빈', 'Choi Da Bin', '1999-01-01', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'cdb9901@gmail.com',
    TRUE, FALSE, FALSE, FALSE, FALSE);
CALL insert_user(3, '이승규', 'Lee Seung Gyu', '1998-12-31', '서울특별시 도봉구', '010-7847-2321', '78905-1351-01', 'lsg8734@gmail.com',
    TRUE, FALSE, FALSE, FALSE, FALSE);
CALL insert_user(4, '전현석', 'Jeon Hyun Seok', '1998-11-11', '서울특별시 강서구', '010-1345-2341', '1234-5678-9012', 'jhs26@gmail.com',
    TRUE, FALSE, FALSE, FALSE, FALSE);
CALL insert_user(5, '이혁준', 'Lee Hyuk Jun', '1998-10-10', '서울특별시 강동구', '010-1234-5678', '1234-5678-9012', 'lhj7812@gmail.com',
    TRUE, FALSE, FALSE, FALSE, FALSE);
# postgraduate
CALL insert_user(6, '송하나', 'Song Ha Na', '1998-09-09', '서울특별시 강북구', '010-9761-2341', '3879-48-125-245', 'shn0990@naver.com',
    FALSE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user(7, '이상혁', 'Lee Sang Hyuk', '1996-05-07', '서울특별시 강서구', '010-7777-7777', '123567-6962-24692', 'lsh773@gmail.com',
    FALSE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user(8, '리위안하오', 'Li Weianhao', '1998-01-28', '허난성 핑딩산시 루저우시', '010-2641-6373', '097347-88853-12', 'lwhao@gmail.com',
    FALSE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user(9, '이현우', 'Lee Hyun Woo', '1988-11-09', '경기도 성남시', '010-3763-2341', '784338-1234-5678', 'lhw8732@hanmail.net',  # also assistant
    FALSE, TRUE, TRUE, FALSE, FALSE);
CALL insert_user(10, '손흥민', 'Son Heung Min', '1992-07-08', '강원도 춘천시 후평동', '010-1315-5448', '15415-456121-83', 'shm83765@gmail.com',  # also assistant
    FALSE, TRUE, TRUE, FALSE, FALSE);
# undergraduate & postgraduate
CALL insert_user(11, '이수빈', 'Lee Su Bin', '1998-01-01', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'lsb837@gmail.com',
    TRUE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user(12, '페리시치', 'Perisic Ivan', '1989-02-02', '크로아티아 자그레브', '010-6873-2341', '4892-2421-8432', 'kje2234@gmail.com',
    TRUE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user(13, '이승우', 'Lee Seung Woo', '1998-03-03', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'lsw9283@naver.com',
    TRUE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user(14, '전종서', 'Jeon Jong Seo', '1998-04-04', '충청북도 청주시', '010-6873-7682', '67267-789138-12', 'europe23u@gmail.com',  # also assistant
    TRUE, TRUE, TRUE, FALSE, FALSE);
CALL insert_user(15, '이민지', 'Lee Min Ji', '1996-12-31', '전라북도 전주시', '010-6873-2341', '4892-2421-8432', 'jke78@cau.ac.kr',  # also assistant
    TRUE, TRUE, TRUE, FALSE, FALSE);
# professor
CALL insert_user(16, '김현수', 'Kim Hyun Soo', '1970-01-01', '서울특별시 강남구', '010-6792-2341', '1234-5678-9012', 'khs673@cau.ac.kr',
    FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user(17, '김수현', 'Kim Su Hyun', '1967-02-02', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'kyre874@cau.ac.kr',
    FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user(18, '엘링 홀란', 'Erling HollAND', '1965-03-03', '노르웨이 오슬로', '010-8738-9872', '7823823-13948-32', 'hollAND@gamil.com',
    FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user(19, '이승우', 'Lee Seung Woo', '1963-04-04', '인천광역시 부평구', '010-2768-3221', '89348-1398647-232', 'ejhii@cau.ac.kr',
    FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user(20, '이민지', 'Lee Min Ji', '1961-05-05', '서울특별시 강남구', '010-6873-7887', '78237-28731-781', 'wkje@gmail.com',
    FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user(21, '김현수', 'Kim Hyun Soo', '1976-08-23', '서울특별시 강남구', '010-9998-7768', '1234-5678-2983', 'iiwj@gmail.com',
    FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user(22, '김하나', 'Kim Ha Na', '1979-09-01', '서울특별시 노원구', '010-7878-9823', '4892-2421-8432', 'khn07834@naver.com',
    FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user(23, '박스태프', 'Park Staph', '1978-12-31', '서울특별시 용산구', '010-7847-2321', '78905-1351-01', 'yong98@gmail.com',
    FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user(24, '이현운', 'Lee Hyun Woon', '1977-11-11', '경기도 성남시', '010-1345-2341', '1234-5678-9012', 'lhwoooo@naver.com',
    FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user(25, '최민재', 'Choi Min Jae', '1975-10-10', '서울특별시 강남구', '010-8792-7823', '97624-231-512', 'cmjiiiii@hanmail.net',
    FALSE, FALSE, FALSE, TRUE, FALSE);
# assistant
CALL insert_user(26, '김현수', 'Kim Hyun Soo', '1997-09-18', '서울특별시 서초구', '010-8721-0987', '8734201-3184-12', 'khs9923@gmail.com',
    FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user(27, '김수민', 'Kim Su Min', '1996-08-17', '서울특별시 동작구', '010-7728-8723', '76763-00912-982', 'kimsm96@naver.com',
    FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user(28, '최태성', 'Choi Tae Sung', '1995-07-16', '경기도 남양주시 진접읍', '010-0923-9982', '4892-878723-8432', 'choi2938@cau.ac.kr',
    FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user(29, '최흥민', 'Choi Heung Min', '1998-06-15', '강원도 강릉시 강동면', '010-0029-8778', '772398-87143-03', 'choihe9823@cau.ac.kr',
    FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user(30, '사나', 'Sana', '1996-05-14', '경기도 성남시 분당구', '010-9831-0012', '87872-0012-123', 'sana3232@gmail.com',
    FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user(31, '김우현', 'Kim Woo Hyun', '1995-04-13', '경기도 의정부시 신곡동', '010-6623-9872', '98231-8787210-02', 'kimwh9823@cau.ac.kr',
    FALSE, FALSE, TRUE, FALSE, FALSE);
# staff
CALL insert_user(32, '이현주', 'Lee Hyun Joo', '1980-09-18', '서울특별시 서초구', '010-8721-0987', '8734201-3184-12', 'dkj07238@gmail.com',
    FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user(33, '이수진', 'Lee Su Jin', '1981-08-17', '서울특별시 동작구', '010-7728-9817', '76763-8712-123', 'llei00782@naver.com',
    FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user(34, '이민지', 'Lee Min Ji', '1982-07-16', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'leemj82@naver.com',
    FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user(35, '이승우', 'Lee Seung Woo', '1983-06-15', '서울특별시 강남구', '010-0029-8778', '772398-87143-03', 'lsu772@gmail.com',
    FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user(36, '김철수', 'Kim Chul Soo', '1984-05-14', '경기도 성남시 분당구', '010-9831-0012', '87872-0012-123', 'KimCh@gmail.com',
    FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user(37, '최민수', 'Choi Min Soo', '1985-04-13', '경기도 의정부시 신곡동', '010-6623-1234', '98231-9872-123', 'uuue2323@naver.com',
    FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user(38, '김스테프' , 'Kim Staph', '1986-03-12', '인천광역시 부평구', '010-8882-1347', '98231-0238-319874', 'kimstaff@naver.com',
    FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user(39, '이현우', 'Lee Hyun Woo', '1987-02-11', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'lee_hw0923@naver.com',
    FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user(40, '이민지', 'Lee Min Ji', '1988-01-10', '서울특별시 강북구', '010-9823-2341', '4892-2421-7623', 'lmj8723@hanmail.net',
    FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user(41, '이승우', 'Lee Seung Woo', '1989-12-31', '인천광역시 부평구', '010-8823-7823', '9727578-2873-9832', 'lsw0734@gmail.com',
    FALSE, FALSE, FALSE, FALSE, TRUE);

SELECT * FROM user;
SELECT * FROM student JOIN user ON student.user_id = user.user_id;
SELECT * FROM undergraduate JOIN student ON undergraduate.student_id = student.student_id JOIN user ON student.user_id = user.user_id;
SELECT * FROM postgraduate JOIN student ON postgraduate.student_id = student.student_id JOIN user ON student.user_id = user.user_id;
SELECT * FROM employee JOIN user ON employee.user_id = user.user_id;
SELECT * FROM instructor JOIN employee ON instructor.employee_id = employee.employee_id JOIN user ON employee.user_id = user.user_id;
SELECT * FROM professor JOIN instructor ON professor.instructor_id = instructor.instructor_id JOIN employee ON instructor.employee_id = employee.employee_id JOIN user ON employee.user_id = user.user_id;
SELECT * FROM assistant JOIN instructor ON assistant.instructor_id = instructor.instructor_id JOIN employee ON instructor.employee_id = employee.employee_id JOIN user ON employee.user_id = user.user_id;
SELECT * FROM staff JOIN employee ON staff.employee_id = employee.employee_id JOIN user ON employee.user_id = user.user_id;

# INSERT dummy user's states using with user_id
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '재학', '2018-03-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id BETWEEN 1 AND 5;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '휴학', '2019-03-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id BETWEEN 1 AND 2;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '재학', '2021-03-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id = 1;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '자퇴', '2023-03-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id = 2;

# INSERT dummy postgraduate who was undergraduate before using with user_id
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '재학', '2013-03-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id BETWEEN 11 AND 13;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '재학', '2012-03-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id BETWEEN 14 AND 15;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '휴학', '2014-03-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id BETWEEN 11 AND 12;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '재학', '2015-03-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id = 11;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '재학', '2016-03-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id = 12;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '졸업', '2017-02-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id BETWEEN 14 AND 15;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '졸업', '2018-02-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id = 13;
INSERT INTO undergraduate_state (undergraduate_id, state, modified_date)
    SELECT u.undergraduate_id, '졸업', '2020-02-02' FROM undergraduate u JOIN student s ON u.student_id = s.student_id
    WHERE s.user_id BETWEEN 11 AND 12;


SELECT * FROM undergraduate_state
JOIN undergraduate ON undergraduate_state.undergraduate_id = undergraduate.undergraduate_id
JOIN student ON undergraduate.student_id = student.student_id
JOIN user ON student.user_id = user.user_id ORDER BY undergraduate_state.modified_date DESC;

SELECT * FROM undergraduate_state
JOIN undergraduate ON undergraduate_state.undergraduate_id = undergraduate.undergraduate_id
JOIN student ON undergraduate.student_id = student.student_id
JOIN user ON student.user_id = user.user_id
WHERE user.kor_name = '김태현' AND undergraduate_state.modified_date = (SELECT MIN(modified_date) FROM undergraduate_state
    JOIN undergraduate ON undergraduate_state.undergraduate_id = undergraduate.undergraduate_id
    JOIN student ON undergraduate.student_id = student.student_id
    JOIN user ON student.user_id = user.user_id
    WHERE user.kor_name = '김태현' AND undergraduate_state.state = '재학' AND undergraduate_state.modified_date > '2019-03-01');

# INSERT dummy postgraduate student's states using with user_id
INSERT INTO postgraduate_state (postgraduate_id, state, modified_date)
    SELECT p.postgraduate_id, '재학', '2021-03-02' FROM postgraduate p JOIN student s ON p.student_id = s.student_id
    WHERE s.user_id BETWEEN 6 AND 7;
INSERT INTO postgraduate_state (postgraduate_id, state, modified_date)
    SELECT p.postgraduate_id, '재학', '2022-03-02' FROM postgraduate p JOIN student s ON p.student_id = s.student_id
    WHERE s.user_id BETWEEN 8 AND 10;
INSERT INTO postgraduate_state (postgraduate_id, state, modified_date)
    SELECT p.postgraduate_id, '휴학', '2023-03-02' FROM postgraduate p JOIN student s ON p.student_id = s.student_id
    WHERE s.user_id BETWEEN 7 AND 8;

# INSERT dummy postgraduate who was undergraduate before using with user_id
INSERT INTO postgraduate_state (postgraduate_id, state, modified_date)
    SELECT p.postgraduate_id, '재학', '2020-03-02' FROM postgraduate p JOIN student s ON p.student_id = s.student_id
    WHERE s.user_id BETWEEN 11 AND 13;
INSERT INTO postgraduate_state (postgraduate_id, state, modified_date)
    SELECT p.postgraduate_id, '재학', '2019-03-02' FROM postgraduate p JOIN student s ON p.student_id = s.student_id
    WHERE s.user_id BETWEEN 14 AND 15;
INSERT INTO postgraduate_state (postgraduate_id, state, modified_date)
    SELECT p.postgraduate_id, '휴학', '2021-03-02' FROM postgraduate p JOIN student s ON p.student_id = s.student_id
    WHERE s.user_id BETWEEN 11 AND 12;
INSERT INTO postgraduate_state (postgraduate_id, state, modified_date)
    SELECT p.postgraduate_id, '재학', '2022-03-02' FROM postgraduate p JOIN student s ON p.student_id = s.student_id
    WHERE s.user_id = 11;
INSERT INTO postgraduate_state (postgraduate_id, state, modified_date)
    SELECT p.postgraduate_id, '재학', '2023-03-02' FROM postgraduate p JOIN student s ON p.student_id = s.student_id
    WHERE s.user_id = 12;
INSERT INTO postgraduate_state (postgraduate_id, state, modified_date)
    SELECT p.postgraduate_id, '졸업', '2024-02-02' FROM postgraduate p JOIN student s ON p.student_id = s.student_id
    WHERE s.user_id = 13;

SELECT * FROM postgraduate_state
JOIN postgraduate ON postgraduate_state.postgraduate_id = postgraduate.postgraduate_id
JOIN student ON postgraduate.student_id = student.student_id
JOIN user ON student.user_id = user.user_id ORDER BY postgraduate_state.modified_date DESC;



# DELETE from postgraduate_state;
# DELETE FROM undergraduate_state;
# DELETE FROM professor;
# DELETE FROM assistant;
# DELETE FROM instructor;
# DELETE FROM staff;
# DELETE FROM employee;
# DELETE FROM postgraduate;
# DELETE FROM undergraduate;
# DELETE FROM student;
# DELETE FROM user;

