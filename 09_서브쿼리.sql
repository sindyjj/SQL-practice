/*
# �������� 
1. SQL ���� �ȿ� �Ǵٸ� SQL�� �����ϴ� ���.
���� ���� ���Ǹ� ���ÿ� ó���� �� �ֽ��ϴ�.
WHERE, SELECT, FROM ���� �ۼ��� �����մϴ�.

- ���������� ������� () �ȿ� �����.
 ������������ �������� 1�� ���Ͽ��� �մϴ�.
- �������� ������ ���� ����� �ϳ� �ݵ�� ���� �մϴ�.
- �ؼ��� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.
 ���� �����ؼ� �˻� ���� �� ��Ȯ�� �ɷ��ֱ� ���ؼ� ����(����)������ ����.
*/

SELECT salary FROM employees
WHERE first_name = 'Nancy';

SELECT first_name FROM employees
WHERE salary > 12008;

--'Nancy'�� �޿����� �޿��� ���� ����� �˻��ϴ� ���� (_) �� 
-- ���� �����ϰ� ���� ���´��� �ѿ� ������� ����ȴ�.
SELECT first_name FROM employees
WHERE salary > (SELECT salary FROM employees
                WHERE first_name = 'Nancy');
                
-- employee_id �� 103���� ����� job_id�� ������ job_id�� ���� ����� ��ȭ.
SELECT * FROM  employees
WHERE job_id = (SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG'); 
-- ������ ������ ���� ������ �����ڸ� ����ؾ� �մϴ�.
-- ������ ���������� = (�� �ϳ��� ���� �����ؾ��Ѵ�.)
-- ������ ������(=,>,<,>=,<=,<>) ����ϴ� ���� �ϳ��� �ุ ��ȯ�ؾ� �մϴ�.

--������ ������ (IN, ANY, ALL)
-- IN : �ȿ� �߿� �ϳ��� �ִٸ� �˻� ��Ÿ����.
SELECT * FROM  employees
WHERE job_id IN (SELECT job_id FROM employees
                WHERE job_id = 'IT_PROG'); 

-- first_name�� David�� ��� �� �޿��� ���� �޿��� �޴� ������� ��ȸ.
SELECT * FROM employees
WHERE salary IN(SELECT salary FROM employees
                WHERE first_name = 'David');
                
-- ANY,SOME : ���� ���������� ���� ���ϵ� ������ ���� ���մϴ�.
-- �ϳ��� �����ϸ� �˴ϴ�. ���� ���� �� ���� ũ�� �̶� �� > ANY
SELECT * FROM employees
WHERE salary > ANY(SELECT salary FROM employees
                WHERE first_name = 'David');
                
-- ALL: ���� ���������� ���� ���ϵ� ������ ���� ��� ���ؼ�
-- ��� �����ؾ� �մϴ�. (��ȣ �ȿ� �ִ� �� ���� (3���� ������) �� Ŀ���Ѵ�. )
SELECT * FROM employees
WHERE salary > ALL(SELECT salary FROM employees
                WHERE first_name = 'David');
                
--EXIST : ���������� �ϳ� �̻��� ���� ��ȯ�ϸ� ������ ����.
-- job_history�� �����ϴ� ������ employees���� �����Ѵٸ� ��ȸ�� ����
SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM job_history jh
              WHERE e.employee_id = jh.employee_id); -- �ߺ��� ���ܵǰ� 10���� 7���� ���´�
            
-- EXIST �� �ϳ��� �ุ ��ȯ�ص� ���̰� ANY �� �ϳ��� ���� �����ؾ��� ��ȯ�ȴ�.
              
-- 1 �̶�� ���°� ��¡���� �ǹ̰� �ִ�. 
-- �����ʹ� ������ ���� select from�� ������ ���ؼ� ���� 1
-- ���̺��� ��ü �� ��ŭ ���´�.   
              
SELECT 1 FROM job_history;

SELECT * FROM employees
WHERE EXISTS (SELECT 1 FROM departments
              WHERE department_id =10);
-- EXISTS: �� ���� ���θ� Ȯ�� �ϳ��� �����ϸ� ������ �����Ǵϱ� �Է°��� ���´�.


------------------------------------------------------------------------------

-- SELECT ���� ���������� ���̱�. SELECT (�÷�) FORM employees;
-- ��Į�� �������� ��� Ī�մϴ�.
-- ��Į�� ��������: ���� ����� ���� ���� ��ȯ�ϴ� ����������. �ַ� SELECT WHERE ������ ����.
SELECT
    e.first_name,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

SELECT
-- () �ȿ� �ִ� ������ �ึ�� ����ȴ�. 1�� �ƴ��� �����ؼ� �Է°��� ��Ÿ���ָ� () �ȿ� ������ �ǰ�
-- e.first_name�� �� ����ǰ� ���� ������ ���ö����� �ݺ��ȴ�.
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
- ��Į�� ���������� ���κ��� ���� ���
: �Լ�ó�� �� ���ڵ�� ��Ȯ�� �ϳ��� ������ ������ ��.

- ������ ��Į�� ������������ ���� ���
: ��ȸ�� �����Ͱ� ��뷮�� ���, �ش� �����Ͱ�
����, ���� ���� ����� ���(sql �������� ������ �� �� �پ�ϴ�.)
*/

-- �� �μ��� �Ŵ��� �̸� ��ȸ
-- LEFT JOIN
SELECT
    d.*,
    e.first_name
FROM departments d
LEFT JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

-- SELECT�� �������� (��Į��)
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
                
-- �� �μ��� ��� �� �̱�
SELECT
    d.*,
    (
    SELECT
        COUNT(*)
    FROM employees e
    WHERE e.department_id = d.department_id
    GROUP BY department_id
    ) AS �����
FROM departments d;

-- �ζ��� ��(FROM ������ ���������� ���� ��.)
-- Ư�� ���̺� ��ü�� �ƴ� SELECT�� ���� �Ϻ� �����͸� ��ȸ�� ���� ���� ���̺�� ����ϰ� ���� ��.
-- ������ ���س��� ��ȸ �ڷ�� ������ �����ؼ� ������ ���� ���. 1_spl ����(ROWNUM)

SELECT
    ROWNUM AS rn, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;

-- salary�� ������ �����ϸ鼭 �ٷ� ROWNUM�� ���̸�
-- ROWNUM�� ������ ���� �ʴ� ��Ȳ�� �߻��մϴ�.
-- ����: ROWNUM�� ���� �ٰ� ������ ����Ǳ� ����. ORDER BY�� �׻� �������� ����.
-- �ذ�: ������ �̸� ����� �ڷῡ ROWNUM�� �ٿ��� �ٽ� ��ȸ�ϴ� ���� ���� �� ���ƿ�.

SELECT ROWNUM AS rn , tbl.*
FROM (
SELECT
    employee_id, first_name, salary
FROM employees
ORDER BY salary DESC
) tbl                        -- �����ڵ� �� ��
WHERE rn > 20 AND rn <= 30; 
-- WHERE �� ���� ����ǰ� SELECT �� ����Ǳ� ������ ������ ���.


-- ROWNUM�� ���̰� ���� ������ �����ؼ� ��ȸ�Ϸ��� �ϴµ�,
-- ���� ������ �Ұ����ϰ�, ������ �� ���� ������ �߻��ϴ���.
-- ����: WHERE������ ���� �����ϰ� ���� ROWNUM�� SELECT �Ǳ� ������.
-- �ذ�: ROWNUM���� �ٿ� ���� �ٽ� �� �� �ڷḦ SELECT �ؼ� ������ �����ؾ� �ǰڱ���.

/*
���� ���� SELECT ������ �ʿ��� ���̺� ����(�ζ��� ��)�� ����.
�ٱ��� SELECT ������ ROWNUM�� �ٿ��� �ٽ� ��ȸ
���� �ٱ��� SELECT �������� �̹� �پ��ִ� ROWNUM�� ������ �����ؼ� ��ȸ.
SQL�� ���� ����
FROM,JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/
SELECT * FROM  -- 3��
    ( 
    SELECT ROWNUM AS rn , tbl.* --2��
    FROM (  
            SELECT -- 1��
                employee_id, first_name, salary
            FROM employees
            ORDER BY salary DESC
        ) tbl  
    )
WHERE rn > 20 AND rn <= 30;


