 ----------------------------
--락카상태 확인
----------------------------
BEGIN

    SELECT COUNT(*), get_commcode(P_CORP_CODE,'GF009',MAX(STATUS_CODE))
            INTO CHK_LOCKER_STAT_CNT, V_LOCKER_STAT_NAME
    FROM GFH01S
    WHERE CORP_CODE = P_CORP_CODE 
    AND UPJANG_CODE = P_UPJANG_CODE
    AND KEY_NO = P_LOCKER_KEY
    AND SEX = P_SEX
    AND NVL(STATUS_CODE,'003') = '003';  --003 고장(수리중)

        
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        CHK_USE_LOCKER_CNT := 0;
    WHEN OTHERS THEN
        O_RESULT         := '0';
        O_MSG            := '[고정락카 사용등록]락카상태 확인중 에러가 발생하였습니다.(PKG_SpaLockerFixPop.SP_INSERT)';
        RETURN;
END;
            
IF CHK_LOCKER_STAT_CNT > 0 THEN
    O_RESULT := '0';
    O_MSG    := '[고정락카 사용등록] '||P_LOCKER_KEY||' 락카는'||V_LOCKER_STAT_NAME
        || ' 상태입니다. 확인해주세요[PKG_LockerFixPop.SP_INSERT]';
    RETURN;
END IF;