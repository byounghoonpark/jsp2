create table book (
   seq  number primary key,
   writer varchar2(50),
   title varchar2(200),
   content varchar2(4000),
   regdate date
)
select * from book

delete from book where seq=3

select nvl(max(seq),0) from book