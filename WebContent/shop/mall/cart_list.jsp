<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/inc_header.jsp" %>
<table border="0" align="center" width="80%">
	<tr>
		<td colspan="7">
			<h2>장바구니 목록</h2>
		</td>
	</tr>
	<tr>
		<td style="padding: 10px 0px 5px;">전체 ${totalRecord }건입니다.</td>
	</tr>
	<c:if test="${totalRecord == 0 }">
		<tr>
			<td height="200">
				<table border="1" align="center" style="width:100%; height:200px;">
					<tr>
						<td align="center">장바구니에 등록된 상품이 없습니다.</td>
					</tr>
				</table>
			</td>
		</tr>
	</c:if>
	<c:if test="${totalRecord > 0 }">
		<tr>
			<td>
				<table border="1" align="center" style="width:100%;">
					<tr align="center">
						<td>
							<input type="checkbox" id="checkAll" onchange="checkAll(event);">
						</td>
						<td>상품사진</td>
						<td>상품명</td>
						<td>가격</td>
						<td>구매수량</td>
						<td>금액</td>
						<td>등록일</td>
					</tr>
					<c:set var="checkAllPrice" value="0"/>
					<c:forEach var="dto" items="${list }">
						<tr>
							<td align="center">
								<input type="checkbox" id="checkNo" name="checkNo" onchange="priceCalculator(event, '${dto.buy_money }');" value="${dto.no }">
							</td>
							<td>
								<c:choose>
									<c:when test="${fn:split(dto.product_img, ',')[0] == '-' }">
										<a href="#" onclick="suntaek_proc('mall_view', '', '${dto.no}');">이미지X</a>
									</c:when>
									<c:otherwise>
										<c:set var="temp1" value="${fn:split(dto.product_img, ',')[0] }"></c:set>
										<c:set var="temp2" value="${fn:split(temp1, '|')[0] }"></c:set>
										<c:set var="temp3" value="${fn:split(temp1, '|')[1] }"></c:set>
										<a href="#" onclick="suntaek_proc('mall_view', '', '${dto.no}');">
											<img src="${path }/attach/product_img/${temp3}" alt="0" title="0" style="width:50px; height:50px;">
										</a>
									</c:otherwise>
								</c:choose>
							</td>
							<td>${dto.product_name }</td>
							<td>${dto.product_price }</td>
							<td>
								<select name="amount_${dto.no }" id="amount_${dto.no }" onchange="changeAmount('${dto.no }');">
									<c:forEach var="i" begin="1" end="20" step="1">
										<c:choose>
											<c:when test="${dto.amount == i}">
												<option value="${i }" selected>${i }</option>
											</c:when>
											<c:otherwise>
												<option value="${i }">${i }</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								${dto.amount }
							</td>
							<td>${dto.buy_money }</td>
							<td>${dto.regi_date }</td>
							<c:set var="jj" value="${jj = jj - 1 }" />						
							<c:set var="checkAllPrice" value="${checkAllPrice = checkAllPrice + dto.buy_money }" />
						</tr>
					</c:forEach>
					<tr align="right">
						<td colspan="7">
							<span id="checkAllPrice" style="display: none;">${checkAllPrice }</span> <%--총 가격을 checkAll 체크박스 script로 조절 하기 위한 span 태그--%>
							합계금액 : <span id="resultPrice"></span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td colspan="7" height="50" align="center">
				<c:set var="tempGubun" value="cart_list"></c:set>
				
				<a href="#" onclick="suntaek_proc('${tempGubun }', '1', '');">[첫페이지]</a>&nbsp;&nbsp;
				
				<c:if test="${startPage > blockSize }">
					<a href="#" onclick="suntaek_proc('${tempGubun }', '${startPage - blockSize}', '');">[이전10개]</a>
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
						<a href="#" onclick="suntaek_proc('${tempGubun }', '${i}', '');">${i }</a>
					</c:if>
				</c:forEach>
				
				&nbsp;
				<c:if test="${lastPage < totalPage }">
					<a href="#" onclick="suntaek_proc('${tempGubun }', '${startPage + blockSize}', '');">[다음10개]</a>
				</c:if>
				<c:if test="${lastPage >= totalPage }">
					[다음10개]
				</c:if>
				
				&nbsp;&nbsp;
				<a href="#" onclick="suntaek_proc('${tempGubun }', '${totalPage}', '');">[끝페이지]</a>&nbsp;&nbsp;
			</td>
		</tr>
	</c:if>
	<tr>
		<td colspan="7" height="50" align="right">
			<button type="button" onclick="suntaek_proc('cart_deleteProc', '1', '${dto.productNo}');">장바구니비우기</button>
			<button type="button" onclick="suntaek_proc('mall_list', '1', '');">쇼핑하기</button>
			<button type="button" onclick="suntaek_proc('cart_list', '1', '');">주문하기</button>
		</td>
	</tr>
</table>
<script>
	function priceCalculator(event, resultPrice) {
		var prePrice = document.getElementById("resultPrice").innerHTML;
		if(prePrice == '') {
			prePrice = 0;
		}
		prePrice = parseInt(prePrice);
		
		if(event.target.checked)  {
			prePrice += parseInt(resultPrice);
		} else {
			prePrice -= parseInt(resultPrice);
		}
		
		document.getElementById("resultPrice").innerHTML = prePrice;
	}
	
	function checkAll(event) {
		var checkNo = document.getElementsByName("checkNo");
		
		for(var i = 0; i < checkNo.length; i++) {
			if(event.target.checked) {
				checkNo[i].checked = true;
				document.getElementById("resultPrice").innerHTML = document.getElementById("checkAllPrice").innerHTML;
			} else {
				checkNo[i].checked = false;
				document.getElementById("resultPrice").innerHTML = '0';
			}
		}
	}
	
	function changeAmount(no) {
// 		alert("no >>> " + no);
		suntaek_proc('changeAmount', '', no);
	}
</script>