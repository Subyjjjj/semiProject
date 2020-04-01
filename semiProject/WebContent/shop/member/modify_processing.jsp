<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.utillity.Utillity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(member_modify.jsp)에서 받은 회원정보로 테이블을 변경하고 login.jsp로 이동하는 처리페이지 --%>
<%@include file="/shop/security/login_status.jspf" %>
<%
	//겟방식 접근을 에러 페이지로 이동
	if (request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}

	//입력값을 반환받아 저장
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	if (passwd != null && !passwd.equals("")) { //비밀번호가 입력된 경우 - 새로운 비밀번호 사용
		passwd = Utillity.encrypt(passwd);
	} else { //비밀번호가 입력되지 않은 경우 - 기존 비밀번호 사용
		passwd = loginMember.getPasswd();
	}
	
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = Utillity.stripTag(request.getParameter("address2"));
	
	//DTO 인스턴스를 생성하여 반환받은 입력값으로 필드값 변경
	// => 입력값을 변환하여 필드값으로 저장
	MemberDTO member = new MemberDTO();
	member.setId(id);
	member.setPasswd(passwd);
	member.setName(name);
	member.setEmail(email);
	member.setPhone(phone);
	member.setZipcode(zipcode);
	member.setAddress1(address1);
	member.setAddress2(Utillity.stripTag(address2));
	
	//변경 회원정보를 전달하여 MEMBER 테이블에 저장된 학생정보를 변경하는 DAO 클래스의 메소드 호출
	MemberDAO.getMemberDAO().updateMember(member);
	
	//변경된 회원정보를 세션의 인증정보로 저장
	session.setAttribute("loginMember", MemberDAO.getMemberDAO().selectIdMember(id));
	
	//로그인 입력페이지로 이동
	// => 포함되는 JSP 문서에서는 리다이렉트 이동 불가능
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=mypage';");
	out.println("</script>");
%>