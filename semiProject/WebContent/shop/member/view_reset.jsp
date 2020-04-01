<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="mb_login" class="mbskin">

    <h1>비밀번호 재설정이 완료되었습니다</h1>
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