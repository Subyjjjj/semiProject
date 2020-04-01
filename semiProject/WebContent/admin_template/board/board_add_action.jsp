<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="java.io.File"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>


<%
    //입력파일이 저장되기 위한 업로드 디렉토리의 실제 경로를 반환받아 저장
	//getRealPath(): 최상위 경로를 얻어올 때 사용하는 메소드 → web apps에 가서 업로드 된 것을 확인해야 한다
	String saveDirectory=request.getServletContext().getRealPath("/shop/bbs_images");
	
	//MultiPartRequest 인스턴스 생성
	//→ 입력파일이 서버 디렉토리에 자동 업로드 처리
	MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//입력값(전달값)을 반환받아 저장
	int ref=Integer.parseInt(mr.getParameter("ref"));
	String pageNum=mr.getParameter("pageNum");
	
	//입력값에서 태그 관련 기호를 Escape 문자로 변환하여 저장
	// => XSS 공격을 방어하는 방법
	String subject=mr.getParameter("subject").replace("<", "&lt;").replace(">", "&gt;");
	
	int status=0;
	
	//비밀글(checkbox)를 체크하여 전달된 경우
	if(mr.getParameter("secret")!=null) {
		status=Integer.parseInt(mr.getParameter("secret"));
	}
	String boardContent=mr.getParameter("boardContent").replace("<", "&lt;").replace(">", "&gt;");
	
	//시퀸스 객체의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출
	int num=BoardDAO.getDAO().selectNextNum();
	
	String boardImage=mr.getFilesystemName("boardImage");
	
	//새글 또는 답글을 구분하여 처리하기 위한 명령
	if(ref==0) {//새글
		ref=num;
	}
	
		
	//DTO 인스턴스를 생성하고 필드값 변경
	BoardDTO board=new BoardDTO();
	board.setNum(num);//자동증가값
	board.setId(loginMember.getId());
	board.setWriter(loginMember.getName());//로그인 사용자 이름
	board.setSubject(subject);//입력값
	board.setRef(ref);//새글 : 자동증가값, 답글 : 부모글 전달값(ref)
	board.setContent(boardContent);//입력값
	board.setStatus(status);//일반글 : 0, 비밀글 : 1
	board.setCategory(1);
	board.setImage(boardImage);//이미지 경로
	
	
	if (BoardDAO.getDAO().selectNumBoard(num)!=null) {
		new File(saveDirectory,boardImage).delete();
		session.setAttribute("message", "동일한 상품이 존재합니다.");
		session.setAttribute("board", board);
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=board&work=add';");
		out.println("</script>");		
		return;
	}
	
	BoardDAO.getDAO().insertBoard(board);
	
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=board&work=list';");
	out.println("</script>");
	
%>