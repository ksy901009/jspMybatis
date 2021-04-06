<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_sessionChk.jsp" %>
<div style="display: none;">
	proc : <span id="span_proc"></span><br>
	pageNumber : <span id="span_pageNumber">${pageNumber }888</span><br>
	no : <span id="span_no">${no }</span><br>
	search_option : <span id="span_search_option">${search_option }</span><br>
	search_data : <span id="span_search_data">${search_data }</span><br>
	path : <span id="span_path">${path }</span><br>
</div>
<div>
	<input type="hidden" name="" value="${no }">
	
	<h2>메모장</h2>
	
	이름 : <input type="text" id="writer" size="10"><br>
	내용 : <input type="text" id="content" size="40">
	<input type="button" id="btnSave" value="등록">
	<input type="button" id="btnUpdate" value="수정">
	<p>
</div>
<div id="result"></div>
<%@ include file="../memo/_memo.jsp" %>