SELECT * FROM TBL_USER; --5개  USERID,USERNAME,
SELECT * FROM TBL_BOARD; --10개 USERID,BOARDNO
SELECT * FROM TBL_COMMENT; --25개 USERID, BOARDNO

-- 게시글 제목, 내용, 조회수, 작성자 이름 출력
SELECT TITLE, CONTENTS, CNT, USERNAME
FROM TBL_BOARD B
INNER JOIN TBL_USER U ON B.USERID = U.USERID;

-- 사용자 아이디, 이름, 해당 사용자가 작성한 댓글 개수 출력
SELECT U.USERID, USERNAME, COUNT(*) 댓글개수
FROM TBL_USER U
INNER JOIN TBL_COMMENT C ON U.USERID = C.USERID
GROUP BY U.USERID, USERNAME;

--작성한 게시글의 조회수 합이 가장 많은 상위 3명의 이름과 조회수 합 출력
SELECT * FROM TBL_USER; --5개  USERID,USERNAME,
SELECT * FROM TBL_BOARD; --10개 USERID,BOARDNO,CNT
SELECT * FROM TBL_COMMENT; --25개 USERID,BOARDNO,COMMENTNO

SELECT USERNAME, SUM_CNT
FROM (
    SELECT USERID, SUM(CNT)AS SUM_CNT
    FROM TBL_BOARD
    GROUP BY USERID
    ORDER BY SUM_CNT DESC
)T
INNER JOIN TBL_USER U ON T.USERID = U.USERID
WHERE ROWNUM <= 3;

-- 서브쿼리
SELECT USERID, SUM(CNT)AS SUM_CNT
FROM TBL_BOARD
GROUP BY USERID
ORDER BY SUM_CNT DESC;



--제목|댓글개수 UNION 댓글전체개수|댓글개수
SELECT * FROM TBL_USER; --5개  USERID,USERNAME,
SELECT * FROM TBL_BOARD; --10개 USERID,BOARDNO,CNT
SELECT * FROM TBL_COMMENT; --25개 USERID,BOARDNO,COMMENTNO

SELECT TITLE, 댓글개수
FROM (
    SELECT 
        TITLE, 
        COUNT(*)댓글개수,
        1 AS ORDERKEY
    FROM TBL_BOARD B
    INNER JOIN TBL_COMMENT C ON B.BOARDNO = C.BOARDNO
    GROUP BY B.BOARDNO, TITLE
    UNION
    SELECT 
        '댓글전체개수', 
        COUNT(*),
        2 AS ORDERKEY
    FROM TBL_COMMENT
    ORDER BY ORDERKEY, 댓글개수
);


--
SELECT 
    TITLE, 
    COUNT(*)댓글개수,
    1 AS ORDERKEY
FROM TBL_BOARD B
INNER JOIN TBL_COMMENT C ON B.BOARDNO = C.BOARDNO
GROUP BY B.BOARDNO, TITLE
UNION
SELECT 
    '댓글전체개수', 
    COUNT(*),
    2 AS ORDERKEY
FROM TBL_COMMENT
ORDER BY ORDERKEY, 댓글개수;





--
SELECT COUNT(*)
FROM TBL_COMMENT;



--
SELECT SUM(댓글개수)
FROM (
    SELECT BOARDNO, COUNT(*) AS 댓글개수
    FROM TBL_COMMENT
    GROUP BY BOARDNO
);


--
SELECT BOARDNO, COUNT(*) AS 댓글개수
FROM TBL_COMMENT
GROUP BY BOARDNO;

SELECT 
    TITLE,
    댓글개수,
    1 AS ORDERKEY
FROM (
    SELECT BOARDNO, COUNT(*) AS 댓글개수
    FROM TBL_COMMENT
    GROUP BY BOARDNO
) T
INNER JOIN TBL_BOARD B ON T.BOARDNO = B.BOARDNO
--ORDER BY 댓글개수   **order by는 쿼리문 맨 마지막에 딱 한번 나올수있다.
UNION
SELECT
    '댓글전체개수',
    COUNT(*),  --> 왜 안될까? => order by 다음에 union이 나올수없다. order by가 맨 마지막에 나와야한다.
    2 AS ORDERKEY
FROM TBL_COMMENT
ORDER BY ORDERKEY, 댓글개수;

--답변 : 
SELECT TITLE,댓글개수
FROM (
    SELECT 
        TITLE,
        댓글개수,
        1 AS ORDERKEY    --가상컬럼인 ORDERKEY 별칭으로 두고 사용
    FROM (
        SELECT BOARDNO, COUNT(*) AS 댓글개수
        FROM TBL_COMMENT
        GROUP BY BOARDNO
    ) T
    INNER JOIN TBL_BOARD B ON T.BOARDNO = B.BOARDNO
    --ORDER BY 댓글개수   **order by는 쿼리문 맨 마지막에 딱 한번 나올수있다.
    UNION
    SELECT
        '댓글전체개수',
        COUNT(*),  --> 왜 안될까? => order by 다음에 union이 나올수없다. order by가 맨 마지막에 나와야한다.**
        2 AS ORDERKEY
    FROM TBL_COMMENT
    ORDER BY ORDERKEY, 댓글개수  --정렬은 앞에꺼부터 정렬한담에 , 뒤에꺼 정렬가능.**
);

-- UNION, ORDER BY 퀴즈였음.
