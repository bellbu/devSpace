헤드

            -- 등록                   
            PROCEDURE SP_INSERT(
                                 P_CORP_CODE    VARCHAR2 
                                ,P_USER_ID      VARCHAR2
                                ,P_GRADE_DATE   VARCHAR2
                                ,P_SCHOOL_CODE  VARCHAR2
                                ,P_KOREAN       VARCHAR2
                                ,P_MATH         VARCHAR2
                                ,P_ENG          VARCHAR2
                                ,P_ETC          VARCHAR2
                                ,P_INS_EMP_NO   VARCHAR2
                                ,P_INS_IP       VARCHAR2
                                ,O_RESULT       IN OUT VARCHAR2     -- 목록,상세조회 정보 
                                ,O_MSG          IN OUT VARCHAR2     -- 오류MSG
                                );                                                         
                                
             -- 수정                               
            PROCEDURE SP_UPDATE(
                                 P_CORP_CODE    VARCHAR2 
                                ,P_USER_ID      VARCHAR2
                                ,P_sGRADE_DATE   VARCHAR2
                                ,P_GRADE_DATE   VARCHAR2
                                ,P_SCHOOL_CODE  VARCHAR2
                                ,P_KOREAN       VARCHAR2
                                ,P_MATH         VARCHAR2
                                ,P_ENG          VARCHAR2
                                ,P_ETC          VARCHAR2
                                ,P_UPD_EMP_NO   VARCHAR2
                                ,P_UPD_IP       VARCHAR2
                                ,O_RESULT       IN OUT VARCHAR2     -- 목록,상세조회 정보 
                                ,O_MSG          IN OUT VARCHAR2     -- 오류MSG
                                    );  
                                    
                                                                                      
             -- 삭제 
            PROCEDURE SP_DELETE(
                                 P_CORP_CODE    VARCHAR2 
                                ,P_USER_ID      VARCHAR2
                                ,P_sGRADE_DATE   VARCHAR2
                                ,P_SCHOOL_CODE  VARCHAR2
                                ,O_RESULT       IN OUT VARCHAR2     -- 목록,상세조회 정보 
                                ,O_MSG          IN OUT VARCHAR2     -- 오류MSG
                                );       
                                                           




바디

                    
        -- 등록
        PROCEDURE SP_INSERT(
                             P_CORP_CODE    VARCHAR2 
                            ,P_USER_ID      VARCHAR2
                            ,P_GRADE_DATE   VARCHAR2
                            ,P_SCHOOL_CODE  VARCHAR2
                            ,P_KOREAN       VARCHAR2
                            ,P_MATH         VARCHAR2
                            ,P_ENG          VARCHAR2
                            ,P_ETC          VARCHAR2
                            ,P_INS_EMP_NO   VARCHAR2
                            ,P_INS_IP       VARCHAR2
                            ,O_RESULT       IN OUT VARCHAR2     -- 목록,상세조회 정보 
                            ,O_MSG          IN OUT VARCHAR2     -- 오류MSG
                            )
        IS
        
        P_CNT NUMBER;
            
        BEGIN
        
            O_RESULT := '0';
            
            -- 빈값 유효성 체크
            IF P_GRADE_DATE IS NULL THEN
                O_MSG := '시험날짜가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
                
            IF P_KOREAN IS NULL THEN
                O_MSG := '국어 점수가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
            
            IF P_MATH IS NULL THEN
                O_MSG := '수학 점수가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
            
            IF P_ENG IS NULL THEN
                O_MSG := '영어 점수가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
            
            IF P_ETC IS NULL THEN
                O_MSG := '예체능 점수가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
                        
            --시험날짜 중복 유효성 체크          
            SELECT COUNT(*) INTO P_CNT
            FROM OJT01D
            WHERE CORP_CODE = P_CORP_CODE
            AND USER_ID = P_USER_ID
            AND GRADE_DATE = REPLACE(P_GRADE_DATE,'-','')
            ;
        
            IF P_CNT <> 0 THEN
                O_MSG := '해당 시험날짜에 성적이 존재합니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;    
        
            INSERT INTO OJT01D (
                                CORP_CODE
                                ,USER_ID
                                ,SCHOOL_CODE
                                ,KOREAN
                                ,MATH
                                ,ENG
                                ,ETC
                                ,INS_EMP_NO
                                ,INS_DATE
                                ,INS_IP
                                ,GRADE_DATE
                           ) 
            VALUES ( 
                    P_CORP_CODE,
                    P_USER_ID,
                    P_SCHOOL_CODE,
                    P_KOREAN,
                    P_MATH,
                    P_ENG,
                    P_ETC,
                    P_INS_EMP_NO,
                    SYSDATE,
                    P_INS_IP,
                    REPLACE(P_GRADE_DATE,'-','')
             );             

            O_RESULT := '1';
            
        EXCEPTION                               
        WHEN OTHERS THEN   
            BEGIN
                O_MSG := SQLERRM;
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END;
       
        END;        
        
        
        
         -- 수정
        PROCEDURE SP_UPDATE(
                             P_CORP_CODE    VARCHAR2 
                            ,P_USER_ID      VARCHAR2
                            ,P_sGRADE_DATE   VARCHAR2
                            ,P_GRADE_DATE   VARCHAR2
                            ,P_SCHOOL_CODE  VARCHAR2
                            ,P_KOREAN       VARCHAR2
                            ,P_MATH         VARCHAR2
                            ,P_ENG          VARCHAR2
                            ,P_ETC          VARCHAR2
                            ,P_UPD_EMP_NO   VARCHAR2
                            ,P_UPD_IP       VARCHAR2
                            ,O_RESULT       IN OUT VARCHAR2     -- 목록,상세조회 정보 
                            ,O_MSG          IN OUT VARCHAR2     -- 오류MSG
                            )
        IS
        
        P_CNT NUMBER;
                        
        BEGIN
    
            O_RESULT := '0';
            
            -- 빈값 유효성 체크
            IF P_GRADE_DATE IS NULL THEN
                O_MSG := '시험날짜가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
                
            IF P_KOREAN IS NULL THEN
                O_MSG := '국어 점수가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
            
            IF P_MATH IS NULL THEN
                O_MSG := '수학 점수가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
            
            IF P_ENG IS NULL THEN
                O_MSG := '영어 점수가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
            
            IF P_ETC IS NULL THEN
                O_MSG := '예체능 점수가 입력되지 않았습니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;
            
            -- 시험날짜 중복 유효성 체크
            IF REPLACE(P_sGRADE_DATE,'-','') <> REPLACE(P_GRADE_DATE,'-','') THEN
                SELECT COUNT(*) INTO P_CNT
                FROM OJT01D
                WHERE 
                        CORP_CODE = P_CORP_CODE 
                        AND USER_ID = P_USER_ID 
                        AND GRADE_DATE = REPLACE(P_GRADE_DATE,'-','');
            END IF;            
        
            IF P_CNT <> 0 THEN
                O_MSG := '해당 시험날짜에 성적이 존재합니다.';
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END IF;                

            UPDATE OJT01D
            SET    
                   GRADE_DATE = REPLACE(P_GRADE_DATE,'-',''),
                   KOREAN = P_KOREAN,
                   MATH = P_MATH,
                   ENG = P_ENG,
                   ETC = P_ETC,
                   UPD_EMP_NO = P_UPD_EMP_NO,
                   UPD_DATE = SYSDATE,
                   UPD_IP = P_UPD_IP
            WHERE CORP_CODE = P_CORP_CODE
            AND USER_ID = P_USER_ID
            AND GRADE_DATE = REPLACE(P_sGRADE_DATE,'-','')
            ;
                     
            O_RESULT := '1';
                
        EXCEPTION                               
        WHEN OTHERS THEN   
                BEGIN
                    O_MSG := SQLERRM;
                    DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                    RETURN;
                END;
           
        END;            
        
        
        
        -- 삭제         
        PROCEDURE SP_DELETE(
                            P_CORP_CODE    VARCHAR2 
                            ,P_USER_ID      VARCHAR2
                            ,P_sGRADE_DATE   VARCHAR2
                            ,P_SCHOOL_CODE  VARCHAR2
                            ,O_RESULT       IN OUT VARCHAR2     -- 목록,상세조회 정보 
                            ,O_MSG          IN OUT VARCHAR2     -- 오류MSG
                            )
        IS
                
        BEGIN
        
            O_RESULT := '0';
            
                        
            DELETE FROM OJT01D 
            WHERE CORP_CODE = P_CORP_CODE                      
            AND USER_ID = P_USER_ID
            AND (GRADE_DATE = REPLACE(P_sGRADE_DATE,'-','') OR GRADE_DATE IS NULL)                  
            ; 
        
            O_RESULT := '1';
                
        EXCEPTION                               
        WHEN OTHERS THEN   
            BEGIN
                O_MSG := SQLERRM;
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END;
           
        END;   