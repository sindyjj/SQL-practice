
--insert
--테이블 구조 확인
DESC departments;

-- INSERT의 첫번째 방법(모든 컬럼 데이터를 한 번에 지정)
INSERT INTO departments
VALUES(300,'개발부',null,null);

SELECT * FROM departments;
ROLLBACK;

-- INSERT의 두번째 방법 (직접 칼럼을 지정하고 저장, NOT NULL 확인하세요.!)
INSERT INTO departments
    (department_id,location_id)
VALUES
    (300,1700);
    
-- 사본 테이블 생성
-- 사본 테이블을 생성할 때 그냥 생성하면 -> 조회된 데이터까지 모두 복사
-- WHERE절에 FALSE값 (1=2) 지칭하면 -> 테이블의 구조만 복사되고 데이터는 복사 X
CREATE TABLE emps AS
(SELECT employee_id,first_name, job_id,
        hire_date FROM employees WHERE 1 = 2); -- 1와 2는 같다 일부러 FALSE값을 줬다. -- 값없이 매뉴만 만들겠다

SELECT * FROM emps;
DROP TABLE emps; -- 테이블을 삭제하는 기능

-- INSERT (서브쿼리)
INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date FROM employees WHERE department_id = 50);

-----------------------------------------------------------------------------------------------

--UPDATE
CREATE TABLE emps AS
(SELECT * FROM employees);

SELECT * FROM emps;

-- UPDATE를 진행할 때는 누구를 수정할 지 잘 지목해야 합니다.
-- 그렇지 않으면 수정 대상이 테이블 전체로 지목됩니다.
UPDATE emps SET salary = 30000; -- 전체 지목 대상

ROLLBACK;

UPDATE emps SET salary = salary + salary * 0.1 --1 개의 수정할 값
WHERE employee_id = 100; -- 지목 대상

UPDATE emps
SET phone_number = '010-4129-4291', manager_id = 102 --2 개의 수정할 값
WHERE employee_id = 100; -- 지목 대상

--UPDATE (서브쿼리)
UPDATE emps
SET (job_id, salary, manager_id) =
  (
    SELECT job_id, salary, manager_id -- 1 번  id가 100인 사람을 조회
    FROM emps
    WHERE employee_id = 100
  )
WHERE employee_id = 101;  -- 101번과 100번을 맞춰주겠다 58번 절 3개로

SELECT * FROM emps;

--------------------------------------------------------------------------

--DELETE
DELETE FROM emps
WHERE employee_id = 103;

--DELETE (서브쿼리)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT'); --60번 ID가 4개 있다  4개 삭제 완료