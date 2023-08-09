
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
WHERE ABSENCE_YN = 'N'
AND STUDENT_NO LIKE 'A21%'
AND STUDENT_ADDRESS LIKE '전주%';

------------------------------------------------------

------------------ 함수 ------------------

-- 문제 1
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY/MM/DD') 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY 입학년도;

-- 문제 2
SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 문제 3
SELECT PROFESSOR_NAME 교수이름, ABS(SUBSTR(PROFESSOR_SSN, 1, 2) + 1900 - 2023) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1' 
ORDER BY 나이;

-- 문제 4
SELECT SUBSTR(PROFESSOR_NAME, 2, 2) 이름
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME LIKE '___';

-- 문제 5 ***
SELECT STUDENT_NO , STUDENT_NAME 
FROM TB_STUDENT
WHERE ABS(TO_DATE(SUBSTR(STUDENT_SSN, 1, 2)) - ENTRANCE_DATE) = '19';

-- 문제 6
SELECT TO_CHAR(TO_DATE('2020-12-25'), 'DAY')
FROM DUAL;

-- 문제 7
SELECT TO_DATE('99/10/11', 'YY/MM/DD'), -- 2099년 10월 11일
TO_DATE('49/10/11', 'YY/MM/DD'), -- 2049년 10월 11일
TO_DATE('99/10/11', 'RR/MM/DD'), -- 1999년 10월 11일
TO_DATE('49/10/11', 'RR/MM/DD') -- 2049년 10월 11일
FROM DUAL;

-- 문제 8
SELECT STUDENT_NO , STUDENT_NAME 
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 문제 9
SELECT ROUND(AVG(POINT), 1) 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 문제 10 ***
SELECT DEPARTMENT_NO 학과번호 , COUNT(*) "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 문제 11
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 문제 12
SELECT SUBSTR(TERM_NO, 1, 4) 년도, ROUND(AVG(POINT), 1) "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

-- 문제 13
SELECT DEPARTMENT_NO 학과코드명, SUM(DECODE(ABSENCE_YN, 'Y', 1, 0)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 문제 14
SELECT STUDENT_NAME 동일이름, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY 1;

-- 문제 15
SELECT NVL(SUBSTR(TERM_NO, 1, 4), ' ') 년도,
		NVL(SUBSTR(TERM_NO, 5, 2), ' ') 학기,
		ROUND(AVG(POINT), 1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4) , SUBSTR(TERM_NO, 5, 2))
ORDER BY SUBSTR(TERM_NO, 1, 4);


------------------------------------------------------------------------

----- 옵션 -----

-- 문제 1
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS 주소지
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

-- 문제 2
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;\

-- 문제 3
SELECT STUDENT_NAME 학생이름 , STUDENT_NO 학번 , STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE STUDENT_ADDRESS LIKE '경기도%'
AND STUDENT_NO LIKE '9%'
ORDER BY STUDENT_NAME;

-- 문제 4
SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN;

-- 문제 5
SELECT STUDENT_NO , TO_CHAR(POINT, 'FM9.00') POINT
FROM TB_GRADE
WHERE TERM_NO = '200402'
AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO ;

-- 문제 6
SELECT STUDENT_NO , STUDENT_NAME , DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

-- 문제 7
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

-- 문제 8
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR USING (PROFESSOR_NO);

-- 문제 9
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR P USING (PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회';

-- 문제 10
SELECT STUDENT_NO 학번, STUDENT_NAME "학생 이름" , ROUND(AVG(POINT), 1) "전체 평점"
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NO  , STUDENT_NAME
ORDER BY 1;

-- 문제 11
SELECT 
FROM 

-- 문제 12
SELECT 
FROM 

-- 문제 13
SELECT 
FROM 

-- 문제 14
SELECT 
FROM 

-- 문제 15
SELECT 
FROM 

-- 문제 16
SELECT 
FROM 

-- 문제 17
SELECT 
FROM 

-- 문제 18
SELECT 
FROM 

-- 문제 19
SELECT 
FROM 



















