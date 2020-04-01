<%@page import="java.util.List"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@page import="semiProject.dto.OrderDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<%
	int orderNo=Integer.parseInt(request.getParameter("orderNo"));
	OrderDTO order= OrderDAO.getDAO().selectOneOrder(orderNo);
	String orderNum=order.getOrderNum();
%>

<p class="for_title" style="margin-top: 100px; text-align: center;">배송정보 수정</p>

<form id="deliveryForm" method="post" action="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=delivery_modify_action&orderNum=<%=orderNum%>">
<div style="width: 80%; margin: 0 auto;">
<div class="board_t2" style="width: 50%; margin: 0 auto;" >
	<div class="gLeft">
		<p class="total">
			<strong>수취인정보</strong>
			<input type="hidden" name="orderNo" value="<%=orderNo%>">
		</p>
	</div>
	<table class="admin_t">
		<tr>
			<th>수취인명</th>
			<td><input id="name" name="name" size="50" value="<%= order.getName() %>"></td>
		</tr>
		<tr>
			<th>수취인<br>전화번호</th>
			<td><input id="phone" name="phone" size="50" value="<%= order.getPhone() %>"></td>
		</tr>
		<tr>
			<th rowspan="2">배송지</th>
			<td><span>우편번호 : </span><input id="zipCode" name="zipCode" size="10"value="<%= order.getAddress().substring(0, 5) %>"></td>
		</tr>
		<tr>
			<td><span>주소 : </span><input id="address" name="address" size="50" value="<%= order.getAddress().substring(6) %>"></td>
		</tr>
		<tr>
			<th>배송메모</th>
			<%-- <td><input id="customMsg" name="customMsg"> <%if(order.getCustomMsg()!=null) { %> value="<%=order.getCustomMsg() %>"<%} %></td> --%>
			<td><textarea id="customMsg" name="customMsg" rows="12" cols="60"><%if(order.getCustomMsg()!=null) { %><%=order.getCustomMsg() %><%} %></textarea></td>
		</tr>
	</table>
	<div style="text-align:center; margin-top: 10px;">
		<button class="btnDate" id="deliveryModifyBtn" type="submit" style="width: 120px; height: 50px;">배송정보수정</button>&nbsp;
		<button class="btnDate" id="resetBtn" type="reset" style="width: 120px; height: 50px;">초기화</button>&nbsp;
		<button class="btnDate" id="cancelBtn" type="button" style="width: 120px; height: 50px;">취소</button>&nbsp;
	</div>
</div>
	<!-- <div style="text-align:center;">
		<button class="btnDate selected" type="submit" style="width: 160px; height: 50px;"><span style="font-size: 15px;">배송정보수정</span></button>&nbsp;
		<button class="btnDate" id="resetBtn" type="reset" style="width: 120px; height: 50px;"><span style="font-size: 15px;">다시입력</span></button>&nbsp;
		<button class="btnDate" id="cancelBtn" type="button" style="width: 120px; height: 50px;"><span style="font-size: 15px;">취소</span></button>&nbsp;
	</div> -->
</div>
</form>

<script type="text/javascript">
$("#deliveryForm").submit(function() {
	/* 유효성검사 */
});


$("#resetBtn").click(function() {
	$("#message").text("");	
});


$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=detail&orderNo="+<%=orderNo%>+"&orderNum="+<%=orderNum%>;
});
</script>