<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글번호를 전달받아 BOARD테이블에 저장된 해당행을 삭제처리하고 게시글목록 출력페이지(board_list.jsp)로 이동하는 JSP문서 --%>
<%
	//비정상적인 요청에 대한 응답처리 
	 if(request.getParameter("num")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';"); 
		out.println("</script>");
		return;
	}

	// 전달값저장
	int num=Integer.parseInt(request.getParameter("num"));
	
	// 게시글번호를 전달하여 BOARD테이블에 저장된 게시글을 검색하여 반환하는 DAO클래스메소드호출
	BoardDTO board= BoardDAO.getDAO().selectNumBoard(num);

	// 검색된 게시글이 없거나 삭제글인 경우 => 비정상적인 요청
	 if(board==null || board.getStatus()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';"); 
		out.println("</script>");
		return;
	}
	
	// 세션에 저장된 인증정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	// 게시글 삭제권한 : 로그인상태의사용자 중 작성자 or 관리자만 >> 비정상적인요청
	if(loginMember==null || !loginMember.getId().equals(board.getId()) && loginMember.getStatus()!=9) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';"); 
			out.println("</script>");
			return;
	}
	
	// 게시글번호를 전달하여 BOARD테이블에 저장된 해당 게시물을 삭제"처리"(즉, 상태변경)하는 DAO클래스의 메소드호출
	BoardDAO.getDAO().deleteBoard(num);
	
	// 게시글목록페이지로 이동
	out.println("<script type='text/javascript'>");
	if (Integer.parseInt(request.getParameter("category")) == 3) {
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/product&content=item&productNum="+request.getParameter("productNum")+"';");
	} else if (Integer.parseInt(request.getParameter("category")) == 4) {
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/product&content=item&productNum="+request.getParameter("productNum")+"';");
	} else if (Integer.parseInt(request.getParameter("category")) == 2) {
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/bbs&content=boardQA';");
	} else if (Integer.parseInt(request.getParameter("category")) == 1) {
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/bbs&content=boardNotice';");
	}
	out.println("</script>");

	
%>

