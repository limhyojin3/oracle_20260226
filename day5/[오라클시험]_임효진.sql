SELECT COUNT(*) FROM MEMBER; -- 10개
SELECT COUNT(*) FROM MEMBER_POINT; -- 30개
SELECT COUNT(*) FROM PRODUCT; -- 20개
SELECT COUNT(*) FROM PRODUCT_ORDERS; -- 40개
--
--#주의점 : 주문 금액과 관련된 문제를 풀이할 때는 주문 수량도 고려할 것.

--1. 아래 조건에 맞게 쿼리를 작성하고 실행하시오.
--(사용 테이블 : MEMBER)
-- 1-1) 아이디가 'test123', 비밀번호가 '1234', 이름이 '홍길동'인 레코드 추가 (INSERT)
-- 1-2) 1-1에서 추가한 사용자의 이메일을 test@test.com 으로 수정 (UPDATE)
-- 1-3) 1-1에서 추가한 레코드를 삭제 (DELETE)
 
SELECT * FROM MEMBER;
--
INSERT INTO MEMBER(MEMBER_ID, PASSWORD, MEMBER_NAME) VALUES('test123', '1234', '홍길동');
UPDATE MEMBER SET EMAIL = 'test@test.com' WHERE MEMBER_ID = 'test123';
DELETE FROM MEMBER WHERE MEMBER_ID = 'test123';
 

--2. 주문 내역에서 '인천' 지역에서 주문 사용자의 내역 조회
--(
--	사용 테이블 : PRODUCT_ORDERS
--	출력 컬럼 : 주문자 아이디, 가격, 주소
--)

SELECT * FROM PRODUCT_ORDERS;
-- 답변 :
SELECT ORDER_ID, (ORDER_PRICE * ORDER_QTY),DELIVERY_ADDR 
FROM PRODUCT_ORDERS
WHERE DELIVERY_ADDR LIKE '인천%';
--
SELECT *
FROM PRODUCT_ORDERS
WHERE DELIVERY_ADDR LIKE '인천%';
 
--3. 이메일에서 메일 아이디만 따로 출력 하시오
--(ex, abcde@naver.com -> abcde / 즉, @ 이전 문자만 출력)
--(
--	사용 테이블 : MEMBER
--	출력 컬럼 : 이름, 메일 아이디
--)

SELECT * FROM MEMBER;
--답변 : 
SELECT 
    MEMBER_NAME,
    SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM MEMBER;

--4. 아래 조건에 맞게 VIEW를 만들고, 검색해 보시오.
--(사용 테이블 : MEMBER_POINT)
--조건 1) VIEW 이름은 POINT_VIEW
--조건 2) DESCRIPTION이 '리뷰'인 레코드만 검색
--조건 3) 읽기 전용으로 만들 것

SELECT * FROM MEMBER_POINT;
-- 답변 : VIEW생성
CREATE OR REPLACE VIEW POINT_VIEW AS 
SELECT *
FROM MEMBER_POINT
WHERE DESCRIPTION = '리뷰'
WITH READ ONLY;
-- 답변 : VIEW 검색
SELECT *
FROM POINT_VIEW;
--
SELECT *
FROM MEMBER_POINT
WHERE DESCRIPTION = '리뷰';
--

--5. 고객 아이디, 이름, 주문한 제품 명, 배송 주소를 출력하시오.
--(
--	사용 테이블 : MEMBER, PRODUCT, PRODUCT_ORDERS
--	출력 컬럼 : 고객 아이디, 이름, 주문한 제품 명, 배송 주소
--)

SELECT * FROM MEMBER;
SELECT * FROM PRODUCT;
SELECT * FROM PRODUCT_ORDERS;
-- 답변 :
SELECT M.MEMBER_ID, MEMBER_NAME, PRODUCT_NAME, DELIVERY_ADDR
FROM MEMBER M
INNER JOIN PRODUCT_ORDERS O ON M.MEMBER_ID = O.MEMBER_ID
INNER JOIN PRODUCT P ON O.PRODUCT_ID = P.PRODUCT_ID; 
--
SELECT * 
FROM MEMBER M
INNER JOIN PRODUCT_ORDERS O ON M.MEMBER_ID = O.MEMBER_ID
INNER JOIN PRODUCT P ON O.PRODUCT_ID = P.PRODUCT_ID; 


--6. 누적된 포인트가 가장 많은 고객의 아이디, 이름, 누적 포인트량 을 출력하시오.
--(
--	사용 테이블 : MEMBER_POINT, MEMBER
--	출력 컬럼 : 아이디, 이름, 누적 포인트량
--)

SELECT * FROM MEMBER_POINT;
SELECT * FROM MEMBER;
-- 답변 :
SELECT P.MEMBER_ID, MEMBER_NAME, SUM(POINT_AMOUNT)
FROM MEMBER_POINT P
INNER JOIN MEMBER M ON P.MEMBER_ID = M.MEMBER_ID
GROUP BY P.MEMBER_ID, MEMBER_NAME;
--
SELECT *
FROM MEMBER_POINT P
INNER JOIN MEMBER M ON P.MEMBER_ID = M.MEMBER_ID;


--7. 가장 많은 제품을 구매한 고객의 아이디, 이름, 주문 개수를 출력하시오.
--(
--	사용 테이블 : MEMBER, PRODUCT_ORDERS
--	출력 컬럼 : 고객 아이디, 이름, 주문 개수
--)

SELECT * FROM MEMBER;
SELECT * FROM PRODUCT_ORDERS;
-- 답변 :
SELECT O.MEMBER_ID, MEMBER_NAME, COUNT(*)
FROM PRODUCT_ORDERS O
INNER JOIN MEMBER M ON O.MEMBER_ID = M.MEMBER_ID
GROUP BY O.MEMBER_ID, MEMBER_NAME;
--
SELECT * 
FROM PRODUCT_ORDERS O
INNER JOIN MEMBER M ON O.MEMBER_ID = M.MEMBER_ID;


--8. 고객이 주문한 금액의 총합이 가장 큰 사람과 가장 적은 사람의 차이를 구하시오.
--(
--	사용 테이블 : PRODUCT_ORDERS
--	출력 컬럼 : 주문한 금액의 총합이 가장 큰 사람과 가장 적은 사람의 차이
--)

SELECT * FROM PRODUCT_ORDERS;
-- 답변 : 10470000
SELECT MAX(SUM(ORDER_PRICE * ORDER_QTY)) - MIN(SUM(ORDER_PRICE * ORDER_QTY))
FROM PRODUCT_ORDERS
GROUP BY MEMBER_ID;
--
SELECT MAX(PRICE_QTY_SUM) - MIN(PRICE_QTY_SUM) 
FROM (
    SELECT MEMBER_ID, SUM(ORDER_PRICE * ORDER_QTY) PRICE_QTY_SUM
    FROM PRODUCT_ORDERS
    GROUP BY MEMBER_ID
);
--
SELECT MEMBER_ID, SUM(ORDER_PRICE * ORDER_QTY)
FROM PRODUCT_ORDERS
GROUP BY MEMBER_ID;


--9. 전체 주문 금액의 평균보다 주문 금액의 평균이 더 큰 고객의 아이디, 이름, 주문 금액 평균액을 출력하시오.
--(
--	사용 테이블 : MEMBER, PRODUCT_ORDERS
--	출력 컬럼 : 아이디, 이름, 주문 금액 평균액
--)

SELECT * FROM MEMBER;
SELECT * FROM PRODUCT_ORDERS;
--답변 :
SELECT O.MEMBER_ID, MEMBER_NAME, AVG(ORDER_PRICE * ORDER_QTY)
FROM PRODUCT_ORDERS O
INNER JOIN MEMBER M ON O.MEMBER_ID = M.MEMBER_ID
GROUP BY O.MEMBER_ID, MEMBER_NAME
HAVING AVG(ORDER_PRICE * ORDER_QTY) > (
    SELECT AVG(SUM_PRICE_QTY) --4919000(전체 주문 금액의 평균)
    FROM (
        SELECT MEMBER_ID, SUM(ORDER_PRICE * ORDER_QTY) SUM_PRICE_QTY
        FROM PRODUCT_ORDERS
        GROUP BY MEMBER_ID
    )
);

--
SELECT O.MEMBER_ID, MEMBER_NAME, AVG(ORDER_PRICE * ORDER_QTY)
FROM PRODUCT_ORDERS O
INNER JOIN MEMBER M ON O.MEMBER_ID = M.MEMBER_ID
GROUP BY O.MEMBER_ID, MEMBER_NAME;
--
SELECT *
FROM PRODUCT_ORDERS O
INNER JOIN MEMBER M ON O.MEMBER_ID = M.MEMBER_ID;
--
SELECT AVG(SUM_PRICE_QTY) --4919000(전체 주문 금액의 평균)
FROM (
    SELECT MEMBER_ID, SUM(ORDER_PRICE * ORDER_QTY) SUM_PRICE_QTY
    FROM PRODUCT_ORDERS
    GROUP BY MEMBER_ID
);
--
SELECT MEMBER_ID, SUM(ORDER_PRICE * ORDER_QTY)
FROM PRODUCT_ORDERS
GROUP BY MEMBER_ID;
--


--10. 부하직원이 가장 많은 사원의 사번, 이름, 부하직원 수를 구하시오.
--(
--	사용 테이블 : EMP
--	출력 컬럼 : 사번, 이름, 부하직원 수
--)

SELECT * FROM EMP;
--
SELECT MAX(COUNT(*)) -- 5
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
GROUP BY E1.MGR, E2.ENAME;
-- 답변 :
SELECT E1.MGR, E2.ENAME, COUNT(*) 
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
GROUP BY E1.MGR, E2.ENAME
HAVING COUNT(*) = (
    SELECT MAX(COUNT(*)) -- 5
    FROM EMP E1
    INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
    GROUP BY E1.MGR, E2.ENAME
);
--
SELECT E1.MGR, E2.ENAME, COUNT(*) 
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
GROUP BY E1.MGR, E2.ENAME;
--
SELECT * 
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO;


--11. 본인보다 높은 학년인 사람의 학생 수 구하고, 아래 이미지와 같이 결과를 도출하시오.
--(사용 테이블 : STU)

SELECT * FROM STU;
-- 최종답변 :
SELECT 높은학년사람수, STUNO, NAME, S.GRADE
FROM STU S
INNER JOIN (
    SELECT 
        T.*,
        CASE
            WHEN GRADE = 4 THEN 0
            WHEN GRADE = 3 THEN (
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 4
                )
            WHEN GRADE = 2 THEN ((
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 3
            ) + (
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 4
            ))
            WHEN GRADE = 1 THEN ((
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 2
            ) + (
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 3
            ) + (
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 4
            ))
            ELSE NULL
        END 높은학년사람수
    FROM (
        SELECT GRADE, COUNT(*) CNT
        FROM STU
        GROUP BY GRADE
    ) T
) T2 ON S.GRADE = T2.GRADE
ORDER BY 높은학년사람수 DESC, NAME ASC; 
--
SELECT *
FROM STU S
INNER JOIN (
    SELECT 
        T.*,
        CASE
            WHEN GRADE = 4 THEN 0
            WHEN GRADE = 3 THEN (
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 4
                )
            WHEN GRADE = 2 THEN ((
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 3
            ) + (
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 4
            ))
            WHEN GRADE = 1 THEN ((
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 2
            ) + (
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 3
            ) + (
                SELECT COUNT(*)
                FROM STU
                GROUP BY GRADE
                HAVING GRADE = 4
            ))
            ELSE NULL
        END 높은학년사람수
    FROM (
        SELECT GRADE, COUNT(*) CNT
        FROM STU
        GROUP BY GRADE
    ) T
) T2 ON S.GRADE = T2.GRADE; 
--
SELECT 
    T.*,
    CASE
        WHEN GRADE = 4 THEN 0
        WHEN GRADE = 3 THEN (
            SELECT COUNT(*)
            FROM STU
            GROUP BY GRADE
            HAVING GRADE = 4
            )
        WHEN GRADE = 2 THEN ((
            SELECT COUNT(*)
            FROM STU
            GROUP BY GRADE
            HAVING GRADE = 3
        ) + (
            SELECT COUNT(*)
            FROM STU
            GROUP BY GRADE
            HAVING GRADE = 4
        ))
        WHEN GRADE = 1 THEN ((
            SELECT COUNT(*)
            FROM STU
            GROUP BY GRADE
            HAVING GRADE = 2
        ) + (
            SELECT COUNT(*)
            FROM STU
            GROUP BY GRADE
            HAVING GRADE = 3
        ) + (
            SELECT COUNT(*)
            FROM STU
            GROUP BY GRADE
            HAVING GRADE = 4
        ))
        ELSE NULL
    END 높은학년사람수
FROM (
    SELECT GRADE, COUNT(*) CNT
    FROM STU
    GROUP BY GRADE
) T;
--
SELECT COUNT(*)
FROM STU
GROUP BY GRADE
HAVING GRADE = 1;
--
SELECT COUNT(*)
FROM STU
GROUP BY GRADE
HAVING GRADE = 2;
--
SELECT COUNT(*)
FROM STU
GROUP BY GRADE
HAVING GRADE = 3;
--
SELECT COUNT(*)
FROM STU
GROUP BY GRADE
HAVING GRADE = 4;
--
SELECT GRADE, COUNT(*)
FROM STU
GROUP BY GRADE;



--12.학생들의 성별(남,여) 인원수를 구하고, 아래 이미지와 같이 결과를 도출하시오.
--(사용 테이블 : STU)

SELECT * FROM STU;
--
SELECT
    DECODE
FROM (
    SELECT SUBSTR(JUMIN, 7, 1) SUBS, COUNT(*)
    FROM STU
    GROUP BY SUBSTR(JUMIN, 7, 1)
);
-- 답변 :
SELECT *
FROM (
    SELECT COUNT(*) 남자--12
    FROM STU
    GROUP BY SUBSTR(JUMIN, 7, 1)
    HAVING SUBSTR(JUMIN, 7, 1) IN ('1','3')
) T1 INNER JOIN (
    SELECT COUNT(*) 여자 --8
    FROM STU
    GROUP BY SUBSTR(JUMIN, 7, 1)
    HAVING SUBSTR(JUMIN, 7, 1) IN ('2', '4')
) T2 ON 1=1;

--
SELECT COUNT(*) 여자 --8
FROM STU
GROUP BY SUBSTR(JUMIN, 7, 1)
HAVING SUBSTR(JUMIN, 7, 1) IN ('2', '4');
--
SELECT COUNT(*) 남자--12
FROM STU
GROUP BY SUBSTR(JUMIN, 7, 1)
HAVING SUBSTR(JUMIN, 7, 1) IN ('1','3');
--
SELECT SUBSTR(JUMIN, 7, 1), COUNT(*)
FROM STU
GROUP BY SUBSTR(JUMIN, 7, 1);
--
SELECT 
    NAME,
    SUBSTR(JUMIN, 7, 1)
FROM STU;

