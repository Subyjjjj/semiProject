<%@page import="semiProject.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String[] checkedProductNum=request.getParameterValues("checkedProductNum");
	
	for(String productNum:checkedProductNum){
		int now=Integer.parseInt(productNum);
		ProductDAO.getDAO().soldoutProduct(now);
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=product&work=list';");
	out.println("</script>");
%>
