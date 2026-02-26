-- 조인
select *
from student; --stu_no, stu_name, stu_dept, stu_grade, stu_class, stu_gender, stu_height, stu_weight

select *
from enrol; --stu_no, stu_no, enr_grade

SELECT *
FROM SUBJECT; --sub_no, sub_name, sub_prof, sub_grade, sub_dept

select *
from student       --student테이블을 기준으로 enrol테이블과 inner join한다. 
inner join enrol on student.stu_no = enrol.stu_no; -- on조건절(student.stu_no = enrol.stu_no)을 만족한다.

select student.stu_no, stu_name, enr_grade    --컬럼명이 같은경우 앞에 테이블을 붙여서 명확히 해준다.student.stu_no;
from student
inner join enrol on student.stu_no = enrol.stu_no;

SELECT S.STU_NO, STU_NAME, ENR_GRADE
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO;  --별명을 써도 된다.

SELECT S.STU_NO, STU_NAME, ENR_GRADE, E.SUB_NO, SUB_NAME  
FROM STUDENT S    
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON SUB.SUB_NO = E.SUB_NO; 
--inner join 여러개 가능함!


SELECT *
FROM EMP; --empno, ename, job, mgr, hiredate, sal, comm, deptno
SELECT *
FROM DEPT; --deptno, dname, loc
--사번, 이름, 급여, 부서이름 출력

SELECT EMPNO, ENAME, SAL, DNAME
FROM EMP E   --EMP테이블을 기준으로 DEPT테이블과 INNER JOIN 한다. 
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;  --ON 뒤에 조건 => E.DEPTNO 와 D.DEPTNO가 같음

SELECT *
FROM EMP;  --empno, ename, job, mgr, hiredate, sal, comm, deptno
SELECT *
FROM DEPT; --deptno, dname, loc
SELECT *
FROM SALGRADE;  --grade,losal,hisal
                                   --(유용! 어렵지만 이렇게 이해하면됨!)
--사번,이름,급여,급여수준              --ON E.SAL BETWEEN S.LOSAL AND S.HISAL; => 작성은 ON 속성 BETWEEN 속성 AND 속성
SELECT EMPNO, ENAME, SAL, GRADE    --800 between 700 and 1200 => grade = 1; => 실제 연산시에는 value값끼리 비교.
FROM EMP E                          --**emp테이블과 salgrade테이블에 공통된 컬럼이 없는경우
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL;  --800 between 700 and 1200 => grade = 1; 
                    --ON 뒤에 조건 => E.SAL BETWEEN S.LOSAL AND S.HISAL 를 만족하도록 행을 출력

--STUDENT, ENROL, SUBJECT
--1. 학생들의 시험 평균 점수 구하기(학번, 이름, 평균점수)

--select s.stu_no, avg(enr_grade)
--
--group by s.stu_no;  => 가능.
select s.stu_no, avg(enr_grade)   --(20131001, 68)
from student s
inner join enrol e on s.stu_no = e.stu_no
group by s.stu_no;   --s.stu_no  value가 같은것끼리 그룹이 된다.

--select s.stu_no, stu_name, avg(enr_grade)
--
--group by s.stu_no;         => 불가능.

--stu_name이 group by 안되어있어서 => select에 stu_name과 avg() 를 함께 쓸수없음
select s.stu_no, stu_name, avg(enr_grade)   --(20131001, 68) 그룹의 평균을 구하고싶은데, stu_name은 그룹이 아닌데요? 하면서 에러남.
from student s
inner join enrol e on s.stu_no = e.stu_no
group by s.stu_no; 


--(select s.stu_no, stu_name, avg(enr_grade)) 
--
--group by s.stu_no, stu_name;      => 가능          --select컬럼갯수와 group by컬럼갯수를 일치시켜주기.
                                                    --그렇지않으면 avg()쓸때 에러가 난다.

--**두 컬럼이 모두 group by 되어있어야함. 그래야 두 컬럼명 과 avg()를 함께 쓸수있음.
select s.stu_no, stu_name, avg(enr_grade)   --(20131001, 68)
from student s
inner join enrol e on s.stu_no = e.stu_no
group by s.stu_no, stu_name;  --stu_no value값이 같은것끼리 그룹이 된다. 
                            --그리고 그 그룹내에서 stu_name value값이 같은것끼리 그룹이 된다. 
                            -- **그룹으로 만든다는건 중복을 없애겠다는 뜻.(+) 그룹내의 평균을 구한다든가 하고싶다는것.
                            -- **중복을 없애고 행을 압축시키고싶다 => group by로 value값이 같은것끼리 그룹으로 묶는다!(+)
                        
                        
                            
select stu_dept   --출력해보면 중복이 없음. value값이 다른것들만 남음.
from student
group by stu_dept;  --group by : stu_dept   value값이 같은것끼리 그룹이 된다.
-- **중복을 없애고 행을 압축시키고싶다 => group by로 value값이 같은것끼리 그룹으로 묶는다!




select *
from student; --stu_no, stu_name, stu_dept, stu_grade, stu_class, stu_gender, stu_height, stu_weight

select *
from enrol; --stu_no, stu_no, enr_grade

select *            
from student s       --student 테이블을 기준으로 enrol테이블을 inner join한다.
inner join enrol e on s.stu_no = e.stu_no;  --on조건절을 기준으로 합친다.



select s.stu_no, stu_name, avg(enr_grade)
from student s
inner join enrol e on s.stu_no = e.stu_no
group by s.stu_no, stu_name;       --s.stu_no가 같은것끼리 그룹이 된다. s.stu_no가 같은그룹 내에서 stu_name이 같은 것끼리 그룹이 된다.

--2. 학과별 시험 평균점수 구하기(+)


select *            
from student s       --student 테이블을 기준으로 enrol테이블을 inner join한다.
inner join enrol e on s.stu_no = e.stu_no;  --on조건절을 기준으로 합친다.



select s.stu_dept, avg(enr_grade)  --그룹별 avg(enr_grade)를 구한다.
from student s
inner join enrol e on s.stu_no = e.stu_no
group by s.stu_dept;   --s.stu_dept  value 값이 같은것끼리 그룹이 된다.

select * from student;
select * from enrol;
select * from subject;

