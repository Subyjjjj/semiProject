<%@page import="java.io.File"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	
	String saveDirectory=request.getServletContext().getRealPath("/img/product_images");

	String productImage1=ProductDAO.getDAO().selectNumProduct(productNum).getProductImage1();
	String productImage2=ProductDAO.getDAO().selectNumProduct(productNum).getProductImage2();
	String productImage3=ProductDAO.getDAO().selectNumProduct(productNum).getProductImage3();
	
	ProductDAO.getDAO().deleteProduct(productNum);
	
	// 실제로 행이 삭제된 경우 제품의 이미지를 제거
	new File(saveDirectory, productImage1).delete();
	new File(saveDirectory, productImage2).delete();
	new File(saveDirectory, productImage3).delete();
	
	// 목록 페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=product&work=list';");
	out.println("</script>");

%>