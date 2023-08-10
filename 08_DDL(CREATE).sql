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





























