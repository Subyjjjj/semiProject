<%@page import="semiProject.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션에 저장된 인증정보 반환받아 저장
	MemberDTO loginmember = (MemberDTO)session.getAttribute("loginMember");
%>
	<header id="hd_wrap">
		<div class="hd_logo">
			<a href="<%=request.getContextPath()%>/index.jsp"> 
			<img src="<%=request.getContextPath()%>/img/logo_img" alt="에덴의동쪽">
			</a>
		</div>

		<div class="hd_menu">
			<div class="gnb_wrap" style="display: none">
				<ul id="gnb_1dul">
					<li class="gnb_1dli gnb_mnal">
						<button type="button" class="gnb_menu_btn">
							<i class="fa fa-bars" aria-hidden="true"></i><span class="sound_only">전체메뉴열기</span>
						</button></li>
					
					<li class="gnb_1dli" style="z-index: 999">
						<a href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=intro01" 
						target="_self" class="gnb_1da">About us</a> <span class="bg">하위분류</span>
						<ul class="gnb_2dul">
							<li class="gnb_2dli"><a
								href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=intro01" target="_self"
								class="gnb_2da">회사소개</a></li>
							<li class="gnb_2dli"><a
								href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=intro02" target="_self"
								class="gnb_2da">찾아오시는길</a></li>
						</ul>
					</li>
					
					
					<li class="gnb_1dli" style="z-index: 998">
						<a href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=wine01" target="_self"
						class="gnb_1da">Meoru Wine</a> <span class="bg">하위분류</span>
						<ul class="gnb_2dul">
							<li class="gnb_2dli"><a
								href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=wine01" target="_self"
								class="gnb_2da">산머루와인</a></li>
						</ul>
					</li>
					
					<li class="gnb_1dli" style="z-index: 997">
						<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list" target="_self" class="gnb_1da">Wine
							EMPERY</a> <span class="bg">하위분류</span>
						<ul class="gnb_2dul">
							<li class="gnb_2dli"><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list"
								target="_self" class="gnb_2da">ALL</a></li>
							<li class="gnb_2dli"><a
								href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list" target="_self"
								class="gnb_2da">EMPERY</a></li>
							<li class="gnb_2dli"><a
								href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list" target="_self"
								class="gnb_2da">Set</a></li>
						</ul>
					</li>
						
					<li class="gnb_1dli" style="z-index: 996">
						<a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice" target="_self"
						class="gnb_1da">CS center</a> <span class="bg">하위분류</span>
						<ul class="gnb_2dul">
							<li class="gnb_2dli"><a
								href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice" target="_self"
								class="gnb_2da">공지사항</a></li>
							<li class="gnb_2dli"><a
								href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardQA" target="_self"
								class="gnb_2da">자유게시판</a></li>
						</ul>
					</li>
				</ul>
			</div>


			
			<ul class="gnb_dp1_wrap">

				<li class="gnb_dp1">
					<div class="">
						<span><a href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=intro01"
							target="_self" class="gnb_al_a">About us</a></span>
					</div>


					<ul class="gnb_dp2_wrap">

						<li class="gnb_dp2"><a
							href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=intro01" target="_self">
								회사소개 </a></li>


						<li class="gnb_dp2"><a
							href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=intro02" target="_self">
								찾아오시는길 </a></li>

					</ul>
				</li>


				<li class="gnb_dp1">
					<div class="">
						<span><a href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=wine01"
							target="_self" class="gnb_al_a">Wine Info</a></span>
					</div>


					<ul class="gnb_dp2_wrap">

						<li class="gnb_dp2"><a
							href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=wine01" target="_self">
								와인 즐기는법 </a></li>

					</ul>
				</li>


				<li class="gnb_dp1">
					<div class="">
						<span><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list" target="_self"
							class="gnb_al_a">Wine EMPERY</a></span>
					</div>


					<ul class="gnb_dp2_wrap">

						<li class="gnb_dp2"><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=RED"
							target="_self"> 레드 와인 </a></li>


						<li class="gnb_dp2"><a
							href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=WHI" target="_self">
								화이트 와인 </a></li>


						<li class="gnb_dp2"><a
							href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=ROS" target="_self"> 로제 와인
						</a></li>
						
						
						<li class="gnb_dp2"><a
							href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=SHA" target="_self"> 샴페인
						</a></li>
					</ul>
				</li>


				<li class="gnb_dp1">
					<div class="">
						<span><a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice"
							target="_self" class="gnb_al_a">CS center</a></span>
					</div>


					<ul class="gnb_dp2_wrap">

						<li class="gnb_dp2"><a
							href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardNotice" target="_self">
								공지사항 </a></li>

						<li class="gnb_dp2"><a
							href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=boardQA" target="_self">
								자유게시판 </a></li>

					</ul>
				</li>

			</ul>


			<script>
				$(document).ready(function() {
					$('.gnb_dp1').hover(function() {
						$('.gnb_dp2_wrap', this).stop().slideDown(200);
					}, function() {
						$('.gnb_dp2_wrap', this).stop().slideUp(200);
					});
				});
			</script>



		</div>


		<ul class="hd_mem">
		<% if (loginmember == null) { //비로그인 %>
			<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=login"><b>Login</b></a></li>
			<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=register">Register</a></li>
		<% } else if (loginmember.getStatus() == 1) { //일반회원 로그인 상태 %>
			<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=logout">Logout</a></li>
			<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=modify_confirm">Edit</a></li>
			<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=mypage">My page</a></li>
			<li class="tnb_cart"><a href="<%=request.getContextPath()%>/index.jsp?part=shop/order&content=cart">Cart</a></li>
		<% } else if (loginmember.getStatus() == 9) { //관리자 로그인 상태%>
			<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp"><b>Admin</b></a></li>
			<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=logout">Logout</a></li>
			<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=modify_confirm">Edit</a></li>
			<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=mypage">My page</a></li>
			<li class="tnb_cart"><a href="<%=request.getContextPath()%>/index.jsp?part=shop/order&content=cart">Cart</a></li>
		<% } %>
		</ul>

	</header>