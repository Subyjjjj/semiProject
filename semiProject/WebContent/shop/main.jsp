<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//최신글 공지글로 페이징 처리를 위해 1으로 고정
	int pageNum=1;
	
	//하나의 페이지에 출력될 게시글의 갯수 설정
	int pageSize=16;
	
	//페이지에 대한 게시글 시작행 번호를 계산하여 저장
	//ex) 1 Page : 1, 2 Page : 11, 3 Page : 21, 4 Page : 31, ... 
	int startRow=(pageNum-1)*pageSize+1;
		
	//페이지에 대한 게시글 종료행 번호를 계산하여 저장
	//ex) 1 Page : 10, 2 Page : 20, 3 Page : 30, 4 Page : 40, ... 
	int endRow=pageNum*pageSize;
	
	String search = "", keyword = "", color = "", country = "", sort = "";
	
	//게시글의 시작 행번호와 종료 행번호를 전달하여 PRODUCT 테이블에 저장된
	//게시글 중 시작 행번호와 종료 행번호 범위의 게시글을 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	List<ProductDTO> productList = ProductDAO.getDAO().selectAllProduct(startRow, endRow, search, keyword, color, country, sort);
	
	//sct_clear태그를 사용해 상품을 정렬 시키기 위한 변수
	int clear = 1;
%>
<!-- 콘텐츠 시작 { -->
	<div id="container">
		<!--  -->
	</div>

	<div class="main_vis_wrap">
		<!-- 메인이미지 시작 { -->

		<div id="main_bn">
			<ul class="slide-wrap">
				<li class="bn_first">
					<div class="txt">
						<p class="t1">
							<span>Wine</span> EMPERY
						</p>
						<p class="t2">
							봉화 "에덴의 동쪽" 산 머루주 양조장에서 만든 머루와인 엠퍼리<br>그 독특한 맛과 향의 머루와인
						</p>
					</div> <img width="100%" src="<%=request.getContextPath()%>/img/banner/1" width="1903" alt="">
				</li>
				<li class="bn_first">
					<div class="txt">
						<p class="t1">
							<span>Wine</span> EMPERY
						</p>
						<p class="t2">
							봉화 "에덴의 동쪽" 산 머루주 양조장에서 만든 머루와인 엠퍼리<br>그 독특한 맛과 향의 머루와인
						</p>
					</div> <img width="100%" src="<%=request.getContextPath()%>/img/banner/2" width="1903" alt="">
				</li>
				<li class="bn_first">
					<div class="txt">
						<p class="t1">
							<span>Wine</span> EMPERY
						</p>
						<p class="t2">
							봉화 "에덴의 동쪽" 산 머루주 양조장에서 만든 머루와인 엠퍼리<br>그 독특한 맛과 향의 머루와인
						</p>
					</div> <img width="100%" src="<%=request.getContextPath()%>/img/banner/3" width="1903" alt="">
				</li>
				<li class="bn_first">
					<div class="txt">
						<p class="t1">
							<span>Wine</span> EMPERY
						</p>
						<p class="t2">
							봉화 "에덴의 동쪽" 산 머루주 양조장에서 만든 머루와인 엠퍼리<br>그 독특한 맛과 향의 머루와인
						</p>
					</div> <img width="100%" src="<%=request.getContextPath()%>/img/banner/4" width="1903"
					alt="">
				</li>
			</ul>
			<div id="bx_pager" class="bx_pager">
				<ul>
					<li><a data-slide-index="0" href=""></a></li>
					<li><a data-slide-index="1" href=""></a></li>
					<li><a data-slide-index="2" href=""></a></li>
					<li><a data-slide-index="3" href=""></a></li>
				</ul>
			</div>
		</div>

		<script>
			jQuery(function($) {
				var slider = $('.slide-wrap').show().bxSlider({
					speed : 2000,
					mode : 'fade',
					pagerCustom : '#bx_pager',
					auto : true,
					pause : 4000,
					useCSS : false,
					onSlideAfter : function() {
						slider.startAuto();
					}
				});
			});
		</script>

		<!-- } 메인이미지 끝 -->
	</div>

	<div class="sec01_wrap">
		<div class="tit lora c1">
			<span>Wine</span> EMPERY
		</div>
		<div class="con Noto-serif">
			향기를 맡으면 완전히 숙성한 머루의 달콤한 향기가 부드럽게 와인의 표면에 맴돕니다. <br> 하지만, 와인 속에
			많은 향이 잠겨있는 듯한 느낌이 듭니다.
		</div>
		<div class="link_wrap Noto-serif">
			<a class="bs" href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=wine01">
				와인이야기</a>
		</div>
	</div>

	<div class="sec02_wrap">
		<div class="box">
			<div class="c bg1"></div>
		</div>
		<div class="box">
			<div class="c txt Noto-serif">
				<div class="tt">About us</div>
				<div class="bar"></div>
				<div class="cc">
					경상북도 봉화군의 에덴의동쪽"에서 생산하는<br>산머루와인 엠퍼리는 야생속의 자연에서 생긴 <br>여러가지
					세균, 해충과 싸우면서 탄생된 대지의 <br>생명력을 가진 그대로의 산물입니다.
				</div>
				<div class="link_wrap Noto-serif">
					<a class="bs" href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=intro01">회사소개</a>
				</div>
			</div>
		</div>
		<div class="box">
			<div class="c bg2"></div>
		</div>
		<div class="box">
			<div class="c txt Noto-serif">
				<div class="tt">Enjoying EMPERY</div>
				<div class="bar"></div>
				<div class="cc">
					와인을 제대로 즐기는 방법은 무엇일까요?<br>와인의 맛과 향 그리고 빛깔을 제대로 감상하려면 <br>알맞은
					온도로 서빙하고 향을 잘 살릴 수 있는 잔을 <br>선택하는 것이 좋습니다.
				</div>
				<div class="link_wrap Noto-serif">
					<a class="bs" href="<%=request.getContextPath()%>/index.jsp?part=shop/doc&content=wine01">와인 즐기는법</a>
				</div>
			</div>
		</div>
	</div>

	<div class="sec03_wrap">
		<header>
			<h2 class="ph c1">Products</h2>
		</header>
	</div>


	<!-- 히트상품 시작 { -->
	<section class="sct_wrap">

		<!-- 상품진열 40 시작 { -->
		<ul class="smt smt_40">
			<li class="sct_li sct_clear"
				style="padding: 20px 20px 20px 309px; width: px; height: 291px">
				<div class="sct_img">
					<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=1">
						<img
						src="https://www.empery.kr/data/item/1545178726/thumb-7Iqk7JyE7Yq41_289x289.jpg"
						width="289" height="289" alt="EMPERY - Sweet">
					</a>
				</div>
				<div class="sct_txt">
					<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=1">
						EMPERY - Sweet </a>
				</div>
				<div class="sct_basic">세미 스파클링 타입의 감미로운 와인으로 내츄럴한 향과 뛰어난 맛을
					느끼실 수 있습니다.</div>
				<div class="sct_basic">엠퍼리 스위트 Type 750ml</div>
				<div class="sct_cost">35,000원</div>
				<div class="sct_icon">
					<span class="sit_icon"><span class="shop_icon shop_icon_1">히트</span></span>
				</div>
			</li>
			<li class="sct_li sct_last"
				style="padding: 20px 20px 20px 309px; width: px; height: 291px">
				<div class="sct_img">
					<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=2">
						<img
						src="https://www.empery.kr/data/item/1545180298/thumb-65Oc65287J201_289x289.jpg"
						width="289" height="289" alt="EMPERY - Dry">
					</a>
				</div>
				<div class="sct_txt">
					<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=2">
						EMPERY - Dry </a>
				</div>
				<div class="sct_basic">감미가 적은 타입으로 더욱 깊은 맛과 향을 느끼실 수 있습니다.</div>
				<div class="sct_basic">엠퍼리 드라이 Type 750ml</div>
				<div class="sct_cost">35,000원</div>
				<div class="sct_icon">
					<span class="sit_icon"><span class="shop_icon shop_icon_1">히트</span></span>
				</div>
			</li>
		</ul>
		<!-- } 상품진열13 끝 -->
	</section>
	<!-- } 히트상품 끝 -->

	<!-- 추천상품 시작 { -->
	<section class="sct_wrap">

		<!-- 상품진열 10 시작 { -->
		<ul class="sct sct_10">
			<% for(ProductDTO product:productList) { %>
	<%-- 상품 정렬을 위한 조건문. --%>
	<% if ((clear % 4) == 1 ) { %>
	<li class="sct_li sct_clear" style="width:289px">
	<% } else if ((clear % 4) == 0) { %>
	<li class="sct_li sct_last" style="width:289px">	
	<% } else { %>
	<li class="sct_li" style="width:289px">
	<% } %>
		<div class="sct_img">
			<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=<%=product.getProductNum()%>">
			<img src="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage1()%>" width="289" height="289" alt="EMPERY - Sweet">
			</a>
		</div>
		<div class="sct_txt">
		<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=<%=product.getProductNum()%>"><%=product.getProductName() %></a>
		</div>
		<% String[] productDetails = product.getProductDetail().split("___"); %>
		<div class="sct_basic">
		<% if (productDetails[0].length() > 75 ) { %>
			<%=productDetails[0].substring(0, 75) + "..." %>
		<% } else { %>
			<%=productDetails[0] %>
		<% } %>
		</div>
		<div class="sct_cost"><%=DecimalFormat.getCurrencyInstance().format(product.getProductPrice()) %></div>
	</li>
	<% clear++; %>
<% } %>
		</ul>
		<!-- } 상품진열 10 끝 -->
	</section>
	<!-- } 추천상품 끝 -->



	<!-- } 콘텐츠 끝 -->