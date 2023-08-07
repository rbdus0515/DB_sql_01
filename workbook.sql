
-- 문제 1 --
SELECT DEPARTMENT_NAME 학과명 , CATEGORY 계열
FROM TB_DEPARTMENT;

-- 문제 2 --
SELECT CAPACITY "학과별 정원", DEPARTMENT_NAME || "의 정원은" || CAPACITY || "명 입니다."
FROM TB_DEPARTMENT;

-- 문제 3 --
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 001
AND ABSENCE_YN = 'Y'
AND SUBSTR(STUDENT_SSN, 8, 1) = 2;

-- 문제 4 --
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- 문제 5 --
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30 ;

-- 문제 6 --
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 문제 7 --
SELECT DEPARTMENT_NO
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 문제 8 --
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 문제 9 --
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

-- 문제 10 --
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE 





















