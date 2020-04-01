<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
 <link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<%
	String ref = "0";
	//0번 일반글, 1번 비밀글
	//String category = null;
	String pageNum="1"; //요청페이지 번호 저장
	
	if(request.getParameter("ref") != null) {
		ref=request.getParameter("ref");
		pageNum = request.getParameter("pageNum");
	}

	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	BoardDTO board=(BoardDTO)session.getAttribute("board");
	if(board!=null) {
		session.removeAttribute("board");
	}
	
	
%>

<style type="text/css">

.btnSearch, .btnDate{
	height: 38px;
	vertical-align: middle;
}

input[type="text"]{
	width: 100%;
	height: 100%;
	border: none;
}

</style>

<p class="for_title" style="margin-top: 100px; text-align: center;">공지사항 등록</p> 
<div id="searchBox">
	<div class="board_t1" style="width:70%;" >
	
		<form id="boardForm" action="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=add_action" method="post" enctype="multipart/form-data">
			<input type="hidden" name="ref" value="<%=ref%>">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<table class="admin_t" style="height: 1000px; ">
			<tr style="width: 10%;">
				<th> 문의사항 종류 </th>
				<td colspan="2">공지사항</td>
			</tr>
			<tr style="width: 10%;">
				<th>공지사항 제목</th>
				<td colspan="2"><input type="text" <% if(board!=null){ %>value="<%= board.getSubject()%>" <%} %>name="subject" id="subject"/></td>
			</tr>
			<tr style="width: 10%;">
				<th>비밀글 여부</th>
				<td colspan="2">
					<label class="gLabel eSelected">
						<input type="checkbox" name="secret" value="1" <% if(board!=null){ %><%if (board.getStatus() == 1) { %>checked<% } %><%} %> > 비밀글
					</label>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="2" >
					<% if(board==null){ %>
						<label class="downFile"><i class="fa fa-download" aria-hidden="true"></i>&nbsp;
							<input type="file" name="boardImage" id="boardImage">
						</label>
					<%}else{%>
						<img src="<%=request.getContextPath() %>/shop/bbs_images/<%=board.getImage() %>" style="width: 100%; height: 90%;">
						<br>
						<label class="downFile"><i class="fa fa-download" aria-hidden="true"></i>&nbsp;
							<input type="file" name="boardImage" id="boardImage">
						</label>
					<%} %>
						
				</td>
			</tr>
			<tr style="height: 70%;">
				<th>공지사항 내용</th>
				<td colspan="2"><textarea id="boardContent" cols="90" rows="40" name="boardContent"><% if(board!=null){ %><%=board.getContent()%><%} %></textarea></td>
			</tr>
			</table>

			<div id="message" style="color: red; text-align: center; font-size: 20px;"></div>
			<br />
			
			<div style="text-align:center;">
				<button class="btnSearch" id="enrollBtn" type="button" >공지사항 등록</button>&nbsp;
				<button class="btnSearch" id="resetBtn" type="reset">초기화</button>&nbsp;
				<button class="btnSearch" id="cancelBtn" type="button" >취소</button>&nbsp;&nbsp;&nbsp;
			</div>
			
		</form>
	</div>
</div>





<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#boardContent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#boardContent").focus();
		return false;
	}
});

$("#enrollBtn").click(function() {
	if(confirm(공지사항을 등록하시겠습니까?)){
		$("#boardForm").submit();
	}
});

$("#resetBtn").click(function() {
	$("#message").text("");	
	$("#subject").focus();
});

$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list";
});

</script>