<%@page import="semiProject.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 	//action에서 setAttribute을 통해 전달된 값으 getAttribute로 받아 출력
	String message=(String)session.getAttribute("messaege");
	if(message==null){
		message= "";
	} else {
		session.removeAttribute("message");
	}
	
	
%>

    
<div id="mb_login" class="mbskin">
    <h1>비밀번호 찾기</h1>

    <form id="login" name="flogin" action="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=find_pw_action" method="post">

    <fieldset id="login_fs">
        <input type="text" name="find_id" id="id" required class="frm_input required" size="20" maxLength="20" placeholder="아이디를 입력하세요">
        <input type="text" name="find_email" id="email" required class="frm_input required" size="20" maxLength="20" placeholder="이메일을 입력하세요">
        
        <p id="message" style="color: red;padding-left: 0px;padding-right: 0px;padding-bottom: 10px;"><%=message %></p>
        
        <input id="s_btn_submit" type="button" value="확인" class="btn_submit">
       
    </fieldset>

    
    <aside id="login_info">
        <div>
            <a href="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=find_id" >아이디 찾기</a>
            <a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=register">회원가입</a>
            
        </div>
    </aside>
	</form>
</div>

<script type="text/javascript">
$("#s_btn_submit").click(function() {
	/*검증영역시작*/
	if($("#id").val()=="") {
		$("#message").text("아이디를 입력해주세요.");
		$("#id").focus();
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