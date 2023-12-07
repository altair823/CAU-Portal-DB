USE cauportal;

# drop tables

DROP TABLE IF EXISTS pay;
DROP TABLE IF EXISTS scholarship;
DROP TABLE IF EXISTS notice_post;
DROP TABLE IF EXISTS archive_post;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS auth_emp_board;
DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS class_time;
DROP TABLE IF EXISTS instruct;
DROP TABLE IF EXISTS syllabus;
DROP TABLE IF EXISTS take_class;
DROP TABLE IF EXISTS class;
DROP TABLE IF EXISTS pre_req_course;
DROP TABLE IF EXISTS req_course;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS initial_fee;
DROP TABLE IF EXISTS postgraduate_enroll;
DROP TABLE IF EXISTS undergraduate_enroll;
DROP TABLE IF EXISTS professor_state;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS assistant;
DROP TABLE IF EXISTS instructor;
DROP TABLE IF EXISTS staff_state;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS postgraduate_state;
DROP TABLE IF EXISTS postgraduate;
DROP TABLE IF EXISTS undergraduate_state;
DROP TABLE IF EXISTS undergraduate;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS building;


# building section

CREATE TABLE building (
                          building_id INT PRIMARY KEY AUTO_INCREMENT,
                          building_num VARCHAR(16),
                          name VARCHAR(255) NOT NULL
);

CREATE TABLE room (
                      room_id INT PRIMARY KEY AUTO_INCREMENT,
                      building_id INT NOT NULL,
                      FOREIGN KEY (building_id) REFERENCES building(building_id),
                      room_num VARCHAR(16) NOT NULL,
                      capacity INT NOT NULL
);

# user section

CREATE TABLE user (
                      user_id INT PRIMARY KEY AUTO_INCREMENT,
                      kor_name VARCHAR(255) NOT NULL,
                      eng_name VARCHAR(255) NOT NULL,
                      birthdate DATE NOT NULL,
                      address VARCHAR(255) NOT NULL,
                      phone_num VARCHAR(255) NOT NULL,
                      account_num VARCHAR(255) NOT NULL,
                      email VARCHAR(255) NOT NULL,
                      active BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE student (
                         student_id INT PRIMARY KEY AUTO_INCREMENT,
                         user_id INT NOT NULL,
                         FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE undergraduate (
                               undergraduate_id INT PRIMARY KEY AUTO_INCREMENT,
                               student_id INT NOT NULL,
                               FOREIGN KEY (student_id) REFERENCES student(student_id)
);

CREATE TABLE postgraduate (
                              postgraduate_id INT PRIMARY KEY AUTO_INCREMENT,
                              student_id INT NOT NULL,
                              FOREIGN KEY (student_id) REFERENCES student(student_id)
);

CREATE TABLE undergraduate_state (
                                     undergraduate_id INT,
                                     FOREIGN KEY (undergraduate_id) REFERENCES undergraduate(undergraduate_id),
                                     state VARCHAR(255) NOT NULL,
                                     modified_date DATE NOT NULL,
                                     PRIMARY KEY (undergraduate_id, modified_date)
);

CREATE TABLE postgraduate_state (
                                    postgraduate_id INT,
                                    FOREIGN KEY (postgraduate_id) REFERENCES postgraduate(postgraduate_id),
                                    state VARCHAR(255) NOT NULL,
                                    modified_date DATE NOT NULL,
                                    PRIMARY KEY (postgraduate_id, modified_date)
);

CREATE TABLE employee (
                          employee_id INT PRIMARY KEY AUTO_INCREMENT,
                          user_id INT NOT NULL,
                          FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE staff (
                       staff_id INT PRIMARY KEY AUTO_INCREMENT,
                       employee_id INT NOT NULL,
                       FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE staff_state (
                             staff_id INT,
                             FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
                             modified_date DATE NOT NULL,
                             state VARCHAR(255) NOT NULL,
                             admin_department VARCHAR(255) NOT NULL,
                             admin_position VARCHAR(255) NOT NULL,
                             PRIMARY KEY (staff_id, modified_date)
);

CREATE TABLE instructor (
                            instructor_id INT PRIMARY KEY AUTO_INCREMENT,
                            employee_id INT NOT NULL,
                            FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE assistant (
                           assistant_id INT PRIMARY KEY AUTO_INCREMENT,
                           instructor_id INT NOT NULL,
                           FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
);

CREATE TABLE professor (
                           professor_id INT PRIMARY KEY AUTO_INCREMENT,
                           instructor_id INT NOT NULL,
                           FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
);


CREATE TABLE department (
                            department_id INT PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(255) NOT NULL,
                            is_undergraduate BOOLEAN NOT NULL,
                            is_postgraduate BOOLEAN NOT NULL,
                            active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE professor_state (
                                 professor_id INT,
                                 FOREIGN KEY (professor_id) REFERENCES professor(professor_id),
                                 state VARCHAR(255) NOT NULL,
                                 modified_date DATE NOT NULL,
                                 room_id INT NOT NULL,
                                 FOREIGN KEY (room_id) REFERENCES room(room_id),
                                 department_id INT,
                                 FOREIGN KEY (department_id) REFERENCES department(department_id),
                                 PRIMARY KEY (professor_id, modified_date)
);

CREATE TABLE undergraduate_enroll (
                                      undergraduate_id INT NOT NULL,
                                      FOREIGN KEY (undergraduate_id) REFERENCES undergraduate(undergraduate_id),
                                      department_id INT NOT NULL,
                                      FOREIGN KEY (department_id) REFERENCES department(department_id),
                                      date DATE NOT NULL,
                                      major_type VARCHAR(255) NOT NULL,
                                      PRIMARY KEY (undergraduate_id, department_id, date)
);

CREATE TABLE postgraduate_enroll (
                                     postgraduate_id INT NOT NULL,
                                     FOREIGN KEY (postgraduate_id) REFERENCES postgraduate(postgraduate_id),
                                     department_id INT NOT NULL,
                                     FOREIGN KEY (department_id) REFERENCES department(department_id),
                                     date DATE NOT NULL,
                                     major_type VARCHAR(255) NOT NULL,
                                     PRIMARY KEY (postgraduate_id, department_id, date)
);

CREATE TABLE initial_fee (
                             department_id INT NOT NULL,
                             FOREIGN KEY (department_id) REFERENCES department(department_id),
                             year INT NOT NULL,
                             semester INT NOT NULL, # 1: 1학기, 2: 2학기, 3: 여름학기, 4: 겨울학기
                             admission_fee INT NOT NULL, # 입학금
                             tuition INT NOT NULL, # 수업료
                             student_fee INT NOT NULL, # 학생회비
                             extra_fee INT NOT NULL, # 기타납입금
                             PRIMARY KEY (department_id, year, semester)
);

CREATE TABLE course (
                        course_id INT PRIMARY KEY AUTO_INCREMENT,
                        department_id INT NOT NULL,
                        FOREIGN KEY (department_id) REFERENCES department(department_id),
                        name VARCHAR(255) NOT NULL,
                        credit INT NOT NULL
);

CREATE TABLE req_course (
                            course_id INT NOT NULL,
                            FOREIGN KEY (course_id) REFERENCES course(course_id),
                            department_id INT NOT NULL,
                            FOREIGN KEY (department_id) REFERENCES department(department_id),
                            modified_year INT NOT NULL,
                            PRIMARY KEY (course_id, department_id, modified_year)
);

CREATE TABLE pre_req_course (
                                course_id INT NOT NULL,
                                FOREIGN KEY (course_id) REFERENCES course(course_id),
                                pre_course_id INT NOT NULL,
                                FOREIGN KEY (pre_course_id) REFERENCES course(course_id),
                                PRIMARY KEY (course_id, pre_course_id)
);

CREATE TABLE class (
                       class_id INT PRIMARY KEY AUTO_INCREMENT,
                       course_id INT NOT NULL,
                       FOREIGN KEY (course_id) REFERENCES course(course_id),
                       year INT NOT NULL,
                       semester INT NOT NULL,
                       division INT NOT NULL,
                       capacity INT NOT NULL
);

CREATE TABLE take_class (
                            class_id INT NOT NULL,
                            FOREIGN KEY (class_id) REFERENCES class(class_id),
                            student_id INT NOT NULL,
                            FOREIGN KEY (student_id) REFERENCES student(student_id),
                            grade FLOAT NOT NULL, # 4.5 = A+, 4.0 = A, 3.5 = B+, 3.0 = B, 2.5 = C+, 2.0 = C, 1.5 = D+, 1.0 = D, 0.0 = F
                            PRIMARY KEY (class_id, student_id)
);

CREATE TABLE syllabus (
                          class_id INT primary key,
                          FOREIGN KEY (class_id) REFERENCES class(class_id),
                          content TEXT NOT NULL
);

CREATE TABLE instruct (
                          class_id INT NOT NULL,
                          FOREIGN KEY (class_id) REFERENCES class(class_id),
                          instructor_id INT NOT NULL,
                          FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id),
                          start_date DATE NOT NULL,
                          end_date DATE, # NULL if not ended
                          PRIMARY KEY (class_id, instructor_id)
);

CREATE TABLE class_time (
                            class_id INT NOT NULL,
                            FOREIGN KEY (class_id) REFERENCES class(class_id),
                            day INT NOT NULL, # 1: 일, 2: 월, 3: 화, 4: 수, 5: 목, 6: 금, 7: 토
                            start_time TIME NOT NULL,
                            end_time TIME NOT NULL,
                            room_id INT NOT NULL,
                            FOREIGN KEY (room_id) REFERENCES room(room_id),
                            PRIMARY KEY (class_id, day)
);

# board section

CREATE TABLE board (
                       board_id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(255) NOT NULL
);

CREATE TABLE auth_emp_board (
                                board_id INT NOT NULL,
                                FOREIGN KEY (board_id) REFERENCES board(board_id),
                                employee_id INT NOT NULL,
                                FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
                                PRIMARY KEY (board_id, employee_id)
);

CREATE TABLE post (
                      post_id INT PRIMARY KEY AUTO_INCREMENT,
                      board_id INT NOT NULL,
                      FOREIGN KEY (board_id) REFERENCES board(board_id),
                      writer_id INT NOT NULL,
                      FOREIGN KEY (writer_id) REFERENCES employee(employee_id),
                      title VARCHAR(255) NOT NULL,
                      content TEXT NOT NULL,
                      created_date DATE NOT NULL,
                      modified_date DATE NOT NULL,
                      attachment_path VARCHAR(255),
                      view_count INT NOT NULL
);

CREATE TABLE notice_post (
                             post_id INT NOT NULL,
                             FOREIGN KEY (post_id) REFERENCES post(post_id),
                             due_date DATE NOT NULL,
                             PRIMARY KEY (post_id)
);

CREATE TABLE archive_post (
                              post_id INT NOT NULL,
                              FOREIGN KEY (post_id) REFERENCES post(post_id),
                              PRIMARY KEY (post_id)
);

# tuition section

CREATE TABLE pay (
                     student_id INT NOT NULL,
                     FOREIGN KEY (student_id) REFERENCES student(student_id),
                     date DATE NOT NULL,
                     year INT NOT NULL,
                     semester INT NOT NULL,
                     admission_fee INT NOT NULL,
                     tuition INT NOT NULL,
                     student_fee INT NOT NULL,
                     extra_fee INT NOT NULL,
                     PRIMARY KEY (student_id, date)
);

CREATE TABLE scholarship (
                             student_id INT NOT NULL,
                             FOREIGN KEY (student_id) REFERENCES student(student_id),
                             scholarship_type VARCHAR(255) NOT NULL,
                             date DATE NOT NULL,
                             year INT NOT NULL,
                             semester INT NOT NULL,
                             amount INT NOT NULL,
                             PRIMARY KEY (student_id, scholarship_type, date)
);




DROP TRIGGER IF EXISTS update_active_undergraduate;

DELIMITER $$
CREATE TRIGGER update_active_undergraduate
    AFTER INSERT ON undergraduate_state
    FOR EACH ROW
BEGIN
    IF NEW.state = '졸업' OR NEW.state = '자퇴' THEN
        UPDATE user
        SET user.active = FALSE
        WHERE user.user_id = (
            SELECT student.user_id
            FROM student JOIN undergraduate ON student.student_id = undergraduate.student_id
            WHERE undergraduate.undergraduate_id = NEW.undergraduate_id);
    ELSEIF NEW.state = '재학' THEN
        UPDATE user
        SET user.active = TRUE
        WHERE user.user_id = (
            SELECT student.user_id
            FROM student JOIN undergraduate ON student.student_id = undergraduate.student_id
            WHERE undergraduate.undergraduate_id = NEW.undergraduate_id);
    END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS update_active_postgraduate;

DELIMITER $$
CREATE TRIGGER update_active_postgraduate
    AFTER INSERT ON postgraduate_state
    FOR EACH ROW
BEGIN
    IF NEW.state = '졸업' OR NEW.state = '자퇴' THEN
        UPDATE user
        SET user.active = FALSE
        WHERE user.user_id = (
            SELECT student.user_id
            FROM student JOIN postgraduate ON student.student_id = postgraduate.student_id
            WHERE postgraduate.postgraduate_id = NEW.postgraduate_id);
    ELSEIF NEW.state = '재학' THEN
        UPDATE user
        SET user.active = TRUE
        WHERE user.user_id = (
            SELECT student.user_id
            FROM student JOIN postgraduate ON student.student_id = postgraduate.student_id
            WHERE postgraduate.postgraduate_id = NEW.postgraduate_id);
    END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS update_active_professor;

DELIMITER $$
CREATE TRIGGER update_active_professor
    AFTER INSERT ON professor_state
    FOR EACH ROW
BEGIN
    IF NEW.state = '퇴직' THEN
        UPDATE user
        SET user.active = FALSE
        WHERE user.user_id = (
            SELECT employee.user_id
            FROM employee JOIN instructor ON employee.employee_id = instructor.employee_id
                          JOIN professor ON instructor.instructor_id = professor.instructor_id
            WHERE professor.professor_id = NEW.professor_id);
    ELSEIF NEW.state = '재직' THEN
        UPDATE user
        SET user.active = TRUE
        WHERE user.user_id = (
            SELECT employee.user_id
            FROM employee JOIN instructor ON employee.employee_id = instructor.employee_id
                          JOIN professor ON instructor.instructor_id = professor.instructor_id
            WHERE professor.professor_id = NEW.professor_id);
    END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS update_active_staff;

DELIMITER $$
CREATE TRIGGER update_active_staff
    AFTER INSERT ON staff_state
    FOR EACH ROW
BEGIN
    IF NEW.state = '퇴직' THEN
        UPDATE user
        SET user.active = FALSE
        WHERE user.user_id = (
            SELECT employee.user_id
            FROM employee
                     JOIN staff ON employee.employee_id = staff.employee_id
            WHERE staff.staff_id = NEW.staff_id);
    ELSEIF NEW.state = '재직' THEN
        UPDATE user
        SET user.active = TRUE
        WHERE user.user_id = (
            SELECT employee.user_id
            FROM employee
                     JOIN staff ON employee.employee_id = staff.employee_id
            WHERE staff.staff_id = NEW.staff_id);
    END IF;
END $$
DELIMITER ;




## Get id from user_id

DROP FUNCTION IF EXISTS get_student_id;

DELIMITER $$
CREATE FUNCTION get_student_id (p_user_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT student_id
        FROM student
        WHERE user_id = p_user_id
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_undergraduate_id;

DELIMITER $$
CREATE FUNCTION get_undergraduate_id (p_user_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT undergraduate_id
        FROM undergraduate
        WHERE student_id = get_student_id(p_user_id)
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_postgraduate_id;

DELIMITER $$
CREATE FUNCTION get_postgraduate_id (p_user_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT postgraduate_id
        FROM postgraduate
        WHERE student_id = get_student_id(p_user_id)
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_employee_id;

DELIMITER $$
CREATE FUNCTION get_employee_id (p_user_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT employee_id
        FROM employee
        WHERE user_id = p_user_id
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_instructor_id;

DELIMITER $$
CREATE FUNCTION get_instructor_id (p_user_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT instructor_id
        FROM instructor
        WHERE employee_id = get_employee_id(p_user_id)
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_assistant_id;

DELIMITER $$
CREATE FUNCTION get_assistant_id (p_user_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT assistant_id
        FROM assistant
        WHERE instructor_id = get_instructor_id(p_user_id)
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_professor_id;

DELIMITER $$
CREATE FUNCTION get_professor_id (p_user_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT professor_id
        FROM professor
        WHERE instructor_id = get_instructor_id(p_user_id)
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_staff_id;

DELIMITER $$
CREATE FUNCTION get_staff_id (p_user_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT staff_id
        FROM staff
        WHERE employee_id = get_employee_id(p_user_id)
    );
END $$
DELIMITER ;


## Get user_id from id

DROP FUNCTION IF EXISTS get_user_id_from_student_id;

DELIMITER $$
CREATE FUNCTION get_user_id_from_student_id (p_student_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT user_id
        FROM student
        WHERE student_id = p_student_id
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_user_id_from_undergraduate_id;

DELIMITER $$
CREATE FUNCTION get_user_id_from_undergraduate_id (p_undergraduate_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT user_id
        FROM student JOIN undergraduate ON student.student_id = undergraduate.student_id
        WHERE undergraduate.undergraduate_id = p_undergraduate_id
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_user_id_from_postgraduate_id;

DELIMITER $$
CREATE FUNCTION get_user_id_from_postgraduate_id (p_postgraduate_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT user_id
        FROM student JOIN postgraduate ON student.student_id = postgraduate.student_id
        WHERE postgraduate.postgraduate_id = p_postgraduate_id
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_user_id_from_employee_id;

DELIMITER $$
CREATE FUNCTION get_user_id_from_employee_id (p_employee_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT user_id
        FROM employee
        WHERE employee_id = p_employee_id
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_user_id_from_instructor_id;

DELIMITER $$
CREATE FUNCTION get_user_id_from_instructor_id (p_instructor_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT user_id
        FROM employee JOIN instructor ON employee.employee_id = instructor.employee_id
        WHERE instructor.instructor_id = p_instructor_id
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_user_id_from_assistant_id;

DELIMITER $$
CREATE FUNCTION get_user_id_from_assistant_id (p_assistant_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT user_id
        FROM employee JOIN instructor ON employee.employee_id = instructor.employee_id
                      JOIN assistant ON instructor.instructor_id = assistant.instructor_id
        WHERE assistant.assistant_id = p_assistant_id
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_user_id_from_professor_id;

DELIMITER $$
CREATE FUNCTION get_user_id_from_professor_id (p_professor_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT user_id
        FROM employee JOIN instructor ON employee.employee_id = instructor.employee_id
                      JOIN professor ON instructor.instructor_id = professor.instructor_id
        WHERE professor.professor_id = p_professor_id
    );
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS get_user_id_from_staff_id;

DELIMITER $$
CREATE FUNCTION get_user_id_from_staff_id (p_staff_id INT) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT user_id
        FROM employee JOIN staff ON employee.employee_id = staff.employee_id
        WHERE staff.staff_id = p_staff_id
    );
END $$
DELIMITER ;


## Get department_id from department's name
DROP FUNCTION IF EXISTS get_department_id;

DELIMITER $$
CREATE FUNCTION get_department_id (p_department_name VARCHAR(255)) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT department_id
        FROM department d
        WHERE d.name = p_department_name
    );
END $$
DELIMITER ;


## Get course_id from course's name
DROP FUNCTION IF EXISTS get_course_id;

DELIMITER $$
CREATE FUNCTION get_course_id (p_course_name VARCHAR(255)) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (
        SELECT course_id
        FROM course c
        WHERE c.name = p_course_name
    );
END $$
DELIMITER ;




DROP PROCEDURE IF EXISTS insert_user_with_id;

DELIMITER $$

CREATE PROCEDURE insert_user_with_id (
    IN
        p_user_id INT,
    p_kor_name VARCHAR(255),
    p_eng_name VARCHAR(255),
    p_birthdate DATE,
    p_address VARCHAR(255),
    p_phone_num VARCHAR(255),
    p_account_num VARCHAR(255),
    p_email VARCHAR(255),
    is_undergraduate BOOLEAN,
    is_postgraduate BOOLEAN,
    is_assistant BOOLEAN,
    is_professor BOOLEAN,
    is_staff BOOLEAN
) BEGIN
    INSERT INTO user (
        user_id,
        kor_name,
        eng_name,
        birthdate,
        address,
        phone_num,
        account_num,
        email,
        active
    ) VALUES (
                 p_user_id,
                 p_kor_name,
                 p_eng_name,
                 p_birthdate,
                 p_address,
                 p_phone_num,
                 p_account_num,
                 p_email,
                 TRUE
             );

    IF is_undergraduate OR is_postgraduate THEN
        INSERT INTO student (user_id) SELECT user_id FROM user WHERE user_id = p_user_id;
    END IF;
    IF is_assistant OR is_professor OR is_staff THEN
        INSERT INTO employee (user_id) SELECT user_id FROM user u WHERE u.user_id = p_user_id;
    END IF;
    IF is_undergraduate THEN
        INSERT INTO undergraduate (student_id) SELECT student_id from student WHERE user_id = p_user_id;
    END IF;
    IF is_postgraduate THEN
        INSERT INTO postgraduate (student_id) SELECT student_id from student WHERE user_id = p_user_id;
    END IF;
    IF is_assistant OR is_professor THEN
        INSERT INTO instructor (employee_id) SELECT employee_id from employee WHERE user_id = p_user_id;
    ELSEIF is_staff THEN
        INSERT INTO staff (employee_id) SELECT employee_id from employee WHERE user_id = p_user_id;
    END IF;
    IF is_assistant THEN
        INSERT INTO assistant (instructor_id)
        SELECT instructor_id FROM instructor i JOIN employee e ON i.employee_id = e.employee_id
        WHERE user_id = p_user_id;
    ELSEIF is_professor THEN
        INSERT INTO professor (instructor_id)
        SELECT instructor_id FROM instructor i JOIN employee e ON i.employee_id = e.employee_id
        WHERE user_id = p_user_id;
    END IF;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS insert_user;

DELIMITER $$
CREATE PROCEDURE insert_user (
    IN
        p_kor_name VARCHAR(255),
    p_eng_name VARCHAR(255),
    p_birthdate DATE,
    p_address VARCHAR(255),
    p_phone_num VARCHAR(255),
    p_account_num VARCHAR(255),
    p_email VARCHAR(255),
    is_undergraduate BOOLEAN,
    is_postgraduate BOOLEAN,
    is_assistant BOOLEAN,
    is_professor BOOLEAN,
    is_staff BOOLEAN
) BEGIN
    INSERT INTO user (
        kor_name,
        eng_name,
        birthdate,
        address,
        phone_num,
        account_num,
        email,
        active
    ) VALUES (
                 p_kor_name,
                 p_eng_name,
                 p_birthdate,
                 p_address,
                 p_phone_num,
                 p_account_num,
                 p_email,
                 TRUE
             );

    SET @p_user_id = LAST_INSERT_ID();

    IF is_undergraduate OR is_postgraduate THEN
        INSERT INTO student (user_id) SELECT user_id FROM user WHERE user_id = @p_user_id;
    END IF;
    IF is_assistant OR is_professor OR is_staff THEN
        INSERT INTO employee (user_id) SELECT user_id FROM user u WHERE u.user_id = @p_user_id;
    END IF;
    IF is_undergraduate THEN
        INSERT INTO undergraduate (student_id) SELECT student_id from student WHERE user_id = @p_user_id;
    END IF;
    IF is_postgraduate THEN
        INSERT INTO postgraduate (student_id) SELECT student_id from student WHERE user_id = @p_user_id;
    END IF;
    IF is_assistant OR is_professor THEN
        INSERT INTO instructor (employee_id) SELECT employee_id from employee WHERE user_id = @p_user_id;
    ELSEIF is_staff THEN
        INSERT INTO staff (employee_id) SELECT employee_id from employee WHERE user_id = @p_user_id;
    END IF;
    IF is_assistant THEN
        INSERT INTO assistant (instructor_id)
        SELECT instructor_id FROM instructor i JOIN employee e ON i.employee_id = e.employee_id
        WHERE user_id = @p_user_id;
    ELSEIF is_professor THEN
        INSERT INTO professor (instructor_id)
        SELECT instructor_id FROM instructor i JOIN employee e ON i.employee_id = e.employee_id
        WHERE user_id = @p_user_id;
    END IF;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS insert_pre_req_course;

DELIMITER $$
CREATE PROCEDURE insert_pre_req_course (
    IN
        p_course_id INT,
    p_pre_req_course_id INT
) BEGIN
    INSERT INTO pre_req_course (course_id, pre_course_id) VALUES (p_course_id, p_pre_req_course_id);
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS insert_department;

DELIMITER $$
CREATE PROCEDURE insert_department (
    IN
        p_name VARCHAR(255),
    p_is_undergraduate BOOLEAN,
    p_is_postgraduate BOOLEAN
) BEGIN
    INSERT INTO department (name, is_undergraduate, is_postgraduate, active)
    VALUES (p_name, p_is_undergraduate, p_is_postgraduate, TRUE);
END$$
DELIMITER ;


###### insert section

# insert building data
INSERT INTO building (name, building_num)
VALUES
    ('영신관', '101'),
    ('약학대학 및 R&D 센터', '102'),
    ('파이퍼홀', '103'),
    ('수림과학관', '104'),
    ('제1의학관', '105'),
    ('제2의학관', '106'),
    ('학생회관', '107'),
    ('산학협력관 및 캠퍼스타운 거점센터', '108'),
    ('본관', '201'),
    ('전산정보관', '202'),
    ('서라벌홀', '203'),
    ('중앙도서관', '204'),
    ('봅스트홀', '207'),
    ('제2공학관', '208'),
    ('창업보육관', '209'),
    ('중앙문화예술관', '301'),
    ('대학원', '302'),
    ('법학관', '303'),
    ('미디어공연영상관', '304'),
    ('교수연구동 및 체육관', '305'),
    ('글로벌 하우스', '307'),
    ('블루미르홀', '308'),
    ('블루미르홀', '309'),
    ('중앙대학교 100주년기념관', '310'),
    ('중앙대학교병원 중앙관', 'A'),
    ('중앙대학교병원 다정관', 'A-1'),
    ('중앙대학교병원 주차타워', 'A-2'),
    ('퓨처하우스', 'B'),
    ('중앙대학교사범대학부속중학교', 'C'),
    ('중앙대학교사범대학부속초등학교', 'D'),
    ('중앙대학교사범대학부속유치원', 'F'),
    ('중앙대학교사범대학부속고등학교', 'L');

# insert room data
INSERT INTO room (building_id, room_num, capacity)
VALUES
    ((SELECT building_id FROM building WHERE building_num = '101'), '101', 40),
    ((SELECT building_id FROM building WHERE building_num = '101'), '102', 50),
    ((SELECT building_id FROM building WHERE building_num = '101'), '103', 60),
    ((SELECT building_id FROM building WHERE building_num = '101'), '104', 70),

    ((SELECT building_id FROM building WHERE building_num = '102'), '201', 40),
    ((SELECT building_id FROM building WHERE building_num = '102'), '202', 50),
    ((SELECT building_id FROM building WHERE building_num = '102'), '203', 60),
    ((SELECT building_id FROM building WHERE building_num = '102'), '204', 70),

    ((SELECT building_id FROM building WHERE building_num = '103'), '301', 40),
    ((SELECT building_id FROM building WHERE building_num = '103'), '302', 50),
    ((SELECT building_id FROM building WHERE building_num = '103'), '303', 60),
    ((SELECT building_id FROM building WHERE building_num = '103'), '304', 70),

    ((SELECT building_id FROM building WHERE building_num = '104'), '401', 40),
    ((SELECT building_id FROM building WHERE building_num = '104'), '402', 50),
    ((SELECT building_id FROM building WHERE building_num = '104'), '403', 60),
    ((SELECT building_id FROM building WHERE building_num = '104'), '404', 70),

    ((SELECT building_id FROM building WHERE building_num = '105'), '501', 40),
    ((SELECT building_id FROM building WHERE building_num = '105'), '502', 50),
    ((SELECT building_id FROM building WHERE building_num = '105'), '503', 60),
    ((SELECT building_id FROM building WHERE building_num = '105'), '504', 70),

    ((SELECT building_id FROM building WHERE building_num = '106'), '601', 40),
    ((SELECT building_id FROM building WHERE building_num = '106'), '602', 50),
    ((SELECT building_id FROM building WHERE building_num = '106'), '603', 60),
    ((SELECT building_id FROM building WHERE building_num = '106'), '604', 70),

    ((SELECT building_id FROM building WHERE building_num = '107'), '701', 40),
    ((SELECT building_id FROM building WHERE building_num = '107'), '702', 50),
    ((SELECT building_id FROM building WHERE building_num = '107'), '703', 60),
    ((SELECT building_id FROM building WHERE building_num = '107'), '704', 70),

    ((SELECT building_id FROM building WHERE building_num = '108'), '801', 40),
    ((SELECT building_id FROM building WHERE building_num = '108'), '802', 50),
    ((SELECT building_id FROM building WHERE building_num = '108'), '803', 60),
    ((SELECT building_id FROM building WHERE building_num = '108'), '804', 70),

    ((SELECT building_id FROM building WHERE building_num = '201'), '101', 40),
    ((SELECT building_id FROM building WHERE building_num = '201'), '102', 50),
    ((SELECT building_id FROM building WHERE building_num = '201'), '103', 60),
    ((SELECT building_id FROM building WHERE building_num = '201'), '104', 70),

    ((SELECT building_id FROM building WHERE building_num = '202'), '201', 40),
    ((SELECT building_id FROM building WHERE building_num = '202'), '202', 50),
    ((SELECT building_id FROM building WHERE building_num = '202'), '203', 60),
    ((SELECT building_id FROM building WHERE building_num = '202'), '204', 70),

    ((SELECT building_id FROM building WHERE building_num = '203'), '301', 40),
    ((SELECT building_id FROM building WHERE building_num = '203'), '302', 50),
    ((SELECT building_id FROM building WHERE building_num = '203'), '303', 60),
    ((SELECT building_id FROM building WHERE building_num = '203'), '304', 70),

    ((SELECT building_id FROM building WHERE building_num = '204'), '401', 40),
    ((SELECT building_id FROM building WHERE building_num = '204'), '402', 50),
    ((SELECT building_id FROM building WHERE building_num = '204'), '403', 60),
    ((SELECT building_id FROM building WHERE building_num = '204'), '404', 70),

    ((SELECT building_id FROM building WHERE building_num = '207'), '501', 40),
    ((SELECT building_id FROM building WHERE building_num = '207'), '502', 50),
    ((SELECT building_id FROM building WHERE building_num = '207'), '503', 60),
    ((SELECT building_id FROM building WHERE building_num = '207'), '504', 70),

    ((SELECT building_id FROM building WHERE building_num = '208'), '601', 40),
    ((SELECT building_id FROM building WHERE building_num = '208'), '602', 50),
    ((SELECT building_id FROM building WHERE building_num = '208'), '603', 60),
    ((SELECT building_id FROM building WHERE building_num = '208'), '604', 70),

    ((SELECT building_id FROM building WHERE building_num = '209'), '701', 40),
    ((SELECT building_id FROM building WHERE building_num = '209'), '702', 50),
    ((SELECT building_id FROM building WHERE building_num = '209'), '703', 60),
    ((SELECT building_id FROM building WHERE building_num = '209'), '704', 70),

    ((SELECT building_id FROM building WHERE building_num = '301'), '101', 40),
    ((SELECT building_id FROM building WHERE building_num = '301'), '102', 50),
    ((SELECT building_id FROM building WHERE building_num = '301'), '103', 60),
    ((SELECT building_id FROM building WHERE building_num = '301'), '104', 70),

    ((SELECT building_id FROM building WHERE building_num = '302'), '201', 40),
    ((SELECT building_id FROM building WHERE building_num = '302'), '202', 50),
    ((SELECT building_id FROM building WHERE building_num = '302'), '203', 60),
    ((SELECT building_id FROM building WHERE building_num = '302'), '204', 70),

    ((SELECT building_id FROM building WHERE building_num = '303'), '301', 40),
    ((SELECT building_id FROM building WHERE building_num = '303'), '302', 50),
    ((SELECT building_id FROM building WHERE building_num = '303'), '303', 60),
    ((SELECT building_id FROM building WHERE building_num = '303'), '304', 70),

    ((SELECT building_id FROM building WHERE building_num = '304'), '401', 40),
    ((SELECT building_id FROM building WHERE building_num = '304'), '402', 50),
    ((SELECT building_id FROM building WHERE building_num = '304'), '403', 60),
    ((SELECT building_id FROM building WHERE building_num = '304'), '404', 70),

    ((SELECT building_id FROM building WHERE building_num = '305'), '501', 40),
    ((SELECT building_id FROM building WHERE building_num = '305'), '502', 50),
    ((SELECT building_id FROM building WHERE building_num = '305'), '503', 60),
    ((SELECT building_id FROM building WHERE building_num = '305'), '504', 70),

    ((SELECT building_id FROM building WHERE building_num = '307'), '601', 40),
    ((SELECT building_id FROM building WHERE building_num = '307'), '602', 50),
    ((SELECT building_id FROM building WHERE building_num = '307'), '603', 60),
    ((SELECT building_id FROM building WHERE building_num = '307'), '604', 70),

    ((SELECT building_id FROM building WHERE building_num = '308'), '701', 40),
    ((SELECT building_id FROM building WHERE building_num = '308'), '702', 50),
    ((SELECT building_id FROM building WHERE building_num = '308'), '703', 60),
    ((SELECT building_id FROM building WHERE building_num = '308'), '704', 70),

    ((SELECT building_id FROM building WHERE building_num = '309'), '801', 40),
    ((SELECT building_id FROM building WHERE building_num = '309'), '802', 50),
    ((SELECT building_id FROM building WHERE building_num = '309'), '803', 60),
    ((SELECT building_id FROM building WHERE building_num = '309'), '804', 70),

    ((SELECT building_id FROM building WHERE building_num = '310'), '101', 40),
    ((SELECT building_id FROM building WHERE building_num = '310'), '102', 50),
    ((SELECT building_id FROM building WHERE building_num = '310'), '103', 60),
    ((SELECT building_id FROM building WHERE building_num = '310'), '104', 70),

    ((SELECT building_id FROM building WHERE building_num = 'A'), '101', 40),
    ((SELECT building_id FROM building WHERE building_num = 'A'), '102', 50),
    ((SELECT building_id FROM building WHERE building_num = 'A'), '103', 60),
    ((SELECT building_id FROM building WHERE building_num = 'A'), '104', 70),

    ((SELECT building_id FROM building WHERE building_num = 'A-1'), '201', 40),
    ((SELECT building_id FROM building WHERE building_num = 'A-1'), '202', 50),
    ((SELECT building_id FROM building WHERE building_num = 'A-1'), '203', 60),
    ((SELECT building_id FROM building WHERE building_num = 'A-1'), '204', 70),

    ((SELECT building_id FROM building WHERE building_num = 'A-2'), '301', 40),
    ((SELECT building_id FROM building WHERE building_num = 'A-2'), '302', 50),
    ((SELECT building_id FROM building WHERE building_num = 'A-2'), '303', 60),
    ((SELECT building_id FROM building WHERE building_num = 'A-2'), '304', 70),

    ((SELECT building_id FROM building WHERE building_num = 'B'), '401', 40),
    ((SELECT building_id FROM building WHERE building_num = 'B'), '402', 50),
    ((SELECT building_id FROM building WHERE building_num = 'B'), '403', 60),
    ((SELECT building_id FROM building WHERE building_num = 'B'), '404', 70),

    ((SELECT building_id FROM building WHERE building_num = 'C'), '501', 40),
    ((SELECT building_id FROM building WHERE building_num = 'C'), '502', 50),
    ((SELECT building_id FROM building WHERE building_num = 'C'), '503', 60),
    ((SELECT building_id FROM building WHERE building_num = 'C'), '504', 70),

    ((SELECT building_id FROM building WHERE building_num = 'D'), '601', 40),
    ((SELECT building_id FROM building WHERE building_num = 'D'), '602', 50),
    ((SELECT building_id FROM building WHERE building_num = 'D'), '603', 60),
    ((SELECT building_id FROM building WHERE building_num = 'D'), '604', 70),

    ((SELECT building_id FROM building WHERE building_num = 'F'), '701', 40),
    ((SELECT building_id FROM building WHERE building_num = 'F'), '702', 50),
    ((SELECT building_id FROM building WHERE building_num = 'F'), '703', 60),
    ((SELECT building_id FROM building WHERE building_num = 'F'), '704', 70),

    ((SELECT building_id FROM building WHERE building_num = 'L'), '801', 40),
    ((SELECT building_id FROM building WHERE building_num = 'L'), '802', 50),
    ((SELECT building_id FROM building WHERE building_num = 'L'), '803', 60),
    ((SELECT building_id FROM building WHERE building_num = 'L'), '804', 70);

# INSERT dummy user data


# undergraduate
CALL insert_user_with_id(1, '김태현', 'Kim Tae Hyun', '1998-08-23', '강원도 춘천시', '010-2015-7768', '1234-5678-9012', 'kimth0734@gmail.com',
                         TRUE, FALSE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(2, '최다빈', 'Choi Da Bin', '1999-01-01', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'cdb9901@gmail.com',
                         TRUE, FALSE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(3, '이승규', 'Lee Seung Gyu', '1998-12-31', '서울특별시 도봉구', '010-7847-2321', '78905-1351-01', 'lsg8734@gmail.com',
                         TRUE, FALSE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(4, '전현석', 'Jeon Hyun Seok', '1998-11-11', '서울특별시 강서구', '010-1345-2341', '1234-5678-9012', 'jhs26@gmail.com',
                         TRUE, FALSE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(5, '이혁준', 'Lee Hyuk Jun', '1998-10-10', '서울특별시 강동구', '010-1234-5678', '1234-5678-9012', 'lhj7812@gmail.com',
                         TRUE, FALSE, FALSE, FALSE, FALSE);
# postgraduate
CALL insert_user_with_id(6, '송하나', 'Song Ha Na', '1998-09-09', '서울특별시 강북구', '010-9761-2341', '3879-48-125-245', 'shn0990@naver.com',
                         FALSE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(7, '이상혁', 'Lee Sang Hyuk', '1996-05-07', '서울특별시 강서구', '010-7777-7777', '123567-6962-24692', 'lsh773@gmail.com',
                         FALSE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(8, '리위안하오', 'Li Weianhao', '1998-01-28', '허난성 핑딩산시 루저우시', '010-2641-6373', '097347-88853-12', 'lwhao@gmail.com',
                         FALSE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(9, '이현우', 'Lee Hyun Woo', '1988-11-09', '경기도 성남시', '010-3763-2341', '784338-1234-5678', 'lhw8732@hanmail.net',
                         FALSE, TRUE, TRUE, FALSE, FALSE);  # also assistant
CALL insert_user_with_id(10, '손흥민', 'Son Heung Min', '1992-07-08', '강원도 춘천시 후평동', '010-1315-5448', '15415-456121-83', 'shm83765@gmail.com',
                         FALSE, TRUE, TRUE, FALSE, FALSE);  # also assistant
# undergraduate & postgraduate
CALL insert_user_with_id(11, '이수빈', 'Lee Su Bin', '1998-01-01', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'lsb837@gmail.com',
                         TRUE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(12, '페리시치', 'Perisic Ivan', '1989-02-02', '크로아티아 자그레브', '010-6873-2341', '4892-2421-8432', 'kje2234@gmail.com',
                         TRUE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(13, '이승우', 'Lee Seung Woo', '1998-03-03', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'lsw9283@naver.com',
                         TRUE, TRUE, FALSE, FALSE, FALSE);
CALL insert_user_with_id(14, '전종서', 'Jeon Jong Seo', '1998-04-04', '충청북도 청주시', '010-6873-7682', '67267-789138-12', 'europe23u@gmail.com',
                         TRUE, TRUE, TRUE, FALSE, FALSE);  # also assistant
CALL insert_user_with_id(15, '이민지', 'Lee Min Ji', '1996-12-31', '전라북도 전주시', '010-6873-2341', '4892-2421-8432', 'jke78@cau.ac.kr',
                         TRUE, TRUE, TRUE, FALSE, FALSE);  # also assistant
# professor
CALL insert_user_with_id(16, '김현수', 'Kim Hyun Soo', '1970-01-01', '서울특별시 강남구', '010-6792-2341', '1234-5678-9012', 'khs673@cau.ac.kr',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user_with_id(17, '김수현', 'Kim Su Hyun', '1967-02-02', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'kyre874@cau.ac.kr',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user_with_id(18, '엘링 홀란', 'Erling HollAND', '1965-03-03', '노르웨이 오슬로', '010-8738-9872', '7823823-13948-32', 'hollAND@gamil.com',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user_with_id(19, '이승우', 'Lee Seung Woo', '1963-04-04', '인천광역시 부평구', '010-2768-3221', '89348-1398647-232', 'ejhii@cau.ac.kr',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user_with_id(20, '이민지', 'Lee Min Ji', '1961-05-05', '서울특별시 강남구', '010-6873-7887', '78237-28731-781', 'wkje@gmail.com',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user_with_id(21, '김현수', 'Kim Hyun Soo', '1976-08-23', '서울특별시 강남구', '010-9998-7768', '1234-5678-2983', 'iiwj@gmail.com',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user_with_id(22, '김하나', 'Kim Ha Na', '1979-09-01', '서울특별시 노원구', '010-7878-9823', '4892-2421-8432', 'khn07834@naver.com',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user_with_id(23, '박스태프', 'Park Staph', '1978-12-31', '서울특별시 용산구', '010-7847-2321', '78905-1351-01', 'yong98@gmail.com',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user_with_id(24, '이현운', 'Lee Hyun Woon', '1977-11-11', '경기도 성남시', '010-1345-2341', '1234-5678-9012', 'lhwoooo@naver.com',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
CALL insert_user_with_id(25, '최민재', 'Choi Min Jae', '1975-10-10', '서울특별시 강남구', '010-8792-7823', '97624-231-512', 'cmjiiiii@hanmail.net',
                         FALSE, FALSE, FALSE, TRUE, FALSE);
# assistant
CALL insert_user_with_id(26, '김현수', 'Kim Hyun Soo', '1997-09-18', '서울특별시 서초구', '010-8721-0987', '8734201-3184-12', 'khs9923@gmail.com',
                         FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user_with_id(27, '김수민', 'Kim Su Min', '1996-08-17', '서울특별시 동작구', '010-7728-8723', '76763-00912-982', 'kimsm96@naver.com',
                         FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user_with_id(28, '최태성', 'Choi Tae Sung', '1995-07-16', '경기도 남양주시 진접읍', '010-0923-9982', '4892-878723-8432', 'choi2938@cau.ac.kr',
                         FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user_with_id(29, '최흥민', 'Choi Heung Min', '1998-06-15', '강원도 강릉시 강동면', '010-0029-8778', '772398-87143-03', 'choihe9823@cau.ac.kr',
                         FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user_with_id(30, '사나', 'Sana', '1996-05-14', '경기도 성남시 분당구', '010-9831-0012', '87872-0012-123', 'sana3232@gmail.com',
                         FALSE, FALSE, TRUE, FALSE, FALSE);
CALL insert_user_with_id(31, '김우현', 'Kim Woo Hyun', '1995-04-13', '경기도 의정부시 신곡동', '010-6623-9872', '98231-8787210-02', 'kimwh9823@cau.ac.kr',
                         FALSE, FALSE, TRUE, FALSE, FALSE);
# staff
CALL insert_user_with_id(32, '이현주', 'Lee Hyun Joo', '1980-09-18', '서울특별시 서초구', '010-8721-0987', '8734201-3184-12', 'dkj07238@gmail.com',
                         FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user_with_id(33, '이수진', 'Lee Su Jin', '1981-08-17', '서울특별시 동작구', '010-7728-9817', '76763-8712-123', 'llei00782@naver.com',
                         FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user_with_id(34, '이민지', 'Lee Min Ji', '1982-07-16', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'leemj82@naver.com',
                         FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user_with_id(35, '이승우', 'Lee Seung Woo', '1983-06-15', '서울특별시 강남구', '010-0029-8778', '772398-87143-03', 'lsu772@gmail.com',
                         FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user_with_id(36, '김철수', 'Kim Chul Soo', '1984-05-14', '경기도 성남시 분당구', '010-9831-0012', '87872-0012-123', 'KimCh@gmail.com',
                         FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user_with_id(37, '최민수', 'Choi Min Soo', '1985-04-13', '경기도 의정부시 신곡동', '010-6623-1234', '98231-9872-123', 'uuue2323@naver.com',
                         FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user_with_id(38, '김스테프' , 'Kim Staph', '1986-03-12', '인천광역시 부평구', '010-8882-1347', '98231-0238-319874', 'kimstaff@naver.com',
                         FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user_with_id(39, '이현우', 'Lee Hyun Woo', '1987-02-11', '서울특별시 강남구', '010-6873-2341', '4892-2421-8432', 'lee_hw0923@naver.com',
                         FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user_with_id(40, '이민지', 'Lee Min Ji', '1988-01-10', '서울특별시 강북구', '010-9823-2341', '4892-2421-7623', 'lmj8723@hanmail.net',
                         FALSE, FALSE, FALSE, FALSE, TRUE);
CALL insert_user_with_id(41, '이승우', 'Lee Seung Woo', '1989-12-31', '인천광역시 부평구', '010-8823-7823', '9727578-2873-9832', 'lsw0734@gmail.com',
                         FALSE, FALSE, FALSE, FALSE, TRUE);

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

# INSERT dummy professor's states using with user_id
INSERT INTO professor_state (professor_id, state, modified_date, room_id)
SELECT p.professor_id, '재직', '2009-03-02',
       (SELECT room_id
        FROM room
                 JOIN building ON room.building_id = building.building_id
        WHERE building_num = '310' ORDER BY rand() LIMIT 1)
FROM professor p
         JOIN instructor i ON p.instructor_id = i.instructor_id
         JOIN employee e ON i.employee_id = e.employee_id
WHERE e.user_id BETWEEN 16 AND 17;

INSERT INTO professor_state (professor_id, state, modified_date, room_id)
SELECT p.professor_id, '재직', '2010-03-02',
       (SELECT room_id
        FROM room
                 JOIN building ON room.building_id = building.building_id
        WHERE building_num = '203' ORDER BY rand() LIMIT 1)
FROM professor p
         JOIN instructor i ON p.instructor_id = i.instructor_id
         JOIN employee e ON i.employee_id = e.employee_id
WHERE e.user_id BETWEEN 18 AND 20;

INSERT INTO professor_state (professor_id, state, modified_date, room_id)
SELECT p.professor_id, '재직', '2011-03-02',
       (SELECT room_id
        FROM room
                 JOIN building ON room.building_id = building.building_id
        WHERE building_num = '303' ORDER BY rand() LIMIT 1)
FROM professor p
         JOIN instructor i ON p.instructor_id = i.instructor_id
         JOIN employee e ON i.employee_id = e.employee_id
WHERE e.user_id BETWEEN 21 AND 23;

INSERT INTO professor_state (professor_id, state, modified_date, room_id)
SELECT p.professor_id, '재직', '2012-03-02',
       (SELECT room_id
        FROM room
                 JOIN building ON room.building_id = building.building_id
        WHERE building_num = '302' ORDER BY rand() LIMIT 1)
FROM professor p
         JOIN instructor i ON p.instructor_id = i.instructor_id
         JOIN employee e ON i.employee_id = e.employee_id
WHERE e.user_id BETWEEN 24 AND 25;

INSERT INTO professor_state (professor_id, state, modified_date, room_id)
SELECT p.professor_id, '휴직', '2013-03-02',
       (SELECT room_id
        FROM room
                 JOIN building ON room.building_id = building.building_id
        WHERE building_num = '301' ORDER BY rand() LIMIT 1)
FROM professor p
         JOIN instructor i ON p.instructor_id = i.instructor_id
         JOIN employee e ON i.employee_id = e.employee_id
WHERE e.user_id = 16;

INSERT INTO professor_state (professor_id, state, modified_date, room_id)
SELECT p.professor_id, '재직', '2015-03-02',
       (SELECT room_id
        FROM room
                 JOIN building ON room.building_id = building.building_id
        WHERE building_num = '301' ORDER BY rand() LIMIT 1)
FROM professor p
         JOIN instructor i ON p.instructor_id = i.instructor_id
         JOIN employee e ON i.employee_id = e.employee_id
WHERE e.user_id = 16;

INSERT INTO professor_state (professor_id, state, modified_date, room_id)
SELECT p.professor_id, '퇴직', '2023-03-02',
       (SELECT room_id
        FROM room
                 JOIN building ON room.building_id = building.building_id
        WHERE building_num = '301' ORDER BY rand() LIMIT 1)
FROM professor p
         JOIN instructor i ON p.instructor_id = i.instructor_id
         JOIN employee e ON i.employee_id = e.employee_id
WHERE e.user_id = 17;


INSERT INTO professor_state (professor_id, state, modified_date, room_id)
SELECT p.professor_id, '퇴직', '2022-03-02',
       (SELECT room_id
        FROM room
                 JOIN building ON room.building_id = building.building_id
        WHERE building_num = '301' ORDER BY rand() LIMIT 1)
FROM professor p
         JOIN instructor i ON p.instructor_id = i.instructor_id
         JOIN employee e ON i.employee_id = e.employee_id
WHERE e.user_id = 20;


# INSERT dummy staff's states using with user_id
INSERT INTO staff_state (staff_id, state, modified_date, admin_department, admin_position)
SELECT s.staff_id, '재직', '2009-03-02', '학생지원팀', '팀장'
FROM staff s JOIN employee e ON s.employee_id = e.employee_id
WHERE e.user_id = 32;

INSERT INTO staff_state (staff_id, state, modified_date, admin_department, admin_position)
SELECT s.staff_id, '재직', '2010-03-02', '학생지원팀', '팀원'
FROM staff s JOIN employee e ON s.employee_id = e.employee_id
WHERE e.user_id BETWEEN 33 AND 34;

INSERT INTO staff_state (staff_id, state, modified_date, admin_department, admin_position)
SELECT s.staff_id, '재직', '2011-03-02', '교무팀', '팀장'
FROM staff s JOIN employee e ON s.employee_id = e.employee_id
WHERE e.user_id = 35;

INSERT INTO staff_state (staff_id, state, modified_date, admin_department, admin_position)
SELECT s.staff_id, '재직', '2012-03-02', '교무팀', '팀원'
FROM staff s JOIN employee e ON s.employee_id = e.employee_id
WHERE e.user_id BETWEEN 36 AND 37;

INSERT INTO staff_state (staff_id, state, modified_date, admin_department, admin_position)
SELECT s.staff_id, '재직', '2013-03-02', '감사팀', '팀장'
FROM staff s JOIN employee e ON s.employee_id = e.employee_id
WHERE e.user_id = 38;

INSERT INTO staff_state (staff_id, state, modified_date, admin_department, admin_position)
SELECT s.staff_id, '재직', '2014-03-02', '감사팀', '팀원'
FROM staff s JOIN employee e ON s.employee_id = e.employee_id
WHERE e.user_id BETWEEN 39 AND 40;

INSERT INTO staff_state (staff_id, state, modified_date, admin_department, admin_position)
SELECT s.staff_id, '재직', '2015-03-02', '인사팀', '팀장'
FROM staff s JOIN employee e ON s.employee_id = e.employee_id
WHERE e.user_id = 41;

INSERT INTO staff_state (staff_id, state, modified_date, admin_department, admin_position)
SELECT s.staff_id, '퇴직', '2016-03-02', '인사팀', '팀원'
FROM staff s JOIN employee e ON s.employee_id = e.employee_id
WHERE e.user_id = 32;

INSERT INTO staff_state (staff_id, state, modified_date, admin_department, admin_position)
SELECT s.staff_id, '퇴직', '2017-03-02', '학생지원팀', '팀장'
FROM staff s JOIN employee e ON s.employee_id = e.employee_id
WHERE e.user_id = 34;



# insert department data
INSERT INTO department (department_id, name, is_undergraduate, is_postgraduate)
VALUES
    (1, '교양', FALSE, FALSe),

    (2, '국어국문학과', TRUE, TRUE),
    (3, '영어영문학과', TRUE, TRUE),
    (4, '독일어문학전공', TRUE, TRUE),
    (5, '프랑스어문학전공', TRUE, TRUE),
    (6, '러시아어문학전공', TRUE, TRUE),
    (7, '중국어문학전공', TRUE, TRUE),
    (8, '일본어문학전공', TRUE, TRUE),

    (9, '철학과', TRUE, TRUE),
    (10, '역사학과', TRUE, TRUE),
    (11, '정치국제학과', TRUE, TRUE),
    (12, '공공인재학부', TRUE, TRUE),
    (13, '정책학전공', TRUE, TRUE),
    (14, '심리학과', TRUE, TRUE),
    (15, '문헌정보학과', TRUE, TRUE),
    (16, '사회복지전공', TRUE, FALSE),
    (17, '미디어커뮤니케이션학부디지털미디어콘텐츠전공', TRUE, FALSE),
    (18, '언론정보전공', TRUE, FALSE),
    (19, '도시계획부동산학과', TRUE, TRUE),
    (20, '사회학과', TRUE, TRUE),
    (21, '교육학과', TRUE, TRUE),
    (22, '유아교육과', TRUE, TRUE),
    (23, '영어교육과', TRUE, TRUE),
    (24, '체육교육과', TRUE, TRUE),

    (25, '물리학과', TRUE, TRUE),
    (26, '화학과', TRUE, TRUE),
    (27, '생명과학과', TRUE, TRUE),
    (28, '수학과', TRUE, TRUE),

    (29, '동물생명공학전공', TRUE, TRUE),
    (30, '식물생명공학전공', TRUE, TRUE),
    (31, '식품공학전공', TRUE, FALSE),
    (32, '식품영양전공', TRUE, FALSE),
    (33, '시스템생명공학과', TRUE, TRUE),
    (34, '건설환경플랜트공학전공', TRUE, FALSE),
    (35, '도시시스템공학전공', TRUE, FALSE),
    (36, '건축학전공', TRUE, TRUE),
    (37, '건축공학전공', TRUE, TRUE),
    (38, '화학공학부', TRUE, TRUE),
    (39, '기계공학부', TRUE, TRUE),
    (40, '원자력전공', TRUE, TRUE),
    (41, '발전기계전공', TRUE, TRUE),
    (42, '발전전기전공', TRUE, TRUE),
    (43, '첨단소재공학과', TRUE, TRUE),
    (44, '전자전기공학부', TRUE, TRUE),
    (45, '나노소재공학전공', TRUE, TRUE),
    (46, '바이오메디컬공학전공', TRUE, TRUE),
    (47, '소프트웨어학부', TRUE, TRUE),
    (48, '인공지능학과', TRUE, TRUE),

    (49, '경영학전공', TRUE, TRUE),
    (50, '글로벌금융전공', TRUE, TRUE),
    (51, '경제학부', TRUE, TRUE),
    (52, '응용통계학과', TRUE, TRUE),
    (53, '광고홍보학과', TRUE, TRUE),
    (54, '지식경영학부', TRUE, TRUE),
    (55, '국제물류학과', TRUE, TRUE),
    (56, '산업보안학과', TRUE, TRUE),

    (57, '의학부', TRUE, TRUE),
    (58, '약학전공', TRUE, TRUE),
    (59, '제약학전공', TRUE, TRUE),
    (60, '간호학과', TRUE, TRUE),

    (61, '연극전공', TRUE, TRUE),
    (62, '영화전공', TRUE, TRUE),
    (63, '공연공간연출전공', TRUE, FALSE),
    (64, '문예창작전공', TRUE, FALSE),
    (65, '사진전공', TRUE, FALSE),
    (66, '무용전공', TRUE, TRUE),
    (67, '한국화전공', TRUE, TRUE),
    (68, '서양화전공', TRUE, TRUE),
    (69, '조소전공', TRUE, TRUE),
    (70, '시각디자인전공', TRUE, TRUE),
    (71, '산업디자인전공', TRUE, TRUE),
    (72, '패션디자인전공', TRUE, TRUE),
    (73, '실내환경디자인전공', TRUE, FALSE),
    (74, '공예전공', TRUE, TRUE),
    (75, '관현악전공', TRUE, TRUE),
    (76, '성악전공', TRUE, TRUE),
    (77, '작곡전공', TRUE, TRUE),
    (78, '피아노전공', TRUE, TRUE),
    (79, '음악예술전공', TRUE, TRUE),
    (80, '연희예술전공', TRUE, TRUE),
    (81, 'TV방송연예전공', TRUE, TRUE),
    (82, '실용음악전공', TRUE, TRUE),
    (83, '게임콘텐츠ㆍ애니메이션전공', TRUE, FALSE),
    (84, '게임 개발 트랙', TRUE, FALSE),
    (85, '영상특수효과 트랙', TRUE, FALSE),
    (86, '디지털 아트 트랙', TRUE, FALSE),
    (87, '생활 레저스포츠전공', TRUE, FALSE),
    (88, '스포츠산업전공', TRUE, FALSE),
    (89, '골프전공', TRUE, FALSE),
    (90, '금융AI', TRUE, FALSE),
    (91, '문화콘텐츠', TRUE, FALSE),
    (92, '창업학', TRUE, FALSE),
    (93, '게임·인터렉티브미디어', TRUE, FALSE),
    (94, '소프트웨어·인문', TRUE, FALSE),
    (95, '사이버보안', TRUE, FALSE),
    (96, '테크놀로지아트', TRUE, FALSE),
    (97, '소프트웨어벤처', TRUE, FALSE),
    (98, '문화다양성', TRUE, FALSE),
    (99, '한류문화', TRUE, FALSE);


# insert department's initial fee data
INSERT INTO initial_fee (department_id, year, semester, admission_fee, tuition, student_fee, extra_fee)
VALUES
    (1, 2020, 1, 1000000, 1300000, 50000, 25000),
    (2, 2020, 1, 1000000, 1300000, 50000, 25000),
    (3, 2020, 1, 1000000, 1300000, 50000, 25000),
    (4, 2020, 1, 1000000, 1300000, 50000, 25000),
    (5, 2020, 1, 1000000, 1300000, 50000, 25000),
    (6, 2020, 1, 1000000, 1300000, 50000, 25000),
    (7, 2020, 1, 1000000, 1300000, 50000, 25000),
    (8, 2021, 1, 900000, 1200000, 50000, 25000),
    (9, 2021, 1, 900000, 1200000, 50000, 25000),
    (10, 2021, 1, 900000, 1200000, 50000, 25000),
    (11, 2021, 1, 900000, 1200000, 50000, 25000),
    (12, 2021, 1, 900000, 1200000, 50000, 25000),
    (13, 2021, 1, 900000, 1200000, 50000, 25000),
    (14, 2021, 1, 900000, 1200000, 50000, 25000),
    (15, 2021, 1, 900000, 1200000, 50000, 25000),
    (16, 2021, 1, 900000, 1200000, 50000, 25000),
    (17, 2021, 1, 900000, 1200000, 50000, 25000),
    (18, 2021, 1, 900000, 1200000, 50000, 25000),
    (19, 2021, 1, 900000, 1200000, 50000, 25000),
    (20, 2021, 1, 900000, 1200000, 50000, 25000),
    (21, 2021, 1, 900000, 1200000, 50000, 25000),
    (22, 2021, 1, 900000, 1200000, 50000, 25000),
    (23, 2021, 1, 900000, 1200000, 50000, 25000),
    (24, 2019, 2, 800000, 1500000, 40000, 27000),
    (25, 2019, 2, 800000, 1500000, 40000, 27000),
    (26, 2019, 2, 800000, 1500000, 40000, 27000),
    (27, 2019, 2, 800000, 1500000, 40000, 27000),
    (28, 2019, 2, 800000, 1500000, 40000, 27000),
    (29, 2019, 2, 800000, 1500000, 40000, 27000),
    (30, 2019, 2, 800000, 1500000, 40000, 27000),
    (31, 2019, 2, 800000, 1500000, 40000, 27000),
    (32, 2019, 2, 800000, 1500000, 40000, 27000),
    (33, 2019, 2, 800000, 1500000, 40000, 27000),
    (34, 2019, 2, 800000, 1500000, 40000, 27000),
    (35, 2019, 2, 800000, 1500000, 40000, 27000),
    (36, 2019, 2, 800000, 1500000, 40000, 27000),
    (37, 2019, 2, 800000, 1500000, 40000, 27000),
    (38, 2019, 2, 800000, 1500000, 40000, 27000),
    (39, 2019, 2, 800000, 1500000, 40000, 27000),
    (40, 2019, 2, 800000, 1500000, 40000, 27000),
    (41, 2019, 2, 800000, 1500000, 40000, 27000),
    (42, 2019, 2, 800000, 1500000, 40000, 27000),
    (43, 2019, 2, 800000, 1500000, 40000, 27000),
    (44, 2019, 2, 800000, 1500000, 40000, 27000),
    (45, 2019, 2, 800000, 1500000, 40000, 27000),
    (46, 2019, 2, 800000, 1500000, 40000, 27000),
    (47, 2019, 2, 800000, 1500000, 40000, 27000),
    (48, 2017, 1, 1050000, 1400000, 50000, 25000),
    (49, 2017, 1, 1050000, 1400000, 50000, 25000),
    (50, 2017, 1, 1050000, 1400000, 50000, 25000),
    (51, 2017, 1, 1050000, 1400000, 50000, 25000),
    (52, 2017, 1, 1050000, 1400000, 50000, 25000),
    (53, 2017, 1, 1050000, 1400000, 50000, 25000),
    (54, 2017, 1, 1050000, 1400000, 50000, 25000),
    (55, 2017, 1, 1050000, 1400000, 50000, 25000),
    (56, 2017, 1, 1050000, 1400000, 50000, 25000),
    (57, 2017, 1, 1050000, 1400000, 50000, 25000),
    (58, 2017, 1, 1050000, 1400000, 50000, 25000),
    (59, 2017, 1, 1050000, 1400000, 50000, 25000),
    (60, 2022, 1, 1400000, 1500000, 50000, 20000),
    (61, 2022, 1, 1400000, 1500000, 50000, 20000),
    (62, 2022, 1, 1400000, 1500000, 50000, 20000),
    (63, 2022, 1, 1400000, 1500000, 50000, 20000),
    (64, 2022, 1, 1400000, 1500000, 50000, 20000),
    (65, 2022, 1, 1400000, 1500000, 50000, 20000),
    (66, 2022, 1, 1400000, 1500000, 50000, 20000),
    (67, 2022, 1, 1400000, 1500000, 50000, 20000),
    (68, 2022, 1, 1400000, 1500000, 50000, 20000),
    (69, 2022, 1, 1400000, 1500000, 50000, 20000),
    (70, 2022, 1, 1400000, 1500000, 50000, 20000),
    (71, 2022, 1, 1400000, 1500000, 50000, 20000),
    (72, 2022, 1, 1400000, 1500000, 50000, 20000),
    (73, 2022, 1, 1400000, 1500000, 50000, 20000),
    (74, 2022, 1, 1400000, 1500000, 50000, 20000),
    (75, 2022, 1, 1400000, 1500000, 50000, 20000),
    (76, 2022, 1, 1400000, 1500000, 50000, 20000),
    (77, 2022, 1, 1400000, 1500000, 50000, 20000),
    (78, 2022, 1, 1400000, 1500000, 50000, 20000),
    (79, 2022, 1, 1400000, 1500000, 50000, 20000),
    (80, 2022, 1, 1400000, 1500000, 50000, 20000),
    (81, 2022, 1, 1400000, 1500000, 50000, 20000),
    (82, 2022, 1, 1400000, 1500000, 50000, 20000),
    (83, 2022, 1, 1400000, 1500000, 50000, 20000),
    (84, 2022, 1, 1400000, 1500000, 50000, 20000),
    (85, 2022, 1, 1400000, 1500000, 50000, 20000),
    (86, 2022, 1, 1400000, 1500000, 50000, 20000),
    (87, 2022, 1, 1400000, 1500000, 50000, 20000),
    (88, 2022, 1, 1400000, 1500000, 50000, 20000),
    (89, 2022, 1, 1400000, 1500000, 50000, 20000),
    (90, 2022, 1, 1400000, 1500000, 50000, 20000),
    (91, 2022, 1, 1400000, 1500000, 50000, 20000),
    (92, 2022, 1, 1400000, 1500000, 50000, 20000),
    (93, 2022, 1, 1400000, 1500000, 50000, 20000),
    (94, 2022, 1, 1400000, 1500000, 50000, 20000),
    (95, 2022, 1, 1400000, 1500000, 50000, 20000),
    (96, 2022, 1, 1400000, 1500000, 50000, 20000),
    (97, 2022, 1, 1400000, 1500000, 50000, 20000),
    (98, 2022, 1, 1400000, 1500000, 50000, 20000);



INSERT INTO undergraduate_enroll (undergraduate_id, department_id, date, major_type)
VALUES
    (get_undergraduate_id(1), get_department_id('심리학과'), '2018-03-01', '본전공'),
    (get_undergraduate_id(2), get_department_id('경영학전공'), '2018-03-01', '본전공'),
    (get_undergraduate_id(3), get_department_id('소프트웨어학부'), '2018-03-01', '본전공'),
    (get_undergraduate_id(4), get_department_id('의학부'), '2018-03-01', '본전공'),
    (get_undergraduate_id(5), get_department_id('경영학전공'), '2018-03-01', '본전공'),
    (get_undergraduate_id(11), get_department_id('사회복지전공'), '2013-03-01', '본전공'),
    (get_undergraduate_id(12), get_department_id('경영학전공'), '2013-03-01', '본전공'),
    (get_undergraduate_id(13), get_department_id('물리학과'), '2013-03-01', '본전공'),
    (get_undergraduate_id(14), get_department_id('수학과'), '2012-03-01', '본전공'),
    (get_undergraduate_id(15), get_department_id('심리학과'), '2012-03-01', '본전공');

INSERT INTO undergraduate_enroll (undergraduate_id, department_id, date, major_type)
VALUES
    (get_undergraduate_id(1), get_department_id('경영학전공'), '2019-03-01', '복수전공'),
    (get_undergraduate_id(2), get_department_id('소프트웨어학부'), '2020-03-01', '복수전공'),
    (get_undergraduate_id(2), get_department_id('사이버보안'), '2021-03-01', '부전공'),
    (get_undergraduate_id(3), get_department_id('경영학전공'), '2020-03-01', '부전공'),
    (get_undergraduate_id(4), get_department_id('사이버보안'), '2020-03-01', '부전공'),
    (get_undergraduate_id(11), get_department_id('인공지능학과'), '2015-03-01', '융합전공'),
    (get_undergraduate_id(12), get_department_id('심리학과'), '2015-03-01', '부전공');

INSERT INTO postgraduate_enroll (postgraduate_id, department_id, date, major_type)
VALUES
    (get_postgraduate_id(6), get_department_id('경영학전공'), '2021-03-01', '석사'),
    (get_postgraduate_id(7), get_department_id('경제학부'), '2021-03-01', '석사'),
    (get_postgraduate_id(8), get_department_id('전자전기공학부'), '2022-03-01', '석박사통합'),
    (get_postgraduate_id(9), get_department_id('화학공학부'), '2022-03-01', '석사'),
    (get_postgraduate_id(10), get_department_id('국어국문학과'), '2022-03-01', '박사'),
    (get_postgraduate_id(11), get_department_id('원자력전공'), '2020-03-01', '박사'),
    (get_postgraduate_id(12), get_department_id('물리학과'), '2020-03-01', '석사'),
    (get_postgraduate_id(13), get_department_id('심리학과'), '2020-03-01', '석사'),
    (get_postgraduate_id(14), get_department_id('역사학과'), '2019-03-01', '석사'),
    (get_postgraduate_id(15), get_department_id('정치국제학과'), '2019-03-01', '석박사통합');


INSERT INTO course (department_id, name, credit)
VALUES
    (get_department_id('심리학과'), '인지심리학', 3),
    (get_department_id('심리학과'), '심리통계', 3),
    (get_department_id('심리학과'), '심리학개론', 2),
    (get_department_id('심리학과'), '실험심리학', 3),
    (get_department_id('심리학과'), '정서심리학', 3),

    (get_department_id('소프트웨어학부'), '컴퓨터구조', 3),
    (get_department_id('소프트웨어학부'), '프로그래밍', 2),
    (get_department_id('소프트웨어학부'), '데이터베이스설계', 3),
    (get_department_id('소프트웨어학부'), '운영체제', 3),
    (get_department_id('소프트웨어학부'), '객체지향프로그래밍', 3),

    (get_department_id('경영학전공'), '경영학개론', 3),
    (get_department_id('경영학전공'), '경영정보시스템', 3),
    (get_department_id('경영학전공'), '경영과학', 3),
    (get_department_id('경영학전공'), '경영통계', 2),
    (get_department_id('경영학전공'), '경영학원론', 2),

    (get_department_id('물리학과'), '일반물리학', 2),
    (get_department_id('물리학과'), '일반물리학실험', 3),
    (get_department_id('물리학과'), '고급물리학', 2),
    (get_department_id('물리학과'), '고급물리학실험', 3),
    (get_department_id('물리학과'), '양자역학', 3),

    (get_department_id('교양'), '영어회화', 2),
    (get_department_id('교양'), '우주의 이해', 3),
    (get_department_id('교양'), '인간행동과 심리', 3),
    (get_department_id('교양'), '식물과 문명', 3),
    (get_department_id('교양'), '한국의 문화유산', 3);

INSERT INTO req_course (course_id, department_id, modified_year)
VALUES
    (get_course_id('심리통계'), get_department_id('심리학과'), 2019),
    (get_course_id('심리학개론'), get_department_id('심리학과'), 2019),
    (get_course_id('실험심리학'), get_department_id('심리학과'), 2019),

    (get_course_id('컴퓨터구조'), get_department_id('소프트웨어학부'), 2020),
    (get_course_id('프로그래밍'), get_department_id('소프트웨어학부'), 2020),

    (get_course_id('경영학개론'), get_department_id('경영학전공'), 2019),
    (get_course_id('경영학원론'), get_department_id('경영학전공'), 2019),

    (get_course_id('일반물리학'), get_department_id('물리학과'), 2018),
    (get_course_id('일반물리학실험'), get_department_id('물리학과'), 2018),
    (get_course_id('양자역학'), get_department_id('물리학과'), 2020);


CALL insert_pre_req_course(get_course_id('심리통계'), get_course_id('심리학개론'));
CALL insert_pre_req_course(get_course_id('실험심리학'), get_course_id('심리학개론'));
CALL insert_pre_req_course(get_course_id('프로그래밍'), get_course_id('컴퓨터구조'));
CALL insert_pre_req_course(get_course_id('경영학원론'), get_course_id('경영학개론'));
CALL insert_pre_req_course(get_course_id('일반물리학실험'), get_course_id('일반물리학'));
CALL insert_pre_req_course(get_course_id('고급물리학실험'), get_course_id('고급물리학'));
CALL insert_pre_req_course(get_course_id('양자역학'), get_course_id('고급물리학'));

INSERT INTO class (class_id, course_id, year, semester, division, capacity)
VALUES
    (1, get_course_id('심리학개론'), 2023, 2, 1, 70),
    (2, get_course_id('실험심리학'), 2023, 2, 1, 70),
    (3, get_course_id('인지심리학'), 2023, 2, 1, 70),
    (4, get_course_id('정서심리학'), 2023, 2, 1, 50),
    (5, get_course_id('프로그래밍'), 2023, 2, 1, 80),
    (6, get_course_id('데이터베이스설계'), 2023, 2, 1, 90);

INSERT INTO take_class (student_id, class_id, grade)
VALUES
    (1, 1, 3.5),
    (1, 2, 4.0),
    (1, 3, 2.0),
    (1, 4, 3.5),
    (1, 5, 4.0),
    (1, 6, 4.5);

INSERT INTO class_time (class_id, day, start_time, end_time, room_id)
VALUES
    (1, 1, '09:00', '12:00', 1),
    (2, 1, '14:00', '15:00', 2),
    (3, 2, '10:00', '13:00', 3),
    (4, 3, '14:00', '15:30', 4),
    (4, 4, '14:00', '15:30', 4),
    (5, 4, '09:00', '12:00', 5),
    (5, 5, '12:00', '15:00', 5),
    (6, 5, '15:00', '18:00', 6);

INSERT INTO instruct (class_id, instructor_id, start_date)
VALUES
    (1, get_instructor_id(16), '2023-09-01'),
    (2, get_instructor_id(17), '2023-09-01'),
    (3, get_instructor_id(18), '2023-09-01'),
    (4, get_instructor_id(19), '2023-09-01'),
    (5, get_instructor_id(20), '2023-09-01'),
    (6, get_instructor_id(21), '2023-09-01');
