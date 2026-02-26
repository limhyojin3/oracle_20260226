--복습(+)

--숫자 함수
select 'test' zz from dual; --임의의 데이터를 출력하고싶을때

-- 1) ROUND : 반올림
select round(123.45678, 2)
from dual;

-- 2) CEIL : 올림
select ceil(123.001)
from dual;

-- 3) FLOOR : 내림
select floor(123.999)
from dual;

-- 4) TRUNC : 특정 위치까지 출력
select trunc(123.4567, 2)
from dual;

-- 5) MOD : 나머지 값
select mod(10, 3)
from dual;

select * from student;
select stu_name, mod(stu_height, 2)
from student;

-- 6) SIGN : 숫자 부호를 반환 -> 양수면 1, 음수면 -1, 0이면 0
select sign(-10) as zz
from dual;

-- 7) ABS : 절댓값
select abs(-10)
from dual;

-- 8) POWER : 제곱
select power(2, 10)
from dual;