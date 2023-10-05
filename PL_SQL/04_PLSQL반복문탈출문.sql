
-- WHILE��

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN

    WHILE v_count <= 10 --end
    LOOP
        v_num := v_num + v_count;
        v_count := v_count + 1;  --step
    END LOOP;

    dbms_output.put_line(v_num);

END;

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN
    WHILE v_count <= 10 --end
    LOOP
        EXIT WHEN v_count =5;
        
        v_num := v_num + v_count;
        v_count := v_count + 1;  --step
    END LOOP;
    dbms_output.put_line(v_num);
END;

-- FOR��
DECLARE
    v_num NUMBER := 4;
BEGIN

    FOR i IN 1..9 -- .�� �� �� �ۼ��ؼ� ������ ǥ��.
    LOOP
        dbms_output.put_line(v_num || 'x' || i || ' = ' || v_numi);
    END LOOP;

END;

-- CONTINUE ��


DECLARE
    v_num NUMBER := 3;
BEGIN

    FOR i IN 1..9 -- .�� �� �� �ۼ��ؼ� ������ ǥ��.
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || 'x' || i || ' = ' || v_numi);
    END LOOP;

END;
-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num := ROUND(DBMS_RANDOM.VALUE(2,9));
    FOR i IN 1..9
    
    LOOP
        CONTINUE  WHEN v_num = FLOOR(v_num / 2);
        dbms_output.put_line( v_num || ' x ' || i || ' = ' || v_num*i);
    END LOOP;
END;
-- ���� ������ �� �Ʒ��� fm
BEGIN

    FOR dan IN 2..9   -- ..�� �ݺ��� 1~9���� �ϳ��� �ؿ� ������ �ݺ��Ѵ�.
    LOOP
        IF MOD(dan,2) = 0 THEN
        dbms_output.put_line('������' || dan || '��');
        FOR hang IN 1..9
        LOOP
            dbms_output.put_line(dan || ' x ' || hang || ' = ' || dan*hang);
        END LOOP;
            dbms_output.put_line('---------------------------------------');
        END IF;
        
    END LOOP;

END;

-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....

CREATE TABLE board (
    bno NUMBER PRIMARY KEY ,
    writer VARCHAR2(30),
    title VARCHAR2(30)
);

CREATE SEQUENCE b_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000
    MINVALUE 1
    NOCACHE
    NOCYCLE;
    

DECLARE
    v_num NUMBER := 1;
BEGIN
    WHILE v_num <= 300
    LOOP
        INSERT INTO board
        VALUES(b_seq.NEXTVAL, 'test' || v_num , 'title' || v_num);
        v_num := v_num +1;
    END LOOP;
    COMMIT;
END;

SELECT * FROM board
ORDER BY bno DESC;




