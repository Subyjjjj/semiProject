<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String message = (String)session.getAttribute("message");
	if (message == null) {
		message = "";
	} else {
		session.removeAttribute("message");
	}
	
	String reId = (String)session.getAttribute("reId");
	if (reId == null) {
		reId = "";
	} else {
		session.removeAttribute("reId");
	}
%>
<div id="mb_login" class="mbskin">
    <h1>아이디 찾기</h1>

    <form id="login" name="flogin" action="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=find_id_action" method="post">

    <fieldset id="login_fs">
        <input type="text" name="find_name" id="name" required class="frm_input required" size="20" maxLength="20" placeholder="이름을 입력하세요">
        <input type="text" name="find_email" id="email" required class="frm_input required" size="20" maxLength="30" placeholder="이메일을 입력하세요">
        
        <p id="message" style="color: red;padding-left: 0px;padding-right: 0px;padding-bottom: 10px;"><%=message %></p>
        
        <input id="s_btn_submit" type="button" value="확인" class="btn_submit">
       
    </fieldset>

    
    <aside id="login_info">
        <div>
            <a href="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=find_pw" >비밀번호 찾기</a>
            <a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=register">회원가입</a>
            
        </div>
    </aside>
	</form>
</div>
<script>
$("#s_btn_submit").click(function() {
	/*검증영역시작*/
	if($("#name").val()=="") {
		$("#message").text("이름을 입력해주세요.");
		$("#name").focus();
		return;
	}
	
	if($("#email").val()=="") {
		$("#message").text("이메일을 입력해 주세요.");
		$("#email").focus();
		return;
	}
	/* 검증영역끝 */
	$("#login").submit();
});




</script>