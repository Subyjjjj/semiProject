<%@page import="java.io.File"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력페이지(board_modify.jsp)에서 전달된 값을 반환받아 BOARD테이블에 저장된 게시글을 변경하고 게시글 출력페이지로 이동하는 JSP문서 --%>
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';"); //원래 405권장
		out.println("</script>");
		return;
	}	

	String saveDirectory=request.getServletContext().getRealPath("/shop/bbs_images");
	// 파일을 입력 할 수도있고 아닐수도 있음 >> 미입력시 파일업로드 X
	MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	// 해당 게시물의 카테고리 값을 불러와 변수에 저장
	int category = BoardDAO.getDAO().selectNumBoard(Integer.parseInt(mr.getParameter("num"))).getCategory();

	// 전달값을 반환받아 저장
	int num=Integer.parseInt(mr.getParameter("num"));
	String pageNum=mr.getParameter("pageNum");
	String search=mr.getParameter("search");
	String keyword=mr.getParameter("keyword");
	String subject=mr.getParameter("subject").replace("<", "&lt;").replace(">", "&gt;");
	int status=0;
	if(mr.getParameter("secret")!=null) {
		status=Integer.parseInt(mr.getParameter("secret"));
	}
	String content=mr.getParameter("content").replace("<", "&lt;").replace(">", "&gt;");
	String image = mr.getFilesystemName("image");
	
	//기존 이미지 파일명 변수에 저장
	String currentImage = mr.getParameter("currentImage");
	
	//DTO인스턴스 생성하고 필드값 변경
	BoardDTO board=new BoardDTO();
	board.setNum(num);
	board.setSubject(subject);
	board.setContent(content);
	board.setStatus(status);
	if (image != null) {
		board.setImage(image); //게시판 이미지를 변경할 경우
		new File(saveDirectory, currentImage).delete(); //기존 이미지 삭제
	} else { //게시판 이미지 미변경
		board.setImage(currentImage);
	}
	
	// 게시글을 전달하여 BOARD테이블에 저장된 해당 게시물을 변경하는 DAO메소드
	BoardDAO.getDAO().updateBoard(board);
	
	// 게시글상세페이지로 이동
	out.println("<script type='text/javascript'>");
	if (category == 1) {
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/bbs&content=boardNotice&num="+num+"&pagenum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	} else if (category == 2) {
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/bbs&content=boardQA&num="+num+"&pagenum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	}
	out.println("</script>");
%>