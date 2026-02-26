-- 그룹 함수

-- SUM, AVG, MAX, MIN, COUNT;
SELECT SUM(PAY)
FROM PROFESSOR;

SELECT AVG(PAY)
FROM PROFESSOR;

SELECT MAX(PAY)
FROM PROFESSOR;

SELECT MIN(PAY)
FROM PROFESSOR;
                               -- 모든행의개수, bonus컬럼 행의 개수
SELECT * FROM PROFESSOR;       -- count(*), count(bonus)
SELECT COUNT(*), COUNT(BONUS)  -- COUNT는 레코드의 개수를 출력함
FROM PROFESSOR;

SELECT * FROM PROFESSOR;

-- 여기부터 복습( )~~~~~~~~

SELECT POSITION, AVG(PAY) --POSITION과 POSITION별 PAY의 평균을 구하기
FROM PROFESSOR
GROUP BY POSITION; --POSITION을 그룹으로 해서

SELECT * FROM STUDENT;

SELECT STU_DEPT, AVG(STU_HEIGHT) -- 생성된 그룹 레코드에서 / 키의 평균을 구한다.
FROM STUDENT
GROUP BY STU_DEPT;  --stu_dept 이름이 같은것끼리 그룹이 된다






--select 컬럼1, 컬럼2, avg(속성) => 두 컬럼이 모두 group by 되어잇어야함. 그래야 AVG() 쓸수있음.** 
--**상위그룹- 상위그룹 내에서 하위그룹 , 각 그룹별(하위그룹별) 키의 평균 **
SELECT STU_DEPT, STU_GENDER, AVG(STU_HEIGHT) --두 컬럼(STU_DEPT, STU_GENDER) 만족하는 레코드들이 생기고/ 각 레코드에서 키의 평균 (AVG(STU_HEIGHT))을 구한다
FROM STUDENT
WHERE STU_GENDER IS NOT NULL
GROUP BY STU_DEPT, STU_GENDER;  --stu_dept 이름이 같은것끼리 그룹이 되고, stu_dept 같은것 안에서 stu_gender가 같은것끼리 그룹이 된다.








SELECT POSITION, MAX(PAY)  --생성된 그룹 레코드에서 각자 급여의 평균을 구한다.
FROM PROFESSOR
GROUP BY POSITION;  --position 이름이 같은것끼리 그룹이 되고

-- 그룹함수에서 조건
SELECT * FROM STUDENT;

SELECT STU_DEPT, COUNT(*)  --생성된 그룹 레코드에서 그룹에 속하는 레코드의 개수(count(*))를 구한다.
FROM STUDENT
--WHERE STU_GENDER = 'M'
GROUP BY STU_DEPT;   --stu_dept 이름이 같은것끼리 그룹이 되고

SELECT STU_DEPT, COUNT(*)
FROM STUDENT
GROUP BY STU_DEPT  --GROUP을 만든후의 조건을 주기=> HAVING    
HAVING COUNT(*) >= 4;    -- 위에서 레코드의 개수(count(*)) 4개이상인것

SELECT * FROM PROFESSOR;

-- 각 직급(POSITION) 별 급여 평균이 300이상인 데이터의
-- 직급, 평균 급여 출력
select avg(pay)   --모든 레코드에서 급여의 평균을 구한다.
from professor;

select position, avg(pay)   --그 그룹별로 급여의 평균을 구한다.
from professor
group by position;   --position 이름이 같은 것끼리 그룹이 된다.

select position, avg(pay)
from professor
group by position
having avg(pay) >= 300;  -- 위에서 조건이 하나 추가된 형태, 급여의 평균이 300이상인거

select position, round(avg(pay))  --위에서 조건이 하나 추가된 형태. 급여의 평균을 반올림하기
from professor
group by position
having avg(pay) >= 300;

--복습(+)  근데 헷깔림. group