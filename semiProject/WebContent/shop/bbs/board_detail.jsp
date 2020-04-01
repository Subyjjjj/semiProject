<%@page import="java.util.List"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글번호를 전달받아 BOARD 테이블에 저장된 게시글을 검색하여 클라이언트에게 전달하는 JSP 문서 --%>
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getParameter("num")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}
	
	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	int category = Integer.parseInt(request.getParameter("category"));
	
	
	//게시글번호를 전달하여 BOARD 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	BoardDTO board=BoardDAO.getDAO().selectNumBoard(num);
	
	//시작행번호와 종료 행번호를 전달받아 BOARD 테이블에 저장된 게시글 중 해당 범위 게시글을 검색하여 반화는 메소드 호출
	//List<BoardDTO> boardList=BoardDAO.getDAO().selectAllBoard(startRow, endRow, search, keyword, category);
	
	//게시글번호를 전달하여 BOARD 테이블에 저장된 이전 이후 글을 반환하는 메소드 호출
	BoardDTO beforeBoard=BoardDAO.getDAO().beforeNumBoard(num, category);
	BoardDTO nextBoard=BoardDAO.getDAO().nextNumBoard(num, category);
	
	//검색된 게시글이 없거나 삭제글인 경우 => 비정상적인 요청
	if(board==null || board.getStatus()==9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}
	
	//세션에 저장된 인증정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	 
	//게시글이 비밀글인 경우
	if(board.getStatus()==1) {
		//로그인 상태의 사용자가 작성자가 아니거나 관리자가 아닌 경우 => 비정상적인 요청
		if(loginMember==null || !loginMember.getId().equals(board.getId()) && loginMember.getStatus()!=9) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
			out.println("</script>");
			return;
		}
	}
	
	//게시글번호를 전달하여 BOARD 테이블에 저장된 게시글의 조회수를 1 증가 되도록 변경하는 DAO 클래스의 메소드 호출
	BoardDAO.getDAO().updateReadCount(num);
%>

<!-- 콘텐츠 시작 -->
<div id="container">
	<div id="wrapper_title">
	<% if(board.getCategory() == 1 ) { %>
	공지사항
	<% } else { %>
	자유게시판
	<% } %>
	</div>

<!-- 게시물 읽기 시작 { -->

<article id="bo_v" style="width:100%">
    <header>
        <h2 id="bo_v_title">
        	<span class="bo_v_tit">
        	<% if(board.getStatus()==1) %>
        	<%=board.getSubject()%>
        	</span>
        </h2>
    </header>

    
	<section id="bo_v_info">
		<h2>페이지 정보</h2>
		<span class="sound_only">작성자</span> <strong><span class="sv_member"><%=board.getWriter() %></span></strong>
		<span class="sound_only">조회</span><strong><i class="fa fa-eye" aria-hidden="true"></i><%=board.getReadCount()+1 %></strong>
		<strong class="if_date"><span class="sound_only">작성일</span><i class="fa fa-clock-o" aria-hidden="true"></i> <%=board.getRegDate().substring(0, 19) %></strong>
	</section>


    <section id="bo_v_atc">
        <h2 id="bo_v_atc_title">본문</h2>
        <% if (board.getImage() != null) { %>
        <div id="bo_v_img">
		<img src="<%=request.getContextPath()%>/shop/bbs_images/<%=board.getImage() %>">
		</div>
		<% } %>
        <!-- 본문 내용 시작 { -->
        <div id="bo_v_con"><%=board.getContent().replace("\n", "<br>") %></div>
        <!-- } 본문 내용 끝 --> 
    </section>

    <div id="bo_v_share">
        
    </div>

    
    
    <!-- 게시물 상단 버튼 시작 { -->
    <div id="bo_v_top">
        <ul class="bo_v_left">
        </ul>

        <ul class="bo_v_com">
        	<li>
        		<% if (board.getCategory() == 1) { %>
        		<a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice" class="btn_b01 btn">
        		<i class="fa fa-list" aria-hidden="true"></i> 목록
        		</a>
        		<% } else { %>
        		<a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardQA" class="btn_b01 btn">
        		<i class="fa fa-list" aria-hidden="true"></i> 목록
        		</a>
        		<% } %>
        		
        		
        		<!-- 로그인 상태의 사용자가 관리자, 작성자 둘다 아닌경우 >> 비정상적인요청 -->
        		<% if(loginMember!=null && (loginMember.getId().equals(board.getId()) || loginMember.getStatus()==9)) { %>
        		<button onclick='removeBtn()' type='button' id='removeBtn' class="btn_b01 btn">
        			<i class="fas fa-trash-alt"></i> 글삭제 
        		</button>
        		
        		<button onclick='modifyBtn()' type='button' id='modifyBtn' class="btn_b02 btn">
        			<i class="fas fa-registered"></i> 글수정
        		</button>
        		<% } %>
        		
        		<!-- 로그인 유저만 답글 기능 사용 가능 -->
        		<% if(loginMember != null && board.getCategory() == 2) { %>
        		<button onclick='replyBtn()' type='button' id='replyBtn' class="btn_b01 btn">
        			<i class="fab fa-replyd"></i> 답글쓰기
        		</button>
        		<% } %>
        	</li>
        </ul>

        <ul class="bo_v_nb">
        
        <% if (beforeBoard != null) { %>
        <li class="btn_prv">
       		
        	<span class="nb_tit"><i class="fa fa-caret-up" aria-hidden="true"></i> 이전글</span>
        	<a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_detail&num=<%=beforeBoard.getNum()%>">
        		<%=beforeBoard.getSubject()%>
        	</a> 
        	<span class="nb_date"></span>
        </li>            
        <% } %>
        
        <% if (nextBoard != null ) { %>
        	<li class="btn_next">
        	<span class="nb_tit"><i class="fa fa-caret-down" aria-hidden="true"></i> 다음글</span>
        	<a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_detail&num=<%=nextBoard.getNum()%>">
        		<%=nextBoard.getSubject()%>
        	</a> 
        	<span class="nb_date"></span></li> 
        	</ul>
        <% } %>
        </div>
        
        <!-- 삭제처리를 위한 영역 -->
        <form id="boardForm" method="post">
			<%-- 게시글변경 및 삭제 처리페이지 요청시 전달값 [필수] --%>
			<input type="hidden" name="num" value="<%=board.getNum()%>">
			<%-- 게시글목록 출력페이지 요청시 전달값 [선택]--%>
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<input type="hidden" name="search" value="<%=search%>">
			<input type="hidden" name="keyword" value="<%=keyword%>">
			<%-- 답글 입력페이지 요청시 전달값 [필수] --%>
			<input type="hidden" name="ref" value="<%=board.getRef()%>">
			<input type="hidden" name="category" value="<%=board.getCategory()%>">
		</form>
		
	
        
    <!-- } 게시물 상단 버튼 끝 -->

    

</article>
<!-- } 게시판 읽기 끝 -->

<!-- } 게시글 읽기 끝 -->
    </div>
    <!-- } 콘텐츠 끝 -->

<script type="text/javascript">
function removeBtn(){
	if(confirm("정말 삭제하시겠습니까?")){
		$("#boardForm").attr("action","<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_remove_processing");
		$("#boardForm").submit();
	}
}

$("#modifyBtn").click(function() {
	$("#boardForm").attr("action","<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_modify");
	$("#boardForm").submit();
});

$("#replyBtn").click(function() {
	$("#boardForm").attr("action","<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_write");
	$("#boardForm").submit();
});
</script>