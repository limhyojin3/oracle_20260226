-- 트리거
-- 특정 테이블(선택한 테이블)에 변화가 생겼을 때 (INSERT,DELETE,UPDATE)
-- 실행되는 프로시저

--이상한 값 들어오는거 방지 용도 => BEFORE   -- 트리거가 먼저 실행된후 쿼리문을 실행
--로그기록용도 => AFTER     --쿼리문이 실행된후에 로그만 기록.

CREATE OR REPLACE TRIGGER TEST_TRIGGER
    BEFORE -- 트리거 실행 지점(BEFORE OR AFTER)
    INSERT OR UPDATE ON EMP -- EMP 테이블에 레코드가 INSERT 혹은 UPDATE될때 실행
    FOR EACH ROW -- 각 행별로 트리거 실행
                 -- (ex, UPDATE로 3개 행에 영향을 주었다면 트리거도 3번 실행)
BEGIN                                   -- :OLD.EMP테이블에있는속성
    DBMS_OUTPUT.PUT_LINE('변경 전 : ' || :OLD.SAL); --EMP테이블에 있는 변경전 SAL을 가져온다
    DBMS_OUTPUT.PUT_LINE('변경 후 : ' || :NEW.SAL); --EMP테이블에 있는 변경후 SAL을 가져온다
END;                                    -- :NEW.EMP테이블에있는속성  => 문법이다.
/
--
SELECT * FROM EMP;
--
UPDATE EMP
SET 
    SAL = 1350
WHERE EMPNO = 7521;
--
CREATE TABLE EMP_LOG(
    L_EMPNO NUMBER,
    L_MGR NUMBER,
    O_SAL NUMBER,
    N_SAL NUMBER,
    L_COMM NUMBER,
    L_ID VARCHAR2(30),
    EVENT VARCHAR2(20),
    L_TIME DATE
);
COMMIT;
--
CREATE OR REPLACE TRIGGER EMP_TRIGGER 
    BEFORE
    INSERT OR UPDATE OR DELETE ON EMP
    FOR EACH ROW
BEGIN
    
    IF :NEW.COMM IS NULL OR :NEW.COMM < 0 THEN
        :NEW.COMM := 0;
    END IF;
    
    IF INSERTING THEN
        INSERT INTO EMP_LOG                                            --현재 접속중인 아이디를 가져오는 문법
        VALUES(:NEW.EMPNO, :NEW.MGR, :NEW.SAL, :NEW.SAL, :NEW.COMM, SYS_CONTEXT('USERENV','SESSION_USER'), 'I', SYSDATE); --INSERT를 I로 넣기
    ELSIF UPDATING THEN
        INSERT INTO EMP_LOG                                            --현재 접속중인 아이디를 가져오는 문법
        VALUES(:NEW.EMPNO, :NEW.MGR, :OLD.SAL, :NEW.SAL, :NEW.COMM, SYS_CONTEXT('USERENV','SESSION_USER'), 'U', SYSDATE);
    ELSIF DELETING THEN
        RAISE_APPLICATION_ERROR(-20003, '사원 데이터는 삭제할 수 없습니다.');
        --INSERT INTO EMP_LOG                                            --현재 접속중인 아이디를 가져오는 문법
        --VALUES(:OLD.EMPNO, :OLD.MGR, :OLD.SAL, :OLD.SAL, :OLD.COMM, SYS_CONTEXT('USERENV','SESSION_USER'), 'D', SYSDATE); 
    
    END IF;
    --트리거 안에서는 커밋 필요없나봄

END;
/
--
SELECT SYS_CONTEXT('USERENV','SESSION_USER')
FROM DUAL;
--
SELECT * FROM EMP;
--
UPDATE EMP
SET 
    SAL = 2050
WHERE EMPNO = 7521;
COMMIT;
--
SELECT * FROM EMP_LOG;
--
INSERT INTO EMP(EMPNO,ENAME,SAL)
VALUES('9876','PARK',2500);
--
INSERT INTO EMP(EMPNO, ENAME, SAL, COMM)
VALUES('1234','KIM',3000, -300);
--
SELECT * FROM ENROL;
--ENROL 테이블 트리거 만들기
--
--조건 1. 테이블명은 ENROL_LOG
--       컬럼은 과목번호, 학생번호, 수정전시험점수, 수정후시험점수, 작업자ID, 작업종류, 작업날짜
CREATE TABLE ENROL_LOG(
    L_SUBNO CHAR(3),
    L_STUNO CHAR(8),
    O_GRADE NUMBER,
    N_GRADE NUMBER,
    L_ID VARCHAR2(30),
    EVENT CHAR(1),
    L_TIME DATE
);
COMMIT;

--조건 2. INSERT할 경우 ENROL_LOG에 해당 내용 자동 저장
--       단, 시험점수가 0~100사이가 아니면 0으로 저장
--조건 3. UPDATE할 경우 ENROL_LOG에 해당 내용 자동 저장
--       단, 시험점수가 0~100사이가 아니면 에러를 띄운 후 종료
--조건 4. DELETE할 경우 에러를 띄운 후 종료
--
CREATE OR REPLACE TRIGGER ENROL_TRIGGER
    BEFORE
    INSERT OR UPDATE OR DELETE ON ENROL --**
    FOR EACH ROW
BEGIN

    IF INSERTING THEN
        IF :NEW.ENR_GRADE < 0 OR :NEW.ENR_GRADE > 100 THEN
            :NEW.ENR_GRADE := 0;
        END IF;
                                       -- :OLD.실제ENROL테이블의 속성이름을 가져온다.  
        INSERT INTO ENROL_LOG          -- :NEW.실제ENROL테이블의 속성이름을 가져온다.                                 --현재 접속중인 아이디를 가져오는 문법
        VALUES(:NEW.SUB_NO, :NEW.STU_NO, :NEW.ENR_GRADE, :NEW.ENR_GRADE, SYS_CONTEXT('USERENV','SESSION_USER'), 'I', SYSDATE); --INSERT를 I로 넣기
    ELSIF UPDATING THEN             
        IF :NEW.ENR_GRADE < 0 OR :NEW.ENR_GRADE > 100 THEN
            RAISE_APPLICATION_ERROR(-20003,'점수는 0~100사이입니다.');
        END IF;
        
        INSERT INTO ENROL_LOG
        VALUES(:NEW.SUB_NO, :NEW.STU_NO, :OLD.ENR_GRADE, :NEW.ENR_GRADE, SYS_CONTEXT('USERENV','SESSION_USER'), 'U', SYSDATE);
        
    ELSIF DELETING THEN
        RAISE_APPLICATION_ERROR(-20003, '삭제할수없습니다.');
    END IF;
END;
/
--
SELECT * FROM ENROL_LOG;
--
UPDATE ENROL
SET ENR_GRADE = 33
WHERE STU_NO = 20153075 AND SUB_NO = 101;
--
UPDATE ENROL
SET ENR_GRADE = 200
WHERE STU_NO = 20153075 AND SUB_NO = 101;
--
SELECT * FROM ENROL
ORDER BY SUB_NO;
--
INSERT INTO ENROL
VALUES(101, 20153075, 99); 
--
DELETE FROM ENROL
WHERE SUB_NO = 101 AND STU_NO = 20153075;
--
SELECT *
FROM ENROL;
--
SELECT *
FROM ENROL_LOG;
