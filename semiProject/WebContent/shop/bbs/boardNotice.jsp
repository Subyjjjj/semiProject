<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- BOARD 테이블에 저장된 게시글을 검색하여 게시글 목록을 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 게시글 목록을 페이지로 구분하여 출력 - 페이징 처리(SQL 명령) --%>
<%-- => 페이지 번호 출력 - 페이징 처리(알고리즘) --%>
<%-- => [제목]을 클릭할 경우 게시글 상세 출력페이지(board_detail.jsp)로 이동 --%>
<%-- => [페이지 번호]와 [검색]을 클릭한 경우 게시글 목록 출력페이지(board_list.jsp)로 이동 --%>
<%
	//검색대상과 검색단어를 반환받아 저장
	String search=request.getParameter("search");
	if(search==null) search="";
	String keyword=request.getParameter("keyword");
	if(keyword==null) keyword="";

	//전달된 페이지 번호를 반환받아 저장
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나의 페이지에 출력될 게시글의 갯수 설정
	int pageSize=10;
	
	//공지사항 게시판의 분류 설정 (=1:공지사항 2:상품문의 3:상품후기)
	int category = 1;
	
	//BOARD 테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출
	//BOARD 테이블에 저장된 전체 게시글 중 검색 게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출
	int totalBoard=BoardDAO.getDAO().selectBoardCount(search, keyword, category);
	     
	//전체 페이지 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalBoard/pageSize);
	
	//저장된 페이지 번호에 대한 검증
	if(pageNum<=0 || pageNum>totalPage) {//비정상적인 요청
		pageNum=1;
	}
	
	//페이지에 대한 게시글 시작행 번호를 계산하여 저장
	//ex) 1 Page : 1, 2 Page : 11, 3 Page : 21, 4 Page : 31, ... 
	int startRow=(pageNum-1)*pageSize+1;
	
	//페이지에 대한 게시글 종료행 번호를 계산하여 저장
	//ex) 1 Page : 10, 2 Page : 20, 3 Page : 30, 4 Page : 40, ... 
	int endRow=pageNum*pageSize;
	
	//마지막 페이지는 게시글의 전체 갯수가 종료행 번호가 되도록 설정 
	if(endRow>totalBoard) {
		endRow=totalBoard;
	}
	
	//게시글의 시작 행번호와 종료 행번호를 전달하여 BOARD 테이블에 저장된 게시글 중 시작 행번호와 종료 행번호 범위의 게시글을 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	List<BoardDTO> boardList=BoardDAO.getDAO().selectAllBoard(startRow, endRow, search, keyword, category);
	
	//출력될 페이지의 게시글 시작번호를 계산하여 저장
	int number=totalBoard-(pageNum-1)*pageSize;
	
	//세션에 저장된 인증정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//서버 시스템의 현재 날짜(시간)정보 저장
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>
	<!-- 콘텐츠 시작 { -->
	<div id="container">
		<!--  -->
		<div id="wrapper_title">공지사항</div>
		<!-- 게시판 목록 시작 { -->
		<div id="bo_list" style="width: 100%">

			<!-- 게시판 페이지 정보 및 버튼 시작 { -->
			<div id="bo_btn_top">
				<div id="bo_list_total">
					<span>Total <%=totalBoard %>건</span> <%=pageNum %> 페이지
				</div>

			</div>
			<!-- } 게시판 페이지 정보 및 버튼 끝 -->

			<!-- 게시판 카테고리 시작 { -->
			<!-- } 게시판 카테고리 끝 -->

			<form name="fboardlist" id="fboardlist" method="post">

				<div class="tbl_head01 tbl_wrap">
					<table>
						<caption>공지사항 목록</caption>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">글쓴이</th>
								<th scope="col">
								<%-- 조회와 날짜의 href는 정렬을 위해 존재 추후 추가요망. --%>
								<a href="">조회
										<i class="fa fa-sort" aria-hidden="true"></i>
								</a></th>
								<th scope="col">
								<a href="">날짜
										<i class="fa fa-sort" aria-hidden="true"></i>
								</a></th>
							</tr>
						</thead>
						<tbody>
						<% if (totalBoard == 0) { %>
							<tr class="">
								<td class="td_num2"></td>
								<td class="td_subject" style="padding-left: 0px">
									<div class="bo_tit">
											검색된 게시글이 하나도 없습니다. 
									</div>
								</td>
								<td class="td_name sv_use"><span class="sv_member"></span></td>
								<td class="td_num"></td>
								<td class="td_datetime"></td>
							</tr>
						<% } else { %>
							<%-- 게시글 목록 출력 --%>
							<% for (BoardDTO board:boardList) { %>
							
							<tr class="">
							<%-- 글번호 --%>
								<td class="td_num2"><%=number %></td>
							<%--답글 여백 및 비밀글, 삭제글 --%>
								<td class="td_subject" style="padding-left: 0px">
								<% if (board.getStatus() == 0) { %>
									<div class="bo_tit">
										<%-- 하이퍼링크 설정과 글제목 --%>
										<a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_detail&num=<%=board.getNum()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>&category=<%=category%>">
											<%=board.getSubject() %>
										</a>
									</div>
								<% } else if (board.getStatus() == 9) { %>
									
									<div class="bo_tit">
										<%-- 하이퍼링크 설정과 글제목 --%>
										[삭제글]작성자 또는 관리자에 의해 삭제된 게시글입니다.
									</div>
									
								<% } %>
								</td>
							<%-- 작성자 --%>
								<td class="td_name sv_use"><span class="sv_member"><%=board.getWriter() %></span></td>
							<%-- 조회수 --%>
								<td class="td_num"><%=board.getReadCount() %></td>
							<%-- 작성일 --%>
								<td class="td_datetime">
								<% if (currentDate.equals(board.getRegDate().substring(0, 10))) { %>
									<%=board.getRegDate().substring(11, 19) %>
								<% } else { %>
									<%=board.getRegDate().substring(0, 10) %>
								<% } %>
								</td>
							</tr>
							<% number--; %>
							<% } %>
						<% } %>
						</tbody>
					</table>
				</div>


			</form>

			<!-- 게시판 검색 시작 { -->
			<fieldset id="bo_sch">
				<legend>게시물 검색</legend>

				<form action="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice" name="fsearch" method="post">
					 <label for="sfl" class="sound_only">검색대상</label> 
					 <select name="search" id="sfl">
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="writer">글쓴이</option>
					</select> 
					
					<label for="stx" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label> 
					
					<input type="text" name="keyword" value="" required id="stx" class="sch_input" size="25" maxlength="20" placeholder="검색어를 입력해주세요">
					<button type="submit" value="검색" class="" style="padding-top: 2px; background-color: Transparent;">
						<img src="<%=request.getContextPath()%>/img/shop/search.png">
					</button>
				</form>
			</fieldset>
			<!-- } 게시판 검색 끝 -->
			<% if(loginMember != null && loginMember.getStatus() == 9) { //관리자 상태의 사용자인 경우 %> 
			<div class="btn_confirm write_div" style="float:right;" id="btn">
        		<input type="button" id="writeBtn" accesskey="s" class="btn_submit btn" value="글쓰기">
    		</div>
    		<% } %>
		</div>




		<!-- 페이지 -->
		<%
		//하나의 페이지 블럭에 출력될 페이지 번호의 갯수 설정
		int blockSize = 5;
	
		//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 저장
		// => 1 Block : 1, 2Block : 6, 3 Block : 11, 4 Block : 16, ....
		int startPage = (pageNum - 1) / blockSize * blockSize + 1;
		
		//페이지 블럭에 출력될 종료 페이지 번호를 계산하여 저장
		// => 1 Block : 5, 2Block : 10, 3 Block : 15, 4 Block : 20, ....
		int endPage = startPage + blockSize - 1;
		
		//마지막 페이지 블럭의 종료 페이지 번호 변경
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		%>
		
		<div style="margin: 25px 0 0; text-align: center; font-size: 1.3em;">
		<% if(startPage > blockSize) { %>
	    	<a href="<%= request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice&pageNum=1&search=<%=search%>&keyword=<%=keyword%>"><i class="fas fa-angle-double-left"></i></a>
		    <a href="<%= request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>"><i class="fas fa-angle-left"></i></a>&nbsp;
        <% } else{ %>
	        <i class="fas fa-angle-double-left"></i>
	        <i class="fas fa-angle-left"></i>&nbsp;
        <% } %>
               
        <% for (int i = startPage; i <= endPage; i++) { %>
			<% if(pageNum!=i){ %>
				<a href="<%= request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>"><%= i %></a>&nbsp;
			<% } else { %>
				<span style="font-weight: bold;">[<%= i %>]&nbsp;</span>
			<% } %>
		<% } %>
               
               
        <% if(endPage != totalPage) { %>
	    	<a href="<%= request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>"><i class="fas fa-angle-right"></i></a>
			<a href="<%= request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>"><i class="fas fa-angle-double-right"></i></a>
        <% } else { %>
		    <i class="fas fa-angle-right"></i>
		    <i class="fas fa-angle-double-right"></i>
        <% } %>
		</div>
		
		<!-- } 게시판 목록 끝 -->

	</div>
	<!-- } 콘텐츠 끝 -->
	
<script type="text/javascript">
$("#writeBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_write&category=1";
});	
</script>