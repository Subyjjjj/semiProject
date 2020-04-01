<%@page import="semiProject.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 카트에서 체크된 물건들을 삭제 처리하는 페이지 --%>
<%@include file="/shop/security/login_status.jspf" %>
<%
	if (request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}

	//삭제하고자 하는 카트의 아이디 값(int)들 불러오기
	String[] cartNum = request.getParameterValues("ct_chk");
	
	//카트 아이디를 전달하여 CART 테이블에 저장된 해당 회원정보를 삭제하는 DAO 메소드 호출
	for (String num: cartNum) {
		CartDAO.getDAO().deleteCart(Integer.parseInt(num));
	}
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/order&content=cart';");
	out.println("</script>");
%>