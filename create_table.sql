USE cauportal;

# drop tables

DROP TABLE IF EXISTS department_tuition;
DROP TABLE IF EXISTS syllabus;
DROP TABLE IF EXISTS take_class;
DROP TABLE IF EXISTS instruct;
DROP TABLE IF EXISTS class;
DROP TABLE IF EXISTS pre_req_course;
DROP TABLE IF EXISTS req_course;
DROP TABLE IF EXISTS course;
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
DROP TABLE IF EXISTS undergraduate_state;
DROP TABLE IF EXISTS postgraduate;
DROP TABLE IF EXISTS undergraduate;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS user;


# user section

CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    kor_name VARCHAR(255) NOT NULL,
    eng_name VARCHAR(255) NOT NULL,
    birthDATE DATE NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_num VARCHAR(255) NOT NULL,
    account_num VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE undergraduate (
    undergraduate_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    admission_date DATE NOT NULL
);

CREATE TABLE postgraduate (
    postgraduate_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    admission_date DATE NOT NULL
);

CREATE TABLE undergraduate_state (
    undergraduate_id INT PRIMARY KEY,
    FOREIGN KEY (undergraduate_id) REFERENCES undergraduate(undergraduate_id),
    state VARCHAR(255) NOT NULL,
    modified_date DATE NOT NULL
);

CREATE TABLE postgraduate_state (
    postgraduate_id INT PRIMARY KEY,
    FOREIGN KEY (postgraduate_id) REFERENCES postgraduate(postgraduate_id),
    state VARCHAR(255) NOT NULL,
    modified_DATE DATE NOT NULL
);

CREATE TABLE employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    salary INT NOT NULL
);

CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE staff_state (
    staff_id INT PRIMARY KEY,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    state VARCHAR(255) NOT NULL,
    modified_date DATE NOT NULL
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
    professor_id INT PRIMARY KEY,
    FOREIGN KEY (professor_id) REFERENCES professor(professor_id),
    state VARCHAR(255) NOT NULL,
    modified_date DATE NOT NULL
);


# department section

CREATE TABLE department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
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

CREATE TABLE department_tuition (
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    date DATE NOT NULL,
    tuition INT NOT NULL,
    PRIMARY KEY (department_id, date)
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
    grade char(2) NOT NULL,
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
    end_date DATE NOT NULL,
    PRIMARY KEY (class_id, instructor_id)
);

