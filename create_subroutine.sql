USE cauportal;

# Trigger section

# Procedure section
DROP PROCEDURE IF EXISTS insert_user;

DELIMITER $$

CREATE PROCEDURE insert_user (
    IN
    user_id_i INT,
    kor_name_i VARCHAR(255),
    eng_name_i VARCHAR(255),
    birthdate_i DATE,
    address_i VARCHAR(255),
    phone_num_i VARCHAR(255),
    account_num_i VARCHAR(255),
    email_i VARCHAR(255),
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
        user_id_i,
        kor_name_i,
        eng_name_i,
        birthdate_i,
        address_i,
        phone_num_i,
        account_num_i,
        email_i,
        TRUE
    );

    IF is_undergraduate OR is_postgraduate THEN
        INSERT INTO student (user_id) SELECT user_id FROM user WHERE user_id = user_id_i;
    ELSEIF is_assistant OR is_professor OR is_staff THEN
        INSERT INTO employee (user_id) SELECT user_id FROM user u WHERE u.user_id = user_id_i;
    END IF;
    IF is_undergraduate THEN
        INSERT INTO undergraduate (student_id) SELECT student_id from student WHERE user_id = user_id_i;
    END IF;
    IF is_postgraduate THEN
        INSERT INTO postgraduate (student_id) SELECT student_id from student WHERE user_id = user_id_i;
    END IF;
    IF is_assistant OR is_professor THEN
        INSERT INTO instructor (employee_id) SELECT employee_id from employee WHERE user_id = user_id_i;
    ELSEIF is_staff THEN
        INSERT INTO staff (employee_id) SELECT employee_id from employee WHERE user_id = user_id_i;
    END IF;
    IF is_assistant THEN
        INSERT INTO assistant (instructor_id)
            SELECT instructor_id FROM instructor i JOIN employee e ON i.employee_id = e.employee_id
            WHERE user_id = user_id_i;
    ELSEIF is_professor THEN
        INSERT INTO professor (instructor_id)
            SELECT instructor_id FROM instructor i JOIN employee e ON i.employee_id = e.employee_id
            WHERE user_id = user_id_i;
    END IF;
END$$

DELIMITER ;

CALL insert_user(
    3,
    '홍길동',
    'Hong Gil Dong',
    '1990-01-01',
    '서울특별시 강남구',
    '010-1234-5678',
    '1234-5678-9012',
    'lle@gmail.com',
    TRUE,
    TRUE,
    FALSE,
    FALSE,
    FALSE
);

SELECT * FROM user;
SELECT * FROM student;
SELECT * FROM undergraduate;
SELECT * FROM postgraduate JOIN cauportal.student s ON postgraduate.student_id = s.student_id JOIN cauportal.user u ON u.user_id = s.user_id;

# DELETE FROM user;

# Function section
