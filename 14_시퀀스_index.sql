
--시퀀스 (순차적으로 증가하는 값을 만들어 주는 객체)

CREATE SEQUENCE dept2_seq
    START WITH 1 -- 시작값 (기본값은 증가할 때 최소값, 감소할 때 최대값)
    INCREMENT BY 1 -- 증가값(1씩 증가하겠다. -1 붙치면 감소도 가능. 기본 값 :1)
    MAXVALUE 10 -- 최대값(최대 10 , 기본값은 1027)
    MINVALUE 1 -- 최소값(최소 1, 기본값 1, 감소일 때 - 1028)
    NOCACHE  -- 캐시메모리 사용 여부(CACHE) (잘 쓰지 않는다 에러때매) 기본값 CACHE
    NOCYCLE; -- 순환여부(기본값 NOCYCLE이 기본, 순환시키려면 CYCLE)

DROP TABLE dept2;

CREATE TABLE dept2 (
    dept_no NUMBER(2) PRIMARY KEY, -- 프라이머리 키를 통해 번호를 통해 구별하겠다.
                                   -- (UNIQUQ(겹치면안됨) +NOT NULL)
    dept_name VARCHAR(14),
    loca VARCHAR(13),
    dept_date DATE
);

-- 시퀀스 사용하기 (NEXTVAL, CURRVAL)
INSERT INTO dept2
VALUES(dept2_seq.NEXTVAL,'test','test',sysdate);
--1번 수행할 때 마다 넘버가 하나씩 올라가면서 다음 값을 준다

SELECT * FROM dept2;

SELECT dept2_seq.CURRVAL FROM dual;

-- 시퀀스 수정 (직접 수정가능)
-- START WITH은 수정이 불가능하다.

ALTER SEQUENCE dept2_seq MAXVALUE 9999; -- 최대값 변경
ALTER SEQUENCE dept2_seq INCREMENT BY 10; -- 증가값 변경
ALTER SEQUENCE dept2_seq MINVALUE 0; -- 최소값 변경

-- 시퀀스 값을 다시 처음으로 돌리는 방법
ALTER SEQUENCE dept2_seq INCREMENT BY -227;
SELECT dept2_seq.NEXTVAL FROM dual;
ALTER SEQUENCE dept2_seq INCREMENT BY 1;

DROP SEQUENCE dept2_seq;

/*
- index
index는 primary key, unique 제약 조건에서 자동으로 생성되고,
조회를 빠르게 해 주는 hint 역할을 합니다.
index는 조회를 빠르게 하지만, 무작위하게 많은 인덱스를 생성해서
사용하면 오히려 성능 부하를 일으킬 수 있습니다.
정말 필요할 때만 index를 사용하는 것이 바람직합니다.
*/

SELECT * FROM employees WHERE salary = 12008;

-- 인덱스 생성
CREATE INDEX emp_salary_idx ON employees(salary);

 /*
 테이블 조회 시 인덱스가 붙은 컬럼을 조건절로 사용한다면
 테이블 전체 조회가 아닌, 컬럼에 붙은 인덱스를 이용해서 조회를 진행합니다.
 인덱스를 생성하게 되면 지정한 컬럼에 ROWID를 붙인 인덱스가 준비되고,
 조회를 진행할 시 해당 인덱스의 ROWID를 통해 빠른 스캔을 가능하게 합니다.
 */
DROP INDEX emp_salary_idx;

-- 시퀀스와 인덱스를 사용하는 hint방법
CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE TABLE tbl_board(
    bno NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(20)
);

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

SELECT * FROM tbl_board
WHERE bno = 29;

COMMIT;

-- 인덱스 이름 변경
ALTER INDEX sys_c007064
RENAME TO tbl_board_idx;


SELECT*FROM
    (
SELECT ROWNUM AS rn,a.*
    FROM
        (
        SELECT *
        FROM tbl_board
        ORDER BY bno DESC
        )a
    )
WHERE rn > 10 AND rn <=30;

-- /*+ INDEX(table_name index_name) */
-- 지정된 인덱스를 강제로 쓰게끔 지정.
-- INDEX ASC, DESC를 추가해서 내림차, 오름차 순으로 쓰게끔 지정 가능.
SELECT*FROM 
    (
    SELECT /*+ INDEX_DESC(tbl_board tbl_board_idx) */ -- 주석이 아닌 힌트 문법
        ROWNUM AS rn,
        bno,
        writer
    FROM tbl_board
    )
WHERE rn > 10 AND rn <= 30;

/*
- 인덱스가 권장되는 경우 
1. 컬럼이 WHERE 또는 조인조건에서 자주 사용되는 경우
2. 열이 광범위한 값을 포함하는 경우
3. 테이블이 대형인 경우
4. 타겟 컬럼이 많은 수의 null값을 포함하는 경우.
5. 테이블이 자주 수정되고, 이미 하나 이상의 인덱스를 가지고 있는 경우에는
 권장하지 않습니다.
*/









