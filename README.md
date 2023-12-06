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
- Java 19

## 4. SQL 파일 실행 순서

1. `create_table.sql`
2. `create_trigger.sql`
3. `create_procedure.sql`
4. `create_function.sql`
5. `insert_room.sql`
6. `insert_user.sql`
7. `insert_department.sql`

## 5. Java 프로젝트와 데이터베이스 연결 방법 
`cau_java/auth/mysql.auth` 파일의 연결 정보를 데이터베이스에 맞게 수정해주세요.

`mysql.auth` 파일은 다음과 같은 형식을 따릅니다. 

자세한 내용은 `cau_java/auth/example_mysql.auth` 파일을 참고해주세요.

``` {text}
host=localhost
port= 3306
database=cauportal
username=root
password=0000
```