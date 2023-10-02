
/*
view는 제한적인 자료만 보기 위해 사용하는 가상 테이블의 개념입니다.
뷰는 기본 테이블로 유도된 가상 테이블이기 때문에
필요한 컬럼만 저장해 두면 관리가 용이해 집니다.
뷰는 가상테이블로 실제 데이터가 물리적으로 저장된 형태는 아닙니다.
뷰를 통해서 데이터에 접근하면 원본 데이터는 안전하게 보호될 수 있습니다.
*/
SELECT * FROM user_sys_privs; -- 권한 확인

-- 단순 뷰: 하나의 테이블을 이용하여 생성한 뷰
-- 뷰의 컬럼 이름은 함수 호출문, 연산식 등 같은 가장 표현식이면 안됩니다.

CREATE VIEW view_emp AS(
    SELECT
        employee_id,
        first_name || '' || last_name AS full_name,
        job_id,
        salary
    FROM employees
    WHERE department_id = 60
);

SELECT * FROM view_emp
WHERE salary >= 6000;

-- 복합 뷰
-- 여러 테이블을 조인해서 필요한 데이터만 저장하고 빠른 확인을 위해 사용.
CREATE VIEW view_emp_dept_jobs AS(
    SELECT
        e.employee_id,
        first_name || '' || last_name AS full_name,
        d.department_name,
        j.job_title
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;

-- 뷰의 수정(CREATE OR REPLACE VIEW 구문)
-- 동일 이름으로 해당 구문을 사용하면 데이트가 변경되면서 새롭게 생성됩니다.

CREATE OR REPLACE VIEW view_emp_dept_jobs AS(
    SELECT
        e.employee_id,
        first_name || '' || last_name AS full_name,
        d.department_name,
        j.job_title,
        e.salary -- 추가
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;

SELECT 
    job_title,
    AVG(salary) AS AVG
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY AVG(salary) DESC; -- SQL 구문이 확실히 짧아짐.

-- 뷰 삭제
DROP VIEW view_emp;

/*
VIEW에 INSERT가 일어나는 경우 실제 테이블에도 반영이 됩니다.
그래서 VIEW의 INSERT, UPDATE,DELETE는 많은 제약 사항이 따릅니다.
원본 테이블이 NOT NULL인 경우 VIEW에 INSERT가 불가능합니다.
VIEW에서 사용하는 컬럼이 가상열인 경우에도 안됩니다.
*/

-- 두 번째 컬럼인 'full_name'은 가상열(virtual column)이기 때문에 INSERT 안됩니다.
INSERT INTO view_emp_dept_jobs
VALUES (300, 'test','test','test', 10000); -- 안됨

-- JOIN된 뷰의 경우 한 번에 수정할 수 없습니다.
INSERT INTO view_emp_dept_jobs
    (employee_id, department_name, job_titlem, salary)
VALUES (300, 'test','test', 10000);

-- 원본 테이블의 null을 허용하지 않는 컬럼 때문에 들어갈 수 없습니다.
INSERT INTO view_emp
(employee_id, job_id, salary)
VALUES(300,'test',10000); -- 안됨

-- 삽입 , 수정 , 삭제 성공 시 원본 테이블도 반영됩니다.
DELETE FROM view_emp
WHERE employee_id = 107;

SELECT * FROM view_emp;
SELECT * FROM employees;

ROLLBACK;

-- WITH CHECK OPTION -> 조건 제약 컬럼
-- 뷰를 생성할 때 사용한 조건 컬럼은 뷰를 통해서 변경할 수 없게 해주는 키워드

CREATE OR REPLACE VIEW view_emp_test AS(
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
)
WITH CHECK OPTION CONSTRAINT view_emp_ck;

UPDATE view_emp_test
SET job_id = 'AD_VP'
WHERE employee_id = 107;

SELECT * FROM view_emp_test;
ROLLBACK;

-- 읽기 전용 뷰 -> WITH READ ONLY (DML 연산을 막음 -> SELECT 만 허용)
CREATE OR REPLACE VIEW view_emp_test AS(
    SELECT
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id,
        department_id
    FROM employees
    WHERE department_id = 60
 )

WITH READ ONLY;

/*
문제 12. 
employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 
1-10번째 데이터만 출력합니다.
조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 
부서아이디, 부서이름 을 출력합니다.
조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.
*/
SELECT* FROM
    (
SELECT ROWNUM AS rn, a.*
    FROM
    (
SELECT

    e.employee_id , e.first_name, e.phone_number,
    e.hire_date, d.department_id , d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY hire_date ASC
    ) a
)
WHERE rn > 0 AND rn <= 10;
/*
문제 13. 
--EMPLOYEES 와 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요.
*/
SELECT
    tbi.*,d.department_name
FROM
    (
SELECT
    last_name, job_id, department_id
FROM employees
WHERE job_id = 'SA_MAN'
    ) tbi
    JOIN departments d
    ON tbi.department_id = d.department_id;
/*
문제 14
--DEPARTMENT테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
--인원수 기준 내림차순 정렬하세요.
--사람이 없는 부서는 출력하지 뽑지 않습니다.
*/
SELECT
    d.department_id, d.department_name, d.manager_id,
    a.total
FROM departments d
JOIN
    (
SELECT
    department_id, COUNT(*) AS total
FROM employees
GROUP BY department_id
    ) a
ON d.department_id = a.department_id
ORDER BY a.total DESC;
-- 위 JOIN 문 
SELECT
    d.department_id, d.department_name, d.manager_id,
    (
        SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
    ) AS total
FROM departments d
WHERE manager_id IS NOT NULL
ORDER BY total DESC;
-- 스칼라 서브쿼리  09 번 참고
/*
문제 15
--부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요.
--부서별 평균이 없으면 0으로 출력하세요.
*/ 
SELECT
    d.*,
    loc.street_address, loc.postal_code,
    NVL(tbl.result,0) AS 부서별평균급여
FROM departments d
JOIN locations loc
ON d.location_id = loc.location_id
LEFT JOIN 
    (
SELECT
    department_id, 
    TRUNC(AVG(salary),0) AS result
FROM employees e
GROUP BY department_id
    ) tbl
ON d.department_id = tbl.department_id;

SELECT
    d.*,
    loc_street_address, loc.postal_code,
    NVL(
        SELECT TRUNC(AVG(e.salary),0)
        FROM employees e
        WHERE e.department_id = d.department_id
    ),
    0) AS 부서별 평균급여
FROM departments d
JOIN locations loc
ON d.location_id = loc.location_id;

/*
문제 16
-문제 15 결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 
ROWNUM을 붙여 1-10 데이터 까지만 출력하세요.
*/      
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl2.*
        FROM
        (
        SELECT
            d.*,
            loc.street_address, loc.postal_code,
            NVL(tbl.result, 0) AS 부서별평균급여
        FROM departments d
        JOIN locations loc
        ON d.location_id = loc.location_id
        LEFT JOIN
            (
            SELECT
                department_id,
                TRUNC(AVG(salary), 0) AS result
            FROM employees
            GROUP BY department_id
            ) tbl
        ON d.department_id = tbl.department_id
        ORDER BY d.department_id DESC
        ) tbl2
    )
WHERE rn > 0 AND rn <= 10;