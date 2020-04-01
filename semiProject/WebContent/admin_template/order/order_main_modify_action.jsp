<%@page import="semiProject.dto.OrderDTO"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 메인페이지에서 요청한경우 :  주문번호, 주문상태--%>
<%
	String[] orderNum=request.getParameterValues("checkOrder");
	//String orderNum=request.getParameter("orderNum");
	String changeStatus=request.getParameter("orderStatusBotttom");
	int orderStatus=0;
	if(changeStatus!=null) {
		orderStatus=Integer.parseInt(request.getParameter("orderStatusBotttom"));
	}
	
	for(String num:orderNum){
		OrderDAO.getDAO().updateMainAtOnce(num, orderStatus);
	}

	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=order&work=list';");
	out.println("</script>");
	
%>
