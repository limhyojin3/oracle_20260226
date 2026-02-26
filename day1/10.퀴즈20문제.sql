select * from emp;

--mgr(매니저,상사), hiredate(입사일), sal(salary급여), comm(commission보너스), deptno(부서번호)


-- 모든 문제는 결과만 출력(update 사용 x)

-- EMP
-- 문자 
--1. ENAME 열에서 모든 이름을 소문자로 변경하여 출력해 보시오.
select lower(ename)
from emp;

--2. ENAME 열에서 'SMITH'를 찾고, 그 값을 'JOHN'으로 변경하여 출력해 보시오.
select * from emp;
select
    ename,
    replace(ename, 'SMITH', 'JOHN')
from emp;
                                    --count() <= 레코드개수
--3. JOB 열에서 'SALESMAN'만 추출하고, 해당 컬럼(SALESMAN)의 길이(레코드개수)를 구해 보시오.
select * from emp;

select *
from emp
where job = 'SALESMAN';

select count(*)
from emp
where job = 'SALESMAN';

select distinct length(job)
from emp
where job = 'SALESMAN';


--4. ENAME 열에서 이름의 첫 글자만 대문자, 나머지 문자는 소문자 변경하여 출력해 보시오.
select * from emp;

select 
    ename,
    upper(substr(ename, 1, 1)) || lower(substr(ename, 2))
from emp;


--5. ENAME 열에서 이름의 마지막 3글자를 추출하여 출력해 보시오.
select * from emp;

select  --substr(SMITH, 3), substr(WARD, 2) => substr( , 5-2), sub( , 4-2)
    ename,
    substr(ename, length(ename)-2)
from emp;
                                        --레코드개수 => count()
--6. JOB 열의 값 중 'MANAGER'로 시작하는 직책을 가진 사람들의 수를 구해 보시오.
select * from emp;

select *
from emp
where job like 'MANAGER%';

select count(*)
from emp
where job like 'MANAGER%';


--7. ENAME과 JOB 열을 합쳐서 'ENAME(JOB)' 형태로 출력해 보시오.
select * from emp;

select 
    ename,
    job,
    ename || '(' || job || ')'
from emp;

--8. ENAME 열에서 'A'가 포함된 모든 사람의 이름을 추출해 보시오.
select * from emp;

select ename
from emp
where ename like '%A%';

--9. 모든 직원의 SAL 값에 10%를 추가한 값을 출력해 보시오.
select * from emp;

select
    ename,
    sal,
    sal + sal * 0.1
from emp;

--10. SAL 값이 1500 이상인 직원들의 평균 급여를 구해 보시오.
select * from emp;

select avg(sal)
from emp
where sal >= 1500;

--11. 각 부서(DEPTNO)별로 급여의 총합을 구해 보시오.
select * from emp;

select 
    deptno, sum(sal)
from emp
group by deptno;

--12. SAL 값이 1300 이상이면서 부서번호가 20인 직원들의 평균 급여를 구해 보시오.
select * from emp;

select avg(sal)
from emp
where sal >= 1300 and deptno = 20;

--13. 각 부서별로 급여가 가장 높은 / 직원의 이름을 구해 보시오.
select * from emp;

--각 부서별 최대 급여
select deptno, max(sal)
from emp
group by deptno;
--(deptno,max(sal)) => select return 값 : (20,3000),(30,2850),(10,5000)

select *
from emp
where (deptno, sal) in (       --(deptno, sal) in ((20, 3000), (30, 2850), (10, 5000))
    select deptno, max(sal)
    from emp
    group by deptno
);


--14. 직급(JOB)별 가장 높은 급여를 / 받는 사람의 사번, 이름, 급여를 출력하시오.
select * from emp;

select job, max(sal)
from emp
group by job;
--select return 값 => (clerk, 1300), (salesman, 1600) ..
--select는 만족하는 '행'을 리턴

select empno, ename, sal
from emp
where (job, sal) in (        --where(job, sal) in ((clerk, 1300), (salesman, 1600)... )
    select job, max(sal)
    from emp
    group by job
);
    
--where (job, sal) = (CLERK, 1300) or ( salesman, 1600) ...;


--15. 전체 평균보다 높은 급여를/ 받는 사람의 사번, 이름, 급여를 출력하시오.

select * from emp;

select avg(sal)
from emp;
--select는 행 또는 value값을 리턴한다.

select empno, ename, sal
from emp
where sal > (
    select avg(sal)
    from emp
);


--복습( )
--16. 직급의 평균 급여가 전체 평균 급여보다 높은 직급의 이름, 평균급여를 출력하시오.

select * from emp;

--직급의 평균급여
select job, avg(sal)
from emp
group by job;  --(CLERK,1037.5), (SALESMAN,1400)...

--전체 평균급여
select avg(sal)
from emp; -- 2007.xx

--직급의 평균급여,  그리고 그것은 전체 평균 급여보다 높은
select job, avg(sal)               --직급의 이름, 평균급여를 출력
from emp
group by job  --(CLERK,1037.5), (SALESMAN,1400)...
having avg(sal) > (    --group 된 후에 조건줄려면 having
    select avg(sal)
    from emp --2007.xx
);



--각 직급의 평균 급여 , 그리고 그것은   전체 평균 급여  를 넘는다
select job, avg(sal)             --조건을 만족하는 행을 출력(직급의 이름, 평균급여를 출력)
from emp
group by job                --job의 이름이 같은것끼리 그룹이 된다.
having avg(sal) > (
    select avg(sal)
    from emp
);

--17. 급여와 보너스의 합이 2500 이상인 사람의 수를 구하시오.

select * from emp;

select count(*)
from emp
where sal + nvl(comm, 0) >= 2500;  --null값을 0으로 대체한다.

--sal + comm => 800 + null (X) => 800 + nvl(comm, 0) (O)

---- PROFESSOR
--1. EMAIL을 *****@abc.net형태로 출력하시오. 
--	 조건) *의 개수는 @앞의 글자 개수와 같아야 함.

select * from professor;
select
    name,
    email,
    instr(email, '@'),
    substr(email, instr(email, '@')), --substr(email,8) =>@abc.net
    --lpad(@abc.net, 16, '*')
    lpad(substr(email, instr(email, '@')), length(email) , '*')  
from professor;

                                    --레코드의 수 count(*)
--2. 이메일의 주소에 'naver'가 들어 가는 사람의 수를 구하시오.

select * 
from professor;

select * 
from professor
where email like '%naver%';

select count(*)
from professor
where email like '%naver%';

--3. 입사일(HIREDATE)을 '2026-02-26' 형태로 출력하시오.
select * from professor;

select 
    name,
    TO_CHAR(HIREDATE, 'YYYY-MM-DD')
from professor;

--복습(+)