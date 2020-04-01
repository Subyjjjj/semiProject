<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<style>
.searchBoxbtns {
	background: #F15F5F;
	color: white;
	width: 150px;
	height: 50px;
	border: none;
	border-radius: 5px; 
}
.searchBoxbtns:hover {
	background: white;
	color: #F15F5F;
	border: 1px solid #F15F5F;
}
</style>
<%

	String currentDate= new SimpleDateFormat("yyyy-MM-dd").format(new Date());

	String startDay = request.getParameter("startDay");
	if (startDay == null)startDay = "";
	
	
	String endDay = request.getParameter("endDay");
	if (endDay == null)endDay ="";
	
	
	String search = request.getParameter("search");
	if (search == null)search = "";
	
	String keyword = request.getParameter("keyword");
	if (keyword == null)keyword = "";
	
	String sort=request.getParameter("sort");
	if(sort==null) sort="reg_date";
	
	String dateAttr=request.getParameter("dateAttr");
	if(dateAttr == null)dateAttr ="All";
	
	int category=0;
	if (request.getParameter("category")!=null) {
		category=Integer.parseInt(request.getParameter("category"));
	}
	
	int status=0;
	if (request.getParameter("status")!=null) {
		status=Integer.parseInt(request.getParameter("status"));
	}

	int pageNum = 1;

	if (request.getParameter("pageNum") != null) {
		pageNum = Integer.parseInt(request.getParameter("pageNum"));
	}

	int pageSize = 10;
	if (request.getParameter("pageSize") != null) {
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
	}
	int total= BoardDAO.getDAO().selectBoardCount(category);
	int totalBoard = BoardDAO.getDAO().selectBoardCount(search, keyword, category, startDay, endDay, status);


	int totalPage = (int) Math.ceil((double) totalBoard / pageSize);

	if (pageNum <= 0 || pageNum > totalPage) {
		pageNum = 1;
	}

	int startRow = (pageNum - 1) * pageSize + 1;
	int endRow = pageNum * pageSize;

	if (endRow > totalBoard) {
		endRow = totalBoard;
	}
	
	
	List<BoardDTO> boardList = BoardDAO.getDAO().selectAllBoard(startRow, endRow, search, keyword, category, startDay, endDay, status, sort);
	
	int number = totalBoard-(pageNum-1)*pageSize;
	

%>


<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">

<div id="orderStatusBar">
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list" <%if(category==0){%>class="select"<%} %>>전체문의</a></li>
		<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&category=1" <%if(category==1){%>class="select"<%} %> >공지사항</a></li>
		<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&category=2" <%if(category==2){%>class="select"<%} %>>자유게시판</a></li>
		<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&category=3" <%if(category==3){%>class="select"<%} %>>상품후기</a></li>
		<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=pageNum %>&pageSize=<%=pageSize%>&category=4" <%if(category==4){%>class="select"<%} %>>상품문의</a></li>
	</ul>
</div>
<hr>
<p class="for_title">&nbsp;&nbsp;<i class="fas fa-wine-glass-alt"></i>&nbsp;<span style="color: #FFA7A7;">
<%if (category==0) { %>
   전체문의
<%} else if (category==1) {%>
   공지사항
<%} else if (category==2) {%>
   자유게시판
<%} else if (category==3) {%>
   상품후기
<%} else if (category==4) {%>
   상품문의
<%} %>
</span>목록</p> 

<form method="post" id="searchForm">
<div class="board_t1">
		<table class="admin_t">
			<tbody>
				<tr>
					<th>문의 선택</th>
					<td colspan="1">
						<select name="category" id="display_category" class="fSelect">
							<option value="0" <%if(category==0){ %>selected<%} %>>전체 게시물</option>
							<option value="1" <%if(category==1){ %>selected<%} %>>공지사항</option>
							<option value="2" <%if(category==2){ %>selected<%} %>>자유게시판</option>
							<option value="3" <%if(category==3){ %>selected<%} %>>상품후기</option>
							<option value="4" <%if(category==4){ %>selected<%} %>>상품문의</option>
						</select>
					</td>
					<th>문의 상태</th>
					<td colspan="1">
						<select name="status" id="display_status" class="fSelect" style="width: 150px;'">
							<option value="10" <%if(status==10){ %>selected<%} %>>전체글</option>
							<option value="0" <%if(status==0){ %>selected<%} %>>일반글</option>
							<option value="1" <%if(status==1){ %>selected<%} %>>비밀글</option>
							<option value="9" <%if(status==9){ %>selected<%} %>>삭제글</option>
						</select>
					</td>
				</tr>

				<tr>
					<th>문의 찾기</th>
					<td colspan="3">
						<select id="search" name="search" class="fSelect">
							<option value="NONE" selected>검색선택</option>
                  		    <option value="empty1" disabled="disabled">---------------</option>
							<option value="subject" <%if(search.equals("subject")){ %>selected<%} %>>제목</option>
							<option value="content" <%if(search.equals("content")){ %>selected<%} %>>내용</option>
							<option value="writer" <%if(search.equals("writer")){ %>selected<%} %>>작성자</option>
							<option value="id" <%if(search.equals("id")){ %>selected<%} %>>아이디</option>
						</select> 
						<input type="text" id="keyword" name="keyword" class="fText" style="width: 400px;" value="<%=keyword%>"> 
					</td>
				</tr>
				<tr>
					<th>작성일</th>
					<td colspan="3">
						<input type="hidden" value="" class="dateAttr" name="dateAttr" />
                       	<a title="1" class="btnDate <%if(dateAttr.equals("1")){%>selected<%}%>"><span>오늘</span></a> 
						<a title="7" class="btnDate <%if(dateAttr.equals("7")){%>selected<%}%>"><span>7일</span></a> 
						<a title="30" class="btnDate <%if(dateAttr.equals("30")){%>selected<%}%>"><span>1개월</span></a> 
						<a title="90" class="btnDate <%if(dateAttr.equals("90")){%>selected<%}%>"><span>3개월</span></a> 
						<a title="180" class="btnDate <%if(dateAttr.equals("180")){%>selected<%}%>"><span>6개월</span></a>
						<a title="365" class="btnDate <%if(dateAttr.equals("365")){%>selected<%}%>"><span>1년</span></a>
						<a title="All" id="ALLPeriod" class="btnDate <%if(dateAttr.equals("All")){%>selected<%}%>"><span>전체</span></a> &nbsp;&nbsp;  
						<input type="date" value="<%=startDay %>" id="startDay" name="startDay" class="fSelect">
						&nbsp;~&nbsp; 
						<input type="date" value="<%=endDay %>" id="endDay" name="endDay" class="fSelect">
					</td>
				</tr>
			</tbody>
		</table>
		<div style="text-align: center;">
			<div id="searchMessage" style="color: red;"></div><br>
			<button class="searchBoxbtns" type="submit"><i class="fas fa-search"></i>&nbsp;검색</button>
			<button id="resetBtn" class="searchBoxbtns" type="button"><i class="fas fa-eraser"></i>&nbsp;초기화</button>
		</div>
	
</div>



<div class="board_t2">
	<!-- 데이터 출력 테이블 -->
	<div class="mState">
		<div class="gLeft">
			<p class="total">
				[총 게시글 <%= total%> 건] 검색결과 <strong><%= totalBoard %></strong> 건
			</p>
		</div>
		<div class="gRight">
			<select class="fSelect" id="sort" name="sort">
				<option value="reg_date DESC" <%if (sort.equals("reg_date DESC")) {%> selected <%}%>>기본정렬(최신날짜순)</option>
				<option value="readcount DESC" <%if (sort.equals("readcount DESC")) {%> selected <%}%>>조회수 많은 순</option>
				<option value="subject ASC" <%if (sort.equals("subject ASC")) {%> selected <%}%>>제목 순</option>
			</select> 
			<select class="fSelect" id="rows" name="rows">
				<option value="10" <%if (pageSize == 10) {%> selected <%}%>>10개씩보기</option>
				<option value="30" <%if (pageSize == 30) {%> selected <%}%>>30개씩보기</option>
				<option value="50" <%if (pageSize == 50) {%> selected <%}%>>50개씩보기</option>
				<option value="100" <%if (pageSize == 100) {%> selected <%}%>>100개씩보기</option>
			</select>
		</div>
	</div>

		<div class="mCtrl">
			&nbsp;<a class="btnNormal removeAllBtn" ><span><i class="fas fa-times" style="color: red;"></i>전체삭제</span></a> 
			&nbsp;<a class="btnNormal removeBtn"><span><i class="fas fa-times" style="color: red;"></i> 삭제</span></a>
			<div id="message" style="color: red;"></div>
		</div>
		<div class="mBoard">
			<table class="admin_t">
				<thead>
					<tr>
						<th><input type="checkbox" class="allChk"></th>
						<th style="width: 70px;">번호</th>
						<th>아이디</th>
						<th>작성자</th>
						<th>게시글 제목</th>
						<th>게시글 종류</th>
						<th>작성일</th>
						<th>게시글 상태</th>
						<th>조회수</th>
						<th>첨부파일</th>
					</tr>
				</thead>
				<tbody>
					<% if (totalBoard == 0) {%>
					<tr>
						<td colspan="9"></td>
					</tr>
					<%} else {%>
						<%for (BoardDTO board : boardList) {%>
					<tr>
						<td><input type="checkbox" name="checkedBoardNum" class="rowChk" value="<%=board.getNum()%>"></td>
						<td><%=board.getNum()%><input type="hidden" value="<%=board.getNum()%>" class="folderTo"></td>
						<td><%=board.getId()%></td>
						<td><%=board.getWriter()%></td>
						<td><% if (board.getNum() != board.getRef()) { %> [답글] <% } %>
							<a style="text-decoration: underline; color:#F15F5F " href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=detail&boardNum=<%=board.getNum()%>&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>"><%=board.getSubject()%></a></td>
						<td><%if(board.getCategory()==1){%>공지사항<%}else if(board.getCategory()==2){ %>자유게시판<%} else if(board.getCategory()==3){ %>상품후기<%}else{ %>상품문의<%} %></td>
						<td><%=board.getRegDate()%></td>
						<td><%if(board.getStatus()==0){%>일반글<%}else if(board.getStatus()==1){%>비밀글<%}else{ %>삭제글<%} %></td>
						<td><%=board.getReadCount()%></td>
						<td><%if(board.getImage()==null) {%><i class="fas fa-times"></i><%}else{ %>
						<a href="<%=request.getContextPath()%>/admin_template/board/board_file.jsp?boardNum=<%= board.getNum() %>" onclick="window.open(this.href,'orderProduct','width=900,height=700'); return false;" style="text-decoration: underline; color:#F15F5F "><i class="far fa-circle"></i></a></td><%} %>
					</tr>
						<%}%>
					<%}%>
				</tbody>
			</table>
		</div>
	
		<div class="mCtrl">
			&nbsp;<a class="btnNormal removeAllBtn"><span><i class="fas fa-times" style="color: red;"></i> 전체삭제</span></a> 
			&nbsp;<a class="btnNormal removeBtn"><span><i class="fas fa-times" style="color: red;"></i> 삭제</span></a>
			<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=add" class="btnNormal" style="background: #F15F5F; color:#fff; float: right;"><i class="fas fa-plus-circle"></i>&nbsp;공지사항 등록</a>
			
		</div>
	
	<div class="mPaginate">
	
		<%
			int blockSize = 5;
			int startPage = (pageNum - 1) / blockSize * blockSize + 1;
			int endPage = startPage + blockSize - 1;
			if (endPage > totalPage) {
				endPage = totalPage;
			}
		%>
	
		<!-- 페이지 이동  -->
		<%if (startPage > blockSize) {%>
			<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=1&pageSize=<%=pageSize%>&category=<%= category %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %> " class="btnNormal"><i class="fas fa-angle-double-left"></i></a>
			<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=startPage - blockSize%>&pageSize=<%=pageSize%>&category=<%= category %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %> " class="btnNormal"><i class="fas fa-angle-left"></i></a>&nbsp;
		<%} else {%>
			<a href="#none" class="btnNormal"><i class="fas fa-angle-double-left"></i></a> <a href="#none" class="btnNormal"><i class="fas fa-angle-left"></i>&nbsp;</a>
		<%}%>
	
		<%for (int i = startPage; i <= endPage; i++) {%>
			<%if (pageNum != i) {%>
				<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=i%>&pageSize=<%=pageSize%>&category=<%= category %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %> " class="btnNormal"><%=i%></a>&nbsp;
			<% } else { %>
			&nbsp;<a href="" class="btnNormal"><%=i%></a>&nbsp;
			<% } %>
		<% } %>
	
	
		<% if (endPage != totalPage) { %>
			<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=startPage + blockSize%>&pageSize=<%=pageSize%>&category=<%= category %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %> " class="btnNormal"><i class="fas fa-angle-right"></i></a> 
			<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=totalPage%>&pageSize=<%=pageSize%>&category=<%= category %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %> " class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
		<% } else {%>
			<a href="#" class="btnNormal"><i class="fas fa-angle-right"></i></a>
			<a href="#" class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
		<% } %>
	</div>
	 <div id="message" style="color: red; text-align: center;"></div>
</div>
</form>

<div id="message" style="color: red; text-align: cen"></div>



<script type="text/javascript">

	
   /* 1일 3일 등 버튼 눌를때 이벤트 */
   $(".btnDate").click(function() {
      if ($(".btnDate.selected").length == 1) {
         $(".btnDate").removeClass("selected");
         $(this).addClass("selected");
         
         var today = new Date();
         today.setDate(-$(this).attr("title")+12);
         var dd = today.getDate();
         var mm = today.getMonth()+1; //January is 0!
         var yyyy = today.getFullYear();
		
         
         if(dd<10) {
             dd='0'+dd
         } 

         if(mm<10) {
             mm='0'+mm
         } 

         today = yyyy+'-'+mm+'-'+dd;
        
         
         $("#startDay").val(today);
         
         var now = new Date();
	      var dd = now.getDate();
	      var mm = now.getMonth()+1; 
	      var yyyy = now.getFullYear();

	      if(dd<10) {
	          dd='0'+dd
	      } 

	      if(mm<10) {
	          mm='0'+mm
	      } 
	      
	      now = yyyy+'-'+mm+'-'+dd;
	      $("#endDay").val(now);
         
      } else if($(".btnDate.selected").length==0) {
         $(this).addClass("selected");
      }
      var inter=$(".selected").attr("title");
      $(".dateAttr").attr("value",inter);
   });
   
   $("#ALLPeriod").click(function() {
		$("#startDay").val("");
		$("#endDay").val("");
	});
   
   
   /* 검색결과 체크박스 */
	$(".allChk").change(function() {
	 	if($(this).is(":checked")){
	 		$(".rowChk").prop("checked", true)
	 	}else{
	$(".rowChk").prop("checked", false)
	 	}
	 });
	  
	  
	$(".removeAllBtn").click(function() {
		if(confirm("정말로 모든 게시물들을 삭제하시겠습니까?")){
			$(".rowChk").prop("checked", true);
			$("#searchForm").attr("method","post");
			$("#searchForm").attr("action","<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=removes_action");
		}
	});
	  
	  
	$(".removeBtn").click(function(){
		if($(".rowChk").filter(":checked").size()==0){
			$("#message").text("선택한 게시물이 하나도 없습니다.");
			return;
		}else if(confirm("정말로 선택한 게시물들을 삭제하시겠습니까?")){
			$("#searchForm").attr("method","post");
			$("#searchForm").attr("action","<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=removes_action");
		}
	});
	
  
   
   /* 페이지 보기(10개 50개 등) 셀렉문 선택시 이벤트 */
   $("#rows").change(function() {
     	var rows=$("#rows option:selected").val();
     	var sort=$("#sort option:selected").val();
     	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=pageNum%>&pageSize="+rows+"&sort="+sort;
	});
   
   $("#sort").change(function() {
    	var sort=$("#sort option:selected").val();
    	var rows=$("#rows option:selected").val();
    	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=<%=pageNum%>&pageSize="+rows+"&sort="+sort;
	});
   
// 검색서브밋 전 체크사항
$("#seachForm").submit(function() {
   //if(orderStatus)
});
$("#resetBtn").click(function() {
	$("#keyword").focus();
	$("#search option:eq(0)").prop("selected", true);
	$("#keyword").val("");
	$("#display_category option:eq(0)").prop("selected", true);
	$("#display_status option:eq(0)").prop("selected", true);
	$("#ALLPeriod").click();
	$("#startDay").val("");
	$("#endDay").val("");
	$("#searchMessage").text("");
});
   
   
   
   
</script>

