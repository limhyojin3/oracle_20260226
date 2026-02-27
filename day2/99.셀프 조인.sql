-- 셀프 조인(self join)  -복습(+)

SELECT * FROM EMP;

SELECT *
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO;  --E1.MGR를 기준으로 E2.EMPNO 인것들을 가져옴
                                         --E1테이블의 MGR를 기준으로 E2테이블의 EMPNO 인것들을 가져옴
--다시보기(+)
SELECT E1.EMPNO, E1.ENAME, E2.ENAME AS MANAGER
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO;

--사번,이름,상사이름
select *
from emp;

select *
from emp e1
inner join emp e2 on e1.mgr = e2.empno;

select e1.empno, e1.ename, e2.ename
from emp e1
inner join emp e2 on e1.mgr = e2.empno;




SELECT *
FROM DEPARTMENT;

SELECT *
FROM PROFESSOR;

SELECT *
FROM PROFESSOR P
INNER JOIN DEPARTMENT D ON P.DEPTNO = D.DEPTNO;

SELECT PROFNO, NAME, DNAME
FROM PROFESSOR P
INNER JOIN DEPARTMENT D ON P.DEPTNO = D.DEPTNO;


SELECT *
FROM DEPARTMENT D1
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO;


SELECT D1.DNAME, D2.DNAME
FROM DEPARTMENT D1
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO;


SELECT PROFNO, NAME, D1.DNAME, D2.DNAME
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO;

--다시보기(+)
SELECT PROFNO, NAME, D1.DNAME, D2.DNAME, D3.DNAME
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN DEPARTMENT D3 ON D2.PART = D3.DEPTNO;      --이너조인은 연달아 쓸수있다.


--교수번호,교수이름,학과,학부,소속대학

select * from professor;
select * from department;

select *
from professor p
inner join department d on p.deptno = d.deptno;

select * from department;




select profno, p.name, d1.dname, d2.dname, d3.dname --***테이블이 계속 오른쪽으로 붙어나감. 헷깔릴수있지만 받아들이기!
from professor p
inner join department d1 on p.deptno = d1.deptno
inner join department d2 on d1.part = d2.deptno
inner join department d3 on d2.part = d3.deptno;

SELECT PROFNO, NAME, D1.DNAME, D2.DNAME, D3.DNAME
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN DEPARTMENT D3 ON D2.PART = D3.DEPTNO;      --이너조인은 연달아 쓸수있다.



select *
from professor p
inner join department d1 on p.deptno = d1.deptno
inner join department d2 on d1.part = d2.deptno;

select *
from professor p
inner join department d1 on p.deptno = d1.deptno
inner join department d2 on d1.part = d2.deptno
inner join department d3 on 
;









--테이블1
select profno, name, deptno
from professor;

--테이블2
select deptno, dname, part
from department;

select * 
from (select profno, name, deptno
from professor) t1
inner join (select deptno, dname, part
from department)t2 on t1.deptno = t2.deptno;

select * 
from (select profno, name, deptno
from professor) t1
inner join (select deptno, dname, part
from department)t2 on t1.deptno = t2.deptno;

select *
from (select * 
from (select profno, name, deptno
from professor) t1
inner join (select deptno, dname, part
from department)t2 on t1.deptno = t2.deptno) t3
inner join (select deptno, dname, part
from department)t4 on t3.part = t4.deptno;
