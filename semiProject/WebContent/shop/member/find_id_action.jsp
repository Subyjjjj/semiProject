<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javaxcript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=error400';");
		out.println("</script>");
		return;
	}

	//입력 값을 반환 받아 저장
	String rName=request.getParameter("find_name");
	//이름값을 제대로 가져오지 못했을 때 에러페이지로 이동하는 구간
	String rEmail=request.getParameter("find_email");
	
	
	//인증처리 - 이름과 이메일을 전달하여 id에 저장된 회원정보를 검색하여 DAO 클래스의 메소드를 호출
	String reId=MemberDAO.getMemberDAO().selectNameMemberId(rName, rEmail);
	
	//불러온 아이디가 없을때
	//reId는 abc123
	if (reId == null) {
		session.setAttribute("message", "입력하신 정보에 대한 아이디가 존재하지 않습니다.");
		session.setAttribute("reId", reId);
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=find_id';");
		out.println("</script>");
		return;
	}
	
%>
<div>
	<form id="postIdForm" action="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=view_id" method="POST">
	
		<input name="postReId" value="<%=reId %>" />
	
	</form>
</div>
<script>
$(function(){
	$("#postIdForm").submit();
});
</script>