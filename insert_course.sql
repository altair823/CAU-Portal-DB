USE cauportal;

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