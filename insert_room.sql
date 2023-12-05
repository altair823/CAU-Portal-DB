USE cauportal;

# insert building data
INSERT INTO building (name, building_num)
VALUES
    ('영신관', '101'),
    ('약학대학 및 R&D 센터', '102'),
    ('파이퍼홀', '103'),
    ('수림과학관', '104'),
    ('제1의학관', '105'),
    ('제2의학관', '106'),
    ('학생회관', '107'),
    ('산학협력관 및 캠퍼스타운 거점센터', '108'),
    ('본관', '201'),
    ('전산정보관', '202'),
    ('서라벌홀', '203'),
    ('중앙도서관', '204'),
    ('봅스트홀', '207'),
    ('제2공학관', '208'),
    ('창업보육관', '209'),
    ('중앙문화예술관', '301'),
    ('대학원', '302'),
    ('법학관', '303'),
    ('미디어공연영상관', '304'),
    ('교수연구동 및 체육관', '305'),
    ('글로벌 하우스', '307'),
    ('블루미르홀', '308'),
    ('블루미르홀', '309'),
    ('중앙대학교 100주년기념관', '310'),
    ('중앙대학교병원 중앙관', 'A'),
    ('중앙대학교병원 다정관', 'A-1'),
    ('중앙대학교병원 주차타워', 'A-2'),
    ('퓨처하우스', 'B'),
    ('중앙대학교사범대학부속중학교', 'C'),
    ('중앙대학교사범대학부속초등학교', 'D'),
    ('중앙대학교사범대학부속유치원', 'F'),
    ('중앙대학교사범대학부속고등학교', 'L');

# insert room data
INSERT INTO room (building_id, room_num, capacity)
VALUES
((SELECT building_id FROM building WHERE building_num = '101'), '101', 40),
((SELECT building_id FROM building WHERE building_num = '101'), '102', 50),
((SELECT building_id FROM building WHERE building_num = '101'), '103', 60),
((SELECT building_id FROM building WHERE building_num = '101'), '104', 70),

((SELECT building_id FROM building WHERE building_num = '102'), '201', 40),
((SELECT building_id FROM building WHERE building_num = '102'), '202', 50),
((SELECT building_id FROM building WHERE building_num = '102'), '203', 60),
((SELECT building_id FROM building WHERE building_num = '102'), '204', 70),

((SELECT building_id FROM building WHERE building_num = '103'), '301', 40),
((SELECT building_id FROM building WHERE building_num = '103'), '302', 50),
((SELECT building_id FROM building WHERE building_num = '103'), '303', 60),
((SELECT building_id FROM building WHERE building_num = '103'), '304', 70),

((SELECT building_id FROM building WHERE building_num = '104'), '401', 40),
((SELECT building_id FROM building WHERE building_num = '104'), '402', 50),
((SELECT building_id FROM building WHERE building_num = '104'), '403', 60),
((SELECT building_id FROM building WHERE building_num = '104'), '404', 70),

((SELECT building_id FROM building WHERE building_num = '105'), '501', 40),
((SELECT building_id FROM building WHERE building_num = '105'), '502', 50),
((SELECT building_id FROM building WHERE building_num = '105'), '503', 60),
((SELECT building_id FROM building WHERE building_num = '105'), '504', 70),

((SELECT building_id FROM building WHERE building_num = '106'), '601', 40),
((SELECT building_id FROM building WHERE building_num = '106'), '602', 50),
((SELECT building_id FROM building WHERE building_num = '106'), '603', 60),
((SELECT building_id FROM building WHERE building_num = '106'), '604', 70),

((SELECT building_id FROM building WHERE building_num = '107'), '701', 40),
((SELECT building_id FROM building WHERE building_num = '107'), '702', 50),
((SELECT building_id FROM building WHERE building_num = '107'), '703', 60),
((SELECT building_id FROM building WHERE building_num = '107'), '704', 70),

((SELECT building_id FROM building WHERE building_num = '108'), '801', 40),
((SELECT building_id FROM building WHERE building_num = '108'), '802', 50),
((SELECT building_id FROM building WHERE building_num = '108'), '803', 60),
((SELECT building_id FROM building WHERE building_num = '108'), '804', 70),

((SELECT building_id FROM building WHERE building_num = '201'), '101', 40),
((SELECT building_id FROM building WHERE building_num = '201'), '102', 50),
((SELECT building_id FROM building WHERE building_num = '201'), '103', 60),
((SELECT building_id FROM building WHERE building_num = '201'), '104', 70),

((SELECT building_id FROM building WHERE building_num = '202'), '201', 40),
((SELECT building_id FROM building WHERE building_num = '202'), '202', 50),
((SELECT building_id FROM building WHERE building_num = '202'), '203', 60),
((SELECT building_id FROM building WHERE building_num = '202'), '204', 70),

((SELECT building_id FROM building WHERE building_num = '203'), '301', 40),
((SELECT building_id FROM building WHERE building_num = '203'), '302', 50),
((SELECT building_id FROM building WHERE building_num = '203'), '303', 60),
((SELECT building_id FROM building WHERE building_num = '203'), '304', 70),

((SELECT building_id FROM building WHERE building_num = '204'), '401', 40),
((SELECT building_id FROM building WHERE building_num = '204'), '402', 50),
((SELECT building_id FROM building WHERE building_num = '204'), '403', 60),
((SELECT building_id FROM building WHERE building_num = '204'), '404', 70),

((SELECT building_id FROM building WHERE building_num = '207'), '501', 40),
((SELECT building_id FROM building WHERE building_num = '207'), '502', 50),
((SELECT building_id FROM building WHERE building_num = '207'), '503', 60),
((SELECT building_id FROM building WHERE building_num = '207'), '504', 70),

((SELECT building_id FROM building WHERE building_num = '208'), '601', 40),
((SELECT building_id FROM building WHERE building_num = '208'), '602', 50),
((SELECT building_id FROM building WHERE building_num = '208'), '603', 60),
((SELECT building_id FROM building WHERE building_num = '208'), '604', 70),

((SELECT building_id FROM building WHERE building_num = '209'), '701', 40),
((SELECT building_id FROM building WHERE building_num = '209'), '702', 50),
((SELECT building_id FROM building WHERE building_num = '209'), '703', 60),
((SELECT building_id FROM building WHERE building_num = '209'), '704', 70),

((SELECT building_id FROM building WHERE building_num = '301'), '101', 40),
((SELECT building_id FROM building WHERE building_num = '301'), '102', 50),
((SELECT building_id FROM building WHERE building_num = '301'), '103', 60),
((SELECT building_id FROM building WHERE building_num = '301'), '104', 70),

((SELECT building_id FROM building WHERE building_num = '302'), '201', 40),
((SELECT building_id FROM building WHERE building_num = '302'), '202', 50),
((SELECT building_id FROM building WHERE building_num = '302'), '203', 60),
((SELECT building_id FROM building WHERE building_num = '302'), '204', 70),

((SELECT building_id FROM building WHERE building_num = '303'), '301', 40),
((SELECT building_id FROM building WHERE building_num = '303'), '302', 50),
((SELECT building_id FROM building WHERE building_num = '303'), '303', 60),
((SELECT building_id FROM building WHERE building_num = '303'), '304', 70),

((SELECT building_id FROM building WHERE building_num = '304'), '401', 40),
((SELECT building_id FROM building WHERE building_num = '304'), '402', 50),
((SELECT building_id FROM building WHERE building_num = '304'), '403', 60),
((SELECT building_id FROM building WHERE building_num = '304'), '404', 70),

((SELECT building_id FROM building WHERE building_num = '305'), '501', 40),
((SELECT building_id FROM building WHERE building_num = '305'), '502', 50),
((SELECT building_id FROM building WHERE building_num = '305'), '503', 60),
((SELECT building_id FROM building WHERE building_num = '305'), '504', 70),

((SELECT building_id FROM building WHERE building_num = '307'), '601', 40),
((SELECT building_id FROM building WHERE building_num = '307'), '602', 50),
((SELECT building_id FROM building WHERE building_num = '307'), '603', 60),
((SELECT building_id FROM building WHERE building_num = '307'), '604', 70),

((SELECT building_id FROM building WHERE building_num = '308'), '701', 40),
((SELECT building_id FROM building WHERE building_num = '308'), '702', 50),
((SELECT building_id FROM building WHERE building_num = '308'), '703', 60),
((SELECT building_id FROM building WHERE building_num = '308'), '704', 70),

((SELECT building_id FROM building WHERE building_num = '309'), '801', 40),
((SELECT building_id FROM building WHERE building_num = '309'), '802', 50),
((SELECT building_id FROM building WHERE building_num = '309'), '803', 60),
((SELECT building_id FROM building WHERE building_num = '309'), '804', 70),

((SELECT building_id FROM building WHERE building_num = '310'), '101', 40),
((SELECT building_id FROM building WHERE building_num = '310'), '102', 50),
((SELECT building_id FROM building WHERE building_num = '310'), '103', 60),
((SELECT building_id FROM building WHERE building_num = '310'), '104', 70),

((SELECT building_id FROM building WHERE building_num = 'A'), '101', 40),
((SELECT building_id FROM building WHERE building_num = 'A'), '102', 50),
((SELECT building_id FROM building WHERE building_num = 'A'), '103', 60),
((SELECT building_id FROM building WHERE building_num = 'A'), '104', 70),

((SELECT building_id FROM building WHERE building_num = 'A-1'), '201', 40),
((SELECT building_id FROM building WHERE building_num = 'A-1'), '202', 50),
((SELECT building_id FROM building WHERE building_num = 'A-1'), '203', 60),
((SELECT building_id FROM building WHERE building_num = 'A-1'), '204', 70),

((SELECT building_id FROM building WHERE building_num = 'A-2'), '301', 40),
((SELECT building_id FROM building WHERE building_num = 'A-2'), '302', 50),
((SELECT building_id FROM building WHERE building_num = 'A-2'), '303', 60),
((SELECT building_id FROM building WHERE building_num = 'A-2'), '304', 70),

((SELECT building_id FROM building WHERE building_num = 'B'), '401', 40),
((SELECT building_id FROM building WHERE building_num = 'B'), '402', 50),
((SELECT building_id FROM building WHERE building_num = 'B'), '403', 60),
((SELECT building_id FROM building WHERE building_num = 'B'), '404', 70),

((SELECT building_id FROM building WHERE building_num = 'C'), '501', 40),
((SELECT building_id FROM building WHERE building_num = 'C'), '502', 50),
((SELECT building_id FROM building WHERE building_num = 'C'), '503', 60),
((SELECT building_id FROM building WHERE building_num = 'C'), '504', 70),

((SELECT building_id FROM building WHERE building_num = 'D'), '601', 40),
((SELECT building_id FROM building WHERE building_num = 'D'), '602', 50),
((SELECT building_id FROM building WHERE building_num = 'D'), '603', 60),
((SELECT building_id FROM building WHERE building_num = 'D'), '604', 70),

((SELECT building_id FROM building WHERE building_num = 'F'), '701', 40),
((SELECT building_id FROM building WHERE building_num = 'F'), '702', 50),
((SELECT building_id FROM building WHERE building_num = 'F'), '703', 60),
((SELECT building_id FROM building WHERE building_num = 'F'), '704', 70),

((SELECT building_id FROM building WHERE building_num = 'L'), '801', 40),
((SELECT building_id FROM building WHERE building_num = 'L'), '802', 50),
((SELECT building_id FROM building WHERE building_num = 'L'), '803', 60),
((SELECT building_id FROM building WHERE building_num = 'L'), '804', 70);