<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/inc_sessionChk.jsp" %>
<div style="display: none;">
	menu_gubun : ${menu_gubun }<br>
	proc : <span id="span_proc"></span><br>
	pageNumber : <span id="span_pageNumber">${pageNumber }</span><br>
	no : <span id="span_no">${no }</span><br>
	search_option : <span id="span_search_option">${search_option }</span><br>
	search_data : <span id="span_search_data">${search_data }</span><br>
	jumun_su : <span id="span_jumun_su"></span><br>
</div>
<div id="result"></div>
<script>
	$(document).ready(function() {
		<c:if test="${menu_gubun == 'mall_index' }">
			suntaek_proc('mall_list', '1', '');
		</c:if>
	});
	
	function suntaek_proc(value1, value2, value3) {
		if(value1 == 'mall_list') {
			$("#span_proc").text(value1);
			$("#span_no").text("");
		} else if(value1 == 'mall_view') {
			$("#span_proc").text(value1);
			$("#span_no").text(value3);
		} else if(value1 == 'mall_search') {
			value1 = 'mall_list';
			$("#span_proc").text(value1);
			$("#span_no").text("");
			$("#span_search_option").text($("#search_option").val());
			$("#span_search_data").text($("#search_data").val());
		} else if(value1 == 'cart_writeProc') {
// 			alert($("#jumun_su").val());
			$("#span_proc").text(value1);
			$("#span_no").text(value3);
			$("#span_jumun_su").text($("#jumun_su").val());
		} else if(value1 == 'cart_list') {
			$("#span_proc").text(value1);
			$("#span_no").text("");
			$("#span_jumun_su").text("");
		} else if(value1 == 'cart_biew') {
			if(confirm('제품상세보기 페이지로 이동하시겠습니까?')) {
				value1 = 'mall_view';
				$("#span_proc").text(value1);
				$("#span_no").text(value3);
			} else {
				return;
			}
		} else if(value1 == 'cart_clear') {
			if(confirm('정말 비우시겠습니까?')) {
				$("#span_proc").text(value1);
				$("#span_no").text("");
				$("#span_jumun_su").text("");
			} else {
				return;
			}
		} else if(value1 == 'cart_deleteProc') {
			if(confirm('정말 비우시겠습니까?')) {
				$("#span_proc").text(value1);
				$("#span_no").text("");
				$("#span_jumun_su").text("");
			} else {
				return;
			}
		} else if(value1 == "changeAmount") {
			$("#span_proc").text(value1);
			$("#span_no").text(value3);
		}
		
		if(value2 != '') {
			$("#span_pageNumber").text(value2);
		}
		
		goPage(value1);
	}
	
	function goPage(value1) {
		var param;
		var url = "${path}/mall_servlet/" + value1 + ".do";
		
		if(value1 == "mall_list") {
			param = {};
			param.pageNumber = $("#span_pageNumber").text();
			param.search_option = $("#span_search_option").text();
			param.search_data = $("#span_search_data").text();
		} else if(value1 == 'mall_view') {
			param = {};
			param.no = $("#span_no").text();
			param.search_option = $("#span_search_option").text();
			param.search_data = $("#span_search_data").text();
		}else if(value1 == 'cart_writeProc') {
			param = {};
			param.no = $("#span_no").text();
			param.jumun_su = $("#span_jumun_su").text();
		} else if(value1 == 'cart_list') {
			param = {};
			param.pageNumber = $("#span_pageNumber").text();
			param.search_option = $("#span_search_option").text();
			param.search_data = $("#span_search_data").text();
		} else if(value1 == 'cart_clear') {
			var chk_no = '';
			$('input[type="checkbox"]:checked').each(function(index) {
				if(index != 0) {
					chk_no += ',';
				}
				chk_no += $(this).val();
			});
			
			param = {};
			param.chk_no = chk_no;
		} else if(value1 == 'cart_deleteProc') {
			var arrayNo = [];
			var checkNo = document.getElementsByName("checkNo");
			
			for(var i = 0; i < checkNo.length; i++) {
				if(checkNo[i].checked) {
					arrayNo += "," + checkNo[i].value;
				}
			}
			
			arrayNo = arrayNo.substring(1);
			
			param = {};
			param.chk_no = arrayNo;
		} else if(value1 == "changeAmount") {
			param = {
					"no" : $("#span_no").text(),
					"amount" : $("#amount_" + $("#span_no").text()).val()
			}
		}
		
		$.ajax({
			type: "post",
			data: param,
			url: url,
			success: function(data) {
				if(value1 == 'cart_writeProc' || value1 == 'cart_clear' || value1 == 'cart_deleteProc' || value1 == 'changeAmount') {
					value1 = "cart_list";
					suntaek_proc(value1, '1', '');
				} else if(value1 == 'updateProc') {
					suntaek_proc('view', '', $("#span_no").text());
				} else {
					$("#result").html(data);
				}
			}
		});
	}
</script>