--복습( )

-- 문자 함수

-- 1) CONCAT : 문자열 결합
SELECT CONCAT(CONCAT(STU_NO, ' '), STU_NAME) AS ZZ
FROM STUDENT;

-- 1-2) || : 문자열 결합
SELECT STU_NO || ' ' || STU_NAME AS ZZ
FROM STUDENT;

-- 2) LENGTH : 문자열 길이
SELECT * FROM PROFESSOR;

SELECT ID, LENGTH(ID)  --컬럼2개 출력
FROM PROFESSOR;

-- 3) 문자열 자르기
select * from stu;
select name, substr(jumin, 1, 6) 생년월일  -- 컬럼2개 출력
from stu;

-- DECODE : 자바의 IF문 같은거
select * from stu;

select  -- 컬럼3개 출력
    name,
    substr(jumin, 7, 1),  --7번째자리부터시작해서 1개
    substr(jumin, 7), --7번째자리부터 끝까지.
    decode(substr(jumin, 7, 1), 1, '남자', '여자')  -- substr(jumin, 7, 1) == 1 ? '남자' : '여자'
from stu;

-- 4) UPPER, LOWER : 대, 소문자로 변경
select
    upper('Hello Oracle'),
    lower('Hello Oracle')
from dual;

-- 5) INSTR : 특정 문자열이 몇번째에 처음으로 나오는지
select * from professor;
select 
    email,
    instr(email, '@'),  -- email 컬럼 데이터에서 '@'가 처음으로 나오는 위치
    substr(email, instr(email, '@') + 1)  --email 컬럼 데이터에서 /'@'가 처음으로 나오는 위치 바로 다음부터 끝까지/ 문자열을 반환
from professor;      

-- 6) REPLACE : 문자열을 다른 문자열로 대체
select
    email,
    replace(email, 'net', 'com') --email 컬럼 데이터에 있는 /'net' -> 'com' 으로 보이도록/(실제 데이터 변경X, 보이는것만 변경O)
from professor;

-- 7) TRIM, LTRIM, RTRIM : 공백제거
SELECT
    TRIM('   Hello Oracle    '),
    LTRIM('   Hello Oracle    '),
    RTRIM('   Hello Oracle    ')
FROM DUAL;

-- 8) LPAD, RPAD : 지정한 길이 만큼 특정 문자 채우기
SELECT
    ID,
    RPAD(ID, 10, '*')  -- ID 컬럼 데이터를 가지고/ 10글자가 되도록한다/ 빈곳은 '*' 를 채운다.
FROM PROFESSOR;

-- 아이디의 마지막 3글자만 *로 표시
--복습(+)
select
    id,
    substr(id,1,length(id)-3), 
    --rpad(capt, 7, *), rpad(swe, 6, *)
    rpad(substr(id,1,length(id)-3), length(id), '*') as id
from professor;


--복습(+)
select      --substr(id,1,4) => substr(id,1,length(id)-3) => capt
    id,     --id컬럼 데이터를가지고/첫번째 자리부터, (id컬럼데이터의길이-3)개 글자수
    substr(id, 1, length(id)-3) || '***'
from professor;
