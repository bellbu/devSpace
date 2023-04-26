/******************************************************************************
NAME:       SP_ROOM_MNGT_PAY_AMT_SELECT
PURPOSE:    세대별 관리비 예치금 입금 현황

REVISIONS:
VER        DATE        AUTHOR           DESCRIPTION
---------  ----------  ---------------  ------------------------------------
1.0        2022-02-25  정연호            1. 최초생성.
******************************************************************************/

 PROCEDURE SP_ROOM_MNGT_PAY_AMT_SELECT( 
	  P_CORP_CODE                            VARCHAR2          -- 법인코드
	 ,P_ROOM_NO                              VARCHAR2          -- 공동관리코드차수(기본:00 추가:01)
	 ,O_RESULTLIST                   OUT     SYS_REFCURSOR     -- 목록,상세조회 정보
 )
 IS
 
 BEGIN
	 OPEN O_RESULTLIST FOR
	 



	 SELECT SUBSTR(CN_DATE1,1,4)||'-'||SUBSTR(CN_DATE1,5,2)||'-'||SUBSTR(CN_DATE1,7,2) AS PAY_DATE1
			 ,CN_AMT1 AS PAY_AMT1
			 ,SUBSTR(CN_DATE2,1,4)||'-'||SUBSTR(CN_DATE2,5,2)||'-'||SUBSTR(CN_DATE2,7,2) AS PAY_DATE2
			 ,CN_AMT2 AS PAY_AMT2
	 FROM(
		 SELECT CN.F_KEY
			 ,CN.LVL
			 ,CASE 
				 WHEN CN.LVL = 1 THEN B1
				 WHEN CN.LVL = 2 THEN B2
				 WHEN CN.LVL = 3 THEN B3
			  END CN_DATE1
			 ,CASE 
				 WHEN CN.LVL = 1 THEN A1 
				 WHEN CN.LVL = 2 THEN A2
				 WHEN CN.LVL = 3 THEN A3
			  END CN_AMT1
			 ,CASE 
				 WHEN CN.LVL = 1 THEN B4 
				 WHEN CN.LVL = 2 THEN B5
				 WHEN CN.LVL = 3 THEN B6
			  END CN_DATE2
			 ,CASE 
				 WHEN CN.LVL = 1 THEN A4 
				 WHEN CN.LVL = 2 THEN A5
				 WHEN CN.LVL = 3 THEN A6
			  END CN_AMT2  
		 FROM (
			 SELECT 'KEY' AS F_KEY  -- 기준 테이블에 ROW 3개 생성
					,LEVEL AS LVL 
		   FROM DUAL 
		 CONNECT BY LEVEL <= 3
		 ) CN LEFT OUTER JOIN (
				 SELECT  -- F_KEY 그룹바이로 하나의 행으로 나타냄 
					 F_KEY 
					,MAX(A1) AS A1
					,MAX(A2) AS A2
					,MAX(A3) AS A3
					,MAX(A4) AS A4
					,MAX(A5) AS A5
					,MAX(A6) AS A6
					,MAX(B1) AS B1
					,MAX(B2) AS B2
					,MAX(B3) AS B3
					,MAX(B4) AS B4
					,MAX(B5) AS B5
					,MAX(B6) AS B6
					 FROM (
						 SELECT  -- 각 칼럼에 값 집어넣기
							 'KEY' AS F_KEY
							,DECODE(F.RNUM,1,PAYMENT_AMT) AS A1
							,DECODE(F.RNUM,2,PAYMENT_AMT) AS A2
							,DECODE(F.RNUM,3,PAYMENT_AMT) AS A3
							,DECODE(F.RNUM,4,PAYMENT_AMT) AS A4
							,DECODE(F.RNUM,5,PAYMENT_AMT) AS A5
							,DECODE(F.RNUM,6,PAYMENT_AMT) AS A6
							,DECODE(F.RNUM,1,PAYMENT_DATE) AS B1
							,DECODE(F.RNUM,2,PAYMENT_DATE) AS B2
							,DECODE(F.RNUM,3,PAYMENT_DATE) AS B3
							,DECODE(F.RNUM,4,PAYMENT_DATE) AS B4
							,DECODE(F.RNUM,5,PAYMENT_DATE) AS B5
							,DECODE(F.RNUM,6,PAYMENT_DATE) AS B6
							 FROM(
								 SELECT ROWNUM AS RNUM,  -- 전체 조회된 거에서 6개 SELECT
										PAYMENT_DATE,
										PAYMENT_AMT
								 FROM(        
										 SELECT ROWNUM AS RNUM, -- 조회된 순서대로 순번을 매겨서 입금일자, 입금금액 전체 SELECT 
											PAYMENT_DATE,   	-- 입금날짜
											PAYMENT_AMT			-- 입금금액
										 FROM BTM05M
										 WHERE CORP_CODE = P_CORP_CODE
										 AND REPLACE(UPPER(ROOM_NO),'-','') = REPLACE(UPPER(P_ROOM_NO),'-','')
										 ORDER BY PAYMENT_DATE DESC
									 )
								 WHERE ROWNUM < 7
							 ) F
					 ) T
					 GROUP BY F_KEY
		 ) BN ON CN.F_KEY = BN.F_KEY
	  ); 



 
 EXCEPTION
 WHEN OTHERS THEN
	 BEGIN
		 RETURN;
	 END;
 END;




 /******************************************************************************

 NAME:       SP_ROOM_PAY_AMT_SELECT
 PURPOSE:    세대별 관리비 예치금 잔액 현황

 REVISIONS:
 VER        DATE        AUTHOR           DESCRIPTION
 ---------  ----------  ---------------  ------------------------------------
 1.0        2022-02-25  정연호            1. 최초생성.
 1.1        2022-04-05  나동주            2. 당년 당월까지 예치금 잔액 표기 EX)3월분 관리비 부과내역서 조회 시 4월 입출금액 및 잔액 표기 안되도록 요청
******************************************************************************/

  PROCEDURE SP_ROOM_PAY_AMT_SELECT( 
	   P_CORP_CODE                            VARCHAR2          -- 법인코드
	  ,P_MONTH_YEAR                           VARCHAR2          -- 연도
	  ,P_ROOM_NO                              VARCHAR2          -- 공동관리코드차수(기본:00 추가:01)
	  ,O_RESULTLIST                   OUT     SYS_REFCURSOR     -- 목록,상세조회 정보
  )
  IS
  
  BEGIN
	  OPEN O_RESULTLIST FOR
	  SELECT CASE
			  WHEN DUMMY.MANAGE_YEAR_MONTH = '00월' THEN      -- 해당 월
				  '전년이월'								   -- 전년
				  ELSE												
				  DUMMY.MANAGE_YEAR_MONTH                     -- 금년
				 END AS MANAGE_YEAR_MONTH
		  ,CASE
			  WHEN DUMMY.MANAGE_YEAR_MONTH = '00월' THEN
				  (SELECT  THIS_REMAIN_AMT AS THIS_REMAIN_AMT  -- 전년 당월 입금액
				  FROM    BTM06M BT06
				  WHERE   CORP_CODE = P_CORP_CODE
					  AND     COST_YYMM = TO_CHAR(TRUNC(TO_DATE(P_MONTH_YEAR, 'YYYYMM'),'YYYY')-1,'YYYYMM')
					  AND     REPLACE(UPPER(ROOM_NO),'-','') = REPLACE(UPPER(P_ROOM_NO),'-',''))
				  ELSE
				  NVL(BM.THIS_PAYMENT_AMT,'')                   -- 금년 당월 입금액
				 END AS THIS_PAYMENT_AMT			
		  ,NVL(BM.LAST_WITH_DRAW_AMT,'') AS LAST_WITH_DRAW_AMT -- 당월 출금액
		  ,CASE
			  WHEN DUMMY.MANAGE_YEAR_MONTH = '00월' THEN
				  (SELECT  THIS_REMAIN_AMT AS THIS_REMAIN_AMT -- 전년도 당월 잔액
				  FROM    BTM06M
				  WHERE   CORP_CODE = P_CORP_CODE
					  AND     COST_YYMM = TO_CHAR(TRUNC(TO_DATE(P_MONTH_YEAR, 'YYYYMM'),'YYYY')-1,'YYYYMM') -- 전년도 조건
					  AND     REPLACE(UPPER(ROOM_NO),'-','') = REPLACE(UPPER(P_ROOM_NO),'-',''))
				  ELSE
				  NVL(BM.THIS_REMAIN_AMT,'')
				 END AS THIS_REMAIN_AMT
		  ,CASE
			  WHEN DUMMY.MANAGE_YEAR_MONTH = '00월' THEN 
				  '전년도에서 이월'
				  ELSE
				  BM.REMARKS
				 END AS REMARKS
	  FROM(
		  SELECT  LPAD((LEVEL - 1),2,'0')||'월' AS MANAGE_YEAR_MONTH  -- 임시의 0~12월 출력
		  FROM DUAL
		  CONNECT BY LEVEL <= 13
		  ) DUMMY
	  LEFT OUTER JOIN (
			  SELECT  SUBSTR(BT06.COST_YYMM,5,2)||'월' AS MANAGE_YEAR_MONTH --관리년월 
			  ,BT06.THIS_PAYMENT_AMT     -- 당월입금액
			  ,BT06.LAST_WITH_DRAW_AMT   -- 당월출금액
			  ,BT06.THIS_REMAIN_AMT		 -- 당월잔액
			  ,BT06.REMARKS 			 -- 비고
			  FROM    BTM06M BT06
			  WHERE       BT06.CORP_CODE = P_CORP_CODE
				  AND     BT06.COST_YYMM BETWEEN S(P_MONTH_YEAR,1,4)||'01' AND P_MONTH_YEAR  -- 1월부터 조건년도 사이
				  AND     REPLACE(UPPER(BT06.ROOM_NO),'-','') = REPLACE(UPPER(P_ROOM_NO),'-','')
			  ) BM ON DUMMY.MANAGE_YEAR_MONTH = BM.MANAGE_YEAR_MONTH
	  ORDER BY DUMMY.MANAGE_YEAR_MONTH
	  ;
  
  EXCEPTION
  WHEN OTHERS THEN
	  BEGIN
		  RETURN;
	  END;
  END;
  