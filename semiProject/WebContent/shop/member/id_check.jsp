<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- ★★★★★★★★★★★★★★★ --%>
<%-- 회원정보 입력페이지(member_join.jsp)에서 전달된 아이디를 반환받아 MEMBER 테이블에 저장된 아이디와 비교하여 사용 가능 여부를 클라이언트에게 전달하는 jsp 문서 --%>
<%--	=> 아이디 사용 불가능(중복) : 사용 불가 메세지 전달 && 아이디 입력 후 재요청하도록 --%>
<%--	=> 아이디 사용 가능(중복x) : 사용 가능 메세지 전달 && 부모창에 아이디 입력태그에 아이디 출력 --%>
<%
	// 비정상적인 요청에 대한 응답 처리(입력값이 없는 경우; window.open을 통해 GET 방식으로 요청하므로 GET은 상관x)
	if(request.getParameter("id")==null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

	// 입력값을 반환받아 저장
	String id=request.getParameter("id");
	
	// 아이디를 전달하여 MEMBER 테이블에 저장된 회원정보를 검색하는 DAO 클래스의 메소드 호출
	// 	=> null 반환 : 회원정보 미검색 - 전달된 아이디 사용 가능
	// 	=> MemberDTO 인스턴스 반환 : 회원정보 검색 - 전달된 아이디 사용 불가능
	MemberDTO member=MemberDAO.getMemberDAO().selectIdMember(id);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900|Noto+Serif+KR:200,300,400,500,600,700,900|Philosopher:400,400i,700,700i&display=swap');
body {
	
}

div {
	text-align: center;
	margin: 10px;
	font-family: 'Philosopher','Noto Serif KR';
}

.id {
	color: red;
}
</style>
</head>
<body>
	<% if(member==null) { // 아이디 사용 가능 %>
		<div>입력한 <span class="id">[<%=id %>]</span>는 사용 가능한 아이디입니다.<br>&nbsp;</div>
		<div><button type="button" onclick="windowClose();" class="btn btn-primary">아이디 사용</button></div>
	<% } else { // 아이디 사용 불가능 %>
		<div id="message">입력한<span class="id">[<%=id %>]</span>는 이미 사용 중인 아이디입니다.<br>
		다른 아이디를 입력하고 [확인]을 눌러 주세요.</div>
		<%-- form 태그의 action 속성이 생략된 경우 현재 jsp 문서를 재요청 --%>
		<%-- form 태그의 method 속성이 생략된 경우 GET 방식으로 요청하여 입력 --%>
		<div>
			<form name="form" onsubmit="return submitCheck();"> <!-- submit 버튼을 눌렀을 때 메소드로 이동. false 일경우 submit 기능 제거 or true일 경우 submit -->
				<input type="text" name="id">
				<button type="submit" class="btn btn-primary">확인</button>
			</form>
		</div>
	<% } %>
	
	<script type="text/javascript">
	function windowClose() {
		// opener : BOM에서 부모창(member_join.jsp)을 의미. joinForm은 form태그의 name 속성값.
		// id 입력태그에 id 값 집어넣기
		opener.fregisterform.id.value="<%=id %>"; 
		opener.fregisterform.idCheckResult.value="1"; // 아이디 중복체크를 하면 member_join.jsp의 input 태그(name=idCheckResult) 속성이 1로 바뀜
		window.close(); // 창닫기
	}
	
	function submitCheck() {
		var id=form.id.value; // 현재 문서의 form 태그의 name속성값 id 를 가져옴
		if(id=="") {
			document.getElementById("message").innerHTML="아이디를 입력해주세요.<br>&nbsp;";
			document.getElementById("message").style="color: red;";
			return false;
		}
	
		
		var idReg=/^[a-zA-Z]\w{5,19}$/g;
		if(!idReg.test(id)) {
			document.getElementById("message").innerHTML="아이디는 영문자로 시작되는 영문자,숫자,_의 6~20범위의 문자로만 작성 가능합니다.";
			document.getElementById("message").style="color: red;";
			return false;
		}
	}
	</script>
</body>
</html>