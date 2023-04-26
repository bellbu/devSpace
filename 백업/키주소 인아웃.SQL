       PROCEDURE SP_KEY_ADDRESS_CREATE(
                                         P_CORP_CODE            VARCHAR2 --법인코드
                                        ,P_UPJANG_CODE          VARCHAR2
                                        ,P_SALE_DATE            VARCHAR2   
                                        ,P_EMP_NO           VARCHAR2
                                        ,P_EMP_IP           VARCHAR2   
                                        ,O_KEY_ADDRESS    IN OUT VARCHAR2     -- 생성된 키주소 값
                                        ,O_RESULT         IN OUT VARCHAR2     -- 결과값[성공:1 오류:0]
                                        ,O_MSG            IN OUT VARCHAR2     -- 오류MSG
                                       )
        IS

          V_KEY_ADDRESS VARCHAR2(20);
                
        BEGIN
        
           O_RESULT := '0';

            SELECT  P_CORP_CODE||P_UPJANG_CODE||P_SALE_DATE||LPAD(NVL(COUNT(SALE_DATE)+1,1),4,'0') INTO V_KEY_ADDRESS
            FROM GFH01M
            WHERE CORP_CODE     = P_CORP_CODE
            AND   UPJANG_CODE   = P_UPJANG_CODE
            AND   SALE_DATE     = P_SALE_DATE
            ;
                                        
                        
            
            INSERT INTO GFH01M (
                   CORP_CODE
                  ,UPJANG_CODE
                  ,SALE_DATE
                  ,KEY_ADDRESS
                  ,INS_EMP_NO
                  ,INS_DATE
                  ,INS_IP
                           )
            VALUES (
                   P_CORP_CODE
                  ,P_UPJANG_CODE
                  ,P_SALE_DATE
                  ,V_KEY_ADDRESS
                  ,P_EMP_NO
                  ,SYSDATE
                  ,P_EMP_IP
             );
    
        O_RESULT := '1';
        O_KEY_ADDRESS := V_KEY_ADDRESS;

        EXCEPTION
        WHEN OTHERS THEN
            BEGIN
                O_MSG := SQLERRM;
                DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                RETURN;
            END;

        END;