
--형 변환 함수 TO_CHAR(문자), TO_NUMBER(숫자), TO_DATE(날짜)

--날짜를 문자로 TO_CHAR(값,형식)
SELECT TO_CHAR(sysdate) FROM dual;
SELECT TO_CHAR(sysdate,'YYYY-MM-DD DY PM HH:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate,'YYYY-MM-DD HH24:MI:SS') FROM dual;

-- 문자열에 한글을 치고싶다면 쌍따옴표를 써야한다.
SELECT
    first_name, TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일"')
FROM employees;

--숫자를 문자로 TO-CHAR(값,형식)
--형식에서 사용하는 '9'는 실제 숫자 9가 아니라 자리수를 표현하기 위한 기호입니다.
SELECT TO_CHAR(20000,'99999') FROM dual;
--주어진 자릿수에 숫자를 모두 표기할 수 없어서 모두 #으로 표기됩니다.
SELECT TO_CHAR(20000,'9999') FROM dual;
SELECT TO_CHAR(20000.29,'99999.9') FROM dual;
SELECT TO_CHAR(20000,'99,999') FROM dual;
-- L 붙이면 W 표시가 나온다.
SELECT TO_CHAR(salary, 'L99,999') AS salary
FROM employees;

--문자를 숫자로 TO_NUMBER(값,형식)
SELECT '2000' + 2000 FROM dual; --자동 형 변환 (문자->숫자)
SELECT TO_NUMBER('2000') + 2000 FROM dual; --명시적 형 변환
SELECT '$3,300' + 2000 FROM dual;-- 에러
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 FROM dual;

--문자를 날짜로 변환하는 함수 TO_DATE(값,형식)
SELECT TO_DATE('1998-10-30') FROM dual;
SELECT sysdate - TO_DATE('1998-10-30') FROM dual;
SELECT TO_DATE('1998/10/30', 'YY-MM-DD') FROM dual;
--주어진 문자열을 모두 변환해야 합니다.
SELECT TO_DATE('1998-10-30 12:23:50', 'YY-MM-DD HH:MI:SS') FROM dual;

--xxxx년 xx월 xx일 문자열 형식으로 변환해 보세요.
-- 조회 컬럼명은 dateInfo 라고 하겠습니다.
SELECT TO_CHAR(TO_DATE('19981030','YYYYMMDD'),
'YYYY"년" MM"월" DD"일"')AS dateInfo FROM dual;

-- NULL형태를 변환하는 함수 NVL(컬럼, 변환할 타겟값)
SELECT NULL FROM dual;
SELECT NVL(NULL,0) FROM dual;

SELECT
    first_name,
    commission_pct,
    NVL(commission_pct, 0) AS comm_pct
FROM employees;

--NULL 변환 함수 NVL2(컬럼,NULL이 아닌 경우의 값, NULL일 경우의 값)
SELECT
    NVL2('abc','널아님','널임') --널아님
 --   NVL2(NULL,'널아님','널임')  널임
FROM dual;

SELECT 
    first_name,
    NVL2(commission_pct, 'true', 'false')-- 커미션을 받으면 트루 안받으면 false
FROM employees;

-- NVL2 를 사용하지 않으면 NULL 이 연산이 되지 않는다
SELECT
    first_name,
    commission_pct,
    NVL2(commission_pct,(salary * commission_pct),
    salary
   ) AS real_salary
FROM employees;

--DECODE(컬럼 혹은 표현식, 항목1, 결과1, 항목2, 결과2 ...... default) SWITCH 문이랑 비슷
SELECT
    DECODE('C','A','A입니다','B','B입니다','C','C입니다', '뭥 미?')
FROM dual;

SELECT
    job_id,
    salary,
    DECODE(
        job_id,
        'IT_PROG',salary*1.1,--10퍼
        'FI_MGR',salary*1.2,--20퍼
        'AD_VP',salary*1.3, --30퍼
        salary
    ) AS result
FROM employees;

--CASE WHEN THEN END
SELECT
    first_name,
    job_id,
    salary,
    (CASE job_id
        WHEN 'IT_PROG' THEN salary*1.1
        WHEN 'FI_MGR' THEN salary*1.2
        WHEN 'AD_VP' THEN salary*1.3
        WHEN 'FI_ACCOUNT' THEN salary*1.4
        ELSE salary
    END) AS result
FROM employees;

/*
문제 1.
현재일자를 기준으로 employees테이블의 입사일자(hire_date)를 참조해서 근속년수가 17년 이상인
사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다
*/

--SELECT 
--first_name, hire_date,
--NVL2(((sysdate - hire_date) / 365),
--((sysdate - hire_date) / 365)>17,'고인물',
--((sysdate - hire_date) / 365)<17,'짬안됨')   
--FROM employees; 
--ORDER BY 

-- 실행이 제일 먼저 되는 순 FROM (table) -> WHERE
-- 그러므로 WHERE엔 근속년수가 적용이 안되고 
--ORDER은 수행이 늦게 되기 때문에 근속년수가 가능하다.
SELECT
    employee_id AS 사원번호,
    CONCAT(first_name,last_name) AS 사원명,
    hire_date AS 입사일자,
    TRUNC((sysdate-hire_date) / 365) AS 근속년수
FROM employees
WHERE (sysdate-hire_date) / 365 >= 17
ORDER BY 근속년수 DESC;
/*
문제 2.
EMPLOYEES 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
100이라면 ‘사원’, 
120이라면 ‘주임’
121이라면 ‘대리’
122라면 ‘과장’
나머지는 ‘임원’ 으로 출력합니다.
조건 1) department_id가 50인 사람들을 대상으로만 조회합니다
*/

SELECT
    first_name,
    manager_id,
    DECODE(
    manager_id,
        100, '사원',
        120, '주임',
        121, '대리',
        121, '과장',
        '임원'
    ) AS 직급
FROM employees
WHERE department_id = 50;