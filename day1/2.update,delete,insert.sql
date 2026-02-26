--복습(+)

select * from student;

-- 키가 165~175 사이의 학생들을 출력

select * from student 
where stu_height BETWEEN 165 AND 175; --AND
--select * from student where 165 <= stu_height and stu_height <= 175;

select * from professor;

select * from professor
where position in ('정교수', '조교수'); --OR **
--select * from professor where position = '정교수' or position = '조교수';

select * from professor
WHERE POSITION LIKE '%교수%';

select * from student;
insert into student(stu_no, stu_name, stu_dept) values (12345678, '홍길동', '기계');
rollback;
commit;

insert into student values(12341234, '김철수', '전기전자', 1, 'A', 'M', 170, null);
commit;

-- 학번이 12345678 (홍길동)인 학생의 학과를 '컴퓨터정보', 학년을 1, CLASS를 'A'로 수정
select * from student; --

update student 
set stu_dept = '컴퓨터정보',
    stu_grade = 1,
    stu_class = 'A'
where stu_no = 12345678; --
rollback;

--**실수방지를 위한 꿀팁! : 쿼리를 작성할때(특히 update,delete), where 조건절부터 작성후 테이블 작성
--delete
--학번이 12341234 이 학생 삭제 
select * from student;
delete from student where stu_no = '12341234';
rollback;
commit;