
-- ���̺� ������ ��������
--  : ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���� ��Ģ�� �����ϴ� ��.

-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����.
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.

-- �÷� ���� ���� ���� (�÷� ���𸶴� �������� ����)
CREATE TABLE dept2 (                                            
    -- PRIMARY = NULL(�� ��) + UNIQUE(�ߺ�����)
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY, 
    -- ������ �ҋ� �߿��� �� :PRIMARY KEY
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE, 
    -- NULL ���� �ȵ��� UNIQUE �ߺ�����
   loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    dept_date DATE,
   dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);
    DROP TABLE dept2;

-- ���̺� ���� ���� ���� (��� �� ���� �� ���� ������ ���ϴ� ���)
    CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) CONSTRAINT dept_name_notnull NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

-- �ַ� Ű (foreign key)�� �θ����̺�(�������̺�) �� ���ٸ� INSERT �Ұ���
INSERT INTO dept2
VALUES(10,'gg', 3000,100000, 'M');

INSERT INTO dept2
VALUES(20,'hh', 1900,100000, 'M');

UPDATE dept2
SET loca = 4000
WHERE dept_no = 10; -- ����(�ܷ�Ű �������� ����)

UPDATE dept2
SET loca = 4000
WHERE loca = 1900; -- ����(�ܷ�Ű �������� ����)

-- ���� ������ ����
-- ���� ������ �߰�, ������ �����մϴ�. ������ �ȵ˴ϴ�.
-- �����ϸ� �����ϰ� ���ο� �������� �߰��ϼž� �մϴ�.

 CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- pk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);
-- fk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);
-- check �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);
-- NOT NULL�� �� �������·� �����մϴ�.
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

-- ���� ���� Ȯ��
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

-- ���� ���� ���� (���� ���� �̸�����)
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;

CREATE TABLE members (
    M_NAME VARCHAR2(15) NOT NULL,
    M_NUM NUMBER(3) CONSTRAINT mem_member_pk PRIMARY KEY,
    REG_DATE DATE NOT NULL CONSTRAINT mem_regdate_uk UNIQUE,
    GENDER VARCHAR2(1),
    LOCA VARCHAR2(4) CONSTRAINT mem_loca_locid_fk REFERENCES locations(location_id)
);
SELECT * FROM user_constraints
WHERE table_name = 'MEMBERS';

INSERT INTO members
    (M_NAME,M_NUM,REG_DATE,GENDER,LOCA)
VALUES
    ('AAA',1,'2018-07-01','M','1800');
    
INSERT INTO members
    (M_NAME,M_NUM,REG_DATE,GENDER,LOCA)
VALUES
    ('BBB',2,'2018-07-02','F','1900');
    
INSERT INTO members
    (M_NAME,M_NUM,REG_DATE,GENDER,LOCA)
VALUES
    ('CCC',3,'2018-07-03','M','2000');
    
INSERT INTO members
    (M_NAME,M_NUM,REG_DATE,GENDER,LOCA)
VALUES
    ('DDD',4,'2023-09-27','M','2000');

COMMIT;

----2��-------------

SELECT
    m.M_NAME,m.M_NUM,loc.street_address,loc.location_id
FROM members m JOIN locations loc
ON m.loca = loc.location_id
ORDER BY m_num ASC;