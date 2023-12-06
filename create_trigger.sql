USE cauportal;


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
