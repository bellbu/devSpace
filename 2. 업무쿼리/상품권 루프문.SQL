/******************************************************************************
   NAME:       SP_GIFT_ALL_UPDATE
   PURPOSE:     패키지 상품 옵션 수정

   REVISIONS:
   VER        DATE        AUTHOR           DESCRIPTION
   ---------  ----------  ---------------  ------------------------------------
   1.0        2022-02-24      이동환       최초생성
   1.1        2022-12-13      김종부       RBA01M 테이블 조인(CCI_DATE) 
  ******************************************************************************/                        
    PROCEDURE SP_GIFT_ALL_UPDATE (
        P_CORP_CODE             VARCHAR2,
        P_GIFT_CODE             VARCHAR2,
        P_GIFT_NO               VARCHAR2,
        P_GIFT_ST_NO               VARCHAR2,
        P_GIFT_ED_NO               VARCHAR2,
        P_EMP_NO                VARCHAR2,
        P_EMP_IP                VARCHAR2,
        O_RESULT                IN OUT VARCHAR2, 
        O_MSG                   IN OUT VARCHAR2         
    )IS 
    
     V_CNT NUMBER(10) ;
     
    BEGIN
    
    O_RESULT :='0';
    
    SELECT COUNT(*) INTO V_CNT 
    FROM BSA16D A LEFT JOIN RBA01M B ON A.CORP_CODE = B.CORP_CODE  --CCI DATE 조인
                                     AND A.GIFT_NO = B.PKG_NO     
    --WHERE USE_YN = 'N'      --테스트를 위해서 주석처리(현재 데이터 모두 Y 상태)
    WHERE (A.CORP_CODE = P_CORP_CODE AND A.GIFT_STATUS <> '5' AND A.GIFT_NO BETWEEN REPLACE(P_GIFT_ST_NO,'-','') AND REPLACE(P_GIFT_ED_NO,'-','') AND A.GIFT_CODE = P_GIFT_CODE)
    OR (A.CORP_CODE = P_CORP_CODE AND A.GIFT_STATUS = '5' AND (NVL(A.SALE_AMT,0) - NVL(A.USE_AMT,0)) <> '0' AND B.CCI_DATE IS NULL AND GIFT_NO BETWEEN REPLACE(P_GIFT_ST_NO,'-','') AND REPLACE(P_GIFT_ED_NO,'-','') AND A.GIFT_CODE = P_GIFT_CODE)
    ;
    
    
    IF V_CNT = 0 THEN 
        O_MSG:= '변경할 상품권이 없습니다';
        RETURN ;
    END IF;
    
    
    DECLARE CURSOR V_LIST IS
    
        SELECT A.CORP_CODE, A.GIFT_CODE, A.GIFT_NO    
        FROM BSA16D A LEFT JOIN RBA01M B ON A.CORP_CODE = B.CORP_CODE  --CCI DATE 조인
                                         AND A.GIFT_NO = B.PKG_NO     
        --WHERE USE_YN = 'N'      --테스트를 위해서 주석처리(현재 데이터 모두 Y 상태)
        WHERE (A.CORP_CODE = P_CORP_CODE AND A.GIFT_STATUS <> '5' AND A.GIFT_NO BETWEEN REPLACE(P_GIFT_ST_NO,'-','') AND REPLACE(P_GIFT_ED_NO,'-','') AND A.GIFT_CODE = P_GIFT_CODE)
        OR (A.CORP_CODE = P_CORP_CODE AND A.GIFT_STATUS = '5' AND (NVL(A.SALE_AMT,0) - NVL(A.USE_AMT,0)) <> '0' AND B.CCI_DATE IS NULL AND GIFT_NO BETWEEN REPLACE(P_GIFT_ST_NO,'-','') AND REPLACE(P_GIFT_ED_NO,'-','') AND A.GIFT_CODE = P_GIFT_CODE)
        ;
        
    BEGIN
    
           FOR V_CUR IN V_LIST LOOP
           
            DBMS_OUTPUT.PUT_LINE('V_CUR : ' || V_CUR.GIFT_CODE);

              UPDATE BSA16D A
              SET ( 
                     A.VALID_ST_DATE    
                    ,A.VALID_ED_DATE   
                    ,A.SALES_DIV_CODE  
                    ,A.ADV_COUNT_CODE  
                    ,A.ADV_PAY_CODE    
                    ,A.ONE_TIME_YN     
                    ,A.PROPERTY_TAX_YN 
                    ,A.ONLINE_USE_YN
                    ,A.SALE_MEMO
                    ,A.UPD_EMP_NO      
                    ,A.UPD_DATE        
                    ,A.UPD_IP          
             
              ) = ( SELECT 
                     B.VALID_ST_DATE    
                    ,B.VALID_ED_DATE   
                    ,B.SALES_DIV_CODE  
                    ,B.ADV_COUNT_CODE  
                    ,B.ADV_PAY_CODE    
                    ,B.ONE_TIME_YN     
                    ,B.PROPERTY_TAX_YN
                    ,B.ONLINE_USE_YN
                    ,B.SALE_MEMO 
                    ,B.UPD_EMP_NO      
                    ,B.UPD_DATE        
                    ,B.UPD_IP          
                    FROM BSA16D B
                    WHERE CORP_CODE = P_CORP_CODE
                    AND GIFT_CODE = P_GIFT_CODE
                    AND REPLACE(GIFT_NO,'','-') = REPLACE(P_GIFT_NO,'-','')
                  )     
              WHERE A.CORP_CODE = V_CUR.CORP_CODE
              AND A.GIFT_CODE = V_CUR.GIFT_CODE
              AND A.GIFT_NO = V_CUR.GIFT_NO    
              ;     
            
           END LOOP;
           
    END;   


    01 2308 20230208 0015 시퀀스