/*
# 서브쿼리 
1. SQL 문장 안에 또다른 SQL을 포함하는 방식.
여러 개의 질의를 동시에 처리할 수 있습니다.
WHERE, SELECT, FROM 절에 작성이 가능합니다.

- 서브쿼리의 사용방법은 () 안에 명시함.
 서브쿼리절의 리턴행이 1줄 이하여야 합니다.
- 서브쿼리 절에는 비교할 대상이 하나 반드시 들어가야 합니다.
- 해석할 때는 서브쿼리절 부터 먼저 해석하면 됩니다.
 먼저 수행해서 검색 값을 더 정확히 걸러주기 위해서 서브(하위)쿼리를 쓴다.
*/

SELECT salary FROM employees
WHERE first_name = 'Nancy';

SELECT first_name FROM employees
WHERE salary > 12008;

--'Nancy'의 급여보다 급여가 많은 사람을 검색하는 문장 (_) 가 
-- 먼저 수행하고 값이 나온다음 겉에 문장식이 적용된다.
SELECT first_name FROM employees
WHERE salary > (SELECT salary FROM employees
                WHERE first_name = 'Nancy');
                
-- employee_id 가 103번인 사람의 job_id와 동일한 job_id를 가진 사람을 조화.
SELECT * FROM  employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG'); 
-- 단일행 연산자 말고 다중행 연산자를 사용해야 합니다.
-- 단일행 서브쿼리라 = (딱 하나의 값만 정의해야한다.)
-- 단일행 연산자(=,>,<,>=,<=,<>) 사용하는 경우는 하나의 행만 반환해야 합니다.

--다중행 연산자 (IN, ANY, ALL)
-- IN : 안에 중에 하나라도 있다면 검색 나타내라.
SELECT * FROM  employees
WHERE job_id IN (SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG'); 

-- first_name이 David인 사람 중 급여와 같은 급여를 받는 사람들을 조회.
SELECT * FROM employees
WHERE salary IN(SELECT salary FROM employees
                WHERE first_name = 'David');
                
-- ANY,SOME : 값을 서브쿼리에 의해 리턴된 각각의 값과 비교합니다.
-- 하나라도 만족하면 됩니다. 가장 작은 값 보다 크면 이란 뜻 > ANY
SELECT * FROM employees
WHERE salary > ANY(SELECT salary FROM employees
                WHERE first_name = 'David');
                
-- ALL: 값을 서브쿼리에 의해 리턴된 각각의 값을 모두 비교해서
-- 모두 만족해야 합니다. (괄호 안에 있는 값 보다 (3개의 값보다) 더 커야한다. )
SELECT * FROM employees
WHERE salary > ALL(SELECT salary FROM employees
                WHERE first_name = 'David');
                
--EXIST : 서브쿼리가 하나 이상의 행을 반환하면 참으로 간주.
-- job_history에 존재하는 직원이 employees에도 존재한다면 조회에 포함
SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM job_history jh
              WHERE e.employee_id = jh.employee_id); -- 중복은 제외되고 10개중 7개만 나온다
            
-- EXIST 는 하나의 행만 반환해도 참이고 ANY 는 하나의 행이 만족해야지 반환된다.
              
-- 1 이라고 적는건 상징적인 의미가 있다. 
-- 데이터는 관심이 없구 select from을 돌리기 위해서 쓰는 1
-- 테이블의 전체 행 만큼 나온다.   
              
SELECT 1 FROM job_history;

SELECT * FROM employees
WHERE EXISTS (SELECT 1 FROM departments
              WHERE department_id =10);
-- EXISTS: 참 거짓 여부만 확인 하나라도 존재하면 조건이 성립되니까 입력값이 나온다.


------------------------------------------------------------------------------

-- SELECT 절에 서브쿼리를 붙이기. SELECT (컬럼) FORM employees;
-- 스칼라 서브쿼리 라고 칭합니다.
-- 스칼라 서브쿼리: 실행 결과가 단일 값을 반환하는 서브쿼리문. 주로 SELECT WHERE 절에서 사용됨.
SELECT
    e.first_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

SELECT
-- () 안에 있는 내용이 행마다 실행된다. 1행 아담을 수행해서 입력값에 나타내주면 () 안에 수행이 되고
-- e.first_name이 또 수행되고 값이 끝까지 나올때까지 반복된다.
    e.first_name,
    (
        SELECT
            department_name
        FROM departments d
        WHERE d.department_id = e.department_id
    )AS department_name
FROM employees e
ORDER BY first_name ASC;

/*
- 스칼라 서브쿼리가 조인보다 좋은 경우
: 함수처럼 한 레코드당 정확히 하나의 값만을 리턴할 때.

- 조인이 스칼라 서브쿼리보다 좋은 경우
: 조회할 데이터가 대용량인 경우, 해당 데이터가
수정, 삭제 등이 빈번한 경우(sql 가독성이 조인이 좀 더 뛰어납니다.)
*/

-- 각 부서의 매니저 이름 조회
-- LEFT JOIN
SELECT
    d.*,
    e.first_name
FROM departments d
LEFT JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

-- SELECT절 서브쿼리 (스칼라)
SELECT
    d.*,
    (
    SELECT
        first_name
    FROM employees e
    WHERE e.employee_id = d.manager_id
    ) AS manager_name
FROM departments d 
ORDER BY d.manager_id ASC;
                
-- 각 부서별 사원 수 뽑기
SELECT
    d.*,
    (
    SELECT
        COUNT(*)
    FROM employees e
    WHERE e.department_id = d.department_id
    GROUP BY department_id
    ) AS 사원수
FROM departments d;

-- 인라인 뷰(FROM 구문에 서브쿼리가 오는 것.)
-- 특정 테이블 전체가 아닌 SELECT를 통해 일부 데이터를 조회한 것을 가상 테이블로 사용하고 싶을 때.
-- 순번을 정해놓은 조회 자료들 범위를 지정해서 가지고 오는 경우. 1_spl 참고(ROWNUM)

SELECT
    ROWNUM AS rn, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;

-- salary로 정렬을 진행하면서 바로 ROWNUM을 붙이면
-- ROWNUM이 정렬이 되지 않는 상황이 발생합니다.
-- 이유: ROWNUM이 먼저 붙고 정렬이 진행되기 때문. ORDER BY는 항상 마지막에 진행.
-- 해결: 정렬이 미리 진행된 자료에 ROWNUM을 붙여서 다시 조회하는 것이 좋을 것 같아요.

SELECT ROWNUM AS rn , tbl.*
FROM (
SELECT
    employee_id, first_name, salary
FROM employees
ORDER BY salary DESC
) tbl                        -- 에러코드 의 예
WHERE rn > 20 AND rn <= 30; 
-- WHERE 절 먼저 실행되고 SELECT 가 실행되기 떄문에 에러가 뜬다.


-- ROWNUM을 붙이고 나서 범위를 지정해서 조회하려고 하는데,
-- 범위 지정도 불가능하고, 지목할 수 없는 문제가 발생하더라.
-- 이유: WHERE절부터 먼저 실행하고 나서 ROWNUM이 SELECT 되기 때문에.
-- 해결: ROWNUM까지 붙여 놓고 다시 한 번 자료를 SELECT 해서 범위를 지정해야 되겠구나.

/*
가장 안쪽 SELECT 절에서 필요한 테이블 형식(인라인 뷰)을 생성.
바깥쪽 SELECT 절에서 ROWNUM을 붙여서 다시 조회
가장 바깥쪽 SELECT 절에서는 이미 붙어있는 ROWNUM의 범위를 지정해서 조회.
SQL의 실행 순서
FROM,JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/
SELECT * FROM  -- 3번
    ( 
    SELECT ROWNUM AS rn , tbl.* --2번
    FROM (  
            SELECT -- 1번
                employee_id, first_name, salary
            FROM employees
            ORDER BY salary DESC
        ) tbl  
    )
WHERE rn > 20 AND rn <= 30;


