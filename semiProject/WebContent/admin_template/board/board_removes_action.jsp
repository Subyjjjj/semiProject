<%@page import="java.io.File"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String [] checkedBoardNum= request.getParameterValues("checkedBoardNum");	
	
	String saveDirectory=request.getServletContext().getRealPath("/img/product_images");
	
	// 이미지 배열저장후 삭제 하는게 필요함

	for(String num:checkedBoardNum){
		BoardDAO.getDAO().deleteBoard(Integer.parseInt(num));
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=board&work=list';");
	out.println("</script>");

	
%>