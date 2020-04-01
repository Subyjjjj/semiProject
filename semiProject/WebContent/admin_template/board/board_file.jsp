<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<%
	// 입력값을 반환받아 저장
	int num = Integer.parseInt(request.getParameter("boardNum"));
	
	BoardDTO board=BoardDAO.getDAO().selectNumBoard(num);
	
%>
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<style>
#footer {
   position: fixed;
   left: 0px;
   bottom: 0px;
   z-index: 300;
   width: 100%;
   margin: 0;
   padding: 15px 0;
   text-align: center;
   border-top: 1px solid #dedede;
   background-color: #fafafa;
}

.board_t1 .admin_t tr>th{
	width: 70px;
	height: 20px;
}

.board_t1{
	height: auto;
}


</style>
</head>
<body>
	<div class="board_t1" style="width:80%;" >
		<table class="admin_t">
			<tr>
				<th>문의 종류</th>
				<td colspan="1">
					<% if(board.getCategory()==1){ %>
						공지사항
					<% }else if(board.getCategory()==2){ %>
						상품문의
					<% }else if(board.getCategory()==3){ %>
						상품후기
					<% } %>
				</td>
				<th>제목</th>
				<td colspan="1"><%= board.getSubject() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td colspan="1"><%= board.getWriter() %></td>
				<th>작성날짜</th>
				<td colspan="1"><%= board.getRegDate().substring(0,10) %>&nbsp;&nbsp; <%= board.getRegDate().substring(10,10) %> </td>
			</tr>
			<tr>
				<td colspan="4">
					<img src="<%=request.getContextPath() %>/shop/bbs_images/<%=board.getImage() %>" style="max-width:600px; height: auto;">
				</td>
			</tr>
		</table>
	</div>


	<div id="footer">
       <a href="#none" class="btnEm" onclick="window.close();"><span>닫기</span></a>
    </div>

</body>
</html>