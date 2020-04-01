<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>	


<p class="for_title" style="text-align: center; font-size: 20px;" >관리자 메모</p> 
<form id="memoForm" action="" method="post">
	<div id="searchBox">
		<div class="board_t1" style="margin: 0 auto; width: 90%; height: 65%;">
		
				<input type="hidden" name="" value="">
				<input type="hidden" name="" value="">
				<table class="admin_t" style="height: 90%; margin: 0 auto; font-size: 14px;">
					<tr>
						<th style="width: 20%;">제목</th>
						<td colspan="1"><input type="text" name="subject" id="subject" style="width: 80%;"/></td>
					</tr>
					
					<tr>
						<th style="width: 20%;">메모 내용</th>
						<td colspan="1"><textarea id="meomoContent" cols="65" rows="10" name="memoContent"></textarea></td>
					</tr>
				</table>
				
				<br />
				<div id="message" style="color: red; text-align: center; font-size: 16px;"></div>
		</div>
	</div>
	<div style="text-align:center; padding-top: 10px;">
		<button class="btnSearch" type="submit" >메모 등록</button>&nbsp;
		<button class="btnSearch" id="resetBtn" type="reset">초기화</button>&nbsp;
		<button class="btnSearch" id="cancelBtn" type="button" >취소</button>&nbsp;&nbsp;&nbsp;
	</div>
	
</form>

<script type="text/javascript">
$("#resetBtn").click(function() {
	$("#message").text("");	
	$("#subject").focus();
});

$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list";
});
	

</script>