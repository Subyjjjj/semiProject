<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//입력값 캐릭터셋 변경
	request.setCharacterEncoding("utf-8");	

	String part = request.getParameter("part");
	if (part == null) {
		part = "shop";
	}
	
	String content = request.getParameter("content");
	if (content == null) {
		content = "main";
	}
%>

<jsp:forward page="template.jsp">
	<jsp:param value="<%= part %>" name="part"/>
	<jsp:param value="<%= content %>" name="content"/>
</jsp:forward>