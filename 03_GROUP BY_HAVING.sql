/* SELECT 문 해석순서
 * 
 * 5. SELECT 컬럼명 AS 별칭, 계산식, 함수식
 * 1. FROM 참조할 테이블명
 * 2. WHERE 컬럼명 | 함수식 비교연산자 비교값
 * 3. GROUP BY 그룹을 묶을 컬럼명
 * 4. HAVING 그룹함수식 비교연산자 비교값
 * 6. ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식 [NULLS FIRST | LAST];
 * 
 * 
 */

--------------------------------------------------------------------------------

-- GROUP BY 절 : 같은 값들이 여러개 기록된 컬럼을 가지고 같은 값들을 하나의 그룹으로 묶음
-- GROUP BY 컬럼명 | 함수식, ...
-- 여러개의 값을 묶어서 하나로 처리할 목적으로 사용
-- 그룹으로 묶은 값에 대해서 SELECT절 그룹함수를 사용함.

-- 그룹 함수는 단 한개의 결과값만 산출하기 때문에
-- 그룹이 여러개일 경우 오류발생

-- EMPLOYEE 테이블에서 부서코드, 부서별 급여 합 조회
-- 1) 부서코드만 조회
SELECT DEPT_CODE FROM EMPLOYEE; -- 23행

-- 2) 전체 급여 합 모음
SELECT SUN(SARALY) FROM EMPLOYEE; -- 1행

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE -- 1
GROUP BY DEPT_CODE; -- 3
GROUP BY DEPT_COME DEFP 가 기치헹끼리 하나의 그룹이 됨



--
SELECT JOB_CODE, ROUND(AVG(SALARY), COUNT(*))
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE 테이블에서
-- 성별(남/여)와 각 성별 별 인원 수, 급여합을
-- 인원수 오름 차순으로 조회

SELECT DECODE( SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여' ) 성별,
	COUNT(*) "인원 수",
	SUM(SALARY) "급여 합"
FROM EMPLOYEE
GROUP BY DECODE( SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여' ) -- 별칭 사용 X (SELECT절 해석 X)
ORDER BY "인원 수"; -- 별칭 사용 O (SELECT절 해석 완료)

---------------------------------------------------------------


----- WHERE절 GROUP BY절을 혼합하려 사용 -----
--> WHERE절은 각 컬럼에 대한 조건

 /* SELECT 문 해석 순서
  * 
  * 5. SELECT 컬럼명 AS 별칭, 계산식, 함수식
  * 1. FROM 참조할 테이블명
  * 2. WHERE 컬럼명 | 함수식 비교연산자 비교값
  * 3. GROUP BY 그룹을 묶을 컬럼명
  * 4. HAVING 그룹함수식 비교연산자 비교값
  * 6. ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식 [NULLS FIRST | LAST];
  */ 

-- EMPLOYEE 테이블에서 부서코드가 D5, D6인 부서의 부서별 평균 급여, 인원 수 조회

SELECT DEPT_CODE, ROUND(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5', 'D6')
GROUP BY DEPT_CODE;


-- EMPLOYEE 테이블에서 직급별 2000년도 이후(2000년 포함) 입사자들의 급여합을 조회
-- (직급코드 오름차순)

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE HIRE_DATE >= TO_DATE('2000-01-01') 
GROUP BY JOB_CODE
ORDER BY 1;

--------------------------------------------------------------------------

-- 여러 컬럼을 묶어서 그룹으로 지정 가능 --> 그룹내 그룹

-- EMPLOYEE 테이블에서 부서별로 같은 직급인 사원의 수를 조회

SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE -- DEPT_CODE로 그룹을 나누고
							  -- 나눠진 그룹내에서 JOB_CODE로 또 그룹을 분류
							  --> 세분화
ORDER BY DEPT_CODE, JOB_CODE DESC; 

-- *** GROUP BY 사용 시 주의사항 ***
-- SELECT문에 GROUP BY절을 사용할 경우
-- SELECT절에 명시한 조회하려는 컬럼 중
-- 그룹함수가 정용되지 않은 컬럼을
-- 모두 GROUP BY절에 작성해야함.





























