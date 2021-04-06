create table member (
no number not null ,
id varchar2(50) not null ,
passwd varchar2(250) not null ,
name varchar2(50) not null ,
gender varchar2(50) not null ,
bornYear number not null ,
postCode varchar2(50) not null ,
address varchar2(1000) not null ,
detailAddress varchar2(1000) not null ,
extraAddress varchar2(1000) not null ,
regiDate timestamp default current_timestamp ,
primary key(no)
);

select * from member;

create sequence seq_member start with 1 increment by 1 nomaxvalue nocache;

create table memo (
    no          number              not null,
    memberNo    number              not null,
    writer      varchar2(50)        not null,
    content     varchar2(1000)      not null,
    regiDate    timestamp           default current_timestamp
);

create sequence seq_memo start with 1 increment by 1 nomaxvalue nocache;

ALTER TABLE memo ADD CONSTRAINT memo_memberNo_member_no 
FOREIGN KEY (memberNo) REFERENCES member(no) ON DELETE CASCADE;

create table survey (
no number not null ,                                    -- 문제번호
question varchar2(4000) not null ,                      -- 문제
ans1 varchar2(500) not null ,
ans2 varchar2(500) not null ,
ans3 varchar2(500) not null ,
ans4 varchar2(500) not null ,
status char(1) default '1' ,                            -- 설문진행상태(1 진행중, 0종료)
start_date timestamp default current_timestamp ,
last_date timestamp default current_timestamp ,
regi_date timestamp default current_timestamp ,
primary key(no)
);

create sequence seq_survey start with 1 increment by 1 nomaxvalue nocache;

create table survey_answer (
answer_no number not null ,                             -- 답변일련번호
no number not null ,                                    -- surveyNo
answer number not null ,                                -- 답변번호
regi_date timestamp default current_timestamp ,
primary key(answer_no)
);

create sequence seq_survey_answer start with 1 increment by 1 nomaxvalue nocache;

create table board (
    no              number              not null,
	num             number              not null,
	tbl             varchar2(50)        not null,
	writer          varchar2(50)        not null,
	subject         varchar2(50)        not null,
	content         varchar2(50)        not null,
	email           varchar2(50)        not null,
	passwd          varchar2(50)        not null,
	refNo           number              not null,
	StepNo          number              not null,
	levelNo         number              not null,
	parentNo        number              not null,
	hit             number              not null,
	ip              varchar2(50)        not null,
	memberNo        number              not null,
	noticeNo        number              not null,
	secretGubun     varchar2(1)         not null check (secretGubun in ('T', 'F')),
	regiDate        date                default sysdate,
    primary key(no)
);

ALTER TABLE board ADD CONSTRAINT board_memberNo_member_no 
FOREIGN KEY (memberNo) REFERENCES member(no) ON DELETE CASCADE;

alter table board modify content varchar2(500);

create sequence seq_board start with 1 increment by 1 nomaxvalue nocache;

create table board_comment (
    comment_no      number not null primary key, -- 댓글 일련번호
    board_no        number not null references board(no), -- 게시물 번호
    writer          varchar2(50) not null,
    content         clob not null,
    passwd          varchar2(50) not null,
    memberNo        number not null,
    ip              varchar2(50) not null,
    regiDate        date default sysdate
);

ALTER TABLE board_comment ADD CONSTRAINT board_comment_memberNo_member_no 
FOREIGN KEY (memberNo) REFERENCES member(no) ON DELETE CASCADE;

create sequence seq_board_commnet start with 1 increment by 1 nomaxvalue nocache;

create table boardChk (
    no              number not null primary key, -- tbl 일련번호
    tbl             varchar2(50) not null, -- 게시글 구분
    tblName         varchar2(50) not null,
    serviceGubun    varchar2(50) not null,
    regiDate        date default sysdate
);

create sequence seq_boardChk start with 1 increment by 1 nomaxvalue nocache;

insert into boardChk values(seq_boardChk.nextVal, 'freeboard', '자유게시판', 'T', sysdate);
insert into boardChk values(seq_boardChk.nextVal, 'funnyboard', '유머게시판', 'T', sysdate);
insert into boardChk values(seq_boardChk.nextVal, 'memberboard', '회원전용게시판', 'F', sysdate);
insert into boardChk values(seq_boardChk.nextVal, 'javaboard', '자바게시판', 'T', sysdate);

create table product (
    no number not null, -- 상품코드
    name varchar2(50) not null, -- 상품이름
    price number default 0, -- 단가
    description clob, -- 상품설명
    product_img varchar2(1000) not null, -- 상품이미지 파일이름
    regi_date timestamp default current_timestamp,
    primary key(no)
);

create sequence seq_product start with 1 increment by 1 nomaxvalue nocache;

create table cart (
    no          number          not null primary key, -- 일련번호
    memberNo    number          not null, -- 사용자코드
	productNo   number          not null, -- 상품코드
	amount      number          default 0, -- 수량
	regi_date   timestamp       default current_timestamp
);

create sequence seq_cart start with 1 increment by 1 nomaxvalue nocache;

alter table cart add constraint fk_cart_memberNo foreign key(memberNo) references member(no);
alter table cart add constraint fk_cart_productNo foreign key(productNo) references product(no);
select * from cart;
-- alter table cart drop constraint fk_cart_memberNo;

desc memo;

select * from memo;

commit;

desc guestbook;

select * from survey;
select * from survey_answer order by answer_no desc;

select * from tab;

delete from survey;
delete from survey_answer;

commit;

select * from survey_answer;

select * from (select b.*, rownum rnum from (   select * from survey where 1=1                          order by no desc        ) b) where rnum between 1 and 10;

select * from 
(
select b.*, rownum rnum from
(
select t1.*, (select count(*) from survey_answer t2 where t2.no = t1.no) survey_counter
from survey t1 where 1=1                             order by no desc        ) b) where rnum between ? and ?;

select * from survey;

select * from (select b.*, rownum rnum from (
		select t1.*, (select count(*) from survey_answer t2 where t2.no = t1.no) survey_counter
		from survey t1 where 1=1
        
        order by no desc
			) b) where rnum between 1 and 10;
            
select * from board;

select * from tab;

select * from boardchk;

select * from product;

select * from board_comment;

delete from product;
delete from cart;

commit;

select * from member;
select * from product;
select * from cart;


select * from (select A.*, p.product_img, p.price product_price, p.name product_name, (p.price * A.amount) buy_money, Rownum Rnum from (
select * from cart where 1 = 1
order by no desc 
) A, product p where A.productNo = p.no)
where rnum between 1 and 10;

select * from board;

select * from (select A.*, Rownum Rnum, (select amount from cart c where c.productNo = a.no) from (
select * from product where 1 = 1
order by no desc
) A) where rnum between 1 and 10;

select amount from cart where productNo = 20;

select * from (select A.*, (select sum(amount) from cart where productNo = a.no) cart_counter, Rownum Rnum from (
select * from product where 1 = 1
order by no desc
) A) where rnum between 1 and 10;

create table cart (
    no          number          not null primary key, -- 일련번호
    memberNo    number          not null, -- 사용자코드
	productNo   number          not null, -- 상품코드
	amount      number          default 0, -- 수량
	regi_date   timestamp       default current_timestamp
);

alter table cart add constraint fk_cart_member foreign key (memberNo) references member(no) on delete cascade;

alter table cart add constraint FK_CART_MEMBERNO foreign key(memberNo) references member(no) on delete cascade;

alter table cart drop constraint FK_CART_MEMBERNO;

alter table cart add constraint FK_CART_PRODUCTNO foreign key(productNo) references product(no) on delete cascade;

alter table cart drop constraint FK_CART_PRODUCTNO;

alter table memo add constraint SYS_C007711 foreign key(memberNo) references member(no) on delete cascade;

alter table memo drop constraint SYS_C007711;

select * from memo;

commit;

select * from cart;

select * from member;

desc cart;

select * from product;

select * from member;

select * from board;

delete from board where no = 9;

select * from survey_answer order by answer_no desc;

commit;

select * from guestbook;

desc guestbook;