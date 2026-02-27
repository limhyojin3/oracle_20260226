-- OUTER JOIN(LEFT, RIGHT)   --OUTER는 생략가능.  LEFT JOIN: ON조건절을 기준으로 (INNER) JOIN 하되, 
                                                          -- 왼쪽 테이블에 있는건 다 보여줌. 
                                                          -- 값이 없으면 NULL값이 나옴.     
                                              --RIGHT JOIN:오른쪽 테이블에 있는건 다 보여줌.

SELECT * FROM DEPT;

SELECT * FROM EMP;

SELECT *
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

select * from emp;
select * from dept;

select * 
from emp e
inner join dept d on e.deptno = d.deptno;


SELECT STU_NAME, COUNT(ENR_GRADE) -- COUNT(속성): 속성에 NULL값이 있으면 카운트 세지않음.
FROM STUDENT S;
--LEFT JOIN ENROL E ON S.STU_DEPT = E.STU_DEPT;(x)

select * from student;
select * from enrol;

select * 
from student s
left join enrol e on s.stu_no = e.stu_no;

select stu_name, count(enr_grade)
from student s
left join enrol e on s.stu_no = e.stu_no
group by stu_name;




SELECT * FROM PROFESSOR;
SELECT * FROM STU;

--교수이름, 직급, 담당학생
select p.name, position, s.name
from professor p
inner join stu s on p.profno = s.profno;

select p.name, position, nvl(s.name, '담당학생없음')
from professor p
left join stu s on p.profno = s.profno;



SELECT P.NAME, P.POSITION, S.NAME
FROM PROFESSOR P
INNER JOIN STU S ON P.PROFNO = S.PROFNO;

SELECT P.NAME, P.POSITION, NVL(S.NAME, '담당학생없음')--NULL값 나오면 '담당학생없음' 으로 대체함.
FROM PROFESSOR P
LEFT JOIN STU S ON P.PROFNO = S.PROFNO;

-- 학번, 학생 이름, 담당 교수 이름 출력
-- 담당 교수가 없으면 '없음' 으로 출력

SELECT * FROM STU;
SELECT * FROM PROFESSOR;

select *
from stu s
inner join professor p on s.profno = p.profno;

select stuno, s.name, nvl(p.name, '담당교수없음')
from stu s
left join professor p on s.profno = p.profno;




SELECT S.STUNO 학번, S.NAME 학생이름, NVL(P.NAME, '없음') 담당교수
FROM STU S
LEFT JOIN PROFESSOR P ON S.PROFNO = P.PROFNO;

-- 학생들이 시험본 갯수
SELECT *
FROM STUDENT;
SELECT *
FROM ENROL;

select *
from student s
inner join enrol e on s.stu_no = e.stu_no;

select *
from student s
left join enrol e on s.stu_no = e.stu_no;

select stu_name, count(*)
from student s
left join enrol e on s.stu_no = e.stu_no
group by stu_name;

select stu_name, count(enr_grade)
from student s
left join enrol e on s.stu_no = e.stu_no
group by stu_name;

select stu_name, decode(count(enr_grade) , 0, '점수없음',count(enr_grade))
from student s
left join enrol e on s.stu_no = e.stu_no
group by stu_name
order by count(enr_grade) desc;




SELECT *
FROM STUDENT S
LEFT JOIN ENROL E ON S.STU_NO = E.STU_NO;




SELECT STU_NAME, COUNT(ENR_GRADE)
FROM STUDENT S
LEFT JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY STU_NAME;

--점수 없으면 '점수 없음'    -TO_CHAR(AVG(ENR_GRADE)) => TO_CHAR()는 매개변수로 들어온거를 문자로 바꿔줌.
SELECT STU_NAME, NVL(TO_CHAR(AVG(ENR_GRADE)), '점수없음') --NVL( ? , 대체될것) <= NVL 안에는 타입이 같아야함.
FROM STUDENT S
LEFT JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY STU_NAME;


--------------------
select stu_name, nvl(to_char(avg(enr_grade)),'점수없음')
from student s
left join enrol e on s.stu_no = e.stu_no
group by stu_name;


--EMP
--부하직원의 수를 구하고 싶다
--없으면 0으로 출력
--사번, 이름, 자신의 부하직원 수 출력
SELECT * FROM EMP;


--사번,자신의부하직원수
select mgr, count(*)
from emp
where mgr is not null
group by mgr;

select *
from emp e
inner join (
    select mgr, count(*)
    from emp
    where mgr is not null
    group by mgr
) t on e.empno = t.mgr;


select *
from emp e
left join (
    select mgr, count(*)
    from emp
    where mgr is not null
    group by mgr
) t on e.empno = t.mgr;


select e.empno, e.ename, nvl(cnt, 0)
from emp e
left join (
    select mgr, count(*) cnt
    from emp
    where mgr is not null
    group by mgr
) t on e.empno = t.mgr;









SELECT MGR, COUNT(*)
FROM EMP
WHERE MGR IS NOT NULL
GROUP BY MGR;

SELECT *
FROM EMP E
INNER JOIN (
    SELECT MGR, COUNT(*)
    FROM EMP
    WHERE MGR IS NOT NULL
    GROUP BY MGR
) T ON T.MGR = E.EMPNO;


SELECT EMPNO, ENAME, NVL(CNT, 0) AS cnt
FROM EMP E
LEFT JOIN (
    SELECT MGR, COUNT(*) AS CNT
    FROM EMP
    WHERE MGR IS NOT NULL
    GROUP BY MGR
) T ON T.MGR = E.EMPNO
ORDER BY CNT DESC;






--
SELECT * FROM PROFESSOR;

SELECT 
    EMAIL,
    INSTR(EMAIL, '@'),
    INSTR(EMAIL, '.'),
    SUBSTR(EMAIL, INSTR(EMAIL, '.')) STR1,
    SUBSTR(EMAIL, INSTR(EMAIL, '@')+1, INSTR(EMAIL, '.')-1) STR2,
    LPAD(SUBSTR(EMAIL, INSTR(EMAIL, '.')), LENGTH(SUBSTR(EMAIL, INSTR(EMAIL, '@')+1, INSTR(EMAIL, '.')-1)), '*') STR3,
    --PROFNO || '@' || PAY
    LPAD('*', INSTR(EMAIL, '@')-1, '*'),
    LPAD('*', INSTR(EMAIL, '@')-1, '*') || '@' 
    ||LPAD(SUBSTR(EMAIL, INSTR(EMAIL, '.')),
    LENGTH(SUBSTR(EMAIL, INSTR(EMAIL, '@')+1,
    INSTR(EMAIL, '.')-1)), '*')
FROM PROFESSOR;

--*******@***.net

--lpad('@'||lpad(inst2, length(inst1), '*'),length(email), '*')

--테이블을 만드는형태로.. 서브쿼리 사용해서 깔끔하게도 가능.
SELECT      --LPAD(SUBSTR(SECOND,INSTR(SECOND,'.')), LENGTH(SECOND),'*')
    LPAD('@'||LPAD(SUBSTR(SECOND,INSTR(SECOND,'.')), LENGTH(SECOND),'*'), LENGTH(EMAIL), '*')
FROM(
	SELECT EMAIL, SUBSTR(EMAIL, INST1+1) SECOND
FROM(
	SELECT EMAIL, INSTR(EMAIL,'@') AS INST1, INSTR(EMAIL,'.') AS INST2
	FROM PROFESSOR
	)
);
SELECT 
    LPAD('*', LENGTH(EMAIL)-LENGTH(SECOND)-1, '*')
    || '@' ||
    SECOND

FROM (
    SELECT EMAIL, SUBSTR(EMAIL, INST1 + 1) SECOND
    FROM (
        SELECT EMAIL, INSTR(EMAIL, '@') AS INST1, INSTR(EMAIL, '.') AS INST2
        FROM PROFESSOR
    )
);










--테이블2
SELECT EMAIL, SUBSTR(EMAIL, INST1 + 1) SECOND
FROM (
    SELECT EMAIL, INSTR(EMAIL, '@') AS INST1, INSTR(EMAIL, '.') AS INST2
    FROM PROFESSOR
);

--테이블1
SELECT EMAIL, INSTR(EMAIL, '@') AS INST1, INSTR(EMAIL, '.') AS INST2
FROM PROFESSOR;


----------------------------------------
SELECT
    EMAIL,
    RPAD('*', INSTR(EMAIL,'@')-1 , '*')
    || '@' ||
    RPAD('*', INSTR(EMAIL, '.')-INSTR(EMAIL, '@')-1, '*')
    || SUBSTR(EMAIL, INSTR(EMAIL, '.')) AS 메일
FROM PROFESSOR
    
;
SELECT
    EMAIL,
    INSTR(EMAIL, '.'),
    INSTR(EMAIL, '@')
FROM PROFESSOR;



SELECT * FROM PROFESSOR;
select email from professor;
--*******@***.net

select 
    email,
    rpad('*', instr(email, '@')-1, '*') 
    || '@' ||
    rpad('*', instr(email, '.')-instr(email, '@')-1, '*')
    || substr(email, instr(email, '.'))
from professor
;

select
    email,
    rpad('*', instr(email, '.')-instr(email, '@')-1, '*')
from professor;

--instr(email, '.')-instr(email, '@')-1
select
    email,
    instr(email, '@'),
    instr(email, '.')
from professor;

select email
from professor;


select
    email,
    --'@'||lpad(inst2, length(inst1), '*'),
    lpad('@'||lpad(inst2, length(inst1), '*'),length(email), '*')
    
from(
    select
    email,
    inst1,
    substr(inst1, instr(inst1, '.')) inst2
    from (
        select 
            email,
            substr(email, instr(email,'@')+1) inst1
        from professor
    )
);







--테이블2 ( )
select
    email,
    inst1,
    substr(inst1, instr(inst1, '.')) inst2
from (
    select 
    email,
    substr(email, instr(email,'@')+1) inst1
    from professor
);




-테이블1( )
select 
    email,
    substr(email, instr(email,'@')+1) inst1
from professor;


--복습(+)