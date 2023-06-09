<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- fullcalender -->
<link href='../resources/css/main.css' rel='stylesheet' />
<link href='../resources/css/main.min.css' rel='stylesheet' />
<link href='../resources/css/calendar.css' rel='stylesheet' />
<link href='../resources/css/reset.css' rel='stylesheet' />
<script src='../resources/js/main.js'></script>
<script src='../resources/js/main.min.js'></script>
<script src='../resources/js/locales-all.js'></script>
<script src='../resources/js/locales-all.min.js'></script>
<!-- Datepicker -->
<link rel="stylesheet" href="../resources/css/jquery-ui.min.css" >
<link rel="stylesheet" href="../resources/css/jquery-ui.css">
<script src="../resources/js/jquery-ui.min.js"></script>
<!-- timepicker -->
<link rel="stylesheet" href="../resources/css/tui-time-picker.css" />
<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
<!-- jqGrid -->
<link rel="stylesheet" href="../resources/css/ui.jqgrid2.css" />
<script src="../resources/js/grid.locale-kr.js"></script>
<script src="../resources/js/jquery.jqGrid.js"></script>
<link rel="stylesheet" href="../resources/css/jquery.datetimepicker.css" />
<script src="../resources/js/jquery.datetimepicker.js"></script>
<script>
/* 팝업닫기 버튼 클릭시 */
function delBtn() {
	$('body').css("overflow-y", "auto");
	const modal = document.getElementById("modal");
	modal.setAttribute("style","display:none");
	document.getElementById("regScheduleInfo").reset();
}
/* 등록 클릭시 */
function writeBtn() {
	$('body').css("overflow", "hidden");
	var modal = document.getElementById("modal");
	modal.setAttribute("style","display:flex");
	
	var confirmAlertBox = document.getElementById("confirmAlertBox");
    confirmAlertBox.setAttribute("style","display:none");
    
    $('.confirmAlertBox').empty();
    $('#confirmAlertBox4').empty();
    
    const noneBox = document.querySelector('.noneBox2');
	noneBox.setAttribute("style","display: block");  
	
	$('.arr').prop('checked',true);
	const timepickerBox = document.getElementById("radioBoxRepeat");
	timepickerBox.setAttribute("style","display: flex");
	const radioBoxCheck = document.getElementById("radioBoxCheck");
	radioBoxCheck.setAttribute("style","display: block");
	const radioBoxRepeat2 = document.getElementById("radioBoxRepeat2");
	radioBoxRepeat2.setAttribute("style","display: none");
	var timeBox = document.querySelector('.timeBox');
	timeBox.setAttribute("style","display: flex");
	
    $('.checkboxAll').prop('checked',false);
    $('.limitless').prop('checked',false);
	
	var title = document.querySelector('.title');
    title.innerText="작업 등록";
    
    $('.serverContent').remove();
    $('.btnDay').removeClass("active");
	$('.btnDay').children().remove();
    
	 var btn1 = document.getElementById('btnBoxbtn1');
     btn1.innerHTML="";
     btn1.setAttribute("value","등록");
     btn1.setAttribute("class","btnBoxbtn");
     btn1.setAttribute("id","btnBoxbtn1");
     btn1.setAttribute("onclick","regBtn()");
     
     var btn2 = document.getElementById('btnBoxbtn2');
     btn2.innerHTML="";
     btn2.setAttribute("value","닫기");
     btn2.setAttribute("class","btnBoxbtn");
     btn2.setAttribute("id","btnBoxbtn2");
     btn2.setAttribute("onclick","delBtn()");
}
/* 삭제 버튼 클릭시 */
function molBtn() {
	const deleteRadio = document.getElementById("deleteRadio");
	deleteRadio.setAttribute("style","display:block");
	deleteRadio.innerHTML="";
	
	var div = document.createElement("div");
	div.setAttribute("class","radioBox");
	
	var ul = document.createElement("ul");
	
	var radioBoxList = document.createElement("li");
	radioBoxList.setAttribute("class","radioBoxList");
	
	var input = document.createElement("input");
	input.setAttribute("type","radio");
	input.setAttribute("name","delete_radio");
	input.setAttribute("value","0");
	input.setAttribute("checked","checked");
	var span = document.createElement("span");
	span.setAttribute("class","sapnRadio");
	span.innerText="모든 일정";
	
	var radioBoxList3 = document.createElement("li");
	radioBoxList3.setAttribute("class","radioBoxList");
	
	var input3 = document.createElement("input");
	input3.setAttribute("type","radio");
	input3.setAttribute("name","delete_radio");
	input3.setAttribute("value","2");
	var span3 = document.createElement("span");
	span3.setAttribute("class","sapnRadio");
	span3.innerText="이 후 모든 일정";
	
	var btnBox2 = document.createElement("div");
	btnBox2.setAttribute("class","btnBox2");
	var button = document.createElement("input");
	button.setAttribute("type","button");
	button.setAttribute("value","삭제");
	button.setAttribute("class","btnBoxbtn2");
	button.setAttribute("onclick","delSchedule()");
	var button2 = document.createElement("input");
	button2.setAttribute("type","button");
	button2.setAttribute("value","취소");
	button2.setAttribute("class","btnBoxbtn3");
	button2.setAttribute("onclick","delBox()");
	
	deleteRadio.appendChild(div);
	div.appendChild(ul);
	div.appendChild(btnBox2);
	btnBox2.appendChild(button);
	btnBox2.appendChild(button2);
	ul.appendChild(radioBoxList);
	ul.appendChild(radioBoxList3);
	radioBoxList.appendChild(input);
	radioBoxList.appendChild(span);
	radioBoxList3.appendChild(input3);
	radioBoxList3.appendChild(span3);
}
/* 삭제 취소 버튼 클릭시 */
function delBox() {
	const deleteRadio = document.getElementById("deleteRadio");
	deleteRadio.setAttribute("style","display:none");
}
function getCalendarList(){
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			var calendarEl = document.getElementById('calendar');
			var list = data.scheduleList;
			
				var events = list.map(function(item) {
				return {
					title : item.title,
					start : item.event_date + "T" + item.start_time,
					end : item.event_date + "T" + item.end_time,
					id : item.sc_no
				}
			}); 
			
		
			var calendar = new FullCalendar.Calendar(calendarEl, {
				 headerToolbar: {
			            left: 'prev',
			            center: 'title',
			            right: 'next'
			        },
				events : events,
				locale: 'ko',
				eventClick: function(info){
					/* 특정 event를 클릭했을 때 등록 창이 나오도록 변경 */
					$.ajax({
				        url: './getScheduleInfo',
				        data: "sc_no=" + info.event.id,
				        type: 'POST',
				        success: function(data) {
				            writeBtn();
				            
				            var sc_info = data.scheduleInfo;
				            var sc_server = data.serverList;
				            
				            $('.textBox').val(sc_info.title);
				            
				            var sc_no_input = document.createElement('input');
				            sc_no_input.setAttribute('type','hidden');
				            sc_no_input.setAttribute('name','sc_no');
				            sc_no_input.setAttribute('value',sc_info.sc_no);
				            $('.textBox').append(sc_no_input);
				            
				            $('input[name=start_date]').val(sc_info.start_date);
				            $('input[name=end_date]').val(sc_info.end_date);
				            
				            if(sc_info.repeat_cat == 0){
				            	$('.timearr').attr('checked','checked');
				            	$('input[name=start_date_2]').val(sc_info.start_date);
					            $('input[name=end_date_2]').val(sc_info.end_date);
					            $('input[name=start_time_2]').val(sc_info.start_time);
					            $('input[name=end_time_2]').val(sc_info.end_time);
				            } else{
				            	$('input[name=start_date_1]').val(sc_info.start_date);
					            $('input[name=end_date_1]').val(sc_info.end_date);
					            $('input[name=start_time_1]').val(sc_info.start_time);
				            	if(sc_info.end_date == '9999-12-31'){
					            	$('.limitless').prop('checked',true);
					            	const noneBox = document.querySelector('.noneBox2');
					                noneBox.setAttribute("style","display: none");
				            	} else {				            		
					            	$('input[name=end_time_1]').val(sc_info.end_time);
				            	}
				            }				            
				            
				            var repeat_cat = $('input[name=repeat_cat]').get(sc_info.repeat_cat - 1);
				            $(repeat_cat).attr('checked','checked');
				            if($(repeat_cat).val() == 2){
				            	$('input[name=repeat_week]').val(sc_info.repeat_week);
				            } else if($(repeat_cat).val() == 3){
				            	$('input[name=repeat_day]').val(sc_info.repeat_day);
				            }
				            
				            var days = [sc_info.sun, sc_info.mon, sc_info.the, sc_info.wed, sc_info.thu, sc_info.fri, sc_info.sat];
				            for(var i = 0; i < 7; i++){
				            	if(days[i] == 'y'){
				            		var day = $('.btnDay').get(i);
				            		$(day).addClass('active');
				            		var input =document.createElement("input");
				            		input.setAttribute("type","hidden");
				            		input.setAttribute("name",$(day).val());
				            		input.setAttribute("value","y");
				         		    $(day).append(input);
				            	}
				            }
				            
				            if($('button.active').length == 7){
				            	$('.checkboxAll').prop('checked',true);
				            }
				            
				            var confirmAlertBox = document.getElementById("confirmAlertBox");
				            confirmAlertBox.innerText="";
				            
				            var title = document.querySelector('.title');
				            title.innerText="작업 수정&삭제";
				            
					    	var serverList = document.getElementById("serverListM");
					    	serverList.innerHTML = "";
					    	var thead = document.createElement("thead");
					    	thead.setAttribute("id","theadList");
					    	
				            var tr = document.createElement("tr");
							tr.setAttribute("class","serverHeader");
							thead.appendChild(tr);
							var th1 = document.createElement("th");
							th1.setAttribute("class","serverHeaderText");
							tr.appendChild(th1);
							var th2 = document.createElement("input");
							th2.setAttribute("type","checkbox");
							th2.setAttribute("name","allCheck");
							th2.setAttribute("id","allCheck");
							th1.appendChild(th2);
							var th3 = document.createElement("th");
							th3.setAttribute("class","serverHeaderText");
							th3.innerText="서버명";
							tr.appendChild(th3);
							var th4 = document.createElement("th");
							th4.setAttribute("class","serverHeaderText");
							th4.innerText="IP";
							tr.appendChild(th4);
							var th5 = document.createElement("th");
							th5.setAttribute("class","serverHeaderText");
							th5.innerText="OS";
							tr.appendChild(th5);
								
						    serverList.appendChild(thead);
				            
				            
				            
				            var tbody = document.createElement("tbody");
				            tbody.setAttribute("class","tbodyBox");
				            
				            for(x of sc_server){
				            	var tr6 = document.createElement("tr");
								tr6.setAttribute("class","serverContent");
								tbody.appendChild(tr6);
								var th7 = document.createElement("th");
								th7.setAttribute("class","serverContentText");
								tr6.appendChild(th7);
								var th8 = document.createElement("input");
								th8.setAttribute("type","checkbox");
								th8.setAttribute("name","rowCheck");
								th7.appendChild(th8);
								var th9 = document.createElement("th");
								th9.setAttribute("class","serverContentText");
								th9.innerText=x.name;
								tr6.appendChild(th9);
								var th10 = document.createElement("th");
								th10.setAttribute("class","serverContentText");
								th10.innerText=x.ip;
								tr6.appendChild(th10);
								var th11 = document.createElement("th");
								th11.setAttribute("class","serverContentText");
								th11.innerText=x.os;
								tr6.appendChild(th11);
								var th12 = document.createElement("input");
								th12.setAttribute("type","hidden");
								th12.setAttribute("name","server_no");
								th12.setAttribute("value",x.server_no);
								tr6.appendChild(th12);
								
						    	tbody.appendChild(tr6);
						    	serverList.appendChild(tbody);
				    		} 
				        
				            var btn1 = document.getElementById('btnBoxbtn1');
				            btn1.innerHTML="";
				            btn1.setAttribute("value","수정");
				            btn1.setAttribute("class","btnBoxbtn");
				            btn1.setAttribute("id","btnBoxbtn1");
				            btn1.setAttribute("onclick","modBtn()");
				            
				            var btn2 = document.getElementById('btnBoxbtn2');
				            btn2.innerHTML="";
				            btn2.setAttribute("value","삭제");
				            btn2.setAttribute("class","btnBoxbtn");
				            btn2.setAttribute("id","btnBoxbtn2");
				            btn2.setAttribute("onclick","molBtn()");
				            
				            var input_date = document.createElement('input');
				            var event_date = info.event.start;
				            var month = "";
				            var day = "";
				            
				            if((event_date.getMonth() + 1) >= 1 || (event_date.getMonth() + 1) < 10){
				            	month = "0" + (event_date.getMonth() + 1);	
				            }
				            
				            if(event_date.getDate() >= 1 || event_date.getDate() < 10){
				            	day = "0" + event_date.getDate();
				            }
				            cur_date = event_date.getFullYear() + "-" + month + "-" + day;
				            
				            input_date.setAttribute("name","cur_date");
				            input_date.setAttribute("type","hidden");
				            input_date.setAttribute("value", cur_date);
				            $('#regScheduleInfo').append(input_date);
				        },
				        error: function() {
				        	alert("잘못된 접근입니다.");
				        }
				    });
				}
			});
			calendar.render();
				
			var prev = document.getElementsByClassName('fc-prev-button fc-button fc-button-primary');
			prev[0].onclick = function(){
				var date = calendar.getDate();
				// 등록된 모든 이벤트들을 삭제한다.
				calendar.removeAllEvents();
				
				// 새로운 이벤트들을 등록한다.
				var reXhr = new XMLHttpRequest();
				reXhr.onreadystatechange = function(){
					if(reXhr.readyState == 4 && reXhr.status == 200){
						var reData = JSON.parse(reXhr.responseText);
						
						var newEvents = reData.scheduleList.map(function(item){
							if(new Date(item.event_date))
							return {
								title : item.title,
								start : item.event_date + "T" + item.start_time,
								end : item.event_date + "T" + item.end_time,
								id : item.sc_no
							}
						});
						
						calendar.addEventSource(newEvents);
						$(function(){
							$('.fc-scrollgrid-sync-table tbody tr:nth-child(n+4)').children('.fc-day-other').remove();
					  	})
					}
				}
				
				reXhr.open("post", "./getList", true);
				reXhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				reXhr.send("year=" + date.getFullYear() + "&month=" + (date.getMonth() + 1));
			};
				
			var next = document.getElementsByClassName('fc-next-button fc-button fc-button-primary');
			next[0].onclick = function(){
				var date = calendar.getDate();
				// 등록된 모든 이벤트들을 삭제한다.
				calendar.removeAllEvents();
				
				// 새로운 이벤트들을 등록한다.
				var reXhr = new XMLHttpRequest();
				reXhr.onreadystatechange = function(){
					if(reXhr.readyState == 4 && reXhr.status == 200){
						var reData = JSON.parse(reXhr.responseText);
						
						var newEvents = reData.scheduleList.map(function(item){
							return {
								title : item.title,
								start : item.event_date + "T" + item.start_time,
								end : item.event_date + "T" + item.end_time,
								id : item.sc_no
							}
						});
						
						calendar.addEventSource(newEvents);
						$(function(){
							$('.fc-scrollgrid-sync-table tbody tr:nth-child(n+4)').children('.fc-day-other').remove();
					  	})
					}
				}
				
				reXhr.open("post", "./getList", true);
				reXhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				reXhr.send("year=" + date.getFullYear() + "&month=" + (date.getMonth() + 1));
			};
		}
	};
		
	var today = new Date();
	
	xhr.open("post" , "./getList", true);
	xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xhr.send("year=" + today.getFullYear() + "&month=" + (today.getMonth() + 1));
}
function getServerList(){
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			
			
			var aaa = data.serverList;
			var jsonArr = [];
			for (var i = 0; i < aaa.length; i++) {
			    jsonArr.push({
			    	'name': aaa[i].name,
			    	'ip': aaa[i].ip,
			    	'os': aaa[i].os,
			    	'server_no': aaa[i].server_no
			    });
			}
			
			
			$("#list").jqGrid({
				datatype: "local",
				data: jsonArr,
				rowNum: 10,
				rowList:[10,20,30],
				height:500,
				width:1000,
				colModel: [	
						{name: 'name', label : '서버명', align:'left'},
				        {name: 'ip', label : 'IP', align:'left'},
				        {name: 'os', label : 'OS분류', align:'center'},
				        {name: 'server_no', hidden: true}
						],
			    pager: '#pager',
			    multiselect: true
			
			});
			
			
			$('.btnBoxbtn2').click(function(){
				var params = new Array(); 
				var a = $("#list").jqGrid('getGridParam', 'selarrrow');
				
				
				for (var i = 0; i < a.length; i++) { //row id수만큼 실행          
				    if($("input:checkbox[id='jqg_list_"+a[i]+"']").is(":checked")){ //checkbox checked 여부 판단
				    var rowdata = $("#list").getRowData(a[i]);
				    params.push(rowdata);
				    console.log(params);
				    
				    }
				
				}
				
				console.log(params);
		    	
		    	const serverModal = document.getElementById("serverModal"); 
		        serverModal.setAttribute("style","display: none");
		        
		        var theadList = document.getElementById("theadList");
		        
		    	var serverModal2 = document.getElementById("serverListM");
		    	serverModal2.innerHTML = "";
				
		    	var tbody = document.createElement("tbody");
		    	tbody.setAttribute("class","tbodyBox");
		    
 					for(var i = 0; i < params.length; i++){
					var tr6 = document.createElement("tr");
					tr6.setAttribute("class","serverContent");
					tbody.appendChild(tr6);
					var th7 = document.createElement("th");
					th7.setAttribute("class","serverContentText");
					tr6.appendChild(th7);
					var th8 = document.createElement("input");
					th8.setAttribute("type","checkbox");
					th8.setAttribute("name","rowCheck");
					th7.appendChild(th8);
					var th9 = document.createElement("th");
					th9.setAttribute("class","serverContentText");
					th9.innerText=params[i].name;
					tr6.appendChild(th9);
					var th10 = document.createElement("th");
					th10.setAttribute("class","serverContentText");
					th10.innerText=params[i].ip;
					tr6.appendChild(th10);
					var th11 = document.createElement("th");
					th11.setAttribute("class","serverContentText");
					th11.innerText=params[i].os;
					tr6.appendChild(th11);
					var th12 = document.createElement("input");
					th12.setAttribute("type","hidden");
					th12.setAttribute("name","server_no");
					th12.setAttribute("value",params[i].server_no);
					tr6.appendChild(th12);
					}  
		    	
 					tbody.appendChild(tr6);
 					serverModal2.appendChild(theadList);
 					serverModal2.appendChild(tbody);
		    	
			});
		}
	};
	
	xhr.open("post" , "./getServerList" , true);
	xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xhr.send();	
}
window.addEventListener("DOMContentLoaded" , function(){
	
	/* 요일선택 했을시  */ 
	$('.btnDay').click(function(){
  		if($(this).hasClass("active")){
  		   $(this).removeClass("active");
  		   $(this).children().remove();
  		}else{
  		   $(this).addClass("active");  
  		   var valueByClass = $(this).val();
   		   var input =document.createElement("input");
   		   input.setAttribute("type","hidden");
   		   input.setAttribute("name",valueByClass);
   		   input.setAttribute("value","y");
		   $(this).append(input);
  		}
  		var total = $('.btnDay').length;
		var checked = $('.btnDay.active').length;
		if(total != checked){
			$('.checkboxAll').prop("checked", false);
		}else{
			$('.checkboxAll').prop("checked", true); 
		}
	}); 
	/* 요일 전체 체크 시 */
    $('.checkboxAll').click(function(){
        const btnDay = document.querySelectorAll('.btnDay'); 
		var a = $('.checkboxAll').is(':checked');
        
        if(a == true){
        	$(btnDay).addClass("active");
        	$(btnDay).each(function() { 
        		var test = $(this).val();
        		var input =document.createElement("input");
        		   input.setAttribute("type","hidden");
        		   input.setAttribute("name",test);
        		   input.setAttribute("value","y");
     			$(this).append(input);
        		});
        	
   		}else{
   			$(btnDay).removeClass("active");
   			$(btnDay).children().remove();
   		}
	});
	
	
    /* 매월, 매일 */
    $("input[name='repeat_cat']").change(function() {
 		if($("input[name='repeat_cat']:checked").val() == "3") {
 			const dayBox = document.getElementById("dayBox"); 
 	        dayBox.setAttribute("style","display: none");
 		} else {
 			const dayBox = document.getElementById("dayBox"); 
 	        dayBox.setAttribute("style","display: block");
 		}
 	});
    
    
    /* 무기한 클릭시 */
     $('.limitless').click(function(){
        const noneBox = document.querySelector('.noneBox2');
        noneBox.setAttribute("style","display: none");  
        
        var a = $('.limitless').is(':checked');
        
        if(a == true){
        	noneBox.setAttribute("style","display: none");  
   		}else{
   			noneBox.setAttribute("style","display: block");  
   		}
	}); 
    
    $('#btn1').click(function(){
         const serverModal = document.getElementById("serverModal"); 
         serverModal.setAttribute("style","display: block"); 
         $('.cbox').prop('checked',false);
 	}); 
    
    
    $('.btnBoxbtn3').click(function(){
        const serverModal = document.getElementById("serverModal"); 
        serverModal.setAttribute("style","display: none");
        
        var cbox = document.getElementsByClassName('cbox');
        for (var i = 0; i < cbox.length; i++) {
        	cbox[i].checked = false;
        }
	}); 
 	
 	$("input[name='repeat_11']").change(function() {
 		if($("input[name='repeat_11']:checked").val() == "0") {
			const limitless = document.getElementById("radioBoxCheck");
			limitless.setAttribute("style","display: block");
			const timeBox = document.querySelector('.timeBox');
 			timeBox.setAttribute("style","display: flex");
 			const timepickerBox = document.getElementById("radioBoxRepeat");
			timepickerBox.setAttribute("style","display: flex");
 			const radioBoxRepeat2 = document.getElementById("radioBoxRepeat2");
 			radioBoxRepeat2.setAttribute("style","display: none");
 		}  else if($("input[name='repeat_11']:checked").val() == "1") {
 			const timeBox = document.querySelector('.timeBox');
 			timeBox.setAttribute("style","display: none");
 			const limitless = document.getElementById("radioBoxCheck");
			limitless.setAttribute("style","display: none");
			const timepickerBox = document.getElementById("radioBoxRepeat");
			timepickerBox.setAttribute("style","display: none");
			const radioBoxRepeat2 = document.getElementById("radioBoxRepeat2");
			radioBoxRepeat2.setAttribute("style","display: grid");
 		} 
 	});
 	
 	
 	$(document).on("click", "#allCheck", function(){
 		var checked = $("#allCheck").is(':checked');
		if(checked == true){
			$("input[name='rowCheck']").prop('checked',true);
		} else {
			$("input[name='rowCheck']").prop('checked',false);
		}
 	});
 	
 	$("#calendarPage").addClass("on");
 	$(document).ready(function(){
 		  $('.fc-scrollgrid-sync-table tbody tr:nth-child(n+4)').children('.fc-day-other').remove();
 		})
 	
	$(function(){
		$('.datepicker').datepicker({
	    	dateFormat: 'yy-mm-dd',
	    	minDate: 0
			});
	})
	 
    $(function(){
    	$('#datetimepicker1').datetimepicker({
    		datepicker:false,
    		format:'H:i',
    		step: 10
    	});
  	})
  	
  	$(function(){
    	$('#datetimepicker2').datetimepicker({
    		datepicker:false,
    		format:'H:i',
    		step: 10
    	});
  	})
  	
  	$(function(){
    	$('#datetimepicker3').datetimepicker({
    		datepicker:false,
    		format:'H:i',
    		step: 10
    	});
  	})
  	
   $(function(){
    	$('#datetimepicker4').datetimepicker({
    		datepicker:false,
    		format:'H:i',
    		step: 10
    	});
  	})
		 
	/* page load후 바로 실행 되는 함수들 */  	
	getCalendarList();
	writeBtn();
	getServerList();
	delBtn();
});
function confirmTitle(){

	var title = document.querySelector('input[name="title"]').value;
	
	var xhr = new XMLHttpRequest();
	
	//title = escape(title);
	
	//console.log(title);
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = JSON.parse(xhr.responseText);
			
			var confirmAlertBox = document.getElementById("confirmAlertBox");
			confirmAlertBox.style.display = "block";
			if(data.result == true){
				confirmAlertBox.innerText = "이미 존재 하는 작업명 입니다.";
				confirmAlertBox.style.color = "red";
			}else if(title == ""){
				confirmAlertBox.innerText = "작업명은 필수항목 입니다.";
				confirmAlertBox.style.color = "red";
			} else {
				confirmAlertBox.innerText = "사용 가능한 작업명 입니다.";
				confirmAlertBox.style.color = "green";
			}
		}
	};
	
	title = encodeURIComponent(title);
	
	xhr.open("get" , "./isExistTitle?title=" + title , true); 
	xhr.send();
	
};

function deleteServer(){
	
	if ($("input[name='rowCheck']:checked").length == 0) {
		alert("선택된 서버가 없습니다.");
	} else {
		var chk = confirm("정말 삭제하시겠습니까?");
		if(chk == true){
			for(var i=$("input[name='rowCheck']:checked").length-1; i>-1; i--){
				﻿		$("input[name='rowCheck']:checked").eq(i).closest("tr").remove();
			}﻿ 
		}else{
			return;
		}
	}
}
function validationCheck(target){
	var result = 1;
	
	if(target.getAll('start_date') == '' && target.getAll('end_date') == '' && !$('.limitless').is(':checked') && target.getAll('repeat_11') == '0'){
		/* 	2. 시작 날짜가 제대로 입력 됐는지 확인
		 	   날짜 형식이 제대로 되었는지도 확인 해야함 
		 */
		var confirmAlertBox = document.getElementById("confirmAlertBox2");
			confirmAlertBox.style.display = "block";
			confirmAlertBox.innerText = "작업 날짜를 입력해주세요.";
			confirmAlertBox.style.color = "red";
		result = 0;
	} else if(target.getAll('start_date') != '' || target.getAll('end_date') == '') {
		var confirmAlertBox = document.getElementById("confirmAlertBox2");
			confirmAlertBox.style.display = "none";
		result = 1;
	};
	
	if(target.getAll('start_time') == '' || target.getAll('end_time') ==''){
		/*	4. 시작 시간과 끝나는 시작이 입력 됐는지 확인
			   위 날짜 처럼 추후 형식을 확인 했는지도 확인 해야함
		*/
		var confirmAlertBox = document.getElementById("confirmAlertBox3");
			confirmAlertBox.style.display = "block";
			confirmAlertBox.innerText = "작업 시간을 입력해주세요.";
			confirmAlertBox.style.color = "red";
		result = 0;
	} else if(target.getAll('start_time') != '' || target.getAll('end_time') =='') {
		var confirmAlertBox = document.getElementById("confirmAlertBox2");
			confirmAlertBox.style.display = "none";
			result = 1;
	};
	
	
	if(!target.has('server_no')){
		var confirmAlertBox = document.getElementById("confirmAlertBox4");
			confirmAlertBox.style.display = "inline-flex";
			confirmAlertBox.innerText = "서버선택은 필수항목입니다.";
			confirmAlertBox.style.color = "red";
		
		result = 0;
	} 
	
	return result;
}

function regBtn(){
	
	var formData = new FormData(document.getElementById('regScheduleInfo'));
	
	if($('.timearr').is(':checked')){
		formData.set('repeat_cat', 0);
		formData.set('start_date', formData.getAll('start_date_2'));
		formData.set('end_date', formData.getAll('end_date_2'));
		formData.set('start_time', formData.getAll('start_time_2'));
		formData.set('end_time', formData.getAll('end_time_2'));
	} else {
		if($('.limitless').is(':checked')){
			formData.set('end_date', '9999-12-31');
		} else {
			formData.set('end_date', formData.getAll('end_date_1'));
		}
		
		formData.set('start_date', formData.getAll('start_date_1'));
		formData.set('start_time', formData.getAll('start_time_1'));
		formData.set('end_time', formData.getAll('end_time_1'));
	}
	
	if(validationCheck(formData) == 0){
		return;
	} else {
	    $.ajax({
	        url: './regSchedule',
	        data: formData,
	        processData: false,
	        contentType: false,
	        type: 'POST',
	        success: function (data) {
	        	if(data.result == 0){
	        		alert("등록에 성공했습니다.");
		            delBtn();
		            location.reload();
	        	} else {
	        		alert(data.result);
	        	}
	        },
	        error: function (data){
	        	alert("등록에 실패하였습니다. 관리자에게 문의해주시기 바랍니다.");
	        }
	    });
	}	
}
/* 수정 기능 */
function modBtn(){
	$('body').css("overflow-y", "auto");
	
	var formData = new FormData(document.getElementById('regScheduleInfo'));
	
	if($('.timearr').is(':checked')){
		formData.set('repeat_cat', 0);
		formData.set('start_date', formData.getAll('start_date_2'));
		formData.set('end_date', formData.getAll('end_date_2'));
		formData.set('start_time', formData.getAll('start_time_2'));
		formData.set('end_time', formData.getAll('end_time_2'));
	} else {
		if($('.limitless').is(':checked')){
			formData.set('end_date', '9999-12-31');
		} else {
			formData.set('end_date', formData.getAll('end_date_1'));
		}
		
		formData.set('start_date', formData.getAll('start_date_1'));
		formData.set('start_time', formData.getAll('start_time_1'));
		formData.set('end_time', formData.getAll('end_time_1'));
	}
	
	if(validationCheck(formData) == 0){
		return;
	} else {
		$.ajax({
			url: './modSchedule',
			data: formData,
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data){
				alert("수정에 성공했습니다.");
				delBtn();
				location.reload();
			}
		});
	}
}
/* 삭제 기능 */
function delSchedule(){
	$('body').css("overflow-y", "auto");
	var formData = new FormData(document.getElementById('regScheduleInfo'));
	$.ajax({
		url: './delSchedule',
		data: formData,
		processData: false,
		contentType: false,
		type: 'POST',
		success: function(data){
			alert("삭제에 성공했습니다.");
			location.reload();
		}
	});
}
</script>

</head>
<body>
		
			<jsp:include page="../nav/nav.jsp"></jsp:include>
	    	<div id="box">
	    		<button class="writeBtn" onclick="writeBtn()">등록</button>
	    		<div id="calendar"></div>
	    	</div>
	  
		
		<!-- modal 창 -->
		<div id="modal" class="modal-overlay">
			<div class="window">
				<div class="modalBox">
				
					<!-- Form 태그 시작 -->
					<form id="regScheduleInfo" name="param">
					
					<div class="top">
						<h3 class="title">작업 등록</h3>
						<i class="bi bi-x" onclick="delBtn()"></i>
					</div>
					
					<div class="titleBox">
						<strong class="text">작업명<span class="star">*</span></strong>
					
					<div class="titleText">
						<input type="text" name="title" class="textBox" onblur="confirmTitle()" autocomplete='off'>
						<div id="confirmAlertBox" class="confirmAlertBox"></div>
					</div>
					</div>
					
					<div class="dateBox">
						<strong class="text">기간설정</strong>
						<div class="radioBox">
							<input type="radio" name="repeat_11" value="0" class="arr" autocomplete='off' checked> 반복설정
							<input type="radio" name="repeat_11" value="1" class="timearr" autocomplete='off'> 기간설정
							<br>
							
		            	    <div id="radioBoxRepeat">
		                        <input type="text" class="datepicker start_date" name="start_date_1" autocomplete='off'>
		                        <div class="noneBox2">
		                        	<span class="ing">~</span>
		                           	<input type="text" class="datepicker end_date" name="end_date_1" autocomplete='off'>
								</div>
		                    </div>
		                    
		                    <div id="radioBoxRepeat2">
		                    <div class="start">
		                        <input type="text" class="datepicker start_date" name="start_date_2" autocomplete='off'>
		                        <input id="datetimepicker3" class="datetimepicker" type="text" name="start_time_2" autocomplete='off'>
		                    </div>
		                    <div class="end">
		                        <input type="text" class="datepicker end_date" name="end_date_2" autocomplete='off'>
		                        <input id="datetimepicker4" class="datetimepicker" type="text" name="end_time_2" autocomplete='off'>
		                    </div>
		                    </div> 
		                    
		                    <div id="radioBoxCheck">
		                    	<input type="checkbox" class="limitless" autocomplete='off'> 무기한
		                    </div>
		                <div id="confirmAlertBox2" class="confirmAlertBox"></div> 
						</div>
					</div>
					
		
					<div class="timeBox">
						<strong class="text">반복설정</strong>
						<div class="radioBox">
						<div class="Boxxx">
							<input type="radio" name="repeat_cat" value="1" autocomplete='off' checked> 매일
							<input type="radio" name="repeat_cat" value="2" autocomplete='off' class="day"> 매월 <input type="text" name="repeat_week" class="dayBox" autocomplete='off'>째주
							<input type="radio" name="repeat_cat" value="3" autocomplete='off' class="day"> 매월 <input type="text" name="repeat_day" class="dayBox" autocomplete='off'>일
							<br>
		                   	<div id="dayBox">
								<input type="checkbox" name="checkboxAll" value="" class="checkboxAll" autocomplete='off'><span class="checkAll">전체</span> 
		                   		<button type="button" value="sun" name="sun" class="btnDay">SUN</button>
		                   		<button type="button" value="mon" name="mon" class="btnDay">MON</button>
		                   		<button type="button" value="the" name="the" class="btnDay">TUE</button>
		                   		<button type="button" value="wed" name="wed" class="btnDay">WED</button>
		                   		<button type="button" value="thu" name="thu" class="btnDay">THU</button>
		                   		<button type="button" value="fri" name="fri" class="btnDay">FRI</button>
		                   		<button type="button" value="sat" name="sat" class="btnDay">SAT</button>
		                   	</div>
		                   	</div>
		                   	
		                   	<div id="timepickerBox">
		                   	<input id="datetimepicker1" class="datetimepicker" type="text" name="start_time_1" autocomplete='off'>
		                   	<span class="ing">~</span>
		                   	<input id="datetimepicker2" class="datetimepicker" type="text" name="end_time_1" autocomplete='off'>
		                   	</div>
		                   	<div id="confirmAlertBox3" class="confirmAlertBox"></div>
						</div>
					</div>
		
					<div class="listBox">
						<strong class="text">작업대상<span class="star">*</span><div id="confirmAlertBox4"></div> </strong>
						<div class="btnList">
							<input type="button" value="추가" class="btn1" id="btn1" autocomplete='off'>
							<input type="button" value="삭제" class="btn1" onclick="deleteServer()" autocomplete='off'>
						</div>
					</div>
					
					<table class="serverList" id="serverListM">
						<thead id="theadList">
							<tr class="serverHeader">
								<th class="serverHeaderText"><input type="checkbox" id="allCheck" autocomplete='off' name="allCheck"></th>
								<th class="serverHeaderText">서버명</th>
								<th class="serverHeaderText">IP</th>
								<th class="serverHeaderText">OS분류</th>
							</tr>
						</thead>
					</table>
					
					<div class="btnBox">
						<input type="button" value="등록" class="btnBoxbtn" id="btnBoxbtn1" onclick="regBtn()" autocomplete='off'>
						<input type="button" value="닫기" class="btnBoxbtn" id="btnBoxbtn2" onclick="delBtn()" autocomplete='off'>
					</div>
					<div id="deleteRadio"></div>
					</form>
					<!-- Form 태그 종료 -->
				</div>
			</div>
		</div>
		
		<!-- server 등록 modal 창 -->
		<div id="serverModal">
		<div id="serverModalBox">
		<div class="box">서버리스트</div>
			<table id="list"></table>
			<div class="btnBox2">
				<input type="button" value="등록" class="btnBoxbtn2" autocomplete='off'>
				<input type="button" value="닫기" class="btnBoxbtn3" autocomplete='off'>
			</div>
			<div id="pager"></div> 
		</div>
		</div>
	
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</html>