-- STUDENT, ENROL, SUBJECT
--1. 컴퓨터개론 수업을 들은 학생의 학번, 이름, 시험점수 출력

SELECT *
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON E.SUB_NO = SUB.SUB_NO;


SELECT S.STU_NO, S.STU_NAME, SUB_NAME, ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON E.SUB_NO = SUB.SUB_NO
WHERE SUB_NAME = '컴퓨터개론';

--2. 시험의 평균 점수가 70이상인 학생의 학번, 이름, 평균점수 출력

SELECT S.STU_NO, STU_NAME, AVG(ENR_GRADE)
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON E.SUB_NO = SUB.SUB_NO
GROUP BY S.STU_NO, STU_NAME
HAVING AVG(ENR_GRADE) >= 70;


SELECT *
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON E.SUB_NO = SUB.SUB_NO;


--3. 시험을 2개이상 본 학생의 학번, 이름, 시험개수 출력

SELECT *
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO;

SELECT S.STU_NO, S.STU_NAME, COUNT(*) --행의개수:COUNT()
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY S.STU_NO, S.STU_NAME
HAVING COUNT(*) >= 2;


SELECT S.STU_NO, S.STU_NAME, COUNT(ENR_GRADE) --행의개수:COUNT()
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY S.STU_NO, S.STU_NAME
HAVING COUNT(ENR_GRADE) >= 2;


-- EMP, DEPT, SALGRADE
--1. 부서 이름, 부서의 급여 평균 등급 출력

SELECT * FROM EMP;
SELECT * FROM DEPT;
select * from salgrade;

select *
from emp e
inner join dept d on e.deptno = d.deptno
inner join salgrade s on e.sal between s.losal and s.hisal;

select d.dname, round(avg(grade))
from emp e
inner join dept d on e.deptno = d.deptno
inner join salgrade s on e.sal between s.losal and s.hisal
group by d.dname;

--1-2.부서 이름, 부서의 평균급여에 대한 등급을 출력

select *
from emp e
inner join dept d on e.deptno = d.deptno;

select * from salgrade;
--
select d.dname, avg(sal)
from emp e
inner join dept d on e.deptno = d.deptno
group by d.dname;

--답변:
select t.dname, grade
from salgrade s
inner join (
    select d.dname, avg(sal) avg_sal
    from emp e
    inner join dept d on e.deptno = d.deptno
    group by d.dname
) t on t.avg_sal between s.losal and s.hisal;





--inner join salgrade s on e.sal between s.losal and s.hisal;












SELECT *
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

--1. 등급의 평균
SELECT DNAME, AVG(GRADE)
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY DNAME;

SELECT DNAME, ROUND(AVG(GRADE))
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY DNAME;


SELECT * 
FROM DEPT D
INNER JOIN EMP E ON D.DEPTNO = E.DEPTNO;

--------------------------------------------------------------
SELECT DNAME, AVG(SAL) AS SAL_AVG
FROM DEPT D
INNER JOIN EMP E ON D.DEPTNO = E.DEPTNO
GROUP BY DNAME;
--INNER JOIN SALGRADE S ON AVG(SAL) BETWEEN S.LOSAL AND S.HISAL;

SELECT *
FROM (
    SELECT DNAME, AVG(SAL) AS SAL_AVG
    FROM DEPT D
    INNER JOIN EMP E ON D.DEPTNO = E.DEPTNO
    GROUP BY DNAME        --만들어진 테이블도 그 자체로 테이블.
);
-------------------------------------------------------------------
--2.
SELECT *
FROM (
    SELECT DNAME, AVG(SAL) AS SAL_AVG      --별명을 붙여주면 그것이 곧 변수임. (별명==변수)
    FROM DEPT D
    INNER JOIN EMP E ON D.DEPTNO = E.DEPTNO
    GROUP BY DNAME
) T
INNER JOIN SALGRADE S ON T.SAL_AVG BETWEEN S.LOSAL AND S.HISAL;
-------------------------------------------------------------------

--2. 상사가 'BLAKE'인 사원들의 사번, 이름 출력

SELECT *
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO;

select * 
from emp;


select e1.empno, e1.ename, e2.ename
from emp e1
inner join emp e2 on e1.mgr = e2.empno
where e2.ename = 'BLAKE';







SELECT *
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
WHERE E2.ENAME = 'BLAKE';


SELECT E1.EMPNO, E1.ENAME
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
WHERE E2.ENAME = 'BLAKE';



-- PROFESSOR, STU, DEPARTMENT
-- '공과대학'에 속한 학생의 수 구하기 (DEPTNO1 기준)
SELECT * FROM STU;  
select * from department;

select d3.dname, count(*)
from stu s
inner join department d on s.deptno1 = d.deptno
inner join department d2 on d.part = d2.deptno
inner join department d3 on d2.part = d3.deptno  --테이블이 붙어서 이어진 형태
--where d3.dname = '공과대학'
group by d3.dname;



















SELECT S.STUNO, S.NAME, D3.DNAME
FROM STU S
INNER JOIN DEPARTMENT D1 ON S.DEPTNO1 = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN DEPARTMENT D3 ON D2.PART = D3.DEPTNO
WHERE D3.DNAME = '공과대학';

SELECT COUNT(*)   --COUNT(*)만 달랑 넣으면 전체 행의 개수를 구해줌.
FROM STU S
INNER JOIN DEPARTMENT D1 ON S.DEPTNO1 = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN DEPARTMENT D3 ON D2.PART = D3.DEPTNO
WHERE D3.DNAME = '공과대학';

       
       
                            
SELECT D3.DNAME, COUNT(*)   --COUNT(*) 앞에 컬럼명 넣고싶으면 GROUP BY로 그룹으로 만들어준후 ,넣기 가능.
FROM STU S
INNER JOIN DEPARTMENT D1 ON S.DEPTNO1 = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN DEPARTMENT D3 ON D2.PART = D3.DEPTNO
WHERE D3.DNAME = '공과대학'
GROUP BY D3.DNAME;      --그룹으로 만들어줌



SELECT COUNT(*)
FROM STU; --20
SELECT COUNT(*)
FROM DEPARTMENT;--12

