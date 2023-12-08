USE cauportal;

INSERT INTO class (class_id, course_id, year, semester, division, capacity)
VALUES
    (1, get_course_id('심리학개론'), 2023, 2, 1, 70),
    (2, get_course_id('실험심리학'), 2023, 2, 2, 70),
    (3, get_course_id('인지심리학'), 2023, 2, 3, 70),
    (4, get_course_id('정서심리학'), 2023, 2, 1, 50),
    (5, get_course_id('프로그래밍'), 2023, 2, 4, 80),
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
