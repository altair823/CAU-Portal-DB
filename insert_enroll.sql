USE cauportal;

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
