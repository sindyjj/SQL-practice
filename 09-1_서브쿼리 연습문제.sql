/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/

SELECT
   *
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

SELECT
   COUNT(*)
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

SELECT
   *
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees
WHERE job_id = 'IT_PROG')
ORDER BY salary DESC;

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� �μ��� �����ִ� �������
��� ������ ����ϼ���.
*/
SELECT
    *
FROM employees
WHERE department_id = (SELECT department_id FROM departments
                        WHERE manager_id = 100);


/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/

SELECT
    *
FROM employees 
WHERE manager_id > (SELECT manager_id FROM employees
                    WHERE first_name = 'Pat');
                    
SELECT * FROM employees
WHERE manager_id IN(SELECT manager_id FROM employees
                    WHERE first_name = 'James');

/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/
SELECT * FROM 
    (
      SELECT ROWNUM AS rn,tbi.first_name
        FROM
        (
            SELECT * FROM employees 
            ORDER BY first_name DESC
        ) tbi
    )
WHERE rn BETWEEN 41 AND 50;
/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȣ, �Ի����� ����ϼ���.
*/

SELECT * FROM 
    (
      SELECT ROWNUM AS rn,tbi.*
        FROM
        (
            SELECT 
                employee_id,first_name,phone_number,hire_date
            FROM employees 
            ORDER BY hire_date ASC
        ) tbi
    )
WHERE rn BETWEEN 31 AND 40;

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/

SELECT
    e.employee_id AS �������̵�,
    e.first_name || '' || e.last_name AS �̸�,
    e.department_id AS �μ����̵�,
    d.department_name AS �μ���
FROM employees e 
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id ASC;




/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
    e.employee_id,
    e.first_name || '' || e.last_name,
    e.department_id,
    (
    SELECT
        department_name
    FROM departments d
    WHERE d.department_id = e.department_id
    )
FROM employees e
ORDER BY employee_id ASC;


    


/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/
SELECT 
     d.manager_id AS �Ŵ������̵�,d.location_id AS �����̼Ǿ��̵�,
    d.department_id AS �μ����̵�,d.department_name AS �μ��̸�,   
    loc.street_address AS ��Ʈ����巹��,loc.postal_code AS ����Ʈ�ڵ�,loc.city AS ��Ƽ
FROM departments d LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY department_id ASC;

/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
    d.manager_id AS �Ŵ������̵�,d.location_id AS �����̼Ǿ��̵�,
    d.department_id AS �μ����̵�,d.department_name AS �μ��̸�,
    
    (
    SELECT
    loc.street_address  
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) AS street_address,
    
    (
    SELECT
    loc.postal_code  
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) AS postal_code,
    (
    
    SELECT
    loc.city  
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) AS city
    
FROM departments d
ORDER BY department_id ASC;

/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
SELECT
    loc.location_id,
    loc.street_address,
    loc.city,
    c.country_id,
    c.country_name
FROM locations loc LEFT JOIN countries C
ON loc.country_id = c.country_id
ORDER BY c.country_name ASC;

/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
    loc.location_id,
    loc.street_address,
    loc.city,
    loc.country_id,
    (
    SELECT
    c.country_name
    FROM countries c
    WHERE c.country_id = loc.country_id
    ) AS country_name 
FROM locations loc
ORDER BY country_name ASC;     -- ���� �ʿ�




