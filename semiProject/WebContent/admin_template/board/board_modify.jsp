<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
    <link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<%
	
	int num=Integer.parseInt(request.getParameter("boardNum"));
	
	BoardDTO board=BoardDAO.getDAO().selectNumBoard(num);
	

%>

<style type="text/css">

.btnSearch, .btnDate{
	height: 38px;
	vertical-align: middle;
}

input[type="text"]{
	width: 50%;
}


</style>

<p class="for_title" style="margin-top: 100px; text-align: center;"><a href="#none">문의사항 수정</a></p> 
<div id="searchBox">
	<div class="board_t1" style="width:70%;" >
	
		<form id="boardForm" action="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=modify_action" method="post" enctype="multipart/form-data">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="currentImage" value="<%=board.getImage()%>">
			<table class="admin_t" style="height: 1000px; ">
			<tr style="width: 100px;">
				<th> 문의사항 종류 </th>
				<td colspan="3">
					<% if(board.getCategory()==1){ %>
						공지사항
					<% } %>
				</td>
				<td rowspan="5"  width="400"><% if(board.getImage().equals("")){ %>
						첨부사진이 존재하지 않습니다.
					<%}else{%>
						<img src="<%=request.getContextPath() %>/shop/bbs_images/<%=board.getImage() %>" style="width: 100%; height: 90%;">
						<br>
						<span style="font-size: 12px; color: tomato;">&nbsp;*새로운 파일을 업로드 하지 않는 경우 기존 상품이미지가 유지됩니다.</span>
					<%} %>
				</td>
			</tr>
			<tr style="width: 10%;">
				<th>공지사항 제목</th>
				<td colspan="3"><input type="text" value="<%= board.getSubject()%>" name="subject" id="subject"/></td>
			</tr>
			<tr style="width: 10%;">
				<th>공지사항 작성날짜</th>
				<td colspan="3"><%= board.getRegDate().substring(0,10) %>&nbsp;&nbsp; <%= board.getRegDate().substring(10,19) %> </td>
			</tr>
			<tr style="width: 10%;">
				<th>비밀글 여부</th>
				<td colspan="3">
					<label class="gLabel eSelected">
						<input type="checkbox" name="secret" value="1" <%if (board.getStatus() == 1) { %>checked<% } %> > 비밀글
					</label>
				</td>
			</tr>
			<tr style="width: 10%;">
				<th>첨부파일</th>
				<td colspan="3" >
					<label class="downFile"><i class="fa fa-download" aria-hidden="true"></i>&nbsp;
						<input type="file" name="boardImage" id="boardImage">
					</label>
				</td>
			</tr>
			<tr style="height: 80%;">
				<th>공지사항 내용</th>
				<td colspan="4"><textarea id="boardContent" cols="90" rows="40" name="boardContent"><%=board.getContent()%></textarea></td>
			</tr>
			</table>

			<div id="message" style="color: red; text-align: center; font-size: 20px;"></div>
			<br />
			
			<div style="text-align:center;">
				<button class="btnSearch" id="modifyBtn" type="button" >공지사항 수정</button>&nbsp;
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
	
	return true;
});

$("#modifyBtn").click(function() {
	if(confirm("공지사항을 수정하시겠습니까?")){
		$("#boardForm").submit();
	}
});

$("#resetBtn").click(function() {
	$("#message").text("");	
	$("#subject").focus();
});

$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=detail&boardNum=<%=num%>";
});

</script>