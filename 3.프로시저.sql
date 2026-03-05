-- 프로시저 **중요개념  (함수와 비슷)

--
CREATE OR REPLACE PROCEDURE TEST_PROC
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello Oracle');
END;
/
--
SET SERVEROUTPUT ON; --DBMS_OUTPUT.PUT_LINE('Hello Oracle')를 실행시키기위해. => 딱 한번만 세팅하면 끝.
--
EXEC TEST_PROC;
--                                                 -EMP테이블의EMPNO의타입을 가져온다    
CREATE OR REPLACE PROCEDURE EMPINFO_PROC(I_EMPNO IN EMP.EMPNO%TYPE)     --FUNCTION 은 어디서나 쓴다
IS                                                                      --PROCEDURE은 한 테이블 대상으로? 좁은범위에서 쓴다.
    O_ENAME EMP.ENAME%TYPE;
    O_SAL EMP.SAL%TYPE;
BEGIN
    SELECT ENAME, SAL     --I_EMPNO를 입력해서 ENAME과 SAL을 조회
    INTO O_ENAME, O_SAL--변수에 담겟다
    FROM EMP
    WHERE EMPNO = I_EMPNO;
    
    DBMS_OUTPUT.PUT_LINE(O_ENAME || '님의 급여는 ' || O_SAL || '입니다.'); --변수
END;
/
--
SELECT * FROM EMP;
--
EXEC EMPINFO_PROC(7654);
--
CREATE OR REPLACE PROCEDURE EMPSAL_PROC -- 매개변수 길어져서 아래처럼 표현함.
    (
        I_EMPNO IN EMP.EMPNO%TYPE, --EMP테이블에있는 EMPNO의타입을 참조한다(가져온다)
        I_SAL IN EMP.SAL%TYPE
    ) --사번이랑 추가할급여 입력
IS --변수선언
    O_COUNT NUMBER;          --쿼리문에서 행에 변화생김
BEGIN -- 쿼리문을 작성
    UPDATE EMP
    SET
        SAL = SAL + I_SAL  --I_SAL은 추가할 급여
    WHERE EMPNO = I_EMPNO;
    
    O_COUNT := SQL%ROWCOUNT;  --SQL%ROWCOUNT; => SQL 실행 시 영향받은 Row의 수
    
    IF O_COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('사번을 확인해주세요');
    ELSIF O_COUNT = 1 THEN
        DBMS_OUTPUT.PUT_LINE('수정되었습니다!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('2개 이상의 데이터가 저장되었습니다.');
    END IF;
    COMMIT; --커밋 해주기
END;
/
--
SELECT * FROM EMP;
--
EXEC EMPSAL_PROC(7654,100);


-- 프로시저 호출
-- ENROL_PROC('학번', '과목번호', '수정할 점수')
-- 1. 없는 학번이나 없는 과목번호를 입력하면 '정보를 다시 확인해주세요' 출력
-- 2. 점수가 0미만, 100 초과일 경우 '점수의 범위는 1~100 입니다' 출력
-- 3. 학번, 과목번호에 해당하는 점수는 3번째 인자값으로 변경

SELECT * FROM ENROL;
--
CREATE OR REPLACE PROCEDURE ENROL_PROC
    (   
        I_STUNO IN ENROL.STU_NO%TYPE,
        I_SUBNO IN ENROL.SUB_NO%TYPE,
        I_GRADE IN ENROL.ENR_GRADE%TYPE
    ) --학번, 과목번호, 수정할 점수를 입력할거임
IS --변수선언
    O_COUNT NUMBER;  --수정되었는지 확인용
BEGIN --쿼리문작성

    IF I_GRADE BETWEEN 0 AND 100 THEN
        UPDATE ENROL
        SET 
           ENR_GRADE = I_GRADE  --I_GRADE는 수정할 점수
        WHERE SUB_NO = I_SUBNO AND STU_NO = I_STUNO;
        
        O_COUNT := SQL%ROWCOUNT; --SQL%ROWCOUNT; => SQL 실행 시 영향받은 Row의 수
        
        --쿼리문실행결과
        IF O_COUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('정보를 다시 확인해주세요');
        ELSIF O_COUNT = 1 THEN
            DBMS_OUTPUT.PUT_LINE('수정되었습니다!');
        ELSE
            DBMS_OUTPUT.PUT_LINE('2개 이상의 데이터가 저장되었습니다.');
        END IF;
    ELSE     
        DBMS_OUTPUT.PUT_LINE('점수의 범위는 1~100 입니다');
    END IF;
    COMMIT;
END;
/
--
SELECT * FROM ENROL;
--
EXEC ENROL_PROC(20131001,101, 101);
--
EXEC ENROL_PROC(20139999,101, 78);
--
EXEC ENROL_PROC(20131001,101, 88);
--
