
--lower(�ҹ���), initcap(�ձ��ڸ� �빮��), upper(�빮��)

SELECT * FROM dual;

/*
dual�̶�� ���̺��� sys�� �����ϴ� ����Ŭ�� ǥ�� ���̺�μ�,
���� �� �࿡ �� �÷��� ��� �ִ� dummy ���̺� �Դϴ�.
�Ͻ����� ��� �����̳� ��¥ ���� � �ַ� ����մϴ�.
��� ����ڰ� ������ �� �ֽ��ϴ�.
*/

SELECT
    'abcDEF', lower('abcDEF'), upper('abcDEF')
FROM
    dual;
    
SELECT
    last_name,
    LOWER(last_name),
    INITCAP(last_name),
    UPPER(last_name)
FROM employees;

SELECT last_name FROM employees
WHERE LOWER(last_name) = 'austin';

-- length(����),instr(���� ã��, ������ 0�� ��ȯ, ������ �ε��� ��)
SELECT
    'abcDEF', LENGTH('abcDEF'),INSTR('abcdef','a')
FROM dual;

SELECT
    first_name, LENGTH(first_name),INSTR(first_name,'a')
FROM employees;

--substr(�ڸ� ���ڿ�, ���� �ε��� ����), concat(���ڿ���)
--substr(�ڸ� ���ڿ�, ���� �ε���)-> ���ڿ� ������
--�ε��� 1���� ����
SELECT
    'abcdef' AS ex,
    SUBSTR('abcdef',1,4),
    CONCAT('honmo','you')
FROM dual;

SELECT
    first_name,
    SUBSTR(first_name,1,3),
    CONCAT(first_name, last_name)
FROM employees;

--LPAD, RPAD (��, ���� ���� ���ڿ��� ä���)
-- abc�� ���ڿ��� ���ԵǴϱ� ���� 7�ڸ������� ���´�.
SELECT
    LPAD('abc',10,'*'),
    RPAD('abc',10,'*')
FROM dual;

--LTRIM(),RTRIM(),TRIM() ���� ����
--LTRIM(param1,param2) --> param2�� ���� param1���� ã�Ƽ� ���� (���ʺ���)
--RTRIM(param1,param2) --> param2�� ���� param1���� ã�Ƽ� ���� (�����ʺ���)

SELECT LTRIM('javascript_java','java') FROM dual;--�����:script_java
SELECT RTRIM('javascript_java','java') FROM dual;--�����:javascript_
SELECT TRIM('     java     ') FROM dual;-- ��������

--replace()
SELECT
    REPLACE('My dream is honmo','honmo','honmolover')
FROM dual;

SELECT
   REPLACE (REPLACE('My dream is honmo','honmo','honmolover'),' ','')
FROM dual;

SELECT
    REPLACE(CONCAT('honmo', 'ugly!'), '!', '?')
FROM dual;

/*
���� 1.
EMPLOYEES ���̺��� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�. (CONCAT)
���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
*/
SELECT
    CONCAT(first_name,last_name)AS �̸�,
    REPLACE(hire_date, '/', '') AS �Ի�����   
FROM employees
ORDER BY first_name ASC;


/*
���� 2.
EMPLOYEES ���̺��� phone_number�÷��� ###.###.####���·� ����Ǿ� �ִ�
���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� 
��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���. (CONCAT, SUBSTR, LENGTH ���)
*/
SELECT
    REPLACE(CONCAT('(02)',(SUBSTR(phone_number,4))),'.','-') AS phone_number
FROM employees;

/*
���� 3.  IT_PROG
EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
*/
SELECT   
--    (RPAD(RPAD(first_name,3,'*'),10,'*'))AS name,
--    LPAD(salary,10,'*')AS salary
      RPAD(SUBSTR(first_name, 1,3),LENGTH(first_name), '*') AS name,
      LPAD(salary,10,'#')AS salary
FROM employees
WHERE LOWER(job_id) ='it_prog';



