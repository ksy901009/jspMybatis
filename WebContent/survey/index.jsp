<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp" %>
<div style="display: none;">
list_gubun : <span id="span_list_gubun">${list_gubun }</span><br>
proc : <span id="span_proc"></span><br>
pageNumber : <span id="span_pageNumber">${pageNumber }</span><br>
no : <span id="span_no">${no }</span><br>
search_option : <span id="span_search_option">${search_option }</span><br>
search_data : <span id="span_search_data">${search_data }</span><br>
search_date : <span id="span_search_date">${search_date }</span><br>
search_date_check : <span id="span_search_date_check">${search_date_check }</span><br>
search_date_s : <span id="span_search_date_s">${search_date_s }</span><br>
search_date_e : <span id="span_search_date_e">${search_date_e }</span><br>
path : <span id="span_path">${path }</span><br>
</div>
<div id="result"></div>
<%@ include file="../survey/_survey.jsp" %>

<script>
// 	function write() {
// 		var param = {};
// 		$.ajax({
// 			type: "post",
// 			data: param,
// 			url: "${path}/survey_servlet/write.do",
// 			success: function(data) {
// 				$("#result").html(data);
// 			}
// 		});
// 	}
	
// 	function insert() {
// 		if(confirm('등록하시겠습니까?')) {
// 			$.ajax({
// 				type: "post",
// 				data: $('form').serialize(),
// 				url: "${path}/survey_servlet/writeProc.do",
// 				success: function() {
// 					suntaek_page('1');
// // 					list();
// 				}
// 			});
// 		}
// 	}
	
// 	function goList() {
// 		var param = {
// 				"list_gubun" : $("#span_list_gubun").text(),
// 				"pageNumber" : $("#span_pageNumber").text(),
// 				"search_option" : $("#span_search_option").text(),
// 				"search_data" : $("#span_search_data").text(),
// 				"search_date" : $("#span_search_date").text(),
// 				"search_date_s" : $("#span_search_date_s").text(),
// 				"search_date_e" : $("#span_search_date_e").text(),
// 				"search_date_check" : $("#span_search_date_check").text()
// 		}
// 		$.ajax({
// 			type: "post",
// 			data: param,
// 			url: "${path}/survey_servlet/list.do",
// 			success: function(result) {
// 				$("#result").html(result);
// 				if ($("#span_search_date_check").text() == '0') {
// 					$("input[id=search_date_check]:checkbox").prop("checked", true);
// 				} else {
// 					$("input[id=search_date_check]:checkbox").prop("checked", false);
// 				}
// 			}
// 		});
// 	}
	
// 	function goList_2() {
// 		var param = {}
		
// 		$.ajax({
// 			type: "post",
// 			data: param,
// 			url: "${path}/survey_servlet/list_2.do",
// 			success: function(result) {
// 				$("#result").html(result);
// 			}
// 		});
// 	}
	
// 	function surveyAnswerWriteProc() {
// 		if (confirm('저장하시겠습니까?')) {
// 	         var param = {
// 	            "answer_total" : $("#span_answer_total").text()
// 	         }
// 	         $.ajax({
// 	            type: "post",
// 	            data: param,
// 	            url: "${path}/survey_servlet/saveProc.do",
// 	            success: function(){
// 	               suntaek_page('1');
// 	            }
// 	         });
// 	      }
// 	}
	
// 	function pageNumberChange(pageNumber) { // 페이저에서 링크를 누를때 마다 새로운 리스트를 불러오는 함수
// 		$("#span_pageNumber").text(pageNumber);
// 		goList();
// 	}
	
// 	function list() {
// 		var param = '';
// 		$.ajax({
// 			type: "post",
// 			data: param,
// 			url: "${path}/survey_servlet/list.do",
// 			success: function(data) {
// 				$("#result").html(data);
// 			}
// 		});
// 	}
	
// 	function suntaek_page(value1) {
// 		$("#span_pageNumber").text(value1);
// 		goList();
// 	}
	
// 	function view(no) {
// 		$("#span_no").text(no);
		
// 		var param = {
// 				"no" : $("#span_no").text(),
// 		};
		
// 		$.ajax({
// 			type: "post",
// 			data: param,
// 			url: "${path}/survey_servlet/view.do",
// 			success: function(data) {
// 				$("#result").html(data);
// 			}
// 		});
// 	}
	
// 	function update() {
// 		var param = {
// 				"no" : $("#span_no").text()
// 		};
		
// 		$.ajax({
// 			type: "post",
// 			data: param,
// 			url: "${path}/survey_servlet/update.do",
// 			success: function(data) {
// 				$("#result").html(data);
// 			}
// 		});
// 	}
	
// 	function surveyAnswerWriteProc() {
// 		var param = {
// 				"no" : $("#span_no").text(),
// 				"answer" : $("#span_answer").text()
// 		};
		
// 		if(param.answer == '') {
// 			alert('답변을 선택해주세요');
// 		} else {
// 			$.ajax({
// 				type: "post",
// 				data: param,
// 				url: "${path}/survey_servlet/surveyAnswerWriteProc.do",
// 				success: function(data) {
// 					suntaek_page('1');
// 				}
// 			});
// 		}
// 	}
</script>