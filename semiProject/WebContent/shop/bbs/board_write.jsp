<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 공지사항과 문의게시판에서 게시글 입력을 위한 JSP --%>
<%-- 권한에 따라 글쓰는 버튼의 유무 판별. 공지사항 : 운영자만 글쓰기, 삭제 가능, 일반 이용자는   문의게시판 : 로그인한 회원도 기능 권한 부여. --%>
<%-- 글작성시 처리페이지(board_write_processing.jsp) 요청 --%>
<!-- 콘텐츠 시작 { -->
<%@include file="/shop/security/login_status.jspf" %>
<%
	
	//부모글의 전달값 저장과 게시판 카테고리 저장
	String ref = "0";
	//0번 일반글, 1번 비밀글
	//String category = null;
	String pageNum="1"; //요청페이지 번호 저장
	
	if(request.getParameter("ref") != null) {
		ref=request.getParameter("ref");
		pageNum = request.getParameter("pageNum");
	}
	
	if(request.getParameter("category") == null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}

%>
<div id="container">
	<div id="wrapper_title">
	<% if (Integer.parseInt(request.getParameter("category")) == 1) { %>
		공지사항
	<% } else if (Integer.parseInt(request.getParameter("category")) == 2) { %>
		자유게시판
	<% } else if (Integer.parseInt(request.getParameter("category")) == 3) { %>
		상품후기
	<% } else if (Integer.parseInt(request.getParameter("category")) == 4) { %>
		상품문의
	<% } %>
	</div><!-- skin : basic -->
	<section id="bo_w">
    <h2 class="sound_only">글작성 </h2>

    <!-- 게시물 작성/수정 시작 { -->
<form id="boardForm" action="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_write_processing" 
     method="post" enctype="multipart/form-data" autocomplete="off" style="width:100%">
	<input type="hidden" name="ref" value="<%=ref%>">
	<input type="hidden" name="category" value="<%=request.getParameter("category")%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="productNum" value="<%=request.getParameter("productNum")%>">
	<% if (Integer.parseInt(request.getParameter("category")) != 3 || Integer.parseInt(request.getParameter("category")) != 4) { %>
	<input type="checkbox" name="secret" value="1" > 비밀글
	<% } %>
    <div class="bo_w_tit write_div">
        <label for="wr_subject" class="sound_only">제목<strong>필수</strong></label>
        
        <div id="autosave_wrapper write_div">
            <input type="text" name="subject" value="" id="subject" required class="frm_input full_input required" size="50" maxlength="255" placeholder="제목">
        </div>
    </div>

    <div class="write_div">
        <label for="wr_content" class="sound_only">내용<strong>필수</strong></label>
        <div class="wr_content ">
        <span class="sound_only">웹에디터 시작</span>
		<textarea id="board_content" name="content" class="" maxlength="65536" style="width:100%;height:300px"></textarea>
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
	<% if (Integer.parseInt(request.getParameter("category")) == 1) { %>
        <a href="<%= request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice" class="btn_cancel btn">취소</a>
    <% } else if (Integer.parseInt(request.getParameter("category")) == 2) { %>
    	<a href="<%= request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardQA" class="btn_cancel btn">취소</a>
    <% } else if (Integer.parseInt(request.getParameter("category")) == 3) { %>
    	<a href="<%= request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=<%=request.getParameter("productNum") %>" class="btn_cancel btn">취소</a>
    <% } else if (Integer.parseInt(request.getParameter("category")) == 4) { %>
    	<a href="<%= request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=<%=request.getParameter("productNum") %>" class="btn_cancel btn">취소</a>
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