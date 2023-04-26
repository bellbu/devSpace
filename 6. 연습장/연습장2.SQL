            SELECT 
                  T1.CORP_CODE
                 ,T1.SEX AS LOCKER_TYPE  
                 ,T1.KEY_NO AS LOCKER_KEY -- 락카번호
                 ,T1.UPJANG_CODE
                 ,T1.STATUS_CODE AS LOCKER_STAT -- 락카상태
                 ,T3.REMARK
                 ,T3.SEQ_NO
                 ,T3.GUEST_NO 
                 ,T3.GUEST_NAME -- 사용자
                 ,T3.ST_DATE    -- 시작일자
                 ,T3.ED_DATE    -- 종료일자
                 ,T3.USE_YN     -- 사용상태                      
            FROM GFH01S T1,
                        (SELECT 
                             KEY_NO LKEY 
                            ,GUEST_NO
                            ,SEQ_NO
                            ,GUEST_NAME                         
                            ,ST_DATE                                 
                            ,ED_DATE
                            ,REMARK
                            ,USE_YN
                        FROM GFH01D
                        WHERE CORP_CODE = P_CORP_CODE
                        AND (REPLACE(P_USE_DATE,'-','') IS NULL OR REPLACE(P_USE_DATE,'-','') BETWEEN ST_DATE AND ED_DATE)) T3
            WHERE T1.CORP_CODE = P_CORP_CODE
            AND T1.KEY_NO = T3.LKEY(+)
            AND (P_LOCKER_KEY IS NULL OR T1.KEY_NO LIKE '%' || P_LOCKER_KEY || '%')
            AND (P_LOCKER_TYPE IS NULL OR ( T1.SEX = P_LOCKER_TYPE ))
            AND SUBSTR(T1.KEY_NO,1,1) BETWEEN '0' AND '9'
            AND T1.UPJANG_CODE = P_UPJANG_CODE
            ORDER BY LOCKER_KEY ASC;     






          SELECT 
                  T1.CORP_CODE
                 ,T1.LOCKER_KEY
                 ,T1.LOCKER_TYPE
                 ,DECODE( T2.LKEY, NULL, T1.LOCKER_STAT , '002'  ) LOCKER_STAT
                 ,T3.REMARK
                 ,T3.SEQ_NO
                 ,T3.GUEST_NO
                 ,T3.GUEST_NAME
                 ,T3.ST_DATE
                 ,T3.ED_DATE  
                 ,T3.use_yn                       
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
            AND T1.LOCKER_KEY = T2.LKEY(+)
            AND T1.LOCKER_KEY = T3.LKEY(+)
            AND (P_LOCKER_KEY IS NULL OR T1.LOCKER_KEY LIKE '%' || P_LOCKER_KEY || '%')
            AND (P_LOCKER_TYPE IS NULL OR ( T1.LOCKER_TYPE = P_LOCKER_TYPE ))
            AND SUBSTR(T1.LOCKER_KEY,1,1) BETWEEN '0' AND '9'
            ORDER BY LOCKER_KEY ASC;      