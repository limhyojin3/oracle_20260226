-- UNION, UNION ALL
-- SELECT 쿼리 실행 결과를 합쳐주는 명령어

SELECT          --UNION할때는 컬럼의 개수가 같아야한다.
    STU_NO,
    STU_NAME,
    STU_DEPT
FROM STUDENT
WHERE STU_HEIGHT >= 170
--UNION  --OR 연산과 같다. 중복된 행이 있으면 하나로 합쳐서 출력해준다.
UNION ALL --UNION(쿼리끼리 합치면서) 하면서 중복된 행이 있어도 그대로 출력해준다.
SELECT 
    STU_NO,
    STU_NAME,
    STU_DEPT
FROM STUDENT
WHERE STU_WEIGHT >= 60;

-- 주의점
-- 1. 컬럼의 개수, 컬럼의 타입(문자,숫자..)이 같아야 한다.
-- 2. 컬럼의 이름(별칭)은 먼저 나오는 쿼리를 따른다.
-- 3. 정렬(ORDER BY)는 맨 마지막 줄에 작성한다. 첫번째 쿼리 컬럼을 기준으로 한다.


SELECT STU_NAME FROM STUDENT
UNION
SELECT COUNT(*) FROM STUDENT; -- 컬럼의 데이터 타입이 달라서 오류 발생

SELECT STU_NAME AS ZZZ FROM STUDENT
UNION
SELECT STU_DEPT FROM STUDENT; -- 컬럼의 이름은 첫번째 쿼리를 따른다.

-- 대표적으로 UNION이 쓰이는 예시
SELECT STU_DEPT, COUNT(*) 학생수
FROM STUDENT
GROUP BY STU_DEPT
UNION
SELECT '전체학생수', COUNT(*)
FROM STUDENT; 

-- 학생별 시험 평균 점수 출력 + 전체 학생의 평균점수 출력
SELECT 
    STU_NAME,
    AVG(ENR_GRADE) AS AVG,
    1 AS ORDERKEY
FROM ENROL E
INNER JOIN STUDENT S ON E.STU_NO = S.STU_NO
GROUP BY STU_NAME
UNION
SELECT 
    '전체 학생의 평균점수',
    ROUND(AVG(ENR_GRADE),1),
    2 AS ORDERKEY
FROM ENROL
ORDER BY ORDERKEY, AVG; --ORDERKEY 먼저 정렬 후, 정렬된 상태에서 AVG 정렬됨.**

-- ORDERKEY 안보이게 => 서브쿼리로 해결
SELECT STU_NAME, AVG
FROM (
    SELECT 
        STU_NAME,
        AVG(ENR_GRADE) AS AVG,
        1 AS ORDERKEY
    FROM ENROL E
    INNER JOIN STUDENT S ON E.STU_NO = S.STU_NO
    GROUP BY STU_NAME
    UNION   --> UNION 은 행이 추가되는방식.
    SELECT 
        '전체 학생의 평균점수',
        ROUND(AVG(ENR_GRADE),1),
        2 AS ORDERKEY
    FROM ENROL
    ORDER BY ORDERKEY, AVG

);



SELECT * FROM ENROL;