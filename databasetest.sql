use cauportal;

drop table if exists undergraduate_state;
drop table if exists postgraduate;
drop table if exists undergraduate;
drop table if exists student;
drop table if exists user;

create table user (
    user_id int primary key auto_increment,
    kor_name varchar(255) not null,
    eng_name varchar(255) not null,
    birthdate date not null,
    address varchar(255) not null,
    phone_num varchar(255) not null,
    account_num varchar(255) not null,
    email varchar(255) not null
);

create table student (
    student_id int primary key auto_increment,
    user_id int not null,
    foreign key (user_id) references user(user_id)
);

create table undergraduate (
    undergraduate_id int primary key auto_increment,
    student_id int not null,
    foreign key (student_id) references student(student_id),
    admission_date date not null
);

create table postgraduate (
    postgraduate_id int primary key auto_increment,
    student_id int not null,
    foreign key (student_id) references student(student_id),
    admission_date date not null
);

create table undergraduate_state (
    undergraduate_id int primary key,
    foreign key (undergraduate_id) references undergraduate(undergraduate_id),
    state varchar(255) not null,
    modified_date date not null
);

create table postgraduate_state (
    postgraduate_id int primary key,
    foreign key (postgraduate_id) references postgraduate(postgraduate_id),
    state varchar(255) not null,
    modified_date date not null
);

create table employee (
    employee_id int primary key auto_increment,
    user_id int not null,
    foreign key (user_id) references user(user_id),
    salary int not null
);

create table professor (
    professor_id int primary key auto_increment,
    employee_id int not null,
    foreign key (employee_id) references employee(employee_id)
);

create table staff (
    staff_id int primary key auto_increment,
    employee_id int not null,
    foreign key (employee_id) references employee(employee_id)
);