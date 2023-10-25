
CREATE TABLE users(
    user_id VARCHAR2(50) PRIMARY KEY,
    user_pw VARCHAR2(50) NOT NULL,
    user_name VARCHAR2(50) NOT NULL,
    user_phone1 VARCHAR2(50),
    user_phone2 VARCHAR2(50),
    user_email1 VARCHAR2(50),
    user_email2 VARCHAR2(50),
    addr_basic VARCHAR2(300),
    addr_detail VARCHAR2(300),
    addr_zip_num VARCHAR2(50),
    reg_date DATE DEFAULT sysdate
);
SELECT * FROM users;
