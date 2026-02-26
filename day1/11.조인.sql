-- 조인
select *
from student;

select *
from enrol;

SELECT *
FROM SUBJECT;

SELECT *
FROM STUDENT
INNER JOIN ENROL ON STUDENT.STU_NO = ENROL.STU_NO;

SELECT STUDENT.STU_NO, STU_NAME, ENR_GRADE
FROM STUDENT
INNER JOIN ENROL ON STUDENT.STU_NO = ENROL.STU_NO;

SELECT S.STU_NO, STU_NAME, ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO;

SELECT S.STU_NO, STU_NAME, ENR_GRADE, E.SUB_NO, SUB_NAME  --컬럼명이 같은경우 앞에 테이블을 붙여서 명확히 해준다. S.STU_NO;
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO;


SELECT *
FROM EMP;
SELECT *
FROM DEPT;
--사번, 이름, 급여, 부서이름 출력

SELECT EMPNO, ENAME, SAL, DNAME
FROM EMP E   --EMP테이블을 기준으로 DEPT테이블과 INNER JOIN 한다. 
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;  --ON 뒤에 조건 => E.DEPTNO 와 D.DEPTNO가 같음

SELECT *
FROM EMP;
SELECT *
FROM DEPT;
SELECT *
FROM SALGRADE;

SELECT EMPNO, ENAME, SAL, GRADE
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL; --ON 뒤에 조건 => E.SAL BETWEEN S.LOSAL AND S.HISAL 를 만족함

--STUDENT, ENROL, SUBJECT
--1. 학생들의 시험 평균 점수 구하기(학번, 이름, 평균점수)

select s.stu_no, stu_name, avg(enr_grade)
from student s
inner join enrol e on s.stu_no = e.stu_no
group by s.stu_no, stu_name;

--2. 학과별 시험 평균점수 구하기

select stu_dept, avg(enr_grade)
from student s
inner join enrol e on s.stu_no = e.stu_no
group by s.stu_dept;

select * from student;
select * from enrol;
select * from subject;

select s.stu_no, stu_name, stu_dept, e.sub_no, sub_name, enr_grade
from student s
inner join enrol e on s.stu_no = e.stu_no
inner join subject sub on sub.sub_no = e.sub_no;

