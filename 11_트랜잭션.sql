
-- ����Ŀ�� Ȱ��ȭ ���� Ȯ��
SHOW AUTOCOMMIT; 
-- ����Ŀ�� ��
SET AUTOCOMMIT ON;

SET AUTOCOMMIT OFF;

SELECT * FROM emps;

--���̺�����Ʈ ����.
--�ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����.
--ANSI ǥ�� ������ �ƴϱ� ������ �׷��� ���������� ����.
SAVEPOINT insert_park;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (306, 'kim', 'kim1234@gmail.com', sysdate, 1800);
 -- �������� ��� ������ ��������� ���(���)
 -- ���� Ŀ�� �ܰ�� ȸ��(���ư���) �� Ʈ����� ����
 
 
ROLLBACK TO SAVEPOINT insert_park;

DELETE FROM emps WHERE employee_id = 304;

-- �������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ����� ����
-- Ŀ�� �Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� �����ϴ�.
COMMIT;











