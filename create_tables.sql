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
DROP TABLE IF EXISTS postgraduate_major_type;
DROP TABLE IF EXISTS undergraduate_major_type;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS professor_state;
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

CREATE TABLE professor_state (
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professor(professor_id),
    state VARCHAR(255) NOT NULL,
    modified_date DATE NOT NULL,
    room_id INT NOT NULL,
    FOREIGN KEY (room_id) REFERENCES room(room_id),
    PRIMARY KEY (professor_id, modified_date)
);


# department section

CREATE TABLE department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    is_undergraduate BOOLEAN NOT NULL,
    is_postgraduate BOOLEAN NOT NULL
);

CREATE TABLE undergraduate_major_type (
    undergraduate_id INT NOT NULL,
    FOREIGN KEY (undergraduate_id) REFERENCES undergraduate(undergraduate_id),
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    date DATE NOT NULL,
    major_type VARCHAR(255) NOT NULL,
    PRIMARY KEY (undergraduate_id, department_id, date)
);

CREATE TABLE postgraduate_major_type (
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
    year INT NOT NULL,
    PRIMARY KEY (course_id, department_id, year)
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