# CAU-Portal-DB

## 1. 개요

#### 이 레포지토리는 데이터베이스 설계 과목의 팀 프로젝트 레포지토리입니다.

중앙대학교 포털 사이트의 DB를 분석, 구축합니다.

## 2. 팀원

- 김태현
- 최다빈
- 이승규
- 전현석
- 이혁준

## 3. 개발 환경

- MySQL 8.2
- MySQL Workbench 8.0 CE
- intelliJ IDEA
- Java 18

## 4. SQL 파일 실행 순서

1. `create_table.sql`
2. `create_subroutine.sql`
3. `insert_room.sql`
4. `insert_dummy_user.sql`

이 순서대로 실행하지 않으면 의도한 올바른 결과를 보장할 수 없습니다. 


## 5. 자바 파일 실행 방법 
아래의 MYSQL.AUTH파일을 PASSWORD를 자신의 데이터베이스 비번으로 해주어야합니다.
Host name
host=localhost
Port
Default port is 3306.
port= 3306
Database name
database=cauportal
Username
username=root
Password for user
password=0000
