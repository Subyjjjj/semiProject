<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="semiProject.utillity.Utillity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- login.jsp에서 전달된 정보를 처리하는 문서. --%>
<%
	
	//비정상적인 요청에 대한 응답처리
	if (request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}

	//입력값을 반환받아 저장
	String id = request.getParameter("id");
	String passwd = Utillity.encrypt(request.getParameter("passwd"));
		
	//아이디 값으로 멤버 인스턴스를 저장하기 위한 메소드 호출
	MemberDTO member = MemberDAO.getMemberDAO().selectIdMember(id);
		
	//아이디가 없을시
	if (member == null) {
		session.setAttribute("message", "입력한 아이디가 존재하지 않습니다.");
		session.setAttribute("id", id);
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=login';");
		out.println("</script>");
		return;
	}
	
	//비밀번호 인증실패
	if (!member.getPasswd().equals(passwd)) {
		session.setAttribute("message", "입력된 아이디가 없거나 비밀번호가 맞지 않습니다.");
		session.setAttribute("id", id);
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=login';");
		out.println("</script>");
		return;
	}
	
	//탈퇴한 회원 로그인 제한.
	if(member.getStatus() == 0) {
		session.setAttribute("message", "탈퇴한 회원입니다.");
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=login';");
		out.println("</script>");
		return;
	}
	
	//마지막 로그인 날짜 갱신 메소드
	MemberDAO.getMemberDAO().updateLastLogin(id);
	
	//세션에 인증정보 저장
	session.setAttribute("loginMember", MemberDAO.getMemberDAO().selectIdMember(id));
	
	//기존 url 주소 반환받아 저장
	String uri = (String)session.getAttribute("uri");
	
	//페이지 이동
	if (uri == null) { //기존 요청 페이지가 없음
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp';");
		out.println("</script>");
	} else { //기존 요청 페이지 존재
		session.removeAttribute("uri");
		out.println("<script type='text/javascript'>");
		out.println("location.href='" + uri + "';");
		out.println("</script>");
	}
%>