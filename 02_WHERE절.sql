
SELECT * FROM employees;

--WHERE절 비교 (데이터 값은 대/소문자를 구분합니다.)
SELECT first_name AS 이름, last_name AS 성, job_id AS 직업
FROM employees
WHERE job_id = 'IT_PROG';

SELECT * FROM employees
WHERE last_name = 'King';

SELECT *
FROM employees
WHERE department_id = 90; 
-- 문자열이면 홋따옴표를 써야하지만 정수형이기때문에 그냥쓴다.

SELECT * 
FROM employees
WHERE salary >= 15000
AND salary < 20000;

-- 데이트 타입 문자열이기 때문에 홑따옴표 쓴다.
SELECT * FROM employees
WHERE hire_date = '04/01/30';

-- 데이터 행 제한 > <= 이런걸 안쓰고 간략하게 쓸 수 있다.
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

-- IN 연산자의 사용(특정 값들과 비교할 때 사용)
-- IN : IN(A B C) 셋중에 하나라도 있으면 정보 가져와 란 뜻.
SELECT * FROM employees
WHERE manager_id IN(100,101,102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP');

--LIKE 연산자
-- (%)는 어떠한 문자든, (_)는 데이트의 자리(위치)를 찾아낼 때
-- hire_date 가 03% 와 같다면 다 불러와 (%)의 의미는 뒤에는 문자열이 뭐가 들어와도 상관없다.
SELECT first_name, last_name
FROM employees
WHERE hire_date Like '03%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%15';

-- %00% : 앞 뒤에 아무 문자열도 상관없다 그냥 전체에 05가 있으면 다 가져와라 란 뜻
SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%';

-- ___05% : 글자 수 만큼 (_)를 쓰면 지목이 가능하다 밑에 3개를 썼으니 4번째가 05인 것 걸러내라는 뜻
SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '___05%';

--AND(다 맨족), OR
--AND가 OR보다 연산 순서가 빠름
SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >= 6000;

--IS (NULL값을 찾음)
SELECT * FROM employees
WHERE manager_id IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NOT NULL;

-- AND 가 OR보다 연산이 우선이기 때문에 ()를 쳐줘야한다.
SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')
AND salary >= 6000;

--데이터의 정렬 (SELECT 구분의 가장 마지막에 배치됩니다.)
--ASC: ascending = 오름차순
--DESC: descending = 내림차순

SELECT * FROM employees
ORDER BY hire_date ASC; -- 오름차순

SELECT * FROM employees
ORDER BY hire_date DESC; -- 내림차순

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees
WHERE salary >= 5000
ORDER BY employee_id ASC;

SELECT
    first_name,
    salary * 12 AS pay
FROM employees
ORDER BY pay ASC;











