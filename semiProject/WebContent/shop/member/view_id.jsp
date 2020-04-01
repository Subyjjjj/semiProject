<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="mb_login" class="mbskin">
    <h1>아이디 찾기 완료</h1>
	귀하의 아이디는 <%=request.getParameter("postReId") %>입니다. <!-- find_id_action페이지의 form에서 name값을 변수로 가져온다 -->
	<br>
	<br>
	<a id="back_to_login" href="<%=request.getContextPath() %>/index.jsp?part=shop/member&content=login">로그인으로 돌아가기</a>
</div>

<style>
	#mb_login{
		height: 250px;
	}
	#back_to_login{
		background-color: #741945;
		color: #ffffff;
		padding: 10px;
		font-weight: 500;
	}
</style>