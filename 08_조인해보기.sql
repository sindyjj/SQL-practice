
/*
# �����̶�?
- ���� �ٸ� ���̺��� ������ ���谡 �����Ͽ�
 1�� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���ؼ� ����մϴ�.
- SELECT �÷�����Ʈ FROM ���δ���� �Ǵ� ���̺� (1�� �̻�)
  WHERE ���� ���� (����Ŭ ���� ����)
*/

--employees ���̺��� �μ� id�� ��ġ�ϴ� departments ���̺��� �μ� id��
-- ã�Ƽ� SELECT ���Ͽ� �ִ� �÷����� ����ϴ� ������.
SELECT
    e.first_name,
    d.department_name
FROM employees e, departments d
-- employees : first_name , departments : department_name
WHERE e.department_id = d.department_id; -- ����Ŭ ���� ����
-- �� �� ������ �ִ� ��쿡�� �÷��� ������ �ۼ��ؾ��Ѵ�. 
-- ���� ������ �ִ� ��쿡�� �÷��� �ۼ��� �ǹ��� �ƴϴ�.

SELECT 
    e.first_name, e.last_name, e.hire_date,
    e.salary, e.job_id, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id; 
-- ANSI ����: ǥ�� ���� ���� , ON�� ���� ������ ���� ��ɾ�(������ ����)

/*
������ ���̺� ���������� �����ϴ� �÷��� ��쿡��
���̺� �̸��� �����ص� �����մϴ�. �׷���, �ؼ��� ��Ȯ���� ����
���̺� �̸��� �ۼ��ϼż� �Ҽ��� ǥ���� �ִ� ���� �ٶ����մϴ�.
���̺� �̸��� �ʹ� �� �ÿ��� ALIAS�� �ۼ��Ͽ� Ī�մϴ�.
�� ���̺� ��� ������ �ִ� �÷��� ��� �ݵ�� ����� �ּž� �մϴ�.
*/

-- 3���� ���̺��� �̿��� ���� ����(INNER JOIN)
-- ���� ����: ���� ���ǿ� ��ġ�ϴ� �ุ ��ȯ�ϴ� ����. 
-- ���� ���ǰ� ��ġ���� �ʴ� �����ʹ� ��ȸ ��󿡼� ����.
SELECT
    e.first_name, e.last_name,
    e.department_id, e.job_id,
    d.department_name,
    j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id;

SELECT 
    e.first_name, e.last_name, e.department_id,
    d.department_name, e.job_id, j.job_title, loc.city
FROM 
     employees e, 
     departments d, 
     jobs j, 
     locations loc
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id -- 3,4
AND d.location_id = loc.location_id --2
AND loc.state_province = 'California'; --1 
--�������� ���� �ñ������� �ɷ��� �Ҳ� ���� �ɷ����� ��ġ�°� ������ ��Ʈ�̴�.

/*
    1. loc ���̺��� state_province = 'califonia' ���ǿ� �´� ���� ������� 
    2. location_id ���� ���� ���� ������ �����͸� departments���� ã�Ƽ� ����
    3. ���� ������ ����� ������ department_id�� ���� employees ���̺��� �����͸� ã�� ����
    4. ���� ����� jobs ���̺��� ���Ͽ� �����ϰ� ���� ����� ���.
*/

-- �ܺ� ����
/*
    ��ȣ ���̺� ���� ��ġ�Ǵ� ������ ����Ǵ� ���� ���ΰ��� �ٸ���
    ��� �� ���̺� ���� ���� ������ �ش� row���� ��ȸ �����
    ��� ���ԵǴ� ������ ���մϴ�.
*/

SELECT
    e.first_name,
    d.department_name,
    loc.location_id
FROM employees e, departments d, locations loc
WHERE e.department_id = d.department_id(+) --2
AND d.location_id = loc.location_id; --1
/* ���� ���� ����
    employees ���̺��� �����ϰ�, departments ���̺��� �������� �ʾƵ�
    (+)�� ���� ���� ���̺��� �������� �Ͽ� departments ���̺��� ���ο�
    �����϶�� �ǹ̸� �ο��ϱ� ���� ��ȣ�� ���Դϴ�.
    (+)�� �������� employees , department�� ��ġ�ϴ� �͸� ���Դٸ�
    �ܺ� ������ department �������� �ؼ� null�ִ°� ���� 107���� ����ȴ�.
    �ܺ������� �������� ������ ���� �ٸ� ���� ���� �� null�� ǥ��ȴ�.
    (+)�� �ƴ� �ٴ� ���̺��� ������ �ȴ�. ������ �Ǵ� ���� �� ������
    �ٴ� ���̺��� ���� ���ٸ� null �� ������ �ȴ�.(Outer Join ����)
    
    �ܺ������� ����ߴ��� , ���Ŀ� ���������� ����ϰ� �Ǹ�
    ���������� �켱������ �ν��մϴ�.
*/
    
SELECT
    e.employee_id, e.first_name,
    e.department_id,
    j.start_date, j.end_date, j.job_id
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id(+) -- job.history�� ���� �� ���´�.
AND j.department_id(+) = 80; -- ���� ���� ����
-- �ܺ� ���κ��� ���� ������ �� �켱���� �ֱ� ������ 2���� ���� ����Ǵ°� Ȯ���� �� �ִ�.
-- ���� ���� ������ ���� ����Ǳ� ���� 80�̶� ���� �ִ� ���� ���θ� ����ϰ� �ʹٸ�
-- 80�� ��Ÿ���� ������ (+)�ܺ����� ���� ���ľ� 80�̶� ������ �� ���´�.
