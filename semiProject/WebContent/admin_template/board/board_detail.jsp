<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
   
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">

<%
	String startDay= request.getParameter("startDay");

	String endDay= request.getParameter("endDay");

	String search = request.getParameter("search");
	
	String keyword = request.getParameter("keyword");
	
	
	
	
	int	pageSize = Integer.parseInt(request.getParameter("pageSize"));

	
	int num=Integer.parseInt(request.getParameter("boardNum"));
	BoardDTO board=BoardDAO.getDAO().selectNumBoard(num);
	
%>
<style type="text/css">

.btnSearch, .btnDate{
	height: 38px;
	vertical-align: middle;
}



</style>

<p class="for_title" style="margin-top: 100px; text-align: center;"><a href="#none">문의사항 상세보기</a></p> 
<div id="searchBox">
	<div class="board_t1" style="width:70%;" >
			<table class="admin_t" style="height: 1000px; ">
			<tr style="width: 10%;">
				<th> 문의사항 종류 </th>
				<td colspan="3">
					<% if (board.getNum() != board.getRef()) { %> 답글 <% }else{ %>
						<% if(board.getCategory()==1){ %>
							공지사항
						<% }else if(board.getCategory()==2){ %>
							자유게시판
						<% }else if(board.getCategory()==3){ %>
							상품후기
						<% }else{%>
							상품문의
						<%} %>
					<%} %>
				</td>
				<td rowspan="6"  width="400"><% if(board.getImage()==null){ %>
						<p style="text-align: center;">첨부사진이 존재하지 않습니다.</p>
					<%}else{%>
						<img src="<%=request.getContextPath() %>/shop/bbs_images/<%=board.getImage() %>" style="width: 100%; height: 100%;">
					<%} %>
				</td>
			</tr>
			<tr style="width: 10%;">
				<th>문의사항 제목</th>
				<td colspan="3"><%= board.getSubject() %></td>
			</tr>
			<tr style="width: 10%;">
				<th>문의사항 작성자</th>
				<td colspan="3"><%= board.getWriter() %></td>
			</tr>
			<tr style="width: 10%;">
				<th>문의사항 작성날짜</th>
				<td colspan="3"><%= board.getRegDate().substring(0,10) %>&nbsp;&nbsp; <%= board.getRegDate().substring(10,19) %> </td>
			</tr>
			<tr style="width: 10%;">
				<th>문의사항 조회수</th>
				<td colspan="3"><%= board.getReadCount() %></td>
			</tr>
			<tr style="width: 10%;">
				<th>비밀글 여부</th>
				<td colspan="3"><% if(board.getStatus()==1){ %>비밀글<%}else{%>일반글<%} %></td>
			</tr>
			<tr style="height: 60%;">
				<th>문의사항 내용</th>
				<td colspan="4"><%= board.getContent() %></td>
			</tr>
			</table>

			<div style="text-align:center;">
				<button class="btnSearch" id="addBtn" type="button" >공지사항추가</button>&nbsp;
				<% if(board.getCategory()==1) {%>
				<button class="btnSearch" id="modifyBtn" type="button" >공지사항수정</button>&nbsp;
				<button class="btnSearch" id="removeBtn" type="button" >공지사항삭제</button>&nbsp;&nbsp;&nbsp;
				<%}%>
				<button class="btnDate" id="listBtn" type="button">목록보기</button>&nbsp;
			</div>
	</div>
</div>


<script type="text/javascript">
$("#addBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=add";
});

$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=modify&boardNum=<%=num%>";
});

$("#removeBtn").click(function() {
	if (confirm("[<%=board.getSubject()%>] 글을 삭제하시겠습니까?")){
		location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=remove_action&boardNum=<%=num%>";
	}
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageSize=<%=pageSize%>&category=<%=board.getCategory()%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>";
});
</script>