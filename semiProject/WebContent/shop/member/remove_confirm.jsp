<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/login_status.jspf" %>
<%
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>
<!-- 회원 비밀번호 확인 시작 { -->
<div id="mb_confirm" class="mbskin">
    <h1>회원 비밀번호 확인</h1>

    <p>
        <strong>비밀번호를 한번 더 입력해주세요.</strong>
                회원님의 정보를 안전하게 보호하기 위해 비밀번호를 한번 더 확인합니다.
            </p>

    <form name="passwdForm" action="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=remove_processing" onsubmit="return sumbitCheck();" method="post">

    <fieldset>
        <span class="confirm_id">회원아이디</span>
        <span id="mb_confirm_id"><%=loginMember.getId() %></span>
        <label for="confirm_mb_password" class="sound_only">비밀번호<strong>필수</strong></label>
        <input type="password" name="passwd" id="confirm_mb_password" required class="required frm_input" size="15" maxLength="20" placeholder="비밀번호">
        <p id="message" style="color: red;padding-left: 0px;padding-right: 0px;padding-bottom: 10px;"><%=message %></p>
        
        <input type="submit" value="확인" id="btn_submit" class="btn_submit">
    </fieldset>

    </form>

</div>

<script type="text/javascript">
function sumbitCheck() {
	if(passwdForm.passwd.value=="") {
		document.getElementById("message").innerHTML="비밀번호를 입력해주세요.";
		passwdForm.passwd.focus();		
		return false;
	}
	return true;
}
</script>