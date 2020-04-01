<%@page import="jdk.management.resource.internal.TotalResourceContext"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 하단에 최신의 공지사항 4개 출력 --%>
<% 	
	//최신글 공지글로 페이징 처리를 위해 1으로 고정
	int pageNum=1;
	
	//공지사항 게시판의 분류 설정 (=1:공지사항 2:상품문의 3:상품후기)
	int category = 1;

	//하나의 페이지에 출력될 게시글의 갯수 설정
	int pageSize=4;
	
	//페이지에 대한 게시글 시작행 번호를 계산하여 저장
	//ex) 1 Page : 1, 2 Page : 11, 3 Page : 21, 4 Page : 31, ... 
	int startRow=(pageNum-1)*pageSize+1;
		
	//페이지에 대한 게시글 종료행 번호를 계산하여 저장
	//ex) 1 Page : 10, 2 Page : 20, 3 Page : 30, 4 Page : 40, ... 
	int endRow=pageNum*pageSize;
	
	String search = "", keyword = "";
	
	//게시글의 시작 행번호와 종료 행번호를 전달하여 BOARD 테이블에 저장된
	//게시글 중 시작 행번호와 종료 행번호 범위의 게시글을 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	List<BoardDTO> boardList=BoardDAO.getDAO().selectAllBoard(startRow, endRow, search, keyword, category);
%>
<footer id="ft_wrap">
		<div class="ft_top_wrap">
			<div class="top_box box_1">
				<div class="tit">Notice</div>
				<div class="con">
					<ul class="ul_bs_st">
					<% if (boardList != null) { %>
						<% for (BoardDTO board:boardList) { %>
						<li>
							<a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_detail&num=<%=board.getNum()%>&category=<%=category%>">
							<span class='t'><b>·</b><%=board.getSubject() %></span>
							<span class='d'><%=board.getRegDate().substring(0, 10).replace("-", ".") %></span></a>
						</li>
						<% } %>
					<% } %>
					</ul>
				</div>
			</div>
			<div class="top_box box_2">
				<div class="tit">CS Center</div>
				<div class="con">
					<div class="tel">
						T. <b>054.673.8422</b><br class="mo"> M. <b>010.9588.8422</b>
					</div>
					<div class="time">평일 : am 09:00 - pm 18:00 / 점심 : pm 12:00 -
						pm 13:00</div>
					<div class="link_wrap">
						<a class="bs"
							href="#">고객문의</a>
					</div>
				</div>
			</div>
			<div class="top_box box_3">
				<div class="tit">Company info</div>
				<div class="con">
					<div class="half h1">
						에덴의동쪽 엠퍼리<span>·</span>대표 오창중 <br> 사업자등록번호 512-02-51985 <br>
						통신판매업 신고번호 제2020-창중IT-0014호 <br> 서울시 강남구 테헤란로 Itwill 빌딩 15층 4Class <br>
						E. 5chang中@itwill.com <br>
						<!-- T. 054.673.8422<span>·</span> M.010.9588.8422 -->
					</div>
					<div class="half h2">
						<div class="link_wrap">
							<a class="bs" href="#">회사소개</a>
						</div>
						<div class="link_wrap">
							<a class="bs"
								href="#"
								target="_blank">사업자정보확인</a>
						</div>
						<div class="link_wrap">
							<a class="bs"
								href="#">서비스이용약관</a>
						</div>
						<div class="link_wrap">
							<a class="bs"
								href="#">개인정보취급방침</a>
						</div>
						<div class="link_wrap">
							<a class="bs"
								href="#">모바일버전</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ft_bt_wrap">Copyright ⓒ EAST OF EDEN. All rights
			reserved</div>
	</footer>

	<div class="fix_btn_Wrap">
		<a class="bt1" href="<%=request.getContextPath()%>/index.jsp?part=shop/order&content=cart"></a> <a
			class="bt2" href="#" id="btn_t"></a>
	</div>

	<script>
		$(function() {
			$("#btn_t").on("click", function() {
				$("html, body").animate({
					scrollTop : 0
				}, '500');
				return false;
			});
		});
	</script>

	<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"></script>