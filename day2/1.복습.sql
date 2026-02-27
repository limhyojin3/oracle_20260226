SELECT * FROM STUDENT;  --복습(+)

select stu_dept, count(*)
from student
group by stu_dept;



SELECT
    STU_DEPT,       
    COUNT(*)NUM     --그룹별 행의 숫자를 구함
FROM STUDENT
GROUP BY STU_DEPT; --STU_DEPT  value값이 같은것끼리 그룹이 된다


SELECT JOB, AVG(SAL)         -- JOB   | AVG(SAL)
FROM EMP                     -- CLERK | 1037.5
GROUP BY JOB;    --JOB  value값이 같은것끼리 그룹이 된다

select * from emp;

select job, avg(sal)
from emp
group by job;


select * from student;
select * from enrol;

select s.stu_no, stu_name, enr_grade
from student s
inner join enrol e on s.stu_no = e.stu_no; 


-- 학번, 이름, 시험점수
SELECT S.STU_NO, STU_NAME, ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO;

--
SELECT * FROM EMP;
SELECT * FROM SALGRADE;


select * from emp;
select * from salgrade;
select *
from emp e
inner join salgrade sal on e.sal between sal.losal and sal.hisal;

select empno, ename, sal, grade
from emp e
inner join salgrade sal on e.sal between sal.losal and sal.hisal;


-- 사번, 이름, 급여, 급여등급
SELECT *
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL;


SELECT EMPNO, ENAME, SAL, GRADE
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- 학번, 이름, 시험점수의 평균
SELECT S.STU_NO, STU_NAME, AVG(ENR_GRADE)   -- 두 그룹 모두 만족하는 VALUE 값들에 대해서 AVG 구하기.
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
GROUP BY S.STU_NO, STU_NAME;

select * from student;
select * from enrol;

select s.stu_no, stu_name, avg(enr_grade)
from student s
inner join enrol e on s.stu_no = e.stu_no
group by s.stu_no, stu_name
;



--테이블 클릭후 데이터 메뉴 선택