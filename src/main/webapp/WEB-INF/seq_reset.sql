delete from USERFOOD;
drop sequence USERFOOD_idx_seq;
create sequence USERFOOD_idx_seq;

select * from userfood;

select * from freeboard;
select count(id) from freeboard;


delete from DIET;
drop sequence DIET_idx_seq;
create sequence DIET_idx_seq;

select * from diet;
select * from freeboard;
select * from userregister;

delete from freeboard;
drop sequence freeboard_idx_seq;
create sequence freeboard_idx_seq;

insert into freeboard (idx, subject, content, writeDate, hit, name, id, realfilepath)
values (freeboard_idx_seq.nextval, '1111', '1111이다~', '2023-09-25', 0, '관리자', 'admin', '');
insert into freeboard (idx, subject, content, writeDate, hit, name, id, realfilepath)
values (freeboard_idx_seq.nextval, '2222', '2222이다~', '2023-09-25', 0, '관리자', 'admin', '');
insert into freeboard (idx, subject, content, writeDate, hit, name, id, realfilepath)
values (freeboard_idx_seq.nextval, '3333', '3333이다~', '2023-09-25', 0, '관리자', 'admin', '');
insert into freeboard (idx, subject, content, writeDate, hit, name, id, realfilepath)
values (freeboard_idx_seq.nextval, '4444', '4444이다~', '2023-09-25', 0, '관리자', 'admin', '');
commit;
