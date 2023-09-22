
-- 그룹 함수 AVG, MAX , MIN , SUM , COUNT

SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)    
FROM employees;

SELECT COUNT(*) FROM employees; -- 총 행 데이터의 수 107개
SELECT COUNT(first_name) FROM employees; --107개
SELECT COUNT(commission_pct) FROM employees; -- NULL은 세지 않기 때문에 35개
SELECT COUNT(manager_id) FROM employees; --king은 안들어가서 106개

-- 부서별로 그룹화, 그룹함수의 사용
SELECT
    --job_id, 쓴다면 에러가 난다 ( job_id는 그룹화가 되지 않기 떄문이다)
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id;

--주의할 점
-- 그룹함수는 일반 컬럼과 동시에 그냥 출력할 수는 없습니다.
-- department_id 와 AVG(salary) 에 출력 값이 같은 열로 나와야하니까 지정을 GROUP으로 해줘야한다.
SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id; -- ERROR

-- GROUP BY절 2개 이상 사용

SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id,job_id
ORDER BY department_id;

--GROUP BY를 통해 그룹화 할 때 조건을 걸 경우 HAVING을 사용

SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;

SELECT
    job_id,
    COUNT(*)
FROM employees
GROUP BY job_id
HAVING COUNT (*) >= 5
ORDER BY COUNT(*) ASC;

-- 부서 아이디가 50 이상인 것들을 그룹화 시키고, 그룹 월급평균이 5000이만 조회

SELECT
    department_id,
    AVG(salary) AS 평균
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id DESC;

/*
문제 1.
사원 테이블에서 JOB_ID별 사원 수를 구하세요.
사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
*/
SELECT
    job_id,
    COUNT(*)
FROM employees
GROUP BY job_id;

SELECT
    job_id,
    AVG(salary) AS 평균월급
FROM employees
GROUP BY job_id
ORDER BY AVG(salary)DESC;

/*
문제 2.
사원 테이블에서 입사 년도 별 사원 수를 구하세요.
(TO_CHAR() 함수를 사용해서 연도만 변환합니다. 그리고 그것을 그룹화 합니다.) hire_date
*/
SELECT
    TO_CHAR(hire_date,'yy') AS 입사년도,
    COUNT(*) AS 사원수
FROM employees
GROUP BY TO_CHAR(hire_date, 'yy')
ORDER BY 입사년도 ASC;

/*
문제 3.
급여가 5000 이상인 사원들의 부서별 평균 급여를 출력하세요. 
단 부서 평균 급여가 7000이상인 부서만 출력하세요.
*/
SELECT
    department_id,
    AVG(salary) AS 평균급여
FROM employees
WHERE salary >= 5000
GROUP BY department_id
HAVING AVG(salary) >= 7000
ORDER BY department_id ASC;

/*
문제 4.
사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
*/
SELECT
    department_id,
    TRUNC(AVG(salary + (salary * commission_pct)), 2) AS 평균,
    SUM(salary +salary * commission_pct) AS SUM,
    COUNT(*)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;


