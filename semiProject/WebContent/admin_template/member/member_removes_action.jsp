<%@page import="semiProject.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String [] checkedId= request.getParameterValues("checkedId");	
	
	for(String id:checkedId){
		MemberDAO.getMemberDAO().updateStatus(id);
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=member&work=list';");
	out.println("</script>");

	
%>