<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 테이블에 저장된 제품정보를 검색하여 클라이언트에게 전달하는 JSP 문서 --%>
<% 
	//검색대상과 검색단어를 반환받아 저장
	String search=request.getParameter("search");
	if(search==null) search="";
	String keyword=request.getParameter("keyword");
	if(keyword==null) keyword="";	
	
	//와인 종류별로 구분하기 위해 반환받아 저장(색, 나라)
	String color = request.getParameter("color");
	if(color==null) color="";
	String country = request.getParameter("country");
	if(country==null) country="";
	
	//정렬을 위한 값을 반환받아 저장
	String sort=request.getParameter("sort");
	if(sort==null) { 
		sort=""; 
	} else if (sort.equals("priceAsc")) {
		sort="order by product_price asc";
	} else if (sort.equals("priceDesc")) {
		sort="order by product_price desc";
	} else if (sort.equals("addDateDesc")) {
		sort="order by add_date desc";
	}
	
	//전달된 페이지 번호를 반환받아 저장
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나의 페이지에 출력될 게시글의 갯수 설정
	int pageSize=16;
	
	//BOARD 테이블에 저장된 전체 게시글 중 검색 게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출
	int totalProduct = ProductDAO.getDAO().selectProductCount(search, keyword, color, country);
	
	//전체 페이지 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalProduct/pageSize);
	
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
	if(endRow > totalProduct) {
		endRow=totalProduct;
	}
	
	//PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<ProductDTO> productList = ProductDAO.getDAO().selectAllProduct(startRow, endRow, search, keyword, color, country, sort);
	
	//출력될 페이지의 게시글 시작번호를 계산하여 저장
	int number=totalProduct-(pageNum-1)*pageSize;
	
	//sct_clear태그를 사용해 상품을 정렬 시키기 위한 변수
	int clear = 1;
%>
<!-- 콘텐츠 시작 { -->
<div id="container">
	<% if (color.equals("RED")) { %>
	<div id="wrapper_title">Red Wine</div>       
	<% } else if (color.equals("WHI")) { %>
	<div id="wrapper_title">White Wine</div>
	<% } else if (color.equals("ROS")) { %>
	<div id="wrapper_title">Rosé Wine</div>
	<% } else if (color.equals("SHA")) { %>
	<div id="wrapper_title">Champagne</div>
	<% } else { %>
	<div id="wrapper_title">Wine EMPERY</div>
	<% } %>
	
<!-- 상품 목록 시작 { -->
<div id="sct">

<div id="sct_location">
    <a href='<%=request.getContextPath()%>/index.jsp' class="sct_bg">HOME</a>
    <a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list" class="sct_here ">Wine EMPERY</a></div>
<div id="sct_hhtml"></div>
<!-- 상품분류 1 시작 { -->
<aside id="sct_ct_1" class="sct_ct">
    <h2>현재 상품 분류와 관련된 분류</h2>
    <ul>
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=FRA&sort=<%=sort%>">프랑스</a></li>
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=SPA&sort=<%=sort%>">스페인</a></li>    
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=CHI&sort=<%=sort%>">칠레</a></li>    
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=ITA&sort=<%=sort%>">이탈리아</a></li>    
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=ARG&sort=<%=sort%>">아르헨티나</a></li>    
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=AUS&sort=<%=sort%>">호주</a></li>    
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=USA&sort=<%=sort%>">미국</a></li>    
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=GER&sort=<%=sort%>">독일</a></li>    
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=ECT&sort=<%=sort%>">기타</a></li>    
    	<li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=&country=&sort=">전체</a></li>    
    </ul>
</aside>
<!-- } 상품분류 1 끝 -->

<div id="sct_sortlst">
<!-- 상품 정렬 선택 시작 { -->
<section id="sct_sort">
    <h2>상품 정렬</h2>

    <ul id="ssch_sort">
        <li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=<%=country%>&sort=priceAsc">낮은가격순</a></li>
        <li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=<%=country%>&sort=priceDesc">높은가격순</a></li>
        <li><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&color=<%=color%>&country=<%=country%>&sort=addDateDesc">최근등록순</a></li>
    </ul>
</section>
</div>
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
    
    <div id="sct_thtml"></div></div>
    	<!-- 게시판 검색 시작 { -->
			<fieldset id="bo_sch">
				<legend>게시물 검색</legend>

				<form action="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list" name="fsearch" method="post">
					<label for="sfl" class="sound_only">검색대상</label> 
					<select name="search" id="sfl">
						<option value="product_name">제품이름</option>
						<option value="product_detail">내용</option>
					</select> 
					
					<label for="stx" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label> 
					
					<input type="text" name="keyword" value="" required id="stx" class="sch_input" size="25" maxlength="20" placeholder="검색어를 입력해주세요">
					<button type="submit" value="검색" class="" style="padding-top: 2px; background-color: Transparent;">
						<img src="<%=request.getContextPath()%>/img/shop/search.png">
					</button>
				</form>
			</fieldset>
			<div style="clear: both;"></div>
			<!-- } 게시판 검색 끝 -->
    	
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
	    	<a href="<%= request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>&color=<%=color%>&country=<%=country%>&sort=<%=sort%>"><i class="fas fa-angle-double-left"></i></a>
		    <a href="<%= request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>&color=<%=color%>&country=<%=country%>&sort=<%=sort%>"><i class="fas fa-angle-left"></i></a>&nbsp;
        <% } else{ %>
	        <i class="fas fa-angle-double-left"></i>
	        <i class="fas fa-angle-left"></i>&nbsp;
        <% } %>
               
        <% for (int i = startPage; i <= endPage; i++) { %>
			<% if(pageNum!=i){ %>
				<a href="<%= request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>&color=<%=color%>&country=<%=country%>&sort=<%=sort%>"><%= i %></a>&nbsp;
			<% } else { %>
				<span style="font-weight: bold;">[<%= i %>]&nbsp;</span>
			<% } %>
		<% } %>
               
               
        <% if(endPage != totalPage) { %>
	    	<a href="<%= request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>&color=<%=color%>&country=<%=country%>&sort=<%=sort%>"><i class="fas fa-angle-right"></i></a>
			<a href="<%= request.getContextPath()%>/index.jsp?part=shop/product&content=product_list&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>&color=<%=color%>&country=<%=country%>&sort=<%=sort%>"><i class="fas fa-angle-double-right"></i></a>
        <% } else { %>
		    <i class="fas fa-angle-right"></i>
		    <i class="fas fa-angle-double-right"></i>
        <% } %>
        </div>
<!-- } 상품 목록 끝 -->


    </div>
    <!-- } 콘텐츠 끝 -->
