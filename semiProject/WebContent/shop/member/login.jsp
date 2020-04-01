<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String message = (String)session.getAttribute("message");
	if (message == null) {
		message = "";
	} else {
		session.removeAttribute("message");
	}
	
	String id = (String)session.getAttribute("id");
	if (id == null) {
		id = "";
	} else {
		session.removeAttribute("id");
	}
%>
<!-- 로그인 시작 { -->
<div id="mb_login" class="mbskin">
    <h1>로그인</h1>

    <form id="login" name="flogin" action="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=login_processing" method="post">

    <fieldset id="login_fs">
        <legend>회원로그인</legend>
        <label for="id" class="sound_only">회원아이디<strong class="sound_only"> 필수</strong></label>
        <input type="text" name="id" id="id" value="<%=id %>" required class="frm_input required" size="20" maxLength="20" placeholder="아이디">
        <label for="passwd" class="sound_only">비밀번호<strong class="sound_only"> 필수</strong></label>
        <input type="password" name="passwd" id="passwd" required class="frm_input required" size="20" maxLength="20" placeholder="비밀번호">
        
        <p id="message" style="color: red;padding-left: 0px;padding-right: 0px;padding-bottom: 10px;"><%=message %></p>
        
        <input type="button" value="로그인" class="btn_submit">
        <input type="checkbox" name="auto_login" id="login_auto_login">
        <label for="login_auto_login">자동로그인</label>
    </fieldset>

    
    <aside id="login_info">
        <h2>회원로그인 안내</h2>
        <div>
            <a id="login_password_lost" href="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=find_id" >
            아이디 찾기</a><br>
            <a id="login_password_lost" href="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=find_pw" >
            비밀번호 찾기</a>
            <a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=register">회원가입</a>
            
        </div>
    </aside>
	</form>
</div>

<script>
$("#id").focus();

$(function(){
    $("#login_auto_login").click(function(){
        if (this.checked) {
            this.checked = confirm("자동로그인을 사용하시면 다음부터 회원아이디와 비밀번호를 입력하실 필요가 없습니다.\n\n공공장소에서는 개인정보가 유출될 수 있으니 사용을 자제하여 주십시오.\n\n자동로그인을 사용하시겠습니까?");
        }
    });
});
/*
function flogin_submit(f)
{
    return true;
}
*/
$(".btn_submit").click(function() {
	if($("#id").val()=="") {
		$("#message").text("아이디를 입력해 주세요.");
		$("#id").focus();
		return;
	}
	
	if($("#passwd").val()=="") {
		$("#message").text("비밀번호를 입력해 주세요.");
		$("#passwd").focus();
		return;
	}
	
	$("#login").submit();
});
</script>
<!-- } 로그인 끝 -->