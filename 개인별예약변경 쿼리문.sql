 PROCEDURE SP_MODIFY_LIST_SELECT(
            P_CORP_CODE                         VARCHAR2
           ,P_RESERV_NO             VARCHAR2
           ,P_RESERV_SEQ              VARCHAR2
           ,O_RESULTLIST                    OUT SYS_REFCURSOR   -- 목록,상세조회 정보
       )

   IS

   BEGIN


        SELECT 
            A.CORP_CODE        
            ,A.RESERV_NO        
            ,A.RESERV_SEQ    
            ,NVL(A.SEQ,1) SEQ   
            ,NVL(A.UPD_DATE,TO_CHAR(M.INS_DATE,'YYYY-MM-DD')) UPD_DATE
            ,NVL(A.UPD_TIME,TO_CHAR(M.INS_DATE,'HH24:MM')) UPD_TIME
            ,NVL(A.EMP_NAME,GET_EMP_NAME(M.CORP_CODE,M.INS_EMP_NO)) EMP_NAME
            ,NVL(A.MODIFY_TYPE_NAME,'신규')   MODIFY_TYPE_NAME
            ,NVL(A.MODIFY_REMARKS,'마스터예약 생성') AS MODIFY_REMARKS
        FROM RSC01M M 
            LEFT OUTER JOIN (
                SELECT  
                    CM.CORP_CODE
                    ,CM.RESERV_NO
                    ,CM.RESERV_SEQ
                    ,CM.SEQ
                    ,TO_CHAR(CM.UPD_DATE,'YYYY-MM-DD') UPD_DATE
                    ,TO_CHAR(CM.UPD_DATE,'HH24:MI') UPD_TIME
                    ,CASE WHEN CM.HISTORY_MODE = 'C' THEN
                    NVL(GET_EMP_NAME(CM.CORP_CODE,CM.INS_EMP_NO),CM.INS_EMP_NO)
                        WHEN CM.HISTORY_MODE = 'U' THEN
                    NVL(GET_EMP_NAME(CM.CORP_CODE,CM.UPD_EMP_NO),CM.INS_EMP_NO)
                    END AS EMP_NAME
                    ,CASE WHEN CM.HISTORY_MODE = 'C' THEN '신규'
                        WHEN CM.HISTORY_MODE = 'U' THEN '수정'
                    END AS MODIFY_TYPE_NAME
                    ,RTRIM(NVL(CASE WHEN CM.HISTORY_MODE = 'C' THEN '마스터예약 생성' /*신규*/  ELSE /*수정*/
                                CASE
                                    WHEN CM.GSC_NAME            <> CH.GSC_NAME       THEN '투숙객명'        ||' 변경 : '||  CH.GSC_NAME            ||'-->'|| CM.GSC_NAME   ||' , '      
                                END ||
                                CASE 
                                -- WHEN CM.RESERV_STATUS        <> CH.RESERV_STATUS       THEN '예약상태'        ||' 변경 : '||  CH.RESERV_STATUS     ||'-->'|| CM.RESERV_STATUS    
                                    WHEN CM.UPJANG_CODE             <> CH.UPJANG_CODE     THEN '영업장 코드'      ||' 변경 : '||  GET_COMMCODE(CH.CORP_CODE,'RS002',CM.UPJANG_CODE)	||'-->'||GET_COMMCODE(CM.CORP_CODE,'RS002',CH.UPJANG_CODE) ||' , ' --RS002 ||' , '
                                END ||
                                CASE 
                                    WHEN CM.ROOM_TYPE           <> CH.ROOM_TYPE          THEN '객실타입' ||' 변경 : '||         CH.ROOM_TYPE        ||'-->'|| CM.ROOM_TYPE    ||' , '     --(RB003)
                                END ||
                                CASE 
                                    WHEN CM.CCI_DATE            <> CH.CCI_DATE       THEN '입실일'         ||' 변경 : '||   TO_CHAR(TO_DATE(CH.CCI_DATE,'YYYYMMDD'),'YYYY-MM-DD')          ||'-->'||   TO_CHAR(TO_DATE(CM.CCI_DATE,'YYYYMMDD'),'YYYY-MM-DD') ||' , '               
                                END ||
                                CASE 
                                    WHEN CM.CCO_DATE            <> CH.CCO_DATE       THEN '퇴실일'         ||' 변경 : '||   TO_CHAR(TO_DATE(CH.CCO_DATE,'YYYYMMDD'),'YYYY-MM-DD')||'-->'||  TO_CHAR(TO_DATE(CM.CCO_DATE,'YYYYMMDD'),'YYYY-MM-DD') ||' , '        
                                END ||
                                CASE 
                                    WHEN CM.GSC_TEL_NO          <> CH.GSC_TEL_NO      THEN '투숙객연락처'      ||' 변경 : '||   CH.GSC_TEL_NO          ||'-->'|| CM.GSC_TEL_NO       ||' , ' 
                                END ||
                                CASE 
                                    WHEN CM.STAYIN_DAY_CNT       <> CH.STAYIN_DAY_CNT   THEN '숙박일수'        ||' 변경 : '||   CH.STAYIN_DAY_CNT       ||'-->'|| CM.STAYIN_DAY_CNT   ||' , '  
                                END ||
                                CASE
                                    WHEN CM.RESERV_DATE             <> CH.RESERV_DATE     THEN '수정일자'        ||' 변경 : '||   CH.RESERV_DATE         ||'-->'|| CM.RESERV_DATE   ||' , '
                                END ||
                                CASE 
                                    WHEN CM.RATE_CODE           <> CH.RATE_CODE          THEN '요금구분'        ||' 변경 : '||   CH.RATE_CODE       ||'-->'|| CM.RATE_CODE      ||' , '  
                                END ||
                                CASE 
                                    WHEN CM.ACTUAL_RATE             <> CH.ACTUAL_RATE     THEN '실 요금'        ||' 변경 : '||   CH.ACTUAL_RATE         ||'-->'|| CM.ACTUAL_RATE    ||' , '    
                                END ||
                                CASE 
                                    WHEN CM.DC_CODE                 <> CH.DC_CODE        THEN '할인금액'        ||' 변경 : '||   CH.DC_CODE             ||'-->'|| CM.DC_CODE  ||' , '        
                                END ||
                                CASE 
                                    WHEN CM.DC_VALUE            <> CH.DC_VALUE       THEN '할인율'         ||' 변경 : '||   CH.DC_VALUE        ||'-->'|| CM.DC_VALUE   ||' , '       
                                END ||
                                CASE 
                                    WHEN CM.STAYIN_ADULT         <> CH.STAYIN_ADULT    THEN '성인 인원수'      ||' 변경 : '||   CH.STAYIN_ADULT        ||'-->'|| CM.STAYIN_ADULT    ||' , '  
                                END ||
                                CASE 
                                    WHEN CM.STAYIN_CHILD         <> CH.STAYIN_CHILD    THEN '아동 인원수'      ||' 변경 : '||   CH.STAYIN_CHILD        ||'-->'|| CM.STAYIN_CHILD  ||' , '    
                                END ||
                                CASE 
                                    WHEN CM.SOURCE_CODE             <> CH.SOURCE_CODE     THEN '유입구분'        ||' 변경 : '||   CH.SOURCE_CODE         ||'-->'|| CM.SOURCE_CODE    ||' , '   
                                END ||
                                CASE
                                    WHEN NVL(CM.PKG_NO,'없음')             <> NVL(CH.PKG_NO,'없음')        THEN '패키지번호'       ||' 변경 : '||   NVL(CH.PKG_NO,'없음')              ||'-->'|| NVL(CM.PKG_NO,'없음')     ||' , '
                                END ||
                                CASE 
                                    WHEN CM.DHC_TYPE            <> CH.DHC_TYPE       THEN 'DHC구분(RB006)'||' 변경 : '||   CH.DHC_TYPE        ||'-->'|| CM.DHC_TYPE   ||' , '       
                                END ||
                                CASE 
                                    WHEN CM.REMARKS                 <> CH.REMARKS        THEN '예약메모'        ||' 변경 : '||   CH.REMARKS            ||'-->'|| CM.REMARKS       ||' , '   
                                END ||
                                CASE 
                                    WHEN CM.RELATIVE_TYPE        <> CH.RELATIVE_TYPE       THEN '관계사구분'       ||' 변경 : '||  GET_COMMCODE(CH.CORP_CODE,'BT001',CH.RELATIVE_TYPE)  ||'-->'|| GET_COMMCODE(CM.CORP_CODE,'BT001',CM.RELATIVE_TYPE)  ||' , '     
                                END ||
                                CASE 
                                    WHEN CM.BITO_SPA_TYPE        <> CH.BITO_SPA_TYPE       THEN '비토-온천구분'     ||' 변경 : '||   GET_COMMCODE(CH.CORP_CODE,'SP002',CH.BITO_SPA_TYPE)     ||'-->'|| GET_COMMCODE(CM.CORP_CODE,'SP002',CM.BITO_SPA_TYPE)   ||' , '   
                                END ||
                                CASE 
                                    WHEN CM.BITO_SPA_REMARK          <> CH.BITO_SPA_REMARK  THEN '비토 온천 비고'    ||' 변경 : '||   CH.BITO_SPA_REMARK      ||'-->'|| CM.BITO_SPA_REMARK    ||' , '
                                END ||
                                CASE 
                                    WHEN CM.STAYIN_CHILD_DATA     <> CH.STAYIN_CHILD_DATA    THEN '소인년생 배열'     ||' 변경 : '||   CH.STAYIN_CHILD_DATA ||'-->'|| CM.STAYIN_CHILD_DATA  ||' , '
                                END ||
                                CASE 
                                    WHEN CM.ROOM_ONLY_YN     <> CH.ROOM_ONLY_YN    THEN '룸온니여부'     ||' 변경 : '||   CH.ROOM_ONLY_YN ||'-->'|| CM.ROOM_ONLY_YN  ||' , '
                                END 
                    END,'수정사항 X'),' , ') AS MODIFY_REMARKS
                FROM RSC01H CM
                    LEFT OUTER JOIN RSC01H CH 
                        ON CM.CORP_CODE  = CH.CORP_CODE 
                            AND    CM.RESERV_NO  = CH.RESERV_NO
                            AND    CM.RESERV_SEQ = CH.RESERV_SEQ
                            AND    CM.SEQ  = (SELECT MIN(SEQ) FROM RSC01H WHERE RESERV_NO = CH.RESERV_NO AND RESERV_SEQ = CH.RESERV_SEQ AND SEQ >CH.SEQ) --시퀀스가 1씩 증가하지 않는 경우도 있어서 SEQ+1 로 처리하지않음
                WHERE CM.RESERV_NO = P_RESERV_NO 
                AND CM.RESERV_SEQ = P_RESERV_SEQ
            ) A ON M.CORP_CODE  = A.CORP_CODE
                AND    M.RESERV_NO  = A.RESERV_NO
                AND    M.RESERV_SEQ = A.RESERV_SEQ
        WHERE M.RESERV_NO = P_RESERV_NO 
        AND M.RESERV_SEQ = P_RESERV_SEQ

            UNION ALL

        SELECT 
                AM.CORP_CODE
                ,AM.RESERV_NO
                ,AM.RESERV_SEQ
                ,AM.SEQ
                ,NVL(TO_CHAR(AM.UPD_DATE,'YYYY-MM-DD'),TO_CHAR(AM.INS_DATE,'YYYY-MM-DD')) UPD_DATE
                ,NVL(TO_CHAR(AM.UPD_DATE,'HH24:MI'),TO_CHAR(AM.INS_DATE,'HH24:MI')) UPD_TIME
                ,CASE WHEN AM.HISTORY_MODE = 'C' THEN
                    NVL(GET_EMP_NAME(AM.CORP_CODE,AM.INS_EMP_NO),AM.INS_EMP_NO)
                        WHEN AM.HISTORY_MODE = 'U' THEN
                    NVL(GET_EMP_NAME(AM.CORP_CODE,AM.UPD_EMP_NO),AM.INS_EMP_NO)
                    END
                AS EMP_NAME
                ,CASE WHEN AM.HISTORY_MODE = 'C' THEN '신규'
                    WHEN AM.HISTORY_MODE = 'U' THEN '수정'
                END  MODIFY_TYPE_NAME
                ,RTRIM(NVL(CASE WHEN AM.HISTORY_MODE = 'C' THEN '마스터예약 생성' ELSE
                            CASE 
                                WHEN AM.BOOK_DATE		     <> AH.BOOK_DATE		 THEN '예약일자 변경 : '||         TO_CHAR(TO_DATE(AH.BOOK_DATE,'YYYYMMDD'),'YYYY-MM-DD')	||'-->'||TO_CHAR(TO_DATE(AM.BOOK_DATE,'YYYYMMDD'),'YYYY-MM-DD') ||' , '
                            END ||
                            CASE    
                                WHEN AM.COSE				 <> AH.COSE			     THEN '코스 변경 : '||           GET_COMMCODE(AH.CORP_CODE,'RS511',AH.COSE)			        ||'-->'||GET_COMMCODE(AM.CORP_CODE,'RS511',AM.COSE) ||' , '		
                            END ||
                            CASE    
                                WHEN AM.TIME				 <> AH.TIME			     THEN '시간 변경 : '||           SUBSTR(AH.TIME,1,2) ||':'||SUBSTR(AH.TIME,3,2)			    ||'-->'|| SUBSTR(AM.TIME,1,2) ||':'||SUBSTR(AM.TIME,3,2) ||' , '	
                            END ||
                            CASE    
                                WHEN AM.TEAM_MEM_CNT		 <> AH.TEAM_MEM_CNT		 THEN '예약팀 인원수 변경 : '|| 	    AH.TEAM_MEM_CNT			                                ||'-->'||AM.TEAM_MEM_CNT ||' , '
                            END ||
                            CASE    
                                WHEN AM.ENTR_YN			 <> AH.ENTR_YN			 THEN '본인내장구분 변경 : '|| 		AH.ENTR_YN			                                    ||'-->'||AM.ENTR_YN ||' , '
                            END ||
                            CASE    
                                WHEN AM.STTS_CODE		     <> AH.STTS_CODE		 THEN '예약변경구분 변경 : '||       GET_COMMCODE(AH.CORP_CODE,'GB012',AH.STTS_CODE)			||'-->'|| GET_COMMCODE(AM.CORP_CODE,'GB012',AM.STTS_CODE) ||' , '
                            END ||
                            CASE    
                                WHEN NVL(AM.REMARKS,'0')			 <> NVL(AH.REMARKS,'0')			 THEN '예약비고 변경 : '|| 		AH.REMARKS			                                        ||'-->'||AM.REMARKS ||' , '
                            END ||
                            CASE    
                                WHEN AM.BOOK_NAME		     <> AH.BOOK_NAME		 THEN '내장자 명 변경 : '|| 		AH.BOOK_NAME		                                    	||'-->'||AM.BOOK_NAME ||' , '
                            END ||
                            CASE    
                                WHEN AM.BOOK_HP_NO		 <> AH.BOOK_HP_NO		 THEN '내장자 연락처 변경 : '|| 		AH.BOOK_HP_NO		                                	||'-->'||AM.BOOK_HP_NO ||' , '
                            END ||
                            CASE    
                                WHEN AM.PYMT_CODE		     <> AH.PYMT_CODE		 THEN '적용 요금코드 변경 : '|| 		AH.PYMT_CODE			                                ||'-->'||AM.PYMT_CODE ||' , '
                            END ||
                            CASE    
                                WHEN AM.RND_CODE			 <> AH.RND_CODE			 THEN '라운드구분 변경 : '||        GET_COMMCODE(AH.CORP_CODE,'GB102',AH.RND_CODE)		    ||'-->'|| GET_COMMCODE(AM.CORP_CODE,'GB102',AM.RND_CODE) ||' , '	
                            END ||
                            CASE    
                                WHEN AM.ORG_COSE			 <> AH.ORG_COSE			 THEN '9홀 변경전 코스 변경 : '|| 		AH.ORG_COSE			                                    ||'-->'||AM.ORG_COSE ||' , '
                            END ||
                            CASE    
                                WHEN NVL(AM.LIMIT_CHECK_YN,'0')	 <> NVL(AH.LIMIT_CHECK_YN,'0')	 THEN '한도 차감여부 변경 : '|| 		AH.LIMIT_CHECK_YN		                            	||'-->'||AM.LIMIT_CHECK_YN ||' , '
                            END ||
                            CASE    
                                WHEN AM.DC_RATE			 <> AH.DC_RATE			 THEN '동반할인율 변경 : '|| 		    AH.DC_RATE			                                    ||'-->'||AM.DC_RATE ||' , '
                            END
                END,'수정사항 X'),' , ') MODIFY_REMARKS
        FROM RSA50H AM
            LEFT OUTER JOIN RSA50H AH 
                ON AM.CORP_CODE  = AH.CORP_CODE
                    AND AM.RESERV_NO  = AH.RESERV_NO
                    AND AM.RESERV_SEQ = AH.RESERV_SEQ
                    AND AM.SEQ        = (SELECT MIN(SEQ) FROM RSA50H WHERE RESERV_NO = AH.RESERV_NO AND RESERV_SEQ = AH.RESERV_SEQ AND SEQ >AH.SEQ)
        WHERE AM.RESERV_NO = P_RESERV_NO
        AND AM.RESERV_SEQ = P_RESERV_SEQ

            UNION

        SELECT 
                AM.CORP_CODE
                ,AM.RESERV_NO
                ,AM.RESERV_SEQ
                ,999 AS  SEQ
                ,NVL(TO_CHAR(AM.UPD_DATE,'YYYY-MM-DD'),TO_CHAR(AM.INS_DATE,'YYYY-MM-DD')) UPD_DATE
                ,NVL(TO_CHAR(AM.UPD_DATE,'HH24:MI'),TO_CHAR(AM.INS_DATE,'HH24:MI')) UPD_TIME
                ,NVL(GET_EMP_NAME(AM.CORP_CODE,AM.UPD_EMP_NO),AM.INS_EMP_NO) AS EMP_NAME
                ,'취소'  MODIFY_TYPE_NAME
                ,'예약취소' AS  MODIFY_REMARKS
        FROM RSA55S AM
        WHERE AM.RESERV_NO = P_RESERV_NO
        AND AM.RESERV_SEQ = P_RESERV_SEQ
        AND AM.CANCEL_YN = 'Y'
        ORDER BY SEQ DESC;

        EXCEPTION
            WHEN OTHERS
            THEN
                BEGIN
                RETURN;
                END;
        END;    


END PKG_EACHRESERVMODIFYHISTORY;
/