<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_sessionChk.jsp" %>
<table border="1" align="center" width="100%">
	<tr>
		<td colspan="11"><h2>회원목록</h2></td>
	</tr>
	<tr>
		<td colspan="11">
			<select name="search_option" id="search_option">
				<c:choose>
					<c:when test="${search_option == 'id' }">
						<option value="">- 선택 -</option>
						<option value="id" selected>아이디</option>
						<option value="name">이름</option>
						<option value="gender">성별</option>
						<option value="id_name_gender">아이디+이름+성별</option>
					</c:when>
					<c:when test="${search_option == 'name' }">
						<option value="">- 선택 -</option>
						<option value="id">아이디</option>
						<option value="name" selected>이름</option>
						<option value="gender">성별</option>
						<option value="id_name_gender">아이디+이름+성별</option>
					</c:when>
					<c:when test="${search_option == 'gender' }">
						<option value="">- 선택 -</option>
						<option value="id">아이디</option>
						<option value="name">이름</option>
						<option value="gender" selected>성별</option>
						<option value="id_name_gender">아이디+이름+성별</option>
					</c:when>
					<c:when test="${search_option == 'id_name_gender' }">
						<option value="">- 선택 -</option>
						<option value="id">아이디</option>
						<option value="name">이름</option>
						<option value="gender">성별</option>
						<option value="id_name_gender" selected>아이디+이름+성별</option>
					</c:when>
					<c:otherwise>
						<option value="" selected>- 선택 -</option>
						<option value="id">아이디</option>
						<option value="name">이름</option>
						<option value="gender">성별</option>
						<option value="id_name_gender">아이디+이름+성별</option>
					</c:otherwise>
				</c:choose>
			</select>
			<input type="text" name="search_data" id="search_data" value="${search_data }" style="width: 150px;">
			&nbsp;
			<input type="button" value="검색" onclick="search();">
			
			<script>
				function search() {
					if(confirm('검색 OK?')) {
						$("#span_search_option").text($("#search_option").val());
						$("#span_search_data").text($("#search_data").val());
						suntaek_proc('list', '1', '');
					}
				}
			</script>
		</td>
	</tr>
	<tr>
		<td colspan="11">${totalRecord }명의 회원이 있습니다.</td>
	</tr>
	<tr>
		<th>순번</th>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>성별</th>
		<th>출생년도</th>
		<th>우편번호</th>
		<th>주소</th>
		<th>상세주소</th>
		<th>참고항목</th>
		<th>작성일</th>
	</tr>
	<c:if test="${list.size() == 0 }">
		<tr>
			<td colspan="11" height="200">
				등록된 회원이 없습니다.
			</td>
		</tr>
	</c:if>
	<c:forEach var="row" items="${list }">
		<tr>
			<td>${row.no}</td>
			<td>
				<a href="#" onclick="suntaek_proc('view', '0', '${row.no}');">
					${row.id}
				</a>
			</td>
			<td>${row.passwd}</td>
			<td>${row.name}</td>
			<td>${row.gender}</td>
			<td>${row.bornYear}</td>
			<td>${row.postCode}</td>
			<td>${row.address}</td>
			<td>${row.detailAddress}</td>
			<td>${row.extraAddress}</td>
			<td>${row.regiDate}</td>
		</tr>
	</c:forEach>
	<c:if test="${totalRecord > 0 }">
		<tr>
			<td colspan="11" align="center">
				<div style="display: none;">
					pageNumber : ${pageNumber }<br>
					pageSize : ${pageSize }<br>
					blockSize : ${blockSize }<br>
					totalRecord : ${totalRecord }<br>
					jj : ${jj }<br>
					startRecord : ${startRecord }<br>
					lastRecord : ${lastRecord }<br>
					totalPage : ${totalPage }<br>
					startPage : ${startPage }<br>
					lastPage : ${lastPage }
				</div>
				
				<a href="#" onclick="suntaek_proc('list', '1', '');">[첫페이지]</a>&nbsp;&nbsp;
				
				<c:if test="${startPage > blockSize }">
					<a href="#" onclick="suntaek_proc('list', '${startPage - blockSize }', '');">[이전10개]</a>
				</c:if>
				<c:if test="${startPage <= blockSize }">
					[이전10개]
				</c:if>
				&nbsp;
				
				<c:forEach var="i" begin="${startPage }" end="${lastPage }" step="1">
					<c:if test="${i == pageNumber }">
						[${i }]
					</c:if>
					<c:if test="${i != pageNumber }">
						<a href="#" onclick="suntaek_proc('list', '${i}', '');">${i }</a>
					</c:if>
				</c:forEach>
				
				&nbsp;
				<c:if test="${lastPage < totalPage }">
					<a href="#" onclick="suntaek_proc('list', '${startPage + blockSize}', '');">[다음10개]</a>
				</c:if>
				<c:if test="${lastPage >= totalPage }">
					[다음10개]
				</c:if>
				
				&nbsp;&nbsp;
				<a href="#" onclick="suntaek_proc('list', '${totalPage}', '');">[끝페이지]</a>&nbsp;&nbsp;
			</td>
		</tr>
	</c:if>
	<tr>
		<td colspan="11" height="50" align="right">
			<button type="button" onclick="suntaek_all();">전체목록</button>
			<button type="button" onclick="suntaek_proc('write', '1', '');">회원가입</button>
		</td>
	</tr>
</table>
<%
// String pageNumber_ = request.getParameter("pageNumber");
// pageNumber_ = "12a45";

// if(pageNumber_ == null || pageNumber_.trim().equals("")) {
// 	pageNumber_ = "1";
// }

// char imsi;
// for(int i = 0; i < pageNumber_.length(); i++) {
// 	imsi = pageNumber_.charAt(i);
// 	if(imsi >= '0' && imsi <= '9') {
// 		out.println(imsi + " : 숫자입니다.<br>");
// 	} else if(imsi >= 'a' && imsi <= 'z') {
// 		out.println(imsi + " : 소문자입니다.<br>");
// 	} else if(imsi >= 'A' && imsi <= 'Z') {
// 		out.println(imsi + " : 대문자입니다.<br>");
// 	} else {
// 		out.println(imsi + " : 그냥 문자입니다.<br>");
// 	}
// }
%>