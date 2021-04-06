<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/inc_header.jsp" %>
<div style="display: none;">
	menu_gubun : ${menu_gubun }<br>
	proc : <span id="span_proc"></span><br>
	pageNumber : <span id="span_pageNumber">${pageNumber }</span><br>
	no : <span id="span_no">${no }</span><br>
	search_option : <span id="span_search_option">${search_option }</span><br>
	search_data : <span id="span_search_data">${search_data }</span><br>
</div>
<div id="result"></div>
<script>
	$(document).ready(function() {
		<c:if test="${menu_gubun == 'product_index' }">
			suntaek_proc('list', '1', '');
		</c:if>
	});
</script>

<script>
	function suntaek_proc(value1, value2, value3) {
		if(value1 == "write") {
			$("#span_no").text("");
		} else if(value1 == "writeProc") {
			
		} else if(value1 == "list") {
			
		}
		
		$("#span_proc").text(value1);
		if(value2 != '') {
			$("#span_pageNumber").text(value2);
		}
		$("#span_no").text(value3);
		
		goPage(value1);
	}
	
	function goPage(value1) {
		var param = {}
		var process_data;
		var content_type;
		var url = "${path}/product_servlet/" + value1 + ".do";
		
		if(value1 == "write") {
			param = {}
		} else if(value1 == "writeProc") {
			process_data = false;
			content_type = false;
			
			param = new FormData();
			
			param.append("name", $("#name").val());
			param.append("price", $("#price").val());
			param.append("description", $("#description").val());
			
// 			console.log($('input[name="file"]')[0].files[0]);
// 			console.log($('input[name="file"]')[1].files[0]);
// 			console.log($('input[name="file"]')[2].files[0]);
			
// 			return;
			
			var file_counter = parseInt($('input[name="file"]').length);
			for(var i = 0; i < file_counter; i++) {
				param.append(i, $('input[name="file"]')[i].files[0]);
			}
		} else if(value1 == "view" || value1 == "update" || value1 == "delete") {
			param.no = $("#span_no").text();
		} else if(value1 == "updateProc") {
			process_data = false;
			content_type = false;
			
			param = new FormData();
			
			param.append("no", $("#span_no").text());
			param.append("name", $("#name").val());
			param.append("price", $("#price").val());
			param.append("description", $("#description").val());
			
			var file_counter = parseInt($('input[name="file"]').length);
			for(var i = 0; i < file_counter; i++) {
				param.append(i, $('input[name="file"]')[i].files[0]);
			}
		} else if(value1 == "deleteProc") {
			process_data = false;
			content_type = false;
			
			param = new FormData();
			
			param.append("no", $("#span_no").text());
			var file_counter = parseInt($('input[name="file"]').length);
			for(var i = 0; i < file_counter; i++) {
				param.append(i, $('input[name="file"]')[i].files[0]);
			}
		}
		
		$.ajax({
			type: "post",
			data: param,
			processData: process_data,
			contentType: content_type,
			url: url,
			success: function(data) {
				if(value1 == "writeProc" || value1 == "deleteProc") {
					suntaek_proc('list', '', '');
				} else if(value1 == "updateProc") {
					suntaek_proc('view', '', $("#span_no").text());
				} else {
					$("#result").html(data);
				}
			}
		});
	}
</script>