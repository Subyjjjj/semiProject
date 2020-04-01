<%@page import="java.io.File"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
 	
	int num=Integer.parseInt(request.getParameter("boardNum"));
	BoardDTO board=BoardDAO.getDAO().selectNumBoard(num);
	
	// 이미지 경로 지정 다시해야함 
	
	String saveDirectory=request.getServletContext().getRealPath("/img/product_images");

	String boardImage=BoardDAO.getDAO().selectNumBoard(num).getImage();
	
	new File(saveDirectory, boardImage).delete();
	
	BoardDAO.getDAO().deleteBoard(num);
	
	if(board==null || board.getStatus()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/site/index.jsp?part=shop/error&content=error400';"); 
		out.println("</script>");
		return;
	}
	
	// 목록 페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=board&work=list';");
	out.println("</script>");

%>