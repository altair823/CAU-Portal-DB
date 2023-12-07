USE cauportal;


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