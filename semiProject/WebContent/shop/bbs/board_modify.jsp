<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 공지사항과 문의게시판에서 게시글 입력을 위한 JSP --%>
<%-- 권한에 따라 글쓰는 버튼의 유무 판별. 공지사항 : 운영자만 글쓰기, 삭제 가능, 일반 이용자는   문의게시판 : 로그인한 회원도 기능 권한 부여. --%>
<%-- 글작성시 처리페이지(board_write_processing.jsp) 요청 --%>
<!-- 콘텐츠 시작 { -->
<%
	if(request.getParameter("num") == null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}
	
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	// 게시글번호를 전달하여 BOARD테이블에 저장된 게시글을 검색하여 반환하는 DAO클래스 메소드호출
	BoardDTO board=BoardDAO.getDAO().selectNumBoard(num);
	
	// 검색된 게시글이 없거나 삭제글인 경우 => 비정상적인 요청
	if(board==null || board.getStatus()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';"); 
		out.println("</script>");
		return;
	}
	
	// 세션에 저장된 인증정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	// 로그인 상태의 사용자가 관리자, 작성자 둘다 아닌경우 >> 비정상적인요청
	if(loginMember==null || !loginMember.getId().equals(board.getId()) && loginMember.getStatus()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';"); 
		out.println("</script>");
		return;
	}
%>
<div id="container">
	<div id="wrapper_title">
	<% if (board.getCategory() == 1) { %>
		공지사항 수정
	<% } else if (board.getCategory() == 2) { %>
		자유게시판 수정
	<% } %>
	</div><!-- skin : basic -->
	<section id="bo_w">
    <h2 class="sound_only">글수정</h2>

    <!-- 게시물 작성/수정 시작 { -->
<form id="boardForm" action="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_modify_processing" 
     method="post" enctype="multipart/form-data" autocomplete="off" style="width:100%">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="search" value="<%=search%>">
	<input type="hidden" name="keyword" value="<%=keyword%>">
	<input type="hidden" name="currentImage" value="<%=board.getImage()%>">
	
	<input type="checkbox" name="secret" value="1" <%if (board.getStatus() == 1) { %>checked<% } %> > 비밀글

    <div class="bo_w_tit write_div">
        <label for="wr_subject" class="sound_only">제목<strong>필수</strong></label>
        
        <div id="autosave_wrapper write_div">
            <input type="text" name="subject" value="<%=board.getSubject() %>" id="subject" required class="frm_input full_input required" size="50" maxlength="255" placeholder="제목">
        </div>
    </div>

    <div class="write_div">
        <label for="wr_content" class="sound_only">내용<strong>필수</strong></label>
        <div class="wr_content ">
        <span class="sound_only">웹에디터 시작</span>
		<textarea id="board_content" name="content" class="" maxlength="65536" style="width:100%;height:300px"><%=board.getContent() %></textarea>
		<span class="sound_only">웹 에디터 끝</span>
		</div>
    </div>
    
    <div class="bo_w_flie write_div">
    	<div class="file_wr write_div">
            <label for="bf_file_1" class="lb_icon"><i class="fa fa-download" aria-hidden="true"></i><span class="sound_only"> 파일 #1</span></label>
            <input type="file" name="image" id="bf_file_1" title="파일첨부 1 : 용량 1,048,576 바이트 이하만 업로드 가능" class="frm_file ">
        </div>          
    </div>

    <div class="btn_confirm write_div">
	<% if (board.getCategory() == 1) { %>
        <a href="<%= request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice" class="btn_cancel btn">취소</a>
    <% } else if (board.getCategory() == 2) { %>
    	<a href="<%= request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardQA" class="btn_cancel btn">취소</a>
    <% } %>
        <input type="submit" value="작성완료" id="btn_submit" accesskey="s" class="btn_submit btn">
    </div>
</form>

<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#board_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#board_content").focus();
		return false;
	}
});

</script>
</section>
<!-- } 게시물 작성/수정 끝 -->
</div>
    <!-- } 콘텐츠 끝 -->