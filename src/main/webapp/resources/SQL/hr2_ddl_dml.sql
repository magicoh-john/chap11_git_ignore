/* kboard 관리자 보드 */
--CREATE USER KBOARD IDENTIFIED BY 1234;
--GRANT CONNECT, RESOURCE TO KBOARD;
--GRANT UNLIMITED TABLESPACE TO KBOARD;

/* 테이블 생성 */

-- 권한 테이블 생성
--drop table role_tbl cascade constraints;
create table role(
    role_id varchar2(20),
    role_name varchar2(20) not null,
    constraint role_pk primary key(role_id)
);    

insert into role(role_id, role_name) values('admin', '관리자');    
insert into role(role_id, role_name) values('user', '일반사용자'); 

CREATE TABLE member(
    member_id varchar2(10),
    password varchar2(10) not null,
    name varchar2(20),
    email varchar2(50),
    reg_date date default sysdate,
    role_id varchar2(20),
    constraint pk_member primary key(member_id),
    constraint fk_member_role foreign key(role_id) references role(role_id)
);    

INSERT INTO member(member_id, password, name, email, role_id, reg_date)
values('hong', '1234', '홍길동', 'abc@naver.com', 'user', sysdate);

INSERT INTO member(member_id, password, name, email, role_id, reg_date)
values('lee', '1234', '이진선', 'lee@naver.com', 'user', sysdate);

INSERT INTO member(member_id, password, name, email, role_id, reg_date)
values('kim', '1234', '김이순', 'kim@naver.com', 'admin', sysdate);
commit;

CREATE TABLE BOARD(
    BOARD_NO NUMBER, -- 게시물 번호
    TITLE VARCHAR2(255) NOT NULL, -- 제목
    CONTENT CLOB NOT NULL, -- 내용
    MEMBER_ID VARCHAR2(10), -- 작성자
    HIT_NO NUMBER(4) DEFAULT 0, -- 조회수
    REG_DATE DATE DEFAULT SYSDATE, -- 등록일
    CONSTRAINT PK_BOARD PRIMARY KEY(BOARD_NO),
    CONSTRAINT FK_BOARD_MEMBER_ID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);

INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(1, '첫번째 게시물', '이것은 첫번째 게시물', 'hong', sysdate);

INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(2, '두번째 게시물', '이것은 두번째 게시물', 'lee', sysdate);

INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, MEMBER_ID, REG_DATE)
VALUES(3, '세번째 게시물', '이것은 세번째 게시물', 'kim', sysdate);
commit;

SELECT 
	    board_no, 
		title, 
		content, 
		member_id, 
		hit_no, 
		reg_date 
	  FROM 
	      (
	      SELECT /*+INDEX_DESC(BOARD PK_BOARD) */
	        ROWNUM RN, 
	        board_no, 
			title, 
			content, 
			member_id, 
			hit_no, 
			reg_date 
	      FROM 
	        BOARD
	      WHERE
		      (TITLE LIKE '%'||'게시물'||'%' OR CONTENT LIKE '%'||'게시물'||'%') 
		      AND ROWNUM <= 3
		      )
	      WHERE RN > 0 ;