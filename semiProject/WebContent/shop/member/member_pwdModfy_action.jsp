<%@page import="semiProject.utillity.Utillity"%>
<%@page import="semiProject.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<%
	String id=request.getParameter("pwid");
	String passwd=request.getParameter("passwd");	

	if(passwd!=null && !passwd.equals("")){
		passwd=Utillity.encrypt(passwd);
		MemberDAO.getMemberDAO().updateMemberPw(id, passwd);		
		
		out.println("<script type='text/javascript'>");	
		out.println("alert('비밀번호를 재설정하였습니다. 로그인페이지로 이동합니다.');");
		out.println("window.close");			
		out.println("</script>");
	}


%>