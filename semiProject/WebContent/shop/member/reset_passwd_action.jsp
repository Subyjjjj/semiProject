<%@page import="semiProject.utillity.Utillity"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="semiProject.dao.MemberDAO"%>
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
	
	//

	String id=request.getParameter("id");
	
	String Passwd=request.getParameter("newPasswd");
	System.out.println(id);
	System.out.println(Passwd);
	
	//
	//MemberDTO member=MemberDAO.getMemberDAO().selectIdMember(id);
	
	//
	String passwd=Utillity.encrypt(Passwd);
	
	MemberDAO.getMemberDAO().updateNewPw(passwd, id);
	
	session.invalidate();
	
	
	
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=login';");
		out.println("</script>");
	
%>
