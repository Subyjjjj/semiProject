<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>	
<%
	String orderNo=request.getParameter("orderNo");
	String orderNum=request.getParameter("orderNum");
	System.out.println(orderNo+"==="+orderNum);
%>

<form id="deliveryForm" action="<%=request.getContextPath() %>/admin_template/index.jsp?part=order&work=detail_modify_action" method="post">
	<div id="searchBox">
		<div class="board_t1" style="margin: 0 auto; width: 90%; height:75%; padding: 15px;">
		<div style="font-size: 17px; color: #F15F5F;">▶송장번호 등록</div>
		<hr />
			<input type="hidden" name="checkOrder" value="<%=orderNo%>">
			<input type="hidden" name="orderNum" value="<%=orderNum%>">
			<input type="hidden" name="orderStatus" value="4">
			<input type="hidden" name="newWindow" value="1">
			<!-- <input type="hidden" name="orderStatus" value="0"> -->
			
				
				<label>
					<select class="fSelect" name="deliveryName">
			    		<option>배송사</option>
						<option value="empty1" disabled="disabled">---------------</option>
			    		<option value="EMS">우체국택배</option>
			          	<option value="CJ">CJ</option>
			          	<option value="LOTTE">롯데</option>
			          	<option value="DEAHAN">대한통운</option>
			          	<option value="ECT">기타</option>
			        </select>
			        <input type="text" name="deliveryNum" style="width: 300px;">
				</label>
			<br />
			<div style="text-align:center; padding-top:10px;">
				<button class="btnSearch" id="submitBtn" type="submit">송장 등록</button>&nbsp;
				<button class="btnSearch" id="resetBtn" type="reset">초기화</button>&nbsp;
				<button class="btnSearch" id="cancelBtn" type="button" >취소</button>&nbsp;&nbsp;&nbsp;
			</div>
			
		</div>
	</div>
</form>

<script type="text/javascript">
$("#submitBtn").click(function() {
	
});
$("#resetBtn").click(function() {
	$("#message").text("");	
	$("#subject").focus();
});

$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=delivery";
});
	

</script>