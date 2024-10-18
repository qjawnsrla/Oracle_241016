-- 함수 : 특정 결과 데이터를 얻기 위해 데이터를 입력 할 수 있는 특수명령어를 의미
-- 함수에는 내장함수와 사용자 정의함수가 있음
-- 내장 함수에는 당일행 함수와 다중행 함수(집계함수)로 나누어짐
-- 단일행 함수 : 데이터가 한 행씩 입력되고 결과가 한 행씩 나오는 함수
-- 다중행 함수 : 여러 행이 입력되어서 하나의 행으로 결과가 반환되는 것
-- 숫자 함수 : 수학 계산식을 처리하기 위한 함수

SELECT -10, abs(-10) FROM dual;

-- ROUND (숫자, 반올림할 위치) : 반올림한 결과를 반환하는 함수
SELECT ROUND(1234.5678) AS "ROUND", -- 소수점 첫째자리에 반올림해서 결과를 반환
	ROUND(1234.5678, 0) AS ROUND_0,
	ROUND(1234.5678, 1) AS ROUND_1, -- 소수점 두번째 자리에서 반올림해서 소수점 1자리표시 
	ROUND(1234.5678, 2) AS ROUND_2, -- 소수점 세번째 자리에서 반올림해서 소수점 2자리표시
	ROUND(1234.5678, -1) AS ROUND_MINUS1, -- 정수 첫번째 자리를 반올림 1230
	ROUND(1234.5678, -2) AS ROUND_MINUS2 -- 정수 두번째 자리를 반올림 1200
	FROM dual;


-- TRUNC : 버림을 한 결과를 반환하는 함수, 자릿수 지정 가
SELECT TRUNC(1234.5678) AS "TRUNC", -- 소수점 첫째자리에 버림해서 결과를 반환
	TRUNC(1234.5678, 0) AS TRUNC_0,
	TRUNC(1234.5678, 1) AS TRUNC_1, -- 소수점 두번째 자리에서 버림해서 소수점 1자리표시 
	TRUNC(1234.5678, 2) AS TRUNC_2, -- 소수점 세번째 자리에서 버림해서 소수점 2자리표시
	TRUNC(1234.5678, -1) AS TRUNC_MINUS1, -- 정수 첫번째 자리를 버림 1230
	TRUNC(1234.5678, -2) AS TRUNC_MINUS2 -- 정수 두번째 자리를 버림 1200
	FROM dual;

-- MOD : 나누기 한 후 나머지를 출력하는 함수
SELECT MOD (21, 5) FROM dual;
-- CEIL : 소수점 이하를 올림
SELECT CEIL (12.345) FROM dual;
-- FLOOR : 소수점 이하를 날림
SELECT FLOOR(12.999) FROM dual;
-- POWER : 제곱하는 함수
SELECT POWER(3, 4) FROM dual;	-- 3 * 3 * 3 * 3
-- DUAL : SYS 계정에서 제공하는 테이블, 테이블 참조없이 실행해보기 위해 FROM 절에 사용하는 더비 테이블
SELECT 20*30 FROM dual;

-- 문자 함수 : 문자 데이터로부터 특정 결과를 얻고자 할 때 사용하는 함수 
SELECT ename, UPPER(ename), LOWER(ename),INITCAP(ename)
	FROM emp;
-- UPPER 함수로 문자열 비교하기
SELECT * FROM EMP
	WHERE UPPER(ENAME) LIKE UPPER('%james%');

-- 문자열 길이를 구하는 LENGTH 함수, LENGTHB 함수
-- LENGTH : 문자열 길이를 반환
-- LENGTHB : 문자열의 바이트를 반환
SELECT LENGTH(ename), LENGTHB(ename)	-- 영어는 한바이트를 차지하기 때문에 길이와 바이트수가 동일
	FROM emp; 
	
SELECT LENGTH('하니'), LENGTHB('하니') FROM dual; 		-- 오라클 XE에서 한글은 3바이트 차지

-- 직책 이름의 길이가 6글자 이상이고, COMM 이 있는 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE LENGTH(job) >= 6 AND comm IS NOT NULL AND comm != 0;

-- SUNSTR / SUBSTRB : 시작 위치로부터 선택 개수만큼의 문자를 반환하는 함수, 인덱스는 1부터 시작
SELECT job, SUBSTR(job, 1, 2), SUBSTR(job, 3, 2), SUBSTR(job, 5)
	FROM emp;
	
-- SUBSTR 함수와 다른 함수 함께 사용
SELECT job,
	SUBSTR(job, -LENGTH(job)),		-- '1' 이면서 '-5' 의 위치이다
	SUBSTR(job, -LENGTH(job), 2),	-- '1' ~ '2' 까지 출력
	SUBSTR(job, -3)		-- '-3' ~ '-1' 까지 출력
	FROM emp;
	
-- INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지를 알고자 할 때 사용
SELECT INSTR('HELLO, ORACLE', 'L') AS INSTR_1, -- 'L'문자의 위치
	INSTR('HELLO, ORACLE', 'L', 5) AS INSTR_2, -- 5번째 위치에서 시작해서 'L'문자의 위치 찾기
	INSTR('HELLO, ORACLE', 'L', 2, 2) AS INSTR_3 -- 2번째 위치에서 시작해서 2번째 나타나는 'L'문자의 위치 찾기 
	FROM dual;

-- 특정 문자가 포함된 행 찾기
SELECT * FROM EMP
	WHERE INSTR(ENAME, 'S') > 0;	-- 'S' 문자가 포함된 행 출력
	
SELECT * FROM EMP
	WHERE ENAME LIKE '%S%';

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체할 때 사용 
SELECT '010-5006-4146' AS "변경 이전",
 	REPLACE('010-5006-4146', '-', '/') AS "변경 이후 1번째",
 	REPLACE('010-5006-4146', '-') AS "변경 이후 2번째"		-- 대체할 문자 미지정시 삭제라는 뜻 
 	FROM dual;
 
-- LPAD / RPAD : 기준 공간 칸수를 지정하고 빈칸만큼을 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+') FROM dual;
SELECT RPAD('ORACLE', 10, '+') FROM dual;

SELECT RPAD('010222-', 14, '*') AS RPAD_JUMIN,
	RPAD('010-5006-', 13, '*') AS RAPD_PHONE
FROM dual;

-- 두 문자열을 합치는 concat 함수
SELECT CONCAT(empno, ename),
	CONCAT(empno, CONCAT(' : ', ename)) AS "사원정보 : " 
	FROM emp
	WHERE ename = 'JAMES';

-- TRIM / LTRIM / RTRIM : 문자열 데이터에서 특정 문자를 지우기 위해 사용, 문자를 지정하지 않으면 공백을 
SELECT '[' || TRIM('  _ORACLE_  ') || ']' AS TRIM,
	'[' || LTRIM('  _ORACLE_  ') || ']' AS LTRIM,
	'[' || RTRIM('  _ORACLE_  ') || ']' AS RTRIM
	FROM dual;

-- 날짜 데이터를 다루는 함수
-- 날짜 데이터 + 숫자 : 가능, 날짜에서 숫자만큼의 이 후 날짜
-- 날짜 데이터 - 숫자 : 가능, 날짜에서 숫자만큼의 이 전 날짜
-- 날짜 데이터 - 날짜 데이터 : 가능, 두 날짜간의 일 수 차이
-- 날짜 데이터 + 날짜 데이터 : 연산 불가 
-- SYSDATE : 운영체제로부터 시간을 가져오는 함수
SELECT SYSDATE FROM dual;

SELECT SYSDATE AS "현재시간",
	SYSDATE -1 AS "어제",
	SYSDATE +1 AS "내일"
	FROM dual; 

-- 몇 개월 이후 날짜를 구하는 ADD_MONTH 함수 : 특정 날짜에 지정한 개월 수 이후 날짜 데이터를 반환
SELECT SYSDATE AS "현재 시간",
	ADD_MONTHS(SYSDATE, 3) AS "3개월 이후 날짜데이터" 	-- 현재 시간으로부터 3개월 이후 날짜 데이터 반환	
	FROM dual;

-- 입사 10주년이 되는 사원들의 데이터 출력하기 (입사일로부터 10년이 경과한 날짜데이터 반환)
SELECT empno, ename, hiredate AS "입사일", ADD_MONTHS(hiredate, 120) AS "10주년"
	FROM emp;

-- 두 날짜간의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수
SELECT empno, ename, hiredate, SYSDATE,
	MONTHS_BETWEEN(hiredate, SYSDATE) AS "- 재직 기간",
	MONTHS_BETWEEN(SYSDATE, hiredate) AS "재직 기간",
	TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) AS "재직 기간2"
FROM emp;

-- 돌아오는 요일(NEXT_DAY), 달의 마지막 날짜(LAST_DAY)
SELECT SYSDATE,
	NEXT_DAY(SYSDATE, '월요일'),
	LAST_DAY(SYSDATE)
FROM dual;

SELECT LAST_DAY('24/8/28') FROM dual;

-- 날짜 정보 추출 함수 : extract
SELECT EXTRACT (YEAR FROM DATE '2024-10-16')
FROM dual;

SELECT EXTRACT (MONTH FROM DATE '2024-10-16')
FROM dual;

SELECT * FROM EMP
	WHERE EXTRACT (MONTH FROM hiredate) = 12;

-- 자료형을 변환하는 형 변환 함수
SELECT empno, ename, empno + '500' 	-- 오라클의 기본 형변환 변경가능 숫자로 변환
	FROM EMP e 
WHERE ename = 'FORD';
	
SELECT empno, ename, '23445' + '500' 	-- 오라클의 기본 형변환 변경가능 숫자로 변환
	FROM EMP e 
WHERE ename = 'FORD';

-- 날짜, 숫자를 문자로 변환하는 TO_CHAR 함수 : 자바의 SimpleDateForamat 과 유사
SELECT SYSDATE AS "기본시간형태", TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS "현재날짜"
FROM dual;

SELECT SYSDATE,
	TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS 연도,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS ') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS 쿼터,
    TO_CHAR(SYSDATE, 'DD') AS 일,
    TO_CHAR(SYSDATE, 'DDD') AS 경과일,
    TO_CHAR(SYSDATE, 'HH') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH12') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH24') AS "24시간제",
    TO_CHAR(SYSDATE, 'W') AS 몇주차
	FROM dual;

SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'MM') AS MM,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MONTH_KOR,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MONTH_ENG
FROM dual;

-- 숫자 데이터 형식을 지정하여 출력하기
SELECT sal,
	TO_CHAR(sal, '$999,999') AS sal_$, 	-- 9 는 숫자의 한 자리를 의미하고 빈자리를 채우지 않음
	TO_CHAR(sal, 'L999,999') AS sal_L, 	-- 지역 화폐 단위 출력
	TO_CHAR(sal, '999,999.00') AS sal_1, -- 0 은 빈자리를 0으로 채움
	TO_CHAR(sal, '000,999,999.00') AS sal_2
FROM emp;
	
-- TO_NUMBER : 숫자 타입의 문자열을 숫자 데이터로 변환해주는 함수
SELECT 1300 - '1500', TO_NUMBER('1300') + '1500'
FROM dual;

-- TO_DATE : 문자열로 명시 날짜로 변환하는 함수
SELECT TO_DATE('24/10/24', 'YY/MM/DD') 
FROM dual;

SELECT TO_DATE('24-10-24', 'YY/MM/DD') AS "날짜타입1",
	TO_DATE('20240714', 'YYYY/MM/DD') AS "날짜타입2" 
FROM dual;
-- 1987년 7월 1일 이후 입사한 사원 정보 출력하기
SELECT *
	FROM EMP
	WHERE HIREDATE > TO_DATE('1981/07/01', 'YYYY/MM/DD');

SELECT *
	FROM EMP
	WHERE HIREDATE > '1981/07/01'	-- 원칙적으로는 위의 구문이 옳음
	
-- NULL 처리 함수 : 특정 열의 행에 데이터가 없는 경우 데이터값이 NULL이 됨 (NULL 값이 없음)
-- NULL : 값이 할당되지 않았기 때문에 공백이나 0과는 다른 의미, 연산(계산, 비교 등등)
-- NVL(검사할 데이터 또는 열, 앞의 데이터가 NULL인 경우 대체할 값)
SELECT empno, ename, sal, comm, sal+comm,
	NVL(comm, 0),
	sal+NVL(comm, 0) AS 연봉 
	FROM emp;

-- NVL2(검사할 데이터, 데이터 NULL이 아닐 때 반환되는 값, 데이터 NULL 일 때 반환되는 값)
SELECT empno, ename, comm, 
	NVL2(comm, 'O', 'X'),
	NVL2(comm, sal*12+comm, sal*12) AS "연봉"
	FROM emp;

-- NULLIF : 두 값을 비교하여 동일하면 NULL, 동일하지 않으면 첫 번째 값을 반환
SELECT NULLIF (10, 10), NULLIF ('A', 'B')
FROM dual;

-- DECODE : 주어진 데이터 값이 조건 값과 일치하는 값을 출력하고 일치하는 값이 없으면 기본 값 출력
SELECT empno, ename, job, sal,
	DECODE(job,
		'MANAGER', sal * 1.1,
		'SALESMAN', sal * 1.05,
		'ANALYST', sal,
		sal*1.03) AS "연봉인상"
	FROM emp;

-- CASE : SQL의 표준함수, 일반적으로 SELECT절에서 많이 사용됨
SELECT empno, ename, job, sal,
	CASE job
		WHEN 'MANAGER' THEN sal * 1.1
		WHEN 'SALESMAN' THEN sal * 1.05
		WHEN 'ANALYST' THEN sal
		ELSE sal * 1.03
	END AS "연봉인상"
FROM emp;

-- 열 값에 따라서 출력이 달라지는 case 문 : 기준 데이터를 지정하지 않고 사용하는 방법
SELECT empno, ename, comm,
	CASE 
		WHEN comm IS NULL THEN '해당 사항 없음'
		WHEN comm = 0 THEN '수당 없음'
		WHEN comm > 0 THEN '수당 : ' || comm
	END AS "수당 정보"
	FROM emp;

-- 1. EMP 테이블에서 사번, 사원명, 급여조회 (단, 급여는 100 단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT empno, ename,
	TRUNC(sal, -2) AS "TRUNC"
	FROM EMP
	ORDER BY sal DESC;
	
-- 2. EMP 테이블에서 9월에 입사한 직원의 정보 조회
SELECT * FROM EMP
	WHERE EXTRACT (MONTH FROM hiredate) = 9;

-- 3. EMP 테이블에서 사원, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT ename, empno, hiredate, ADD_MONTHS(hiredate, 4800) AS "40주년"
	FROM emp;

-- 4. EMP 테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
SELECT * FROM EMP
	WHERE MONTHS_BETWEEN(SYSDATE, hiredate) / 12 >= 38;
	


-- 실습 문제 : 노션에 DATABASE -> 함수 파트 아래에 있음

-- Q1.
SELECT empno,
	CONCAT(SUBSTR(empno, -LENGTH(empno), 2), '**') AS "MASKING_EMPNO",
	ename AS "ENAME",
	CONCAT(SUBSTR(ename, -LENGTH(ename), 1), '****') AS "MASKING_ENAME"
	FROM emp
	WHERE LENGTH(ename) >= 5 AND LENGTH(ename) < 6;

SELECT empno, RPAD(SUBSTR(empno, 1, 2), 4, '*') AS MAKING_EMPNO,
	ename, RPAD(SUBSTR(ename, 1, 1), LENGTH(ename), '*') AS MAKING_ENAME
	FROM emp
	WHERE LENGTH(ename) = 5;


-- Q2.
SELECT empno, ename, sal,
	TRUNC(SAL/21.5 , 2) AS "DAY_PAY",	-- 소수점 3번째자리에서 버림해서 2번째 자리 출력
	ROUND((SAL/21.5)/8, 1) AS "TIME_PAY"
	FROM EMP;


-- Q3.
SELECT empno, ename,
	TO_CHAR(hiredate, 'YYYY/MM/DD') AS "HIREDATE",
	TO_CHAR(ADD_MONTHS(HIREDATE , 3), 'YYYY/MM/DD') AS "R_JOB",
	comm
	FROM emp;

SELECT empno, ename, hiredate,
	TO_CHAR(NEXT_DAY(ADD_MONTHs(hiredate, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	NVL(TO_CHAR(comm), 'N/A') AS comm
	FROM emp;


-- Q4.
SELECT empno, ename, mgr,
	CASE
		WHEN mgr IS null THEN '0000'
		WHEN SUBSTR(mgr, 1, 2) = '75' THEN '5555'
		WHEN SUBSTR(mgr, 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(mgr, 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(mgr, 1, 2) = '78' THEN '8888'
		ELSE CAST(mgr AS VARCHAR(4))
	END AS "CHG_MGR"
	FROM emp;

SELECT empno, ename, mgr,
	CASE 
		WHEN mgr IS NULL THEN '0000'
		WHEN substr(mgr,1,2) = '78' THEN '8888'
		WHEN substr(TO_CHAR(mgr),1,2) = '77' THEN '7777'
		WHEN substr(TO_CHAR(mgr),1,2) = '76' THEN '6666'
		WHEN substr(TO_CHAR(mgr),1,2) = '75' THEN '5555'
		ELSE to_CHAR(mgr)
	END AS CHG_MGR
	FROM emp;
	
	
	
	
	
	
	
	
	
	
	