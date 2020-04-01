<%@page import="java.io.File"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String saveDirectory=request.getServletContext().getRealPath("/shop/bbs_images");
	// 파일을 입력 할 수도있고 아닐수도 있음 >> 미입력시 파일업로드 X
	MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	

	int num=Integer.parseInt(mr.getParameter("num"));

	String subject=mr.getParameter("subject").replace("<", "&lt;").replace(">", "&gt;");
	int status=0;
	if(mr.getParameter("secret")!=null) {
		status=Integer.parseInt(mr.getParameter("secret"));
	}
	String boardContent=mr.getParameter("boardContent").replace("<", "&lt;").replace(">", "&gt;");
	String boardImage = mr.getFilesystemName("boardImage");
	
	//기존 이미지 파일명 변수에 저장
	String currentImage = mr.getParameter("currentImage");
	
	//DTO인스턴스 생성하고 필드값 변경
	BoardDTO board=new BoardDTO();
	board.setNum(num);
	board.setSubject(subject);
	board.setContent(boardContent);
	board.setStatus(status);
	if (boardImage != null) {
		board.setImage(boardImage); //게시판 이미지를 변경할 경우
		new File(saveDirectory, currentImage).delete(); //기존 이미지 삭제
	} else { //게시판 이미지 미변경
		board.setImage(currentImage);
	}
	
	// 게시글을 전달하여 BOARD테이블에 저장된 해당 게시물을 변경하는 DAO메소드
	BoardDAO.getDAO().updateBoard(board);
	
	// 게시글상세페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=board&work=list&categor=1';");
	out.println("</script>");
	
%>

