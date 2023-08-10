/*
 * - 데이터 딕셔너리
 * 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블
 * 데이터 딕셔너리는 사용자가 테이블을 생성하거나, 사용자를 변경하는 등의
 * 작업을 할 때 데이터베이스 서버에 의해 자동으로 갱신되는 테이블
 * 
 * -- USER_TABLES : 자신의 계정이 소유한 객체 등에 관한 정보를 조회할 수 있는 딕셔너리 뷰
 * 
 * 
 */

SELECT * FROM USER_TABLES;

------------------------------------------------------------------

-- DQL (Data Query Language) : 데이터 질의(조회) 언어
-- DML (Data Manipulation Language) : 데이터 조작 언어
-- 테이블에 데이터 삽입, 수정, 삭제

-- TCL (Transation Control Language) : 트랜잭션 제어 언어
-- DML 수행 내용을 Commit, Rollback 하는 언어


-- DDL (Data Definition Laguage) : 데이터 정의 언어

-- 객체(OBJECT)를 만들고(CREATE), 수정(ALTER), 삭제(DROP) 등
-- 데이터의 전체 구조를 정의하는 언어로 주로 DB 관리자, 설계자가 사용함

-- 오라클에서의 객체 : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),
					-- 인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER),
					-- 프로시져(PROCEDUER), 함수(FUNCTION)
					-- 동의어(SYNONYM), 사용자(USER)	



------------------------------------------------------------------------

-- CREATE (창조, 생성)

-- 테이블이나 인덱스, 뷰 등 다양한 데이터베이스 객체를 생성하는 구문
-- 테이블로 생성된 객체는 DROP 구문을 통해 제거할 수 있음

-- 1. 테이블 생성하기

-- 테이블이란?
-- 행(ROW)과 열(COLUMN)으로 구성되는 가장 기본적인 데이터베이스 객체
-- 데이터베이스 내에서 모든 데이터는 테이블을 통해서 저장된다.

-- [표현식]

/*
 * CREATE TABLE 테이블명 (
 * 		컬럼명 자료형 (크기),
 * 		컬럼명 자료형 (크기),
 * 		컬럼명 자료형 (크기),
 *		...
 *	);
 * 
 */


/*
 * 자료형
 * 
 * NUMBER : 숫자형 (정수, 실수)
 *
 *  CHAR(크기) : 고정길이 문자형 (최대 2000BYTE)
 * 		--> EX) CHAR(10) 컬럼에 'ABC' 3BYTE 문자열만 저장해도 10BYTE 저장공간을 모두 사용.
 * 
 * VARCHAR2(크기) : 가변길이 문자형 (최대 4000BYTE)
 * 		--> EX) VARCHAR2(10) 컬럼에 'ABC' 3BYTE 문자열만 저장하면 나머지 7BYTE 반환함.
 * 
 * DATE : 날짜 타입
 * BLOB : 대용량 이진 데이터(4GB)
 * CLOB : 대용량 문자 데이터(4GB)
 *
 * 
 */

-- MEMBER 테이블 생성

CREATE TABLE "MEMBER" (
	MEMBER_ID VARCHAR2(20),
	MEMBER_PWD VARCHAR2(20),
	MEMBER_NAME VARCHAR2(30),
	MEMBER_SSN CHAR(14),
	ENROLL_DATE DATE DEFAULT SYSDATE
);

-- SQL 작성법 : 대문자 작성권장, 연결된 단어 사이는 "_" (언더바) 사용
-- 문자인코딩 UTF-8 : 영어, 숫자 1BYTE, 한글 3BYTE 취급

-- 만든 테이블 확인
SELECT * FROM MEMBER;

-- 2. 컬럼에 주석 달기
-- [표현식]
-- COMMENT ON COLUMN 테이블명. 컬럼명 IS '주석내용';

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.MEMBER_SSN IS '회원 주민 등록 번호';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원 가입일';


-- MEMBER 테이블에 샘플 데이터 삽입
-- INSERT INTO 테이블명 VALUES (값1, 값2, ...)

INSERT INTO MEMBER VALUES ('MEM01', '123ABC', '홍길동', '991213-1234567', DEFAULT);

SELECT * FROM "MEMBER";

-- INSERT / UPDATE 시 컬럼값으로 DEFAULT 를 작성하면
-- 테이블 생성 시 해당 컬럼에 지정된 DEFAULT 값으로 삽입이 된다.

INSERT INTO MEMBER VALUES ('MEM02', '456QWE', '김영희', '940223-1124557', DEFAULT);
INSERT INTO MEMBER VALUES ('MEM03', '789ASD', '박철수', '951001-1253467', SYSDATE);

INSERT INTO MEMBER (MEMBER_ID, MEMBER_PWD, MEMBER_NAME)
VALUES ('MEM04', 'TDS1213', '이지연');

-- ** JDBC에서 날짜를 입력받았을 때 삽입하는 방법 **
-- '2022-09-13 17:33:27'
INSERT INTO MEMBER VALUES('MEM05', 'GFK593', '김길동', '931111-1653464', 
				TO_DATE('2022-09-13 17:33:27', 'YYYY-MM-DD HH24:MI:SS'));

SELECT * FROM "MEMBER";

COMMIT;


-- ** NUMBER 타입의 유의점 **
CREATE TABLE MEMBER2 (
	MEMBER_ID VARCHAR2(20),
	MEMBER_PWD VARCHAR2(20),
	MEMBER_NAME VARCHAR2(30),
	MEMBER_TEL NUMBER
);

INSERT INTO MEMBER2 VALUES('MEM01', 'PASS01', '고길동', 7712341234);
INSERT INTO MEMBER2 VALUES('MEM02', 'PASS02', '고길순', 01012341234);

SELECT * FROM MEMBER2;

--> NUMBER 타입 컬럼에 데이터 삽입 시
-- 제일 앞에 0이 있으면 이를 자동으로 제거함
--> 전화번호, 주민등록번호 처럼 숫자로만 되어있는 데이터라도
--> 0으로 시작할 가능성이 있으면 CHAR, VARCHAR2 같은 문자형 사용


----------------------------------------------------------------------------

-- ** 제약조건 (CONSTRAINTS) **

/*
 * 사용자가 원하는 조건의 데이터만 유지하기 위해서
 * 특정 컬럼에 설정하는 제약.
 * 데이터 무결성 보장을 목적으로 함.
 * 	--> 중복 데이터 X
 * 
 *  + 입력 데이터에 문제가 없는지 자동으로 검사하는 목적
 *  + 데이터의 수정/삭제 가능 여부 검사등을 목적으로 함
 * 	--> 제약조건을 위배하는 DML 구문은 수행할 수 없다!
 * 
 * 제약조건 종류
 * PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY
 * 
 */

-- 1. NOT NULL
-- 해당 컬럼에 반드시 값이 기록되어야 하는 경우에 사용
-- 삽입/수정시 NULL값을 허용하지 않도록 컬럼레벨에서 제한

CREATE TABLE USER_USED_NN (
	USER_NO NUMBER NOT NULL, -- 사용자 번호 (모든 사용자는 사용자 번호가 있어야한다.)
								--> 컬럼레벨 제약조건 설정
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
);

INSERT INTO USER_USED_NN
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_NN
VALUES(NULL, NULL, NULL, NULL, NULL, '010-1234-5678', 'hong1234@kh.or.kr');
--> NOT NULL 제약조건에 위배되어 오류 발생
-- ORA-01400: NULL을 ("KH"."USER_USED_NN"."USER_NO") 안에 삽입할 수 없습니다

SELECT * FROM USER_USED_NN;

DELETE FROM USER_USED_NN;

ROLLBACK;

-----------------------------------------------------

-- 2. UNIQUE 제약 조건
-- 컬럼에 입력값에 대해서 중복을 제한하는 제약조건
-- 컬럼레벨에서 설정 가능, 테이블 레벨에서 설정 가능
-- 단, UNIQUE 제약조건이 설정된 컬럼에 NULL 값은 중복 삽입 가능

-- * 테이블레벨 : 테이블 생성 시 컬럼 정의가 끝난 후 마지막에 작성

-- * 제약조건 지정 방법
-- 1) 컬럼 레벨 : [CONSTRAINT 제약조건명] 제약조건
-- 2) 테이블 레벨 : [CONSTRAINT 제약조건명] 제약조건(컬럼명)


-- UNIQUE 제약조건 테이블 생성

CREATE TABLE USER_USED_UK (
	USER_NO NUMBER, 
	-- USER_ID VARCHAR2(20) UNIQUE, -- 컬럼레벨 (제약조건명 미지정)
	-- USER_ID VARCHAR2(20) CONSTRAINT USER_ID_U UNIQUE, --  컬럼레벨 (제약조건명 지정)
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	/* 테이블 레벨 */
	-- UNIQUE(USER_ID) -- 테이블레벨 (제약조건명 미지정)
	CONSTRAINT USER_ID_U UNIQUE(USER_ID) -- 테이블레벨 (제약조건명 지정)
);



INSERT INTO USER_USED_UK
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_UN
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
-- 같은 아이디인 데이터가 이미 테이블에 있으므로 UNIQUE 제약조건에 위배되어 오류발생

INSERT INTO USER_USED_UK
VALUES(1, NULL, 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');
--> 아이디에 NULL 값 삽입 가능.

INSERT INTO USER_USED_UK
VALUES(1, NULL, 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');
--> 아이디에 NULL 값 중복 삽입 가능

SELECT * FROM USER_USED_UK;

DELETE FROM USER_USED_UK;

ROLLBACK;
---------------------------------------------------------------


-- UNIQUE 복합키
-- 두 개 이상의 컬럼을 묶어서 하나의 UNIQUE 제약조건을 설정함

-- * 복합키 지정은 테이블 레벨만 가능하다!
-- * 복합키는 지정되는 모든 컬럼의 값이 같을 때 위배된다!

CREATE TABLE USER_USED_UK2 (
	USER_NO NUMBER, 
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	CONSTRAINT USER_ID_NAME_U UNIQUE(USER_ID, USER_NAME)
);

INSERT INTO USER_USED_UK2
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_UK2
VALUES(1, 'USER02', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_UK2
VALUES(1, 'USER01', 'PASS01', '고길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_UK2
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH.USER_ID_NAME_U)에 위배됩니다

SELECT * FROM USER_USED_UK2;

ROLLBACK;

---------------------------------------------------------------------

-- 3. PRIMARY KEY(기본키) 제약조건

-- 테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미함
-- 테이블에 대한 식별자(학번, 사번, 회원번호) 역할을 함

-- NOT NULL + UNIQUE 제약조건의 의미 --> 중복되지 않는 값이 필수로 존재해야 함.

-- 한 테이블당 한개만 설정할 수 있음
-- 컬럼레벨, 테이블레벨, 둘다 설정 가능함
-- 한개 컬럼에 설정할 수 도 있고, 여러개의 컬럼을 묶어서 설정할 수 있음.

CREATE TABLE USER_USED_PK (
	USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY, -- 컬럼레벨 
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
	-- CONSTRAINT USER_ID_PK PRIMARY KEY(USER_ID) -- 테이블 레벨
);

INSERT INTO USER_USED_PK
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_PK
VALUES(1, 'USER02', 'PASS02', '이순신', '남', '010-5678-9999', 'LEE1234@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH.USER_NO_PK)에 위배됩니다
--> 기본키 중복으로 오류

INSERT INTO USER_USED_PK
VALUES(NULL, 'USER02', 'PASS02', '이순신', '남', '010-5678-9999', 'LEE1234@kh.or.kr');
--ORA-01400: NULL을 ("KH"."USER_USED_PK"."USER_NO") 안에 삽입할 수 없습니다
--> 기본키가 NULL 이므로 오류

-----------------------------------------------------------------

-- PRIMARY KEY 복합키 (테이블 레벨만 가능)

CREATE TABLE USER_USED_PK2 (
	USER_NO NUMBER, -- 컬럼레벨 
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	CONSTRAINT USER_ID_PK PRIMARY KEY(USER_ID, USER_NO) -- 테이블 레벨
);

INSERT INTO USER_USED_PK2
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'USER02', 'PASS02', '이순신', '남', '010-5678-9999', 'LEE1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(2, 'USER01', 'PASS02', '이순신', '남', '010-5678-9999', 'LEE1234@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'USER01', 'PASS02', '이순신', '남', '010-5678-9999', 'LEE1234@kh.or.kr');
-- ORA-00001: 무결성 제약 조건(KH.USER_ID_PK)에 위배됩니다
--> 회원 번호와 아이디 둘다 중복되었을 때만 제약조건 위배 에러

INSERT INTO USER_USED_PK2
VALUES(NULL, 'USER01', 'PASS02', '이순신', '남', '010-5678-9999', 'LEE1234@kh.or.kr');
--ORA-01400: NULL을 ("KH"."USER_USED_PK2"."USER_NO") 안에 삽입할 수 없습니다
--> PRIMAEY KEY는 NULL이 들어갈 수 없다.


-------------------------------------------------------------

-- 4. FOREIGN KEY(외부키/외래키) 제약조건

-- 참조된 다른 테이블의 컬럼이 제공하는 값만 사용할 수 있음
-- FOREIGN KEY 제약조건에 의해서 테이블간 관계가 형성됨
-- 제공하는 값 외에는 NULL(참조하는 값 없음) 을 사용할 수 있음.

-- 컬럼레벨일 경우
-- 컬럼명 자료형 (크기) [CONSTRAINT 이름] REFERENCES [(참조할 컬럼)] [삭제룰]





-- 테이블레벨일 경우
-- [CONSTRAINT 이름] FOREIGN KEY (적용할 컬럼명) REFERENCES [(참조할 컬럼)] [삭제룰]


-- * 참조될 수 있는 컬럼은 PRIMARY KEY 컬럼과, UNIQUE 지정된 컬럼만 외래키로 사용할 수 있음
-- 참조할 테이블의 참조할 컬럼명이 생략되면, PRIMARY KEY로 설정된 컬럼이 자동 참조할 컬럼이 됨


CREATE TABLE USER_GRADE(
	GRADE_CODE NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES (10, '일반회원');
INSERT INTO USER_GRADE VALUES (20, '우수회원');
INSERT INTO USER_GRADE VALUES (30, '특별회원');

SELECT * FROM USER_GRADE;



CREATE TABLE USER_USED_FK (
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK REFERENCES USER_GRADE /*(GRADE_CODE)*/ -- 컬럼레벨
											-- 컬럼명 미작성 USER_GRADE 테이블의 PK자동참조
	-- 테이블레벨
	-- CONSTRAINT GRADE_CODE_FK FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE
							--> FOREIGN KEY 라는 단어는 테이블 레벨에서만 사용!
);

COMMIT;

INSERT INTO USER_USED_FK
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(2, 'USER02', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(3, 'USER03', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr', 30);

INSERT INTO USER_USED_FK
VALUES(4, 'USER04', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr', NULL);
--> NULL 사용 가능

INSERT INTO USER_USED_FK
VALUES(5, 'USER05', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr', 50);
-- ORA-02291: 무결성 제약조건(KH.GRADE_CODE_FK)이 위배되었습니다- 부모 키가 없습니다
--> 50 이라는 값은 USER_GRADE 테이블 GRADE_CODE 컬럼에서 제공하는 값이 아니므로
-- 외래키 제약조건에 위배되어 오류 발생.

COMMIT;

-------------------------------

-- * FOREIGN KEY 삭제 옵션

-- 부모테이블의 데이터 삭제 시 자식 테이블의 데이터를
-- 어떤식으로 처리할 지에 대한 내용을 설정 할 수 있다.

-- 1) ON DELETE RESRTICTED(삭제 제한)로 기본 지정되어 있음
-- 외래키로 지정된 컬럼에서 사용되고 있는 값일 경우
-- 제공하는 컬럼의 값을 삭제하지 못함
DELETE FROM USER_GRADE WHERE GRADE_CODE = 30;
-- ORA-02292: 무결성 제약조건(KH.GRADE_CODE_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다

SELECT * FROM USER_USED_FK;

-- GRADE_CODE 중 20은 외래키로 참조되고 있지 않았으므로 삭제가 가능함.
DELETE FROM USER_GRADE WHERE GRADE_CODE = 20;

SELECT * FROM USER_GRADE;

ROLLBACK;


-- 2) ON DELETE SET NULL : 부모키 삭제시 자식키를 NULL로 변경하는 옵션

CREATE TABLE USER_GRADE2(
	GRADE_CODE NUMBER PRIMARY KEY,
	GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 VALUES (10, '일반회원');
INSERT INTO USER_GRADE2 VALUES (20, '우수회원');
INSERT INTO USER_GRADE2 VALUES (30, '특별회원');

SELECT * FROM USER_GRADE2;


-- ON DELETE SET NULL 삭제 옵션이 적용된 테이블 생성
CREATE TABLE USER_USED_FK2 (
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50),
	GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK2 REFERENCES USER_GRADE2 ON DELETE SET NULL
);


INSERT INTO USER_USED_FK2
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr', 10);

INSERT INTO USER_USED_FK2
VALUES(2, 'USER02', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr', 10);

INSERT INTO USER_USED_FK2
VALUES(3, 'USER03', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr', 30);

INSERT INTO USER_USED_FK2
VALUES(4, 'USER04', 'PASS01', '홍길동', '남', '010-1234-5678', 'hong1234@kh.or.kr', NULL);


COMMIT;

SELECT * FROM USER_GRADE2;
SELECT * FROM USER_USED_FK2;

DELETE  FROM USER_GRADE2
WHERE GRADE_CODE = 10;

SELECT * FROM USER_USED_FK2;
















































