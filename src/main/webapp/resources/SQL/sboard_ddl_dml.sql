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

-- 시퀀스 생성
CREATE SEQUENCE BOARD_SEQ INCREMENT BY 1 START WITH 1 ;
select board_seq.nextval from dual;		      


-- 더미 데이터 생성 #1
insert into board(board_no, title, content, member_id, hit_no, reg_date) 
(select board_seq.nextval, title, content, member_id, hit_no, reg_date from board);

-- 더미 데이터 생성 #2
-- 왼쪽에는 실제 컬럼명 = 우측에는 값
delete from kboard;
declare
        type tbl_ins is table of board%rowtype index by binary_integer;
        w_ins tbl_ins;
begin
        for i in 1 .. 2000 loop
                w_ins(i).board_no := i;
                w_ins(i).title := 'title';
                w_ins(i).content := 'content';
                w_ins(i).member_id := 'hong';
                w_ins(i).hit_no := 0;
                w_ins(i).reg_date := sysdate;
        end loop;       
        forall i in 1 .. 2000 insert into board values w_ins(i);
        commit;
end;

--declare
--        type tbl_ins is table of board%rowtype index by binary_integer;
--        w_ins tbl_ins;
--begin
--        for i in 1 .. 200 loop
--                w_ins(i).board_no := i;
--                w_ins(i).title := 'title';
--                w_ins(i).content := 'content';
--                w_ins(i).member_id := 'hong';
--                w_ins(i).hit_no := 0;
--                w_ins(i).reg_date := sysdate;
--                w_ins(i).reply_group := 0; -- 기본값 명시적 설정
--                w_ins(i).reply_order := 0; -- 기본값 명시적 설정
--                w_ins(i).reply_indent := 0; -- 기본값 명시적 설정
--        end loop;       
--        forall i in 1 .. 200 insert into board values w_ins(i);
--        commit;
--end;

-- reply_group 을 board_no값으로 업데이트
update board
set reply_group = board_no;

-- reply_order, reply_indent 를 0으로 업데이트
update board
set reply_order = 0,
    reply_indent = 0;

-- 여기까지 작업하고 서버를 구동하고 답글을 달면 저장이 안된다.
-- 시퀀스를 한 번도 사용하지 않아서 답글의 board_no가 기본으로 1로 만들어진다.
-- 그래서 다음과 같이 시퀀스를 삭제하고 201(최대값+1)를 시작점으로 만들어준다.
-- 그러면 답글의 board_no가 201이 되어 기존에 저장되어 있는 값과 충돌하지 않게 된다. 

-- 시퀀스를 삭제
DROP SEQUENCE board_seq;
-- 시퀀스를 현재 게시물 보다 1큰 수를 기준으로 시작하도록 변경
CREATE SEQUENCE board_seq 
START WITH 201 -- MAX(BOARD_NO) + 1 
INCREMENT BY 1;



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


-- 11 ~ 200 번까지 게시물 삭제
DELETE FROM BOARD
WHERE ROWID IN (
    SELECT ROWID
    FROM BOARD
    ORDER BY REG_DATE ASC 
    OFFSET 10 ROWS FETCH NEXT 190 ROWS ONLY
);

/* 계층형 답글 게시판에 게시물 insert */
INSERT INTO BOARD(board_no, title, content, member_id, reply_group, reply_order, reply_indent)
values(board_seq.nextval, '10번 게시물의 답글', '10번 게시물의 답글', 'hong', 10, 1, 1);
commit;

SELECT 
        board_no, 
        title, 
        content, 
        member_id, 
        hit_no, 
        reg_date,
        reply_group,
        reply_order,
        reply_indent
    FROM (
        SELECT 
            board_no, 
            title, 
            content, 
            member_id, 
            hit_no, 
            reg_date,
            reply_group,
            reply_order,
            reply_indent,
            ROW_NUMBER() OVER (
                PARTITION BY reply_group
                ORDER BY reply_group ASC, reply_order ASC
            ) AS row_num
        FROM board
        WHERE (TITLE LIKE '%' || 'title' || '%' 
               OR CONTENT LIKE '%' || 'title' || '%')
    ) 
    WHERE row_num BETWEEN 1 AND 20
    ORDER BY reply_group ASC, reply_order ASC;
    
-- 서브쿼리(인라인뷰)에서 ROW_NUMBER()는 데이터를 정렬한 후 rnum이라는 번호를 부여합니다. 
-- 바깥 메인 쿼리에서 서브쿼리의 rnum을 사용해서 필요한 만큼의 행을 취할 수 있게 된다.
SELECT board_no, title, member_id, hit_no, reg_date, 
    reply_group, reply_order, reply_indent
FROM (
    SELECT board_no, title, member_id, hit_no, reg_date, 
        reply_group, reply_order, reply_indent,
        ROW_NUMBER() OVER (ORDER BY reply_group DESC, reply_order ASC, reply_indent ASC) AS rnum
    FROM board
) 
WHERE rnum BETWEEN 1 AND 20;

-- 업데이트(order, indent = 0)
update board
set
    reply_order = 0,
    reply_indent = 0;

SELECT 
		        board_no, 
		        title, 
		        member_id, 
		        hit_no, 
		        reg_date, 
		        reply_group, 
		        reply_order, 
		        reply_indent
		    FROM (
		        SELECT 
		            board_no, 
		            title, 
		            member_id, 
		            hit_no, 
		            reg_date, 
		            reply_group, 
		            reply_order, 
		            reply_indent,
		            ROW_NUMBER() OVER (ORDER BY reply_group DESC, reply_order ASC, reply_indent ASC) AS rnum
		        FROM board
		        WHERE
		                (title LIKE '%' || 'title' || '%' 
		                 OR content LIKE '%' || 'title' || '%')
		    )
		    WHERE rnum BETWEEN (1) AND (20);
-- commit;
-- 1. 답글 추가시에는 두 가지 작업이 병행되어야 한다.
-- 1) 부모 보다 reply_order 큰 게시물들의 reply_order를 부모 + 1씩 증가시킨다.            
    UPDATE board
    SET reply_order = reply_order + 1
    WHERE reply_group = 10 AND reply_order > 0;
-- 2) 답글 등록
INSERT INTO board (
    board_no, 
    title, 
    content, 
    member_id, 
    hit_no, 
    reg_date, 
    reply_group, 
    reply_order, 
    reply_indent
) VALUES (
    board_seq.NEXTVAL, 
    '10게시물의 두번째 답글', 
    '10게시물의 두번째 답글', 
    'hong', 
    0, 
    SYSDATE, 
    10, /* 부모의 replyGroup과 동일 */
    0+1, /* 부모의 reply_order + 1 */
    0+1 /* 부모의 reply_indent + 1 */
);
commit;