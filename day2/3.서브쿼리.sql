-- 서브 쿼리

-- 1-1. STUDENT 테이블에서 학과별 평균 키
SELECT STU_DEPT, AVG(STU_HEIGHT) AVG_DEPT  --테이블을 사용하기위해 AVG(STU_HEIGHT)에 별칭을 줌.(변수이름)
FROM STUDENT
GROUP BY STU_DEPT;


select * from student;

select stu_dept, avg(stu_height)
from student
group by stu_dept;



-- 1-2. 학번, 이름, 학과, 키, 내가 속한 학과의 평균 키

select * from student;

select stu_no, stu_name, s.stu_dept, stu_height, avg_dept
from student s 
inner join (
    select stu_dept, avg(stu_height) avg_dept
    from student
    group by stu_dept
) t on s.stu_dept = t.stu_dept; 










SELECT STU_NO, STU_NAME, STU_DEPT, STU_HEIGHT
FROM STUDENT;

SELECT STU_NO, STU_NAME, S.STU_DEPT, STU_HEIGHT, AVG_DEPT
FROM STUDENT S
INNER JOIN (
    SELECT STU_DEPT, AVG(STU_HEIGHT) AVG_DEPT
    FROM STUDENT
    GROUP BY STU_DEPT
)T ON S.STU_DEPT = T.STU_DEPT;  --테이블 사용하기위해 테이블에 별칭을 줌 => T(TEMP)

-- 1-3. 내가 속한 학과의 평균키보다 키가 큰 학생의 학번, 이름, 학과, 키


select * from student;

select stu_no, stu_name, s.stu_dept, stu_height
from student s 
inner join (
    select stu_dept, avg(stu_height) avg_dept
    from student
    group by stu_dept
) t on s.stu_dept = t.stu_dept
where stu_height > avg_dept
; 









SELECT STU_NO, STU_NAME, S.STU_DEPT, STU_HEIGHT, AVG_DEPT
FROM STUDENT S
INNER JOIN (
    SELECT STU_DEPT, AVG(STU_HEIGHT) AVG_DEPT
    FROM STUDENT
    GROUP BY STU_DEPT
)T ON S.STU_DEPT = T.STU_DEPT
WHERE STU_HEIGHT > AVG_DEPT;

-- EMP, DEPT
-- 내가 속한 부서의 평균 급여보다 높은 급여를 받는 사람의
-- 사번, 이름, 급여, 부서이름, 속한 부서의 평균급여 출력 (+)

select * from emp;  --empno,ename,job,mgr,hiredate,sal,comm,deptno
select * from dept; --deptno,dname,loc

select  deptno, avg(sal) avg_sal
from emp
group by deptno;

--empno,ename,e.deptno,sal,avg_sal
select empno, ename, sal, e.deptno, dname, round(avg_sal, 1) 
from emp e
inner join dept d on e.deptno = d.deptno
inner join (
    select  deptno, avg(sal) avg_sal
    from emp
    group by deptno
) t on e.deptno = t.deptno
where sal > avg_sal
;









SELECT EMPNO, ENAME, SAL, DNAME, ROUND(AVG_DEPT, 1)  --avg_dept를 반올림, 1의자리까지 표현
FROM EMP E
INNER JOIN (
    SELECT E.DEPTNO, DNAME, AVG(SAL) AVG_DEPT
    FROM EMP E
    INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
    GROUP BY E.DEPTNO, DNAME
) T ON E.DEPTNO = T.DEPTNO
WHERE SAL > AVG_DEPT;








SELECT DEPTNO, AVG(SAL) AVG_SAL
FROM EMP
GROUP BY DEPTNO;

SELECT *
FROM EMP E
INNER JOIN (
    SELECT DEPTNO, AVG(SAL) AVG_SAL
    FROM EMP
    GROUP BY DEPTNO
)T ON E.DEPTNO = T.DEPTNO;

--
SELECT *
FROM EMP E
INNER JOIN (
    SELECT DEPTNO, AVG(SAL) AVG_SAL
    FROM EMP
    GROUP BY DEPTNO
) T ON E.DEPTNO = T.DEPTNO
WHERE E.SAL > T.AVG_SAL;


--DEPARTMENT, PROFESSOR
--각 직급(POSITION) 별 가장 많은 급여를 받는 사람의
--교수번호, 이름, 급여 출력

select * from department; --deptno,dname,part,build
select * from professor; --profno,name,id,position,pay,hiredate,bonus,deptno,email,hpage

select position, max(pay)
from professor
group by position;

select profno,name,pay
from professor p
inner join (
    select position, max(pay) max_pay
    from professor
    group by position
) t on p.position = t.position
where pay = max_pay;










SELECT * FROM PROFESSOR;

SELECT *
FROM PROFESSOR P
INNER JOIN (
    SELECT POSITION, MAX(PAY)
    FROM PROFESSOR
    GROUP BY POSITION
)T ON P.POSITION = T.POSITION;

-- 답변:
SELECT PROFNO, NAME, PAY
FROM PROFESSOR P
INNER JOIN (
    SELECT POSITION, MAX(PAY) MAX_PAY
    FROM PROFESSOR
    GROUP BY POSITION
)T ON P.POSITION = T.POSITION
WHERE P.PAY = MAX_PAY;

--
SELECT *
FROM PROFESSOR P
INNER JOIN (
    SELECT POSITION, MAX(PAY) MAX_PAY
    FROM PROFESSOR
    GROUP BY POSITION
)T ON P.POSITION = T.POSITION
WHERE P.PAY = MAX_PAY;


SELECT POSITION, MAX(PAY) AS MAX_PAY
FROM PROFESSOR
GROUP BY POSITION;

SELECT PROFNO, NAME, PAY
FROM PROFESSOR P
INNER JOIN (
    SELECT POSITION, MAX(PAY) AS MAX_PAY
    FROM PROFESSOR
    GROUP BY POSITION
) T ON P.POSITION = T.POSITION AND P.PAY = T.MAX_PAY;


SELECT POSITION, MAX(PAY)
FROM PROFESSOR
GROUP BY POSITION;

--본인 '학부'의 평균 급여보다 높은 급여를 받는 교수의 교수번호, 이름, 급여 출력

select * from department; --deptno,dname,part,build
select * from professor; --profno,name,id,position,pay,hiredate,bonus,deptno,email,hpage

select profno,p.name,pay
from professor p
inner join department d on p.deptno = d.deptno
inner join department d2 on d.part = d2.deptno       -- 셀프조인
inner join (                                         -- 서브쿼리
    select d2.dname, avg(pay) avg_pay  --dname,avg_pay   --별칭
    from professor p
    inner join department d on p.deptno = d.deptno   -- 서브쿼리 안에서도 이너조인
    inner join department d2 on d.part = d2.deptno
    group by d2.dname
) t on d2.dname = t.dname           --별칭
where pay > avg_pay;

--


select d2.dname, avg(pay) avg_pay  --dname,avg_pay
from professor p
inner join department d on p.deptno = d.deptno
inner join department d2 on d.part = d2.deptno
group by d2.dname;


select d3.dname, avg(pay) avg_pay   --dname,avg_pay
from professor p
inner join department d on p.deptno = d.deptno
inner join department d2 on d.part = d2.deptno
inner join department d3 on d2.part = d3.deptno
group by d3.dname;


select *
from professor p
inner join department d on p.deptno = d.deptno
inner join department d2 on d.part = d2.deptno
inner join department d3 on d2.part = d3.deptno;












SELECT DNAME, AVG(PAY)
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
GROUP BY D2.DNAME;


SELECT NAME, D2.DNAME, PAY, AVG_PAY
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN (
    SELECT D2.DNAME, AVG(PAY) AVG_PAY
    FROM PROFESSOR P
    INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
    INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
    GROUP BY D2.DNAME
) T ON D2.DNAME = T.DNAME
WHERE PAY > AVG_PAY;










SELECT * 
FROM PROFESSOR P;
SELECT * 
FROM DEPARTMENT;

SELECT D2.DNAME, AVG(PAY) AVG_PAY
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
GROUP BY D2.DNAME;


SELECT *
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO;


SELECT *
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN (
    SELECT D2.DNAME, AVG(PAY) AVG_PAY
    FROM PROFESSOR P
    INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
    INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
    GROUP BY D2.DNAME
) T ON D2.DNAME = T.DNAME;


--교수의 교수번호, 이름, 급여 
SELECT PROFNO, NAME, PAY
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN (
    SELECT D2.DNAME, AVG(PAY) AVG_PAY
    FROM PROFESSOR P
    INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
    INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
    GROUP BY D2.DNAME
) T ON D2.DNAME = T.DNAME AND PAY > AVG_PAY; --WHERE 절 대신에 AND로 표시해도됨..
--WHERE PAY > AVG_PAY; 








-- EMP 테이블
-- 부서별 가장 높은 급여를 받는 사람의 사번, 이름, 급여 출력 (+)
SELECT * FROM EMP;       --empno,ename,job,mgr,hiredate,sal,comm,deptno

select deptno, max(sal) max_sal --deptno,max_sal 
from emp
group by deptno;

--
select empno, ename, sal
from emp e
inner join (
    select deptno, max(sal) max_sal --deptno,max_sal 
    from emp
    group by deptno
) t on e.deptno = t.deptno
where sal = max_sal;



SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT *
FROM EMP E
INNER JOIN (
    SELECT DEPTNO, MAX(SAL) AS MAX_SAL
    FROM EMP
    GROUP BY DEPTNO
) T ON E.DEPTNO = T.DEPTNO AND E.SAL = T.MAX_SAL;


--복습은 단계적으로 풀어보고 최종답변만 맞춰보는방식으로.



--
SELECT EMPNO, ENAME, SAL
FROM EMP E
INNER JOIN (
    SELECT DEPTNO, MAX(SAL) MAX_SAL
    FROM EMP
    GROUP BY DEPTNO
) T ON E.DEPTNO = T.DEPTNO
WHERE SAL = MAX_SAL;
--


SELECT DEPTNO, MAX(SAL)
FROM EMP
GROUP BY DEPTNO;




-- STUDENT
-- 학과별 가장 큰 키를 가진 학생의 학번, 이름, 키 출력

select * from student; --stu_no, stu_name, stu_dept, stu_grade, stu_class, stu_gender, stu_height, stu_weight

select stu_no,stu_name,stu_height
from student s
inner join (
    select stu_dept, max(stu_height) max_height  --stu_dept,max_height
    from student
    group by stu_dept
) t on s.stu_dept = t.stu_dept and stu_height = max_height;




-- 학과별 가장 큰키
select stu_dept, max(stu_height) max_height  --stu_dept,max_height
from student
group by stu_dept;




SELECT *
FROM STUDENT S
INNER JOIN (
    SELECT STU_DEPT, MAX(STU_HEIGHT) AS MAX_HEIGHT
    FROM STUDENT
    GROUP BY STU_DEPT
) T ON S.STU_DEPT = T.STU_DEPT AND S.STU_HEIGHT = T.MAX_HEIGHT;






SELECT * FROM STUDENT;

SELECT STU_NO, STU_NAME, STU_HEIGHT
FROM STUDENT S
INNER JOIN ( 
    SELECT STU_DEPT, MAX(STU_HEIGHT) MAX_STU_HEIGHT
    FROM STUDENT
    GROUP BY STU_DEPT
) T ON S.STU_DEPT = T.STU_DEPT
WHERE STU_HEIGHT = MAX_STU_HEIGHT;

--조인하고 테이블 만들고 조건에 맞춰 출력


SELECT STU_DEPT, MAX(STU_HEIGHT)
FROM STUDENT
GROUP BY STU_DEPT;

--------


SELECT *
FROM STU;

SELECT SUBSTR(STUNO, 1, 2), AVG(HEIGHT)
FROM STU
GROUP BY SUBSTR(STUNO, 1, 2);

--남자와 여자의 평균 키 출력
select * from stu; --stuno,name,id,grade,jumin,birthday,tel,height,weight,deptno1,deptno2,profno


select 
    case
        when substr(jumin, 7, 1) = 1 or substr(jumin, 7, 1) = 3 then '남자'
        else '여자'
    end 성별,
    round(avg(height))
from stu
group by substr(jumin, 7, 1);



select 
    decode(substr(jumin, 7, 1),1,'남자',3,'남자','여자') 성별,
    round(avg(height))
from stu
group by substr(jumin, 7, 1);




SELECT *
FROM STU;

SELECT 
    CASE
        WHEN SUBSTR(JUMIN, 7, 1) IN ('1','3') THEN '남자'
        ELSE '여자'
    END 성별,
    ROUND(AVG(HEIGHT))
FROM STU
GROUP BY SUBSTR(JUMIN, 7, 1); --value 값이 같은 것끼리 그룹이 된다.
                              --substr 한걸로도 그룹을 만들수있다.

SELECT SUBSTR(JUMIN, 7, 1), AVG(HEIGHT)
FROM STU
GROUP BY SUBSTR(JUMIN, 7, 1);

--(+)
SELECT 
    DECODE(SUBSTR(JUMIN, 7, 1), 1, '남자', 3, '남자', '여자'), AVG(HEIGHT)
FROM STU
GROUP BY SUBSTR(JUMIN, 7, 1);  

