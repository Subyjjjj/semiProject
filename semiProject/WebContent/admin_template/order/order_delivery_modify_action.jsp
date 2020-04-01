<%@page import="semiProject.dto.OrderDTO"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String orderNo=request.getParameter("orderNo");
	String orderNum=request.getParameter("orderNum");
	String name=request.getParameter("name");
	String phone=request.getParameter("phone");
	String zipCode=request.getParameter("zipCode");
	String address1=request.getParameter("address");
	String address=zipCode+address1;
	String customMsg="";
	if(request.getParameter("customMsg")!=null){
		customMsg=request.getParameter("customMsg");
	}
	
	OrderDAO.getDAO().updatedelivery(orderNum, name, phone, address, customMsg);
	
	
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=order&work=detail&orderNum="+orderNum+"&orderNo="+orderNo+"';");
	out.println("</script>");
%>
