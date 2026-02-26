--복습(+)

select * from professor;

-- 1. BONUS를 받는 교수들 출력
select * from professor 
where bonus is not null;

-- 2. 급여가 300~400 사이인 교수들 출력
select * from professor;
select * from professor 
where pay between 300 and 400;   --between A and B

-- 3. 아이디에 'a'가 들어가는 교수 출력
select * from professor;
select * from professor
where id like '%a%';  --like '%'

-- 4. PROFNO, NAME, ID를 임의로 넣어서 교수 레코드 INSERT
select * from professor;
insert into professor(profno, name, id)
values(5001, '가나디', 'dyu');

-- 5. 4번에서 만든 데이터 DELETE
select * from professor;
delete from professor
where profno = 5001;

-- 6. 급여가 300이하인 교수들의 급여를 +10 UPDATE
select * from professor where pay <= 300;
update professor 
set pay = pay + 10
where pay <= 300;
rollback;
commit;
