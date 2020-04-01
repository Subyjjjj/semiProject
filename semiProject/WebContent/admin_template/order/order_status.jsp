<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>	
<script src="https://kit.fontawesome.com/76211070e2.js"></script>     

<form id="statusForm" action="" method="post">
	<div id="searchBox">
		<div class="board_t1" style="margin: 0 auto; width: 90%; height:75%; padding: 15px;">
		<div style="font-size: 17px; color: #F15F5F;">▶결제상태 변경</div>
		<hr />
			<input type="hidden" name="" value="">
			<input type="hidden" name="" value="">
				
				<label>
					<i class="fas fa-check" aria-hidden="true"></i>
					선택한 주문의 상태를&nbsp;
					<select class="fSelect" name="changeStatus" style="width: 200px;">
			    		<option>주문상태</option>
						<option value="empty1" disabled="disabled">---------------</option>
			    		<option value="1">결제대기</option>
			          	<option value="2">결제완료</option>
			          	<option value="3">배송준비중</option>
			          	<option value="4">배송중</option>
			          	<option value="5">배송완료</option>
			          	<option value="6">구매확정</option>
			        </select>
			        로 변경합니다.
				</label>
				
			<br />
			<div style="text-align:center; padding-top:10px;">
				<button class="btnSearch" type="submit" >상태 변경</button>&nbsp;
				<button class="btnSearch" id="resetBtn" type="reset">초기화</button>&nbsp;
				<button class="btnSearch" id="cancelBtn" type="button" >취소</button>&nbsp;&nbsp;&nbsp;
			</div>
			
		</div>
	</div>
</form>

<script type="text/javascript">
$("#resetBtn").click(function() {
	$("#message").text("");	
	$("#subject").focus();
});

$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=delivery";
});
	

</script>