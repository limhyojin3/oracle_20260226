-- 프로시저로 INSERT, DELETE

-- STUDENT 테이블에 학번, 이름, 학과를 입력받아서 저장하는 프로시저
-- 프로시저 나 함수 역할 : 외부에서 엉뚱한 값이 들어오면 실행안함

CREATE OR REPLACE PROCEDURE STUINSERT_PROC
(
    I_STUNO IN VARCHAR2,      
    I_STUNAME IN STUDENT.STU_NAME%TYPE,--STUDENT테이블의 STU_NAME의타입을 가져온다
    I_STUDEPT IN STUDENT.STU_DEPT%TYPE
)
IS 
BEGIN
    IF LENGTH(I_STUNO) != 8 THEN
        --DBMS_OUTPUT.PUT_LINE('학번은 8글자!!');
        -- 에러 번호는 20000~20999
        RAISE_APPLICATION_ERROR(-20001, '학번은 8글자!!');
    END IF;
    
    INSERT INTO STUDENT(STU_NO, STU_NAME, STU_DEPT)
    VALUES(I_STUNO, I_STUNAME, I_STUDEPT);
    COMMIT;

END;
/
--
--20000~20999
--
SET SERVEROUTPUT ON; 
-- 프린트문 실행할때 이게 켜져있어야함. 오라클 실행할때 한번만 해주면됨.
EXEC STUINSERT_PROC('1234', '홍길동', '기계');
--
SELECT * FROM STUDENT;
--
SELECT * FROM EMP;
--
EXEC EMPDELETE(사번); -- 해당 사번 직원 데이터 삭제
--
CREATE OR REPLACE PROCEDURE EMPDELETE_PROC(I_EMPNO IN EMP.EMPNO%TYPE) --매개변수자리에는 IN 있고
IS                                          --사번을 입력받는다
    O_SAL EMP.SAL%TYPE;  --변수선언자리에는 IN없네
BEGIN
    SELECT SAL     --사번에 해당하는 SAL조회해서 변수O_SAL에 담는다.
    INTO O_SAL
    FROM EMP
    WHERE EMPNO = I_EMPNO;   
    
    IF O_SAL >= 3000 THEN
        RAISE_APPLICATION_ERROR(-20002, '3000이상 급여를 받는 직원은 삭제 불가합니다.');
    END IF;
    
    DELETE FROM EMP
    WHERE EMPNO = I_EMPNO;
    COMMIT;
END;
/
--
EXEC EMPDELETE_PROC(7788);
--
EXEC EMPDELETE_PROC(1234);
--
EXEC EMPDELETE_PROC(22);
--
-- 급여가 3000 이상인 직원들은 삭제 불가하도록
-- 에러코드는 -20002, 에러 메시지 '3000이상 급여를 받는 직원은 삭제 불가합니다'
SELECT * FROM EMP;
--
EXEC EMPDELETE_PROC(1234);
--