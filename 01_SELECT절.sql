-- ����Ŭ�� �� �� �ּ�.
/*
    ���� �� �ּ��Դϴ�.
    ȣȣȣ~~
*/
-- Ű����� �빮�� �ƴѰ� �ҹ��� 
--SELECT [Į����(���� �� ����)] FROM [���̺� �̸�]
SELECT
    *
FROM
    employees;
    
SELECT employee_id, first_name, last_name
FROM employees;

SELECT email, phone_number, hire_date
FROM employees;

-- �÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����մϴ�.
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary*0.1 AS ������ 
FROM employees;    

-- NULL ���� Ȯ�� (���� 0�̳� �����̶��� �ٸ� �����Դϴ�.)
SELECT department_id, commission_pct
FROM employees;    

-- alias (�÷���, ���̺���� �̸��� �����ؼ� ��ȸ�մϴ�.)
SELECT
    first_name AS �̸�,
    last_name AS ��,
    salary AS �޿�
FROM employees;    

/*
  ����Ŭ�� Ȭ����ǥ�� ���ڸ� ǥ���ϰ�, ���ڿ� �ȿ� Ȭ����ǥ��
  ǥ���ϰ� �ʹٸ� ''�� �� �� �������� ���ø� �˴ϴ�.
  ������ �����ϰ� �ʹٸ� || �� ����մϴ�.
*/
SELECT
    first_name ||' '|| last_name || '''s salary is $' || salary
    AS �޿�����
FROM employees;

-- DISTINCT �ߺ��ɷ��ִ� Ű����
SELECT department_id AS �μ���ȣ FROM employees;
SELECT DISTINCT department_id AS �μ���ȣ FROM employees;


--ROWNUM, ROWID
-- (**�ο��: ������ ���� ��ȯ�ϴ� �� ��ȣ�� ���)
-- (�ο���̵�: �����ͺ��̽� ���� ���� �ּҸ� ��ȯ)
SELECT ROWNUM AS ��ȣ, ROWID AS �ּҰ�, employee_id
FROM employees;








