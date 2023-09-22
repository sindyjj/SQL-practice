
--�� ��ȯ �Լ� TO_CHAR(����), TO_NUMBER(����), TO_DATE(��¥)

--��¥�� ���ڷ� TO_CHAR(��,����)
SELECT TO_CHAR(sysdate) FROM dual;
SELECT TO_CHAR(sysdate,'YYYY-MM-DD DY PM HH:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate,'YYYY-MM-DD HH24:MI:SS') FROM dual;

-- ���ڿ��� �ѱ��� ġ��ʹٸ� �ֵ���ǥ�� ����Ѵ�.
SELECT
    first_name, TO_CHAR(hire_date, 'YYYY"��" MM"��" DD"��"')
FROM employees;

--���ڸ� ���ڷ� TO-CHAR(��,����)
--���Ŀ��� ����ϴ� '9'�� ���� ���� 9�� �ƴ϶� �ڸ����� ǥ���ϱ� ���� ��ȣ�Դϴ�.
SELECT TO_CHAR(20000,'99999') FROM dual;
--�־��� �ڸ����� ���ڸ� ��� ǥ���� �� ��� ��� #���� ǥ��˴ϴ�.
SELECT TO_CHAR(20000,'9999') FROM dual;
SELECT TO_CHAR(20000.29,'99999.9') FROM dual;
SELECT TO_CHAR(20000,'99,999') FROM dual;
-- L ���̸� W ǥ�ð� ���´�.
SELECT TO_CHAR(salary, 'L99,999') AS salary
FROM employees;

--���ڸ� ���ڷ� TO_NUMBER(��,����)
SELECT '2000' + 2000 FROM dual; --�ڵ� �� ��ȯ (����->����)
SELECT TO_NUMBER('2000') + 2000 FROM dual; --����� �� ��ȯ
SELECT '$3,300' + 2000 FROM dual;-- ����
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 FROM dual;

--���ڸ� ��¥�� ��ȯ�ϴ� �Լ� TO_DATE(��,����)
SELECT TO_DATE('1998-10-30') FROM dual;
SELECT sysdate - TO_DATE('1998-10-30') FROM dual;
SELECT TO_DATE('1998/10/30', 'YY-MM-DD') FROM dual;
--�־��� ���ڿ��� ��� ��ȯ�ؾ� �մϴ�.
SELECT TO_DATE('1998-10-30 12:23:50', 'YY-MM-DD HH:MI:SS') FROM dual;

--xxxx�� xx�� xx�� ���ڿ� �������� ��ȯ�� ������.
-- ��ȸ �÷����� dateInfo ��� �ϰڽ��ϴ�.
SELECT TO_CHAR(TO_DATE('19981030','YYYYMMDD'),
'YYYY"��" MM"��" DD"��"')AS dateInfo FROM dual;

-- NULL���¸� ��ȯ�ϴ� �Լ� NVL(�÷�, ��ȯ�� Ÿ�ٰ�)
SELECT NULL FROM dual;
SELECT NVL(NULL,0) FROM dual;

SELECT
    first_name,
    commission_pct,
    NVL(commission_pct, 0) AS comm_pct
FROM employees;

--NULL ��ȯ �Լ� NVL2(�÷�,NULL�� �ƴ� ����� ��, NULL�� ����� ��)
SELECT
    NVL2('abc','�ξƴ�','����') --�ξƴ�
 --   NVL2(NULL,'�ξƴ�','����')  ����
FROM dual;

SELECT 
    first_name,
    NVL2(commission_pct, 'true', 'false')-- Ŀ�̼��� ������ Ʈ�� �ȹ����� false
FROM employees;

-- NVL2 �� ������� ������ NULL �� ������ ���� �ʴ´�
SELECT
    first_name,
    commission_pct,
    NVL2(commission_pct,(salary * commission_pct),
    salary
   ) AS real_salary
FROM employees;

--DECODE(�÷� Ȥ�� ǥ����, �׸�1, ���1, �׸�2, ���2 ...... default) SWITCH ���̶� ���
SELECT
    DECODE('C','A','A�Դϴ�','B','B�Դϴ�','C','C�Դϴ�', '�o ��?')
FROM dual;

SELECT
    job_id,
    salary,
    DECODE(
        job_id,
        'IT_PROG',salary*1.1,--10��
        'FI_MGR',salary*1.2,--20��
        'AD_VP',salary*1.3, --30��
        salary
    ) AS result
FROM employees;

--CASE WHEN THEN END
SELECT
    first_name,
    job_id,
    salary,
    (CASE job_id
        WHEN 'IT_PROG' THEN salary*1.1
        WHEN 'FI_MGR' THEN salary*1.2
        WHEN 'AD_VP' THEN salary*1.3
        WHEN 'FI_ACCOUNT' THEN salary*1.4
        ELSE salary
    END) AS result
FROM employees;

/*
���� 1.
�������ڸ� �������� employees���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 17�� �̻���
����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�
*/

--SELECT 
--first_name, hire_date,
--NVL2(((sysdate - hire_date) / 365),
--((sysdate - hire_date) / 365)>17,'���ι�',
--((sysdate - hire_date) / 365)<17,'«�ȵ�')   
--FROM employees; 
--ORDER BY 

-- ������ ���� ���� �Ǵ� �� FROM (table) -> WHERE
-- �׷��Ƿ� WHERE�� �ټӳ���� ������ �ȵǰ� 
--ORDER�� ������ �ʰ� �Ǳ� ������ �ټӳ���� �����ϴ�.
SELECT
    employee_id AS �����ȣ,
    CONCAT(first_name,last_name) AS �����,
    hire_date AS �Ի�����,
    TRUNC((sysdate-hire_date) / 365) AS �ټӳ��
FROM employees
WHERE (sysdate-hire_date) / 365 >= 17
ORDER BY �ټӳ�� DESC;
/*
���� 2.
EMPLOYEES ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
100�̶�� �������, 
120�̶�� �����ӡ�
121�̶�� ���븮��
122��� �����塯
�������� ���ӿ��� ���� ����մϴ�.
���� 1) department_id�� 50�� ������� ������θ� ��ȸ�մϴ�
*/

SELECT
    first_name,
    manager_id,
    DECODE(
    manager_id,
        100, '���',
        120, '����',
        121, '�븮',
        121, '����',
        '�ӿ�'
    ) AS ����
FROM employees
WHERE department_id = 50;