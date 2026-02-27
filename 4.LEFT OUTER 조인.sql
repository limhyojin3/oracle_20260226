-- OUTER JOIN(LEFT, RIGHT)   --OUTER는 생략가능.  LEFT JOIN: ON조건절을 기준으로 (INNER) JOIN 하되, 
                                                          -- 왼쪽 테이블에 있는건 다 보여줌. 
                                                          -- 값이 없으면 NULL값이 나옴.     
                                              --RIGHT JOIN:오른쪽 테이블에 있는건 다 보여줌.

SELECT * FROM DEPT;

SELECT * FROM EMP;

SELECT *
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

SELECT STU_NAME, COUNT(ENR_GRADE) -- COUNT(속성): 속성에 NULL값이 있으면 카운트 세지않음.
FROM STUDENT S;
--LEFT JOIN ENROL E ON S.STU_DEPT = E.STU_DEPT;(x)

SELECT * FROM PROFESSOR;
SELECT * FROM STU;

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

SELECT S.STUNO 학번, S.NAME 학생이름, NVL(P.NAME, '없음') 담당교수
FROM STU S
LEFT JOIN PROFESSOR P ON S.PROFNO = P.PROFNO;

-- 학생들이 시험본 갯수
SELECT *
FROM STUDENT;
SELECT *
FROM ENROL;

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


--EMP
--부하직원의 수를 구하고 싶다
--없으면 0으로 출력
--사번, 이름, 자신의 부하직원 수 출력
SELECT * FROM EMP;

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



SELECT E1.MGR 보스, E1.EMPNO 부하직원
FROM EMP E1
LEFT JOIN EMP E2 ON E1.MGR = E2.EMPNO;

SELECT E1.MGR 보스, COUNT(E1.EMPNO)
FROM EMP E1
LEFT JOIN EMP E2 ON E1.MGR = E2.EMPNO
GROUP BY E1.MGR;


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

--테이블을 만드는형태로.. 서브쿼리 사용해서 깔끔하게도 가능.
SELECT 
    LPAD('@'||LPAD(SUBSTR(SECOND,INSTR(SECOND,'.')), LENGTH(SECOND),'*'), LENGTH(EMAIL), '*')
FROM(
	SELECT EMAIL, SUBSTR(EMAIL, INST1+1) SECOND
FROM(
	SELECT EMAIL, INSTR(EMAIL,'@') AS INST1, INSTR(EMAIL,'.') AS INST2
	FROM PROFESSOR
	)
);

SELECT
    LPAD




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
