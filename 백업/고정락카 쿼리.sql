CREATE OR REPLACE PACKAGE BODY USERVE.PKG_LOCKERFIXPOP AS --PKG_ + 화면ID
/******************************************************************************

   NAME:       SP_SELECT
   PURPOSE:    고정락카사용등록 락카 조회

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2021-10-08      김정호       최초생성.
   1.1        2021-10-19      김대성       
******************************************************************************/

    PROCEDURE SP_SELECT(
                         P_CORP_CODE        VARCHAR2 
                        ,P_LOCKER_KEY       VARCHAR2
                        ,P_LOCKER_TYPE      VARCHAR2
                        ,P_USE_DATE         VARCHAR2
                        ,O_RESULTLIST                  OUT SYS_REFCURSOR     -- 목록,상세조회 정보 
                     )
    IS
        
    BEGIN
        OPEN O_RESULTLIST FOR
           SELECT 
                  T1.CORP_CODE   -- 순수락카
                 ,T1.LOCKER_KEY  -- 순수락카: 락카키
                 ,T1.LOCKER_TYPE -- 순수락카: 남자, 여자, 가상
                 ,DECODE( T2.LKEY, NULL, T1.LOCKER_STAT , '002'  ) LOCKER_STAT
                 ,T3.REMARK     -- 관리락카: 비고
                 ,T3.SEQ_NO     -- 관리락카 시퀀스
                 ,T3.GUEST_NO   -- -- 고정락카 고객번호
                 ,T3.GUEST_NAME -- 고정락카 고객명
                 ,T3.ST_DATE   -- 고정락카 시작일자
                 ,T3.ED_DATE   -- 고정락카 종료일자
                 ,T3.use_yn    -- 고정락카 사용여부                   
           FROM GBF01S T1
              ,( SELECT SUBSTR( LOCKER_KEY, 1, 3 ) LKEY
                     FROM GBA01D
                    WHERE CORP_CODE = P_CORP_CODE
                      AND BOOK_DATE = TO_CHAR( SYSDATE, 'YYYYMMDD' )
                      AND LOCKER_KEY_YN = 'N'
                 GROUP BY SUBSTR( LOCKER_KEY, 1, 3 )) T2,
                 (SELECT 
                         LOCKER_KEY LKEY 
                        ,GUEST_NO
                        ,SEQ_NO
                        ,GUEST_NAME                         
                        ,ST_DATE                                 
                        ,ED_DATE
                        ,REMARK
                        ,use_yn
                     FROM GBF01D
                    WHERE CORP_CODE = P_CORP_CODE
                      AND (REPLACE(P_USE_DATE,'-','') IS NULL OR REPLACE(P_USE_DATE,'-','') BETWEEN ST_DATE AND ED_DATE)) T3
          WHERE T1.CORP_CODE = P_CORP_CODE
            AND T1.LOCKER_KEY = T2.LKEY(+) -- 이너조인인데 왜 쓰는지??
            AND T1.LOCKER_KEY = T3.LKEY(+) 
            AND (P_LOCKER_KEY IS NULL OR T1.LOCKER_KEY LIKE '%' || P_LOCKER_KEY || '%')
            AND (P_LOCKER_TYPE IS NULL OR ( T1.LOCKER_TYPE = P_LOCKER_TYPE ))
            AND SUBSTR(T1.LOCKER_KEY,1,1) BETWEEN '0' AND '9' -- 숫자로 된 락카만 가져오기
            ORDER BY LOCKER_KEY ASC;      
              
         
    EXCEPTION                               
    WHEN OTHERS THEN   
        BEGIN
            RETURN;
        END;

    END;

/******************************************************************************

   NAME:       SP_SELECT_H
   PURPOSE:    고정락카사용등록 사용이력 조회

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2021-10-08      김정호       최초생성.
******************************************************************************/

    PROCEDURE SP_SELECT_H(
                         P_CORP_CODE     VARCHAR2 
                        ,P_LOCKER_KEY    VARCHAR2
                        ,O_RESULTLIST    OUT SYS_REFCURSOR     -- 목록,상세조회 정보 
                     )
    IS
        
    BEGIN
        OPEN O_RESULTLIST FOR

        SELECT 
            M.LOCKER_KEY,
            M.LOCKER_TYPE,
            M.LOCKER_STAT,
            D.SEQ_NO,
            D.GUEST_NO,
            GUEST_NAME,
            D.ST_DATE,
            D.ED_DATE,
            D.USE_YN,
            D.REMARK
        FROM GBF01D D LEFT OUTER JOIN GBF01S M 
                                   ON M.CORP_CODE = D.CORP_CODE
                                  AND M.LOCKER_KEY = D.LOCKER_KEY
--                                  AND D.USE_YN = 'Y'
        WHERE M.CORP_CODE = P_CORP_CODE
          AND M.LOCKER_KEY = P_LOCKER_KEY
        ORDER BY D.ST_DATE DESC;                
--        ORDER BY M.LOCKER_KEY ASC;                

         
    EXCEPTION                               
    WHEN OTHERS THEN   
        BEGIN
            RETURN;
        END;

    END;

/******************************************************************************

   NAME:       SP_INSERT_RENTSET
   PURPOSE:    고정락카사용등록 등록

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2021-10-08      김정호       최초생성.
******************************************************************************/
    PROCEDURE SP_INSERT(
                       P_CORP_CODE      VARCHAR2 
                      ,P_LOCKER_KEY    VARCHAR2
                      ,P_GUEST_NAME    VARCHAR2
                      ,P_GUEST_NO      VARCHAR2
                      ,P_ST_DATE       VARCHAR2
                      ,P_ED_DATE       VARCHAR2
                      ,P_REMARK        VARCHAR2
                      ,P_EMP_NO        VARCHAR2
                      ,P_EMP_IP        VARCHAR2
                      ,O_RESULT        IN OUT VARCHAR2     -- 결과값[성공:1 오류:0] 
                      ,O_MSG           IN OUT VARCHAR2     -- 오류MSG 
                     )
    IS
    CHK_USE_LOCKER_CNT NUMBER(3) := 0;  -- 기간 중 사용락카 카운트
    CHK_LOCKER_STAT_CNT NUMBER(3) := 0; -- 고장락카 카운트
    CHK_LOCKER_TYPE_CNT NUMBER(3) := 0;
    V_SEX VARCHAR2(10);

    V_LOCKER_STAT_NAME VARCHAR2(100); -- 고장락카 카운트 된 결과의 락카상태 이름
    
    ----------------------------
    --입력 PARAMETER
    ----------------------------
    IN_EXEC_PARAM       VARCHAR2(4000);
    
    BEGIN
        O_MSG    := '저장에 성공하였습니다.';
        O_RESULT := '0';
      
        -- 락카키 파라미터 비어있는 경우 메세지
        IF P_LOCKER_KEY IS NULL THEN
            O_RESULT := '0';
            O_MSG := '락카가 배정되지 않았습니다.'||CHR(13)||'락카 배정 후 고정락카 등록이 가능합니다.';
            RETURN;
        END IF;


            ----------------------------
            --락카상태 확인
            ----------------------------
            BEGIN
               -- 고정락카 등록 전 고장 락카 카운트
               SELECT COUNT(*), get_commcode(P_CORP_CODE,'GB106',MAX(LOCKER_STAT))
                      INTO   CHK_LOCKER_STAT_CNT , V_LOCKER_STAT_NAME
                 FROM GBF01S -- LOCKER_TYPE 타입(GB105): 001(남자), 002(여자), 003(가상) / LOCKER_STAT 상태(GB106): 001:사용가능, 002:고장(수리중), 003:불량(미사용) / REMARK 비고
                WHERE CORP_CODE       = P_CORP_CODE 
                  AND LOCKER_KEY      = P_LOCKER_KEY
                  AND NVL(LOCKER_STAT,'002') = '002';  -- 고장상태
                  
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    CHK_USE_LOCKER_CNT := 0;
                WHEN OTHERS THEN
                    O_RESULT         := '0';
                    O_MSG            := '[고정락카 사용등록]락카상태 확인중 에러가 발생하였습니다.(PKG_LockerFixPop.SP_INSERT)';
                    RETURN;
            END;
                        
            IF CHK_LOCKER_STAT_CNT > 0 THEN
                O_RESULT := '0';
                O_MSG    := '[고정락카 사용등록] '||P_LOCKER_KEY||' 락카는'||V_LOCKER_STAT_NAME
                    || ' 상태입니다. 확인해주세요[PKG_LockerFixPop.SP_INSERT]';
                RETURN;
            END IF;
            
        
            ----------------------------
            --해당락카 사용기간 확인
            ----------------------------
            BEGIN
               SELECT COUNT(*) INTO   CHK_USE_LOCKER_CNT
                 FROM GBF01D
                WHERE CORP_CODE       = P_CORP_CODE 
                  AND LOCKER_KEY      = P_LOCKER_KEY
                  AND ((REPLACE(P_ST_DATE,'-','') BETWEEN ST_DATE AND ED_DATE) OR (REPLACE(P_ED_DATE,'-','') BETWEEN ST_DATE AND ED_DATE))
                  AND NVL(USE_YN,'N') = 'Y';
                  
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    CHK_USE_LOCKER_CNT := 0;
                WHEN OTHERS THEN
                    O_RESULT         := '0';
                    O_MSG            := '[고정락카 사용등록]고정락카 사용기간 조회중 에러가 발생하였습니다.(PKG_LockerFixPop.SP_INSERT)';
                    RETURN;
            END;            

            IF CHK_USE_LOCKER_CNT > 0 THEN
                O_RESULT := '0';
                O_MSG    := '[고정락카 사용등록] 해당기간에 '
                    || ' 이미 사용등록된 락카입니다. 확인해주세요[PKG_LockerFixPop.SP_INSERT]';
                RETURN;
            END IF;
        
            INSERT INTO GBF01D (
                         CORP_CODE
                        ,LOCKER_KEY
                        ,SEQ_NO
                        ,GUEST_NAME  
                        ,GUEST_NO
                        ,ST_DATE
                        ,ED_DATE
                        ,USE_YN
                        ,REMARK
                        ,INS_EMP_NO 
                        ,INS_DATE
                        ,INS_IP
                        ) 
                        VALUES (
                         P_CORP_CODE 
                        ,P_LOCKER_KEY
                        ,(SELECT NVL(MAX(TO_NUMBER(SEQ_NO)),0)+1 FROM GBF01D WHERE CORP_CODE = P_CORP_CODE AND LOCKER_KEY = P_LOCKER_KEY)
                        ,P_GUEST_NAME
                        ,P_GUEST_NO
                        ,P_ST_DATE
                        ,P_ED_DATE
                        ,'Y'
                        ,P_REMARK
                        ,P_EMP_NO
                        ,SYSDATE
                        ,P_EMP_IP 
                         );             

        O_RESULT := '1';
        

        
    EXCEPTION                               
    WHEN OTHERS THEN   
        BEGIN
            O_MSG := SQLERRM;
            RETURN;
        END;

    END;


/******************************************************************************

   NAME:       SP_UPDATE_RENTSET
   PURPOSE:    고정락카사용등록 수정

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2021-10-08      김정호       최초생성.
******************************************************************************/
    PROCEDURE SP_UPDATE(
                       P_CORP_CODE     VARCHAR2 
                      ,P_LOCKER_KEY    VARCHAR2
                      ,P_SEQ_NO        VARCHAR2
                      ,P_GUEST_NAME    VARCHAR2
                      ,P_GUEST_NO      VARCHAR2
                      ,P_ST_DATE       VARCHAR2
                      ,P_ED_DATE       VARCHAR2
                      ,P_REMARK        VARCHAR2
                      ,P_EMP_NO        VARCHAR2
                      ,P_EMP_IP        VARCHAR2
                      ,O_RESULT        IN OUT VARCHAR2     -- 결과값[성공:1 오류:0] 
                      ,O_MSG           IN OUT VARCHAR2     -- 오류MSG 
                     )
    IS
    CHK_USE_LOCKER_CNT NUMBER(3) := 0;
        
    BEGIN
        O_MSG    := '저장에 성공하였습니다.';
        O_RESULT := '0';
        
            ----------------------------
            --해당락카 사용기간 확인
            ----------------------------
            BEGIN
               SELECT COUNT(*) INTO   CHK_USE_LOCKER_CNT
                 FROM GBF01D
                WHERE CORP_CODE       = P_CORP_CODE 
                  AND LOCKER_KEY      = P_LOCKER_KEY
                  AND ((REPLACE(P_ST_DATE,'-','') BETWEEN ST_DATE AND ED_DATE) OR (REPLACE(P_ED_DATE,'-','') BETWEEN ST_DATE AND ED_DATE))

                  AND NVL(USE_YN,'N') = 'Y'
                  AND SEQ_NO <> P_SEQ_NO;
                  
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    CHK_USE_LOCKER_CNT := 0;
                WHEN OTHERS THEN
                    O_RESULT         := '0';
                    O_MSG            := '[고정락카 사용등록]고정락카 사용기간 조회중 에러가 발생하였습니다.(PKG_LockerFixPop.SP_UPDATE)';
                    RETURN;
            END;            

            IF CHK_USE_LOCKER_CNT > 0 THEN
                O_RESULT := '0';
                O_MSG    := '[고정락카 사용등록] 해당기간에 '
                    || ' 이미 사용등록된 락카입니다. 확인해주세요[PKG_LockerFixPop.SP_UPDATE]';
                RETURN;
            END IF;
                    
        UPDATE GBF01D
        SET     CORP_CODE  = P_CORP_CODE
               ,GUEST_NAME = P_GUEST_NAME
               ,GUEST_NO   = P_GUEST_NO
               ,ST_DATE    = P_ST_DATE
               ,ED_DATE    = P_ED_DATE
               ,REMARK     = P_REMARK
               ,UPD_EMP_NO = P_EMP_NO
               ,UPD_DATE   = SYSDATE
               ,UPD_IP     = P_EMP_IP
        WHERE CORP_CODE   = P_CORP_CODE
          AND SEQ_NO      = P_SEQ_NO
          AND LOCKER_KEY  = P_LOCKER_KEY; 
             

        O_RESULT := '1';
        
    EXCEPTION                               
    WHEN OTHERS THEN   
        BEGIN
            O_MSG := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
            RETURN;
        END;

    END;


/******************************************************************************

   NAME:       SP_DELETE_RENTSET(
   PURPOSE:    고정락카사용등록 사용중지

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2021-10-08      김정호       최초생성
******************************************************************************/

    PROCEDURE SP_DELETE(
                       P_CORP_CODE     VARCHAR2
                      ,P_LOCKER_KEY    VARCHAR2    
                      ,P_SEQ_NO        VARCHAR2
                      ,P_EMP_NO        VARCHAR2
                      ,P_EMP_IP        VARCHAR2     
                      ,O_RESULT        IN OUT VARCHAR2     -- 결과값[성공:1 오류:0] 
                      ,O_MSG           IN OUT VARCHAR2     -- 오류MSG 
                     )
    IS
        
    BEGIN
        O_RESULT := '0';

        UPDATE GBF01D
        SET 
            USE_YN     = 'N'
           ,UPD_EMP_NO = P_EMP_NO
           ,UPD_DATE   = SYSDATE
           ,UPD_IP     = P_EMP_IP
        WHERE CORP_CODE  = P_CORP_CODE
          AND SEQ_NO    = P_SEQ_NO
          AND LOCKER_KEY = P_LOCKER_KEY; 

    O_RESULT := '1';
        
    EXCEPTION                               
    WHEN OTHERS THEN   
        BEGIN
            O_MSG := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
            RETURN;
        END;

    END;

END PKG_LockerFixPop;
/