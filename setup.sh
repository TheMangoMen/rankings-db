begin;
create table test (
    uid int not null primary key
);
insert into test (uid) values (100);
select * from test;
drop table test;
rollback;
