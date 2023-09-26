
--insert
--���̺� ���� Ȯ��
DESC departments;

-- INSERT�� ù��° ���(��� �÷� �����͸� �� ���� ����)
INSERT INTO departments
VALUES(300,'���ߺ�',null,null);

SELECT * FROM departments;
ROLLBACK;

-- INSERT�� �ι�° ��� (���� Į���� �����ϰ� ����, NOT NULL Ȯ���ϼ���.!)
INSERT INTO departments
    (department_id,location_id)
VALUES
    (300,1700);
    
-- �纻 ���̺� ����
-- �纻 ���̺��� ������ �� �׳� �����ϸ� -> ��ȸ�� �����ͱ��� ��� ����
-- WHERE���� FALSE�� (1=2) ��Ī�ϸ� -> ���̺��� ������ ����ǰ� �����ʹ� ���� X
CREATE TABLE emps AS
(SELECT employee_id,first_name, job_id,
        hire_date FROM employees WHERE 1 = 2); -- 1�� 2�� ���� �Ϻη� FALSE���� ���. -- ������ �Ŵ��� ����ڴ�

SELECT * FROM emps;
DROP TABLE emps; -- ���̺��� �����ϴ� ���

-- INSERT (��������)
INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date FROM employees WHERE department_id = 50);

-----------------------------------------------------------------------------------------------

--UPDATE
CREATE TABLE emps AS
(SELECT * FROM employees);

SELECT * FROM emps;

-- UPDATE�� ������ ���� ������ ������ �� �� �����ؾ� �մϴ�.
-- �׷��� ������ ���� ����� ���̺� ��ü�� ����˴ϴ�.
UPDATE emps SET salary = 30000; -- ��ü ���� ���

ROLLBACK;

UPDATE emps SET salary = salary + salary * 0.1 --1 ���� ������ ��
WHERE employee_id = 100; -- ���� ���

UPDATE emps
SET phone_number = '010-4129-4291', manager_id = 102 --2 ���� ������ ��
WHERE employee_id = 100; -- ���� ���

--UPDATE (��������)
UPDATE emps
SET (job_id, salary, manager_id) =
  (
    SELECT job_id, salary, manager_id -- 1 ��  id�� 100�� ����� ��ȸ
    FROM emps
    WHERE employee_id = 100
  )
WHERE employee_id = 101;  -- 101���� 100���� �����ְڴ� 58�� �� 3����

SELECT * FROM emps;

--------------------------------------------------------------------------

--DELETE
DELETE FROM emps
WHERE employee_id = 103;

--DELETE (��������)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT'); --60�� ID�� 4�� �ִ�  4�� ���� �Ϸ�