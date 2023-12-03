# insert dummy user data
use cauportal;
insert into user (user_id, kor_name, eng_name, birthdate, address, phone_num, account, email, active)
values
    # undergraduate
    (1, '김태현', 'Kim Tae Hyun', '1998-08-23', '강원도 춘천시', '010-2015-7768', '1234-5678-9012', 'kimth0734@gmail.com', true),
    (2, '최다빈', 'Choi Da Bin', '1999-01-01', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'cdb9901@gmail.com', true),
    (3, '이승규', 'Lee Seung Gyu', '1998-12-31', '서울특별시 도봉구', '010-7847-2321', '78905-1351-01', 'lsg8734@gmail.com', true),
    (4, '전현석', 'Jeon Hyun Seok', '1998-11-11', '서울특별시 강서구', '010-1345-2341', '1234-5678-9012', 'jhs26@gmail.com', true),
    (5, '이혁준', 'Lee Hyuk Jun', '1998-10-10', '서울특별시 강동구', '010-1234-5678', '1234-5678-9012', 'lhj7812@gmail.com', true),
    # postgraduate
    (6, '송하나', 'Song Ha Na', '1998-09-09', '서울특별시 강북구', '010-9761-2341', '3879-48-125-245', 'shn0990@naver.com', true),
    (7, '이상혁', 'Lee Sang Hyuk', '1996-05-07', '서울특별시 강서구', '010-7777-7777', '123567-6962-24692', 'lsh773@gmail.com', true),
    (8, '리위안하오', 'Li Weianhao', '1998-01-28', '허난성 핑딩산시 루저우시', '010-2641-6373', '097347-88853-12', 'lwhao@gmail.com', true),
    (9, '이현우', 'Lee Hyun Woo', '1988-11-09', '경기도 성남시', '010-3763-2341', '784338-1234-5678', 'lhw8732@hanmail.net', true),
    (10, '손흥민', 'Son Heung Min', '1992-07-08', '강원도 춘천시 후평동', '010-1315-5448', '15415-456121-83', 'shm83765@gmail.com', true),
    # undergraduate & postgraduate
    (11, '이수빈', 'Lee Su Bin', '1998-01-01', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'lsb837@gmail.com', true),
    (12, '페리시치', 'Perisic Ivan', '1989-02-02', '크로아티아 자그레브', '010-6873-2341', '4892-2421-8432', 'kje2234@gmail.com', true),
    (13, '이승우', 'Lee Seung Woo', '1998-03-03', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'lsw9283@naver.com', true),
    (14, '전종서', 'Jeon Jong Seo', '1998-04-04', '충청북도 청주시', '010-6873-7682', '67267-789138-12', 'europe23u@gmail.com', true),
    (15, '이민지', 'Lee Min Ji', '1996-12-31', '전라북도 전주시', '010-6873-2341', '4892-2421-8432', 'jke78@cau.ac.kr', true),
    # professor
    (16, '김현수', 'Kim Hyun Soo', '1970-01-01', '서울특별시 강남구', '010-6792-2341', '1234-5678-9012', 'khs673@cau.ac.kr', true),
    (17, '김수현', 'Kim Su Hyun', '1967-02-02', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'kyre874@cau.ac.kr', true),
    (18, '엘링 홀란', 'Erling Holland', '1965-03-03', '노르웨이 오슬로', '010-8738-9872', '7823823-13948-32', 'holland@gamil.com', true),
    (19, '이승우', 'Lee Seung Woo', '1963-04-04', '인천광역시 부평구', '010-2768-3221', '89348-1398647-232', 'ejhii@cau.ac.kr', true),
    (20, '이민지', 'Lee Min Ji', '1961-05-05', '서울특별시 강남구', '010-6873-7887', '78237-28731-781', 'wkje@gmail.com', true),
    # staff
    (21, '김현수', 'Kim Hyun Soo', '1976-08-23', '서울특별시 강남구', '010-9998-7768', '1234-5678-2983', 'iiwj@gmail.com', true),
    (22, '김하나', 'Kim Ha Na', '1979-09-01', '서울특별시 노원구', '010-7878-9823', '4892-2421-8432', 'khn07834@naver.com', true),
    (23, '박스태프', 'Park Staph', '1978-12-31', '서울특별시 용산구', '010-7847-2321', '78905-1351-01', 'yong98@gmail.com', true),
    (24, '이현운', 'Lee Hyun Woon', '1977-11-11', '경기도 성남시', '010-1345-2341', '1234-5678-9012', 'lhwoooo@naver.com', true),
    (25, '최민재', 'Choi Min Jae', '1975-10-10', '서울특별시 강남구', '010-8792-7823', '97624-231-512', 'cmjiiiii@hanmail.net', true);


select * from user;

# insert student data to student table with user_id
insert into student (user_id)
select user_id from user
               where user_id between 1 and 15;

select * from student;

select * from student s
         join user u on s.user_id = u.user_id;

# insert undergraduate data to student table with admission date
insert into undergraduate (student_id, admission_date)
select student_id, '2018-03-02' from student
where user_id between 1 and 3;
insert into undergraduate (student_id, admission_date)
select student_id, '2019-03-02' from student
where user_id between 4 and 5;

# insert postgraduate data to student table with admission date
insert into postgraduate (student_id, admission_date)
select student_id, '2018-03-02' from student
where user_id between 6 and 8;
insert into postgraduate (student_id, admission_date)
select student_id, '2019-03-02' from student
where user_id between 9 and 10;

# insert undergraduate & postgraduate data to student table with admission date
insert into undergraduate (student_id, admission_date)
select student_id, '2013-03-02' from student
where user_id between 11 and 12;
insert into postgraduate (student_id, admission_date)
select student_id, '2018-03-02' from student
where user_id between 11 and 12;
insert into undergraduate (student_id, admission_date)
select student_id, '2014-03-02' from student
where user_id between 13 and 15;
insert into postgraduate (student_id, admission_date)
select student_id, '2019-03-02' from student
where user_id between 13 and 15;

select * from undergraduate u
         join student s on u.student_id = s.student_id
         join user u2 on s.user_id = u2.user_id;

select * from postgraduate p
        join student s on p.student_id = s.student_id
        join user u on s.user_id = u.user_id;

# insert professor data to employee table with user_id
insert into employee (user_id)
select user_id from user
               where user_id between 16 and 25;

select * from employee e
         join user u on e.user_id = u.user_id;

# insert staff data from employee table with employee_id
insert into staff (employee_id)
select employee_id from employee
where user_id between 21 and 25;

select * from staff s
         join employee e on s.employee_id = e.employee_id
         join user u on e.user_id = u.user_id;

# insert instructor data from employee table with employee_id
insert into instructor (employee_id)
select employee_id from employee
where user_id between 16 and 20;

select * from instructor i
         join employee e on i.employee_id = e.employee_id
         join user u on e.user_id = u.user_id;

# insert professor data from instructor table with instructor_id
insert into professor (instructor_id)
select instructor_id from instructor i join employee e on i.employee_id = e.employee_id
where user_id between 16 and 20;

select * from professor p
         join instructor i on p.instructor_id = i.instructor_id
         join employee e on i.employee_id = e.employee_id
         join user u on e.user_id = u.user_id;

# delete from undergraduate;
# delete from postgraduate;
# delete from student;
# delete from user;

