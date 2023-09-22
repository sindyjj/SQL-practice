
SELECT * FROM employees;

--WHERE�� �� (������ ���� ��/�ҹ��ڸ� �����մϴ�.)
SELECT first_name AS �̸�, last_name AS ��, job_id AS ����
FROM employees
WHERE job_id = 'IT_PROG';

SELECT * FROM employees
WHERE last_name = 'King';

SELECT *
FROM employees
WHERE department_id = 90; 
-- ���ڿ��̸� Ȫ����ǥ�� ��������� �������̱⶧���� �׳ɾ���.

SELECT * 
FROM employees
WHERE salary >= 15000
AND salary < 20000;

-- ����Ʈ Ÿ�� ���ڿ��̱� ������ Ȭ����ǥ ����.
SELECT * FROM employees
WHERE hire_date = '04/01/30';

-- ������ �� ���� > <= �̷��� �Ⱦ��� �����ϰ� �� �� �ִ�.
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

-- IN �������� ���(Ư�� ����� ���� �� ���)
-- IN : IN(A B C) ���߿� �ϳ��� ������ ���� ������ �� ��.
SELECT * FROM employees
WHERE manager_id IN(100,101,102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP');

--LIKE ������
-- (%)�� ��� ���ڵ�, (_)�� ����Ʈ�� �ڸ�(��ġ)�� ã�Ƴ� ��
-- hire_date �� 03% �� ���ٸ� �� �ҷ��� (%)�� �ǹ̴� �ڿ��� ���ڿ��� ���� ���͵� �������.
SELECT first_name, last_name
FROM employees
WHERE hire_date Like '03%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%15';

-- %00% : �� �ڿ� �ƹ� ���ڿ��� ������� �׳� ��ü�� 05�� ������ �� �����Ͷ� �� ��
SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%';

-- ___05% : ���� �� ��ŭ (_)�� ���� ������ �����ϴ� �ؿ� 3���� ������ 4��°�� 05�� �� �ɷ������ ��
SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '___05%';

--AND(�� ����), OR
--AND�� OR���� ���� ������ ����
SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >= 6000;

--IS (NULL���� ã��)
SELECT * FROM employees
WHERE manager_id IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NOT NULL;

-- AND �� OR���� ������ �켱�̱� ������ ()�� ������Ѵ�.
SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')
AND salary >= 6000;

--�������� ���� (SELECT ������ ���� �������� ��ġ�˴ϴ�.)
--ASC: ascending = ��������
--DESC: descending = ��������

SELECT * FROM employees
ORDER BY hire_date ASC; -- ��������

SELECT * FROM employees
ORDER BY hire_date DESC; -- ��������

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











