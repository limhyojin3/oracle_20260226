-- EMP
-- 1. 내 부서의 평균 급여보다 높은 급여를 받는 사람 출력

SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT *
FROM EMP E
INNER JOIN (
    SELECT DEPTNO, AVG(SAL) AS AVG_SAL
    FROM EMP
    GROUP BY DEPTNO
)T ON E.DEPTNO = T.DEPTNO
WHERE SAL > AVG_SAL;


--
-- 사용자가 작성한 게시글 조회수의 총합이
-- 모든 게시글 조회수 전체 평균보다 높은 
-- 게시글의 작성자 아이디, 이름, 조회수 총합 출력

SELECT * FROM TBL_BOARD;  --USERID,BOARDNO,TITLE, CONTENTS,CNT
SELECT * FROM TBL_COMMENT; --BOARDNO,USERID
SELECT * FROM TBL_USER; --USERID, USERNAME

--답변 : 
SELECT B.USERID, USERNAME, SUM(CNT) --SUM_CNT(X)
FROM TBL_BOARD B
INNER JOIN TBL_USER U ON B.USERID = U.USERID
GROUP BY B.USERID, USERNAME
HAVING SUM(CNT) > (  --SUM_CNT(X)
    SELECT AVG(CNT)
    FROM TBL_BOARD
);

--
**오라클이 쿼리를 읽는 순서를 보면 이유가 명확해집니다.
1.FROM/JOIN(1순위): 데이터를 가져올 테이블 확인  --INNER JOIN은 가장 먼저 실행되는 FROM 절의 일부로 취급됩니다.
                                          --데이터를 가공하기 전에 "어떤 데이터를 합칠 것인가"를 먼저 결정해야 하기 때문
2.WHERE: 행 필터링
3.GROUP BY: 그룹화
4.HAVING: 그룹 필터링 (← 여기서 에러 발생!) 그룹화된 데이터 중 조건에 맞는 그룹만 남깁니다. (여기서 별칭 사용 불가!)
5.SELECT: 어떤 컬럼을 보여줄지 결정하고, 이때 별칭(Alias)이 부여됩니다.
6.ORDER BY: 정렬

--
SELECT AVG(CNT)  --VALUE값이 하나로 나옴 => 39.8
FROM TBL_BOARD;
















SELECT USERID, SUM(CNT)
FROM TBL_BOARD
GROUP BY USERID;

SELECT USERID, SUM(CNT)
FROM TBL_BOARD
GROUP BY USERID
HAVING SUM(CNT) > 40;

SELECT B.USERID, U.USERNAME, SUM(CNT)
FROM TBL_BOARD B
INNER JOIN TBL_USER U ON B.USERID = U.USERID
GROUP BY B.USERID, U.USERNAME
HAVING SUM(CNT) > (
    SELECT AVG(CNT)
    FROM TBL_BOARD
);
--INNER JOIN 에 매몰되지말고, SELECT 가 VALUE값을 반환한다는 사실을 잊지말기! (VALUE값이 2개 이상이면 해시맵 느낌으로 반환)
--GROUP BY 로 그룹이 된다음에 나온 테이블에 HAVING을 적용가능! WHERE 이 아님.
--복습(+)

--DAY1 -8.서브쿼리에 잘 작성되어있음. 


SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

--1. 구매자 이름, 책 이름, 구매일 출력

SELECT NAME,BOOKNAME,ORDERDATE
FROM CUSTOMER C
INNER JOIN ORDERS O ON C.CUSTID = O.CUSTID
INNER JOIN BOOK B ON O.BOOKID = B.BOOKID;




SELECT AVG(CNT) -- 39.8
FROM TBL_BOARD;

