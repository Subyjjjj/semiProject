<%@page import="semiProject.utillity.Utillity"%>
<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- register_form.jsp에서 post 방식으로 전달된 데이터의 DB입력 처리를 위한 JSP 파일. --%>
<%
	//get 방식의 접근 차단
	if(request.getMethod().equals("GET")) {
		response.sendRedirect("/semiProject/index.jsp");
		return;
	}

	
	
	//입력값 저장
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	phone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7);
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	
	//DTO 인스턴스의 필드값 변경
	MemberDTO member = new MemberDTO();
	member.setId(id);
	member.setPasswd(Utillity.encrypt(passwd));
	member.setName(Utillity.stripTag(name));
	member.setEmail(email);
	member.setPhone(phone);
	member.setZipcode(zipcode);
	member.setAddress1(address1);
	member.setAddress2(address2);
	
	//DB의 멤버 테이블에 필드값 입력
	MemberDAO.getMemberDAO().insertMember(member);
	
	//6)로그인 입력페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=login';");
	out.println("</script>");

%>