           PROCEDURE SP_INSERT2(
                    P_CORP_CODE            VARCHAR2,
                    P_SALE_DATE            VARCHAR2,
                    P_UPJANG_CODE          VARCHAR2,
                    P_KEY_ADDRESS          VARCHAR2,
                    P_KEY_NO               VARCHAR2,
                    P_SEX                  VARCHAR2,
                    P_GUEST_NO             VARCHAR2,
                    P_MEM_NO               VARCHAR2,
                    P_GUEST_NAME           VARCHAR2,
                    P_RELATIVE_TYPE        VARCHAR2,
                    P_ROOM_NO              VARCHAR2,
                    P_ENT_DIV              VARCHAR2,
                    P_MENU_CODE            VARCHAR2,
                    P_SALE_AMT             VARCHAR2,
                    P_REMARKS              VARCHAR2,
                    P_SPA_YN               VARCHAR2,
                    P_GYM_YN               VARCHAR2,
                    P_PAY_KEY_NO           VARCHAR2,
                    P_ENTER_TIME           VARCHAR2,
                    P_EXIT_TIME            VARCHAR2,
                    P_EMP_NO               VARCHAR2,
                    P_INS_IP               VARCHAR2
                   ,O_KEYADDRESS           IN OUT VARCHAR2     -- 키주소 생성
                   ,O_RESULT               IN OUT VARCHAR2     -- 결과값[성공:1 오류:0]
                   ,O_MSG                  IN OUT VARCHAR2     -- 오류MSG
            )

            IS
            
                V_SEX         VARCHAR2(20);
                V_KEY_ADDRESS VARCHAR2(20);
                V_CHECK_CNT   NUMBER;

            BEGIN
            
                O_RESULT := '0';
                
                -- 락카 존재 여부 카운트
                SELECT COUNT(*) INTO V_CHECK_CNT
                FROM GFH01S -- 락카마스터(PK:업장코드, 키번호, 성별) 
                WHERE CORP_CODE = P_CORP_CODE
                AND UPJANG_CODE = P_UPJANG_CODE
                AND KEY_NO = P_KEY_NO;
                
                -- 존재하지 않는 경우
                IF V_CHECK_CNT = 0 THEN
                    O_MSG := '존재하지 않는 락카입니다.';
                    RETURN ;
                end if;
                
                -- 해당락카 성별 셀렉트
                SELECT SEX INTO V_SEX
                FROM GFH01S
                WHERE CORP_CODE = P_CORP_CODE
                AND KEY_NO = P_KEY_NO
                AND UPJANG_CODE = P_UPJANG_CODE;
                
                -- 키주소 검사
                IF P_KEY_ADDRESS IS NOT NULL THEN V_KEY_ADDRESS:=P_KEY_ADDRESS;
                ELSIF P_KEY_ADDRESS IS NULL THEN
                   SELECT  P_CORP_CODE||P_UPJANG_CODE||P_SALE_DATE||LPAD(NVL(COUNT(SALE_DATE)+1,1),4,'0') INTO V_KEY_ADDRESS
                        FROM GFH01M
                        WHERE CORP_CODE     = P_CORP_CODE
                        AND   UPJANG_CODE   = P_UPJANG_CODE
                        AND   SALE_DATE     = P_SALE_DATE
                    ;
                END IF;

                -- 정산확인 카운트
                SELECT COUNT(*) INTO V_CHECK_CNT
                FROM GFH02M
                WHERE CORP_CODE = P_CORP_CODE
                AND UPJANG_CODE = P_UPJANG_CODE
                AND SALE_DATE = P_SALE_DATE
                AND KEY_NO = P_KEY_NO
                AND SEX = V_SEX
                AND PAID_YN = 'N';

                IF V_CHECK_CNT > 0 THEN
                    O_MSG := '해당 락카키의 미정산된 내역이 있습니다.';
                    RETURN ;
                END IF;


                
                IF P_KEY_ADDRESS IS NULL THEN
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
                          ,P_INS_IP
                     );
                END IF;

                    INSERT INTO GFH02M (
                        CORP_CODE
                        ,UPJANG_CODE
                        ,SALE_DATE
                        ,KEY_ADDRESS
                        ,KEY_NO
                        ,SEX
                        ,GUEST_NO
                        ,MEM_NO
                        ,GUEST_NAME
                        ,RELATIVE_TYPE
                        ,ROOM_NO
                        ,ENT_DIV
                        ,MENU_CODE
                        ,SALE_AMT
                        ,REMARKS
                        ,SPA_YN
                        ,GYM_YN
                        ,PAY_KEY_NO
                        ,ENTER_TIME
                        ,INS_EMP_NO
                        ,INS_DATE
                        ,INS_IP
                        )
                    VALUES (
                        P_CORP_CODE
                        ,P_UPJANG_CODE
                        ,P_SALE_DATE
                        ,V_KEY_ADDRESS
                        ,P_KEY_NO
                        ,V_SEX
                        ,P_GUEST_NO
                        ,P_MEM_NO
                        ,P_GUEST_NAME
                        ,P_RELATIVE_TYPE
                        ,P_ROOM_NO
                        ,P_ENT_DIV
                        ,P_MENU_CODE
                        ,P_SALE_AMT
                        ,P_REMARKS
                        ,P_SPA_YN
                        ,P_GYM_YN
                        ,P_PAY_KEY_NO
                        ,TO_CHAR(SYSDATE,'HH24:MI')
                        ,P_EMP_NO
                        ,SYSDATE
                        ,P_INS_IP
                     );

                INSERT INTO GFH03M (
                                    CORP_CODE,
                                    UPJANG_CODE,
                                    KEY_ADDRESS,
                                    KEY_NO,
                                    SEX,
                                    SEQ_NO,
                                    MENU_CODE,
                                    SALE_QTY,
                                    SALE_AMT,
                                    MENU_TYPE,
                                    STAT_CODE,
                                    INS_EMP_NO,
                                    INS_DATE,
                                    INS_IP,
                                    UPD_EMP_NO,
                                    UPD_DATE,
                                    UPD_IP
                ) VALUES (
                                    P_CORP_CODE,
                                    P_UPJANG_CODE,
                                    V_KEY_ADDRESS,
                                    P_KEY_NO,
                                    V_SEX,
                                    (SELECT NVL(MAX(SEQ_NO), 0) + 1
                                       FROM GFH03M
                                       WHERE CORP_CODE = P_CORP_CODE
                                       AND   UPJANG_CODE = P_UPJANG_CODE
                                       AND   KEY_ADDRESS = V_KEY_ADDRESS
                                    ),
                                    P_MENU_CODE,
                                    1,
                                    P_SALE_AMT,
                                    '001',
                                    '001',
                                    P_EMP_NO,
                                    SYSDATE,
                                    P_INS_IP,
                                    P_EMP_NO,
                                    SYSDATE,
                                    P_INS_IP
                );

                O_RESULT := '1';
                O_KEYADDRESS := V_KEY_ADDRESS;

            EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    O_MSG := SQLERRM;
                    DBMS_OUTPUT.PUT_LINE('O_MSG : ' || O_MSG);
                    RETURN;
                END;

            END;