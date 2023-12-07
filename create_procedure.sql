USE cauportal;


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
