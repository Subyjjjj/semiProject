<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.utillity.Utillity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호 입력페이지(member_modify.jsp)에서 전달된 회원정보를 반환받아 
		비교 후 회원탈퇴 처리하고 로그아웃 처리페이지(member_logout_action.jsp)로 이동하는 JSP 문서 --%>
<%-- => 비로그인 상태에서 요청(비정상적인 요청)한 경우 에러페이지(error400.jsp) 이동 --%>
<%-- => 비밀번호가 틀릴 경우 비밀번호 입력페이지로 이동 --%>
<%@include file="/shop/security/login_status.jspf" %>
<%
	if (request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}
	
	//입력값을 반환받아 저장
	String passwd = Utillity.encrypt(request.getParameter("passwd"));
	//System.out.println("테스트");
	//System.out.println(passwd);
	//System.out.println(loginMember.getPasswd());
	
	//입력 비밀번호를 로그인 사용자의 비밀번호와 비교하여 맞지 않을 경우
	if (!passwd.equals(loginMember.getPasswd())) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=remove_confirm';");
		out.println("</script>");
		return;
	}
	
	//로그인 사용자의 아이디를 전달하여 MEMBER 테이블에 저장된 회원정보를 
	//삭제하는 DAO 클래스의 메소드 호출
	MemberDAO.getMemberDAO().updateStatus(loginMember.getId());
	
	//로그아웃 처리페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=logout';");
	out.println("</script>");
%>
