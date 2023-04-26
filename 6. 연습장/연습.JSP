<%@ page language="java" pageEncoding="UTF-8" contentType="text/html"; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<%@ include file="/WEB-INF/include/header.jsp"%>
<title>제목</title>
<style>
#calendar{
    border: 1px solid #BDBDBD;
    text-align: center;
    font-size: 13pt
}
td{
    width: 100px;
}
.date{
    height:60px;
}
.data{
    font-size: 10pt;
}
.clicked{
    background-color: #BCF1B1 !important
}
</style>
<script type="text/javascript">


</script>
</head>
<body>
    <div class="app-admin-wrap layout-sidebar-compact sidebar-dark-purple sidenav-open clearfix">
        <%@ include file="/WEB-INF/include/TopMenu.jsp"%>
        <!-- 서치 박스 -->
        <div class="row">
            <div class="col-md-12">
                <div class="card mb-12">
                    <div class="card-body">
                        <div class="form-row">
                            
                            <div class="col-md-1">
                                <lavel for="sGuestName" class="col-form-label">예약자</lavel>
                                <input type="text" class="form-control" name="sGuestName" id="sGuestName"/>
                            </div>

                            <!-- 조회 버튼 -->
                            <div class="col-md-1 search-btn">
                                <button class="btn btn-info" onclick="f_Retrieve();" hotkey="F3">
                                    <i class="fa fa-search"></i>&nbsp;검색[F3] 
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row main-row">
            <div class="col-md-7">
                <div class="card mb-12">
                    <div class="card-body">
                        <h5><b></b></h5>
                        <table align="center" id="calendar">
                            <tr>
                                <td><font size=4%; color="#B#B6B3"><label onclick="beforem()" id="before"></label></font></td>
                                <td colspan="5" align="center" id="yearmonth"></td>
                                <td><font size=4%; color="#B3B6B3"><label onclick="nextm()" id="next"></label></font></td>
                            </tr>
                            <tr>
                                <td align="center"><font color="#FF9090">일</font></td>
                                <td align="center"> 월 </td>
                                <td align="center"> 화 </td>
                                <td align="center"> 수 </td>
                                <td align="center"> 목 </td>
                                <td align="center"> 금 </td>
                                <td align="center"><font color="#7ED5E4"> 토 </font></td>
                            </tr>
                        </table>
                    </div>
                    <div class="card-body">
                        <h5><b>예약목록</b></h5>
                        <table id="gr_List"></table>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="card mb-12">
                    <div class="card-body">
                        <h5><b>예약등록</b></h5>
                        <form id="insertForm">
                        <input type-="hidden" id="type" name="type" />
                        <input type="hidden" id="reservNo" name="reservNo" />
                        
                        <div class="form=row">
                            <div class="col-md-4" id="stDateDiv">
                                <label for="stDate" class="col-form-label"><span class="essential_astrisk">*</span></span></label>
                                <input type="text" id="stDate" name="stDate" />
                            </div>
                        </div>
                        
                        <div class="col-md-4" id="edDate"



                        </form>                        
                    </div>

                </div>
            </div>



        </div>

    </div>

</body>
</html>