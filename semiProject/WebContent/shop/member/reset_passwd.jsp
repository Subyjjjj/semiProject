<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id=request.getParameter("id");

	
	

%>
    
<div id="mb_login" class="mbskin">
    <h1>비밀번호 재설정</h1>

    <form id="login" name="flogin" action="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=reset_passwd_action" method="post">

    <fieldset id="login_fs">
        <input type="password" name="newPasswd" id="newPasswd" required class="frm_input required" size="20" maxLength="20" placeholder="새로운 비밀번호를 입력하세요">
        <input type="password" name="newPasswdRe" id="newPasswdRe" required class="frm_input required" size="20" maxLength="20" placeholder="새 비밀번호 재확인">
        
        <p id="passwdErr" style="color: red;padding-left: 0px;padding-right: 0px;padding-bottom: 10px;"></p>
        
        <input id="s_btn_submit" type="button" value="확인" class="btn_submit">
        <input type="hidden" name="id" value="<%=id %>" />
       
    </fieldset>

    
    <aside id="login_info">
        <div>
            <a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=login">로그인</a>
            <a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=register">회원가입</a>
            
        </div>
    </aside>
	</form>
</div>

<script type="text/javascript">
//입력란에 값을 제대로 입력했는지, 비밀번호 입력과 재입력의 값이 동일하게 입력되었는지 확인하고 값 전송
$("#s_btn_submit").click(function(){
	
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	
	if ($("#newPasswd").val() == "") {
		$("#passwdErr").text("암호를 반드시 입력해 주세요.");
		return false;
	} else if (!passwdReg.test($("#newPasswd").val())) {
		$("#passwdErr").text("암호는 영문,숫자,특수문자를 넣은 6~20자만 가능합니다.");
		return false;
	} else if ($("#newPasswd").val() != $("#newPasswdRe").val()) {
		$("#passwdErr").text("두 항목이 서로 같아야 합니다.");
		return false;
	} else {
		
	$("#login").submit();
	}
	alert("비밀번호를 재설정하였습니다. 로그인페이지로 이동합니다.");
	});


</script>
