<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 스레드 이동 JSP --%>
<%
	request.setCharacterEncoding("utf-8");
	// 요청값저장
	String part= request.getParameter("part");
	if(part==null) part="main";
	String work= request.getParameter("work");
	if(work==null) work="display";

%>

<%-- 페이지 이동 설정 --%>
<jsp:forward page="layout/template.jsp">
	<jsp:param value="<%= part %>" name="part"/>
	<jsp:param value="<%= work %>" name="work"/>
</jsp:forward>
