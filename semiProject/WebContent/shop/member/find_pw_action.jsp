<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=error400';");
		out.println("</script>");
		return;
	}

	//입력 값을 반환받아 저장
	String id=request.getParameter("find_id");
	String email=request.getParameter("find_email");
	
	//입력한 아이디와 이메일을 전송하여 pw에 저장된 회원정보를 통해 DAO 클래스의 메소드를 호출
	String rePw=MemberDAO.getMemberDAO().selectIdMemberPw(id, email);
	
	
	//입력 값이 저장된 pw와 일치하지 않는다면 메시지를 출력해라
	if(rePw==null){
		session.setAttribute("message", "입력한 정보가 일치하지 않습니다");
		//session.setAttribute("rePw", rePw);
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=find_pw';");
		out.println("</script>");
		return;
		
	}
		
	
		session.setAttribute("rePw", rePw);
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=reset_passwd&id="+id+"';");
		out.println("</script>");
		
	
%>
