-- 조건 처리
-- NVL : NULL 값에 대한 처리

SELECT *
FROM PROFESSOR;

SELECT NAME, PAY, BONUS, PAY+BONUS
FROM PROFESSOR;

SELECT NAME, PAY, BONUS, NVL(BONUS, 0), PAY + NVL(BONUS, 0)  --BONUS가 null 이면 0을 반환한다.
FROM PROFESSOR;

SELECT NAME, BONUS, NVL2(BONUS, 10000, 0)  -- BONUS가 null이 아니라면 10000을 반환, null이라면 0을 반환
FROM PROFESSOR;

-- DECODE : 자바의 조건문(IF)
-- DECODE(컬럼명, '조건값', '조건이랑 같을 때 출력', '조건이랑 다를 때 출력')
-- DECODE(컬럼명, '조건값1', '조건1 만족할 때 출력', '조건값2', '조건2 만족할 때 출력', '조건1~2 모두 만족 안했을 때')

SELECT * FROM STU;
SELECT
    NAME,
    DECODE(GRADE, 4, '졸업반', GRADE || '학년'),
    DECODE(GRADE, 4, '졸업반', 3, '고학년', '저학년')
FROM STU;


-- CASE ~ WHEN : DECODE 보다 좀더 복잡한 IF 가독성있게 처리 가능
SELECT 
    SAL,
    CASE
        WHEN SAL >= 4000 THEN '고소득'
        WHEN SAL BETWEEN 2000 AND 4000 THEN '적당히 받음'
        ELSE '홧팅'
    END 급여정보
FROM EMP;