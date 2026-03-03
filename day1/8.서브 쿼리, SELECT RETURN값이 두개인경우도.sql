-- 서브쿼리

SELECT MAX(PAY)
FROM PROFESSOR;

SELECT *
FROM PROFESSOR
WHERE PAY = 570;

SELECT *
FROM PROFESSOR
WHERE PAY = (
    SELECT MAX(PAY)
    FROM PROFESSOR
);

select * from professor;

SELECT MAX(PAY)  --각그룹별로 최대급여를 구한다
FROM PROFESSOR
GROUP BY POSITION; --position 이름이 같은것끼리 그룹이 된다
--select는 value값을 리턴한다. max(pay) => 570, 380, 300

SELECT *
FROM PROFESSOR
WHERE PAY IN (
    SELECT MAX(PAY)
    FROM PROFESSOR
    GROUP BY POSITION  --570,380,300,300  => 원하는 형태가 아님
);
--where pay in (570, 380, 300)   => pay가 570 이거나 380 이거나 300
    
select * from professor;       
                                                        -- select 는 행 또는 value값을 리턴한다. 
                           -- **SELECT RETURN값 FROM~   => SELECT 옆에 있는게 RETURN값! return값 여러개=>해시맵 느낌!
                           --(정교수,570), (조교수,380), (전임강사,300)
                           --각 그룹별 이름과 각 그룹별 최대 급여를 보여줌 (position,max(pay))
SELECT POSITION, MAX(PAY)  --POSITION, MAX(PAY)(2개의 컬럼) 자리 순으로 비교.
FROM PROFESSOR
GROUP BY POSITION;        -- position 이름이 같은것끼리 그룹이 된다.

SELECT *
FROM PROFESSOR
WHERE (POSITION, PAY) IN (  --(POSITION, PAY) 랑  (2개의 컬럼)
    SELECT POSITION, MAX(PAY)  --POSITION, MAX(PAY)(2개의 컬럼) 자리 순으로 비교.
    FROM PROFESSOR
    GROUP BY POSITION     -- (position, pay) IN ((정교수, 570),(조교수, 380),(전임강사, 300))
);                        -- (position, pay) 가 (정교수, 570) 또는(조교수, 380) 또는 (전임강사, 300) 를 만족하는 
    
SELECT MAX(PAY)   --그 그룹의 최대급여를 구한다.
FROM PROFESSOR
GROUP BY POSITION;  --position value가 같은것끼리 그룹이 된다.
    
SELECT POSITION, MAX(PAY)  --return값이 2개 => (정교수,570), (조교수,380), (전임강사,300)
FROM PROFESSOR
GROUP BY POSITION;

-- STUDENT 테이블에서 키가 가장 큰 사람과 가장 작은 사람의
-- 학번, 이름, 학과, 키 출력
select * from student;

select stu_no, stu_name, stu_dept, stu_height
from student
--where stu_height = (select max(stu_height) from student) OR stu_height = (select min(stu_height) from student);
where stu_height in ((select max(stu_height) from student), (select min(stu_height) from student));
--where stu_height = 188 OR stu_height = 154;
--where stu_height in (188, 154);

select max(stu_height)
from student;   --188

select min(stu_height)
from student;   --154

--복습(+)