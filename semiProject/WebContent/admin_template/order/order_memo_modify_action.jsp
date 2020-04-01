<%@page import="semiProject.dto.OrderDTO"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String standardNo=request.getParameter("orderNo");
	String orderNum=request.getParameter("orderNum");
	String adminMemo=request.getParameter("adminMemo").replace("<", "&lt;").replace(">", "&gt;");
	
	OrderDAO.getDAO().updateAdminMemo(orderNum, adminMemo);

	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=order&work=detail&orderNum="+orderNum+"&orderNo="+standardNo+"';");
	out.println("</script>");
	
%>
