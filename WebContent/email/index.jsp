<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/inc_header.jsp" %>

<div id="result"></div>
asdasds
<script>
	$(document).ready(function(){
		<c:if test="${menu_gubun == 'email_index'}">
			goPage('write');
		</c:if>
	});
	
	function goPage(value1) {
		var url = "${path}/email_servlet/" + value1 + ".do";
		
		if(value1 == 'write') {
			var param = {}
		} else if(value1 == 'writeProc') {
			var param = {
					"fromName" : $("#fromName").val(),
					"fromEmail" : $("#fromEmail").val(),
					"toEmail" : $("#toEmail").val(),
					"subject" : $("#subject").val(),
					"content" : $("#content").val()
			}
		}
		
		$.ajax({
			type : "post",
			data : param,
			url : url,
			success : function(data){
				if(value1 == "write") {
					$("#result").html(data);
				} else {
					goPage('write');
				}
			}
		});
	}
</script>