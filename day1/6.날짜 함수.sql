--복습(+)

-- 날짜 함수

-- 1) SYSDATE
SELECT
    SYSDATE
FROM DUAL;

-- 2) TO_CHAR : 날짜를 문자 포맷으로 변경
-- 3) TO_DATE : 문자를 날짜 포맷으로 변경
SELECT
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
    TO_DATE('2026-02-26', 'YYYY-MM-DD')
FROM DUAL;

select name, hiredate from professor;

SELECT *
FROM PROFESSOR
WHERE TO_CHAR(HIREDATE, 'YY') = '81';