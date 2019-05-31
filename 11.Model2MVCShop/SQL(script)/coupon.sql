DROP SEQUENCE seq_coupon_coupon_no

CREATE SEQUENCE seq_coupon_coupon_no INCREMENT BY 1 START WITH 10000;

CREATE TABLE coupon(
	coupon_no NUMBER NOT NULL,
	coupon_detail			varchar2(20),
	coupon_reg_date DATE default	sysdate
);

INSERT INTO coupon VALUES (seq_coupon_coupon_no.nextval, '10% 할인', SYSDATE);
INSERT INTO coupon VALUES (seq_coupon_coupon_no.nextval, '무료배송', SYSDATE); 

ALTER TABLE users ADD DISCOUNT_COUPON_10 char(1);

ALTER TABLE transaction ADD sold_PRICE NUMBER(20);

CREATE TABLE user_coupon(
user_id varchar2(20) NOT null,
discount_coupon10 CHAR(1)
);