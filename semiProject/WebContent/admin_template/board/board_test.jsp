<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	BoardDTO board=new BoardDTO();

	for(int i=1; i<100; i++){
		board.setNum(i);
		board.setId("choi"+i);
		board.setWriter("태휘"+i);
		board.setSubject("공지사항"+i);
		board.setRef(i+100);
		board.setContent("공지사항 세부내용"+i);
		board.setStatus(0);
		board.setCategory(1);
		board.setImage("0"+i+".jpg");
		
		BoardDAO.getDAO().insertBoard(board);
	}
	
	for(int i=1; i<100; i++){
		board.setNum(100+i);
		board.setId("kim"+i);
		board.setWriter("인섭"+i);
		board.setSubject("상품문의"+i);
		board.setContent("상품문의 세부내용"+i);
		board.setCategory(2);
		
		BoardDAO.getDAO().insertBoard(board);
	}
	
	for(int i=1; i<100; i++){
		board.setNum(200+i);
		board.setId("autumn"+i);
		board.setWriter("가을"+i);
		board.setSubject("상품후기"+i);
		board.setContent("상품후기 세부내용"+i);
		board.setCategory(3);
		
		BoardDAO.getDAO().insertBoard(board);
	}



%>    


<h2> 문의사항 종류별로 3개 만들기 </h2>