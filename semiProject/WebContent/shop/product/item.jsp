<%@page import="semiProject.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품에 대한 상세페이지, 제품 값들(수량, 제품번호 등등)으로 item_preocessing.jsp으로 응답요청 --%>
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getParameter("productNum")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}
	
	//전달값을 반환받아 저장
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");	

	//게시글번호를 전달하여 BOARD 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectNumProduct(productNum);
	
	//검색된 게시글이 없는 경우 => 비정상적인 요청
	if(product == null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}
	
	//세션에 저장된 인증정보(회원정보)를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//디테일에 저장된 값 쪼개기
	String[] productDetails = product.getProductDetail().split("___");
	
	//카테고리 구분
	int review = 3;
	int QA = 4;
	
	//상품후기의 저장된 글을 검색 후 반환.
	List<BoardDTO> reviewList = BoardDAO.getDAO().selectProductBoard(review, productNum);
	
	//상품문의의 저장된 글을 검색 후 반환
	List<BoardDTO> qaList = BoardDAO.getDAO().selectProductBoard(QA, productNum);
	
	//상품후기가 몇개 저장됐는지 카운트하기 위한 변수
	int countReview = BoardDAO.getDAO().selectBoardCount(review, productNum);
	
	//상품문의가 몇개 저장됐는지 카운트하기 위한 변수
	int countQA = BoardDAO.getDAO().selectBoardCount(QA, productNum);
%>
    
<!-- 콘텐츠 시작 { -->
<div id="container">
<div id="wrapper_title">Wine EMPERY</div>       

<div id="sct_location">
    <a href='<%=request.getContextPath()%>/index.jsp' class="sct_bg">HOME</a>
    <a href="./list.php?ca_id=10" class="sct_here ">Wine EMPERY</a></div>

<!-- 상품 상세보기 시작 { -->
<div id="sit_hhtml"></div>
<script src="<%=request.getContextPath()%>/js/shop.js"></script>

<div id="sit">
   
<form name="fitem" id="fitem" method="post" action="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item_processing" onsubmit="return fitem_submit(this);">
	<input type="hidden" name="productNum" value="<%=product.getProductNum() %>">
	<input type="hidden" name="productImage" value="<%=product.getProductImage1() %>">
	<input type="hidden" name="productName" value="<%=product.getProductName()%>">
	<input type="hidden" name="productDetail" value="<%=productDetails[0] %>"> 

<div id="sit_ov_wrap">
    <!-- 상품이미지 미리보기 시작 { -->
    <div id="sit_pvi">
        <div id="sit_pvi_big">
	        <a href="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage1()%>" target="_blank" class="popup_item_image visible">
	        <img src="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage1()%>" width="600" height="600" alt="">
	        </a>
        
        	<a href="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage2()%>" target="_blank" class="popup_item_image">
        	<img src="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage2()%>" width="600" height="600" alt="">
        	</a>
        	
        	<a href="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage3()%>" target="_blank" class="popup_item_image">
        	<img src="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage3()%>" width="600" height="600" alt="">
        	</a>        
        </div>
        
    <ul id="sit_pvi_thumb">
    	<li >
    		<a href="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage1()%>" target="_blank" class="popup_item_image img_thumb">
    		<img src="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage1()%>" width="60" height="60" alt="">
    		<span class="sound_only"> 1번째 이미지 새창</span>
    		</a>
    	</li>
    	
    	<li >
    		<a href="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage2()%>" target="_blank" class="popup_item_image img_thumb">
    		<img src="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage2()%>" width="60" height="60" alt="">
    		<span class="sound_only"> 2번째 이미지 새창</span></a>
    	</li>
    	
    	<li >
    		<a href="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage3()%>" target="_blank" class="popup_item_image img_thumb">
    		<img src="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage3()%>" width="60" height="60" alt="">
    		<span class="sound_only"> 3번째 이미지 새창</span></a>
    	</li>
    </ul>           

    </div>
    <!-- } 상품이미지 미리보기 끝 -->

    <!-- 상품 요약정보 및 구매 시작 { -->
    <section id="sit_ov" class="2017_renewal_itemform">
        <h2 id="sit_title"><%=product.getProductName() %> <span class="sound_only">요약정보 및 구매</span></h2>
        <p id="sit_desc"><%=productDetails[0]%></p>
        <p id="sit_opt_info">상품 선택옵션 0 개, 추가옵션 1 개 </p>
        <div class="sit_info">
            <table class="sit_ov_tbl">
            <colgroup>
                <col class="grid_3">
                <col>
            </colgroup>
            <tbody>
            	<tr>
                	<th scope="row">제조사</th>
                	<td><%=product.getProductCode().split("_")[3]%></td>
            	</tr>
            
                <tr>
	                <th scope="row">원산지</th>
	                <td>
					<%if (product.getProductCode().split("_")[0].equals("FRA")) { %>
	                   	프랑스
                   <%} else if(product.getProductCode().split("_")[0].equals("SPA")) { %>
	                   	스페인
                   <%} else if(product.getProductCode().split("_")[0].equals("CHI")) { %>
	                   	칠레
                   <%} else if(product.getProductCode().split("_")[0].equals("ITA")) { %>
	                   	이탈리아
                   <%} else if(product.getProductCode().split("_")[0].equals("ARG")) { %>
	                   	아르헨티나
                   <%} else if(product.getProductCode().split("_")[0].equals("AUS")) { %>
	                   	호주
                   <%} else if(product.getProductCode().split("_")[0].equals("USA")) { %>
	                   	미국
                   <%} else if(product.getProductCode().split("_")[0].equals("GER")) { %>
	                   	독일
                   <%} else if(product.getProductCode().split("_")[0].equals("ECT")) { %>
	                   	기타국가
                   <%} else { %>
	                   -
                   <%} %>
	                </td>
            	</tr>
            
                <tr>
	                <th scope="row">브랜드</th>
	                <td><%=product.getProductCode().split("_")[2]%></td>
            	</tr>
            
                <tr>
	                <th scope="row">모델</th>
	                <td>
                	<% if (product.getProductCode().split("_")[1].equals("RED")) { %>
	                   		레드와인
	               	<%} else if(product.getProductCode().split("_")[1].equals("WHI")) { %>
		                   	화이트와인
	              	<%} else if(product.getProductCode().split("_")[1].equals("ROS")) { %>
		                   	로제
	               	<%} else if(product.getProductCode().split("_")[1].equals("SHA")) { %>
		                  	샴페인
	               	<%} else {%>
		                  -
	               	<%} %>
	                </td>
            	</tr>
            
            	<tr>
                	<th scope="row">판매가격</th>
                	<td><strong><%=DecimalFormat.getCurrencyInstance().format(product.getProductPrice()) %></strong>
                    <input type="hidden" id="it_price" name="productPrice" value="<%=product.getProductPrice()%>">
                	</td>
            	</tr>
            
                <tr>
                	<th scope="row">포인트</th>
                	<td>구매금액(추가옵션 제외)의 2%</td>
            	</tr>
            	
               	<tr>
                	<th>배송비결제</th>
                	<td>주문시 결제</td>
           		</tr>
                </tbody>
            </table>
        </div><br>
        
        <!-- 선택된 옵션 시작 { -->
        <section id="sit_sel_option">
            <h3>선택된 옵션</h3>
            <ul id="sit_opt_added">
                <li class="sit_opt_list">
                    <input type="hidden" name="io_type" value="0">
                    <input type="hidden" class="io_price" value="0">
                    <input type="hidden" class="io_stock" value="<%=product.getProductQty()%>">
                    
                    <div class="opt_name">
                        <span class="sit_opt_subj"><%=product.getProductName() %></span>
                    </div>
                    
                    <div class="opt_count">
                        <label for="ct_qty_11" class="sound_only">수량</label>
                        <button type="button" class="sit_qty_minus"><i class="fa fa-minus" aria-hidden="true"></i><span class="sound_only">감소</span></button>
                        <input type="text" name="ct_qty" value="0" id="ct_qty_11" class="num_input" size="5">
                        <button type="button" class="sit_qty_plus"><i class="fa fa-plus" aria-hidden="true"></i><span class="sound_only">증가</span></button>
                        <span class="sit_opt_prc">+<%=product.getProductPrice()%></span>
                    </div><br>
                </li>
            </ul>
            <script>
            $(function() {
                price_calculate();
            });
            </script>
        </section><br>
        <!-- } 선택된 옵션 끝 -->

        <!-- 총 구매액 -->
        <div id="sit_tot_price"></div>
        
        <div id="sit_ov_btn" style="padding-left: 35px;padding-top: 20px;">
        	<button type="submit" value="바로구매" id="sit_btn_buy" name="btnBuy"><i class="fa fa-credit-card" aria-hidden="true"></i> 바로구매</button>
            <button type="submit" value="장바구니" id="sit_btn_cart" name="cartBuy"><i class="fa fa-shopping-cart" aria-hidden="true"></i> 장바구니</button>
        </div>
    </section>
    <!-- } 상품 요약정보 및 구매 끝 -->
</div>
</form>

<script type="text/javascript">
$(function(){
    // 상품이미지 첫번째 링크
    $("#sit_pvi_big a:first").addClass("visible");

    // 상품이미지 미리보기 (썸네일에 마우스 오버시)
    $("#sit_pvi .img_thumb").bind("mouseover focus", function(){
        var idx = $("#sit_pvi .img_thumb").index($(this));
        $("#sit_pvi_big a.visible").removeClass("visible");
        $("#sit_pvi_big a:eq("+idx+")").addClass("visible");
    });

    // 상품이미지 크게보기
    $(".popup_item_image").click(function() {
        var url = $(this).attr("href");
        var top = 10;
        var left = 10;
        var opt = 'scrollbars=yes,top='+top+',left='+left;
        popup_window(url, "largeimage", opt);

        return false;
    });
});

function fsubmit_check(f)
{
    // 판매가격이 0 보다 작다면
    if (document.getElementById("it_price").value < 0) {
        alert("전화로 문의해 주시면 감사하겠습니다.");
        return false;
    }

    if($(".sit_opt_list").size() < 1) {
        alert("상품의 선택옵션을 선택해 주십시오.");
        return false;
    }

    var val, io_type, result = true;
    var sum_qty = 0;
    var min_qty = parseInt(1);
    var max_qty = parseInt(0);
    var $el_type = $("input[name^=io_type]");

    $("input[name^=ct_qty]").each(function(index) {
        val = $(this).val();

        if(val.length < 1) {
            alert("수량을 입력해 주십시오.");
            result = false;
            return false;
        }

        if(val.replace(/[0-9]/g, "").length > 0) {
            alert("수량은 숫자로 입력해 주십시오.");
            result = false;
            return false;
        }

        if(parseInt(val.replace(/[^0-9]/g, "")) < 1) {
            alert("수량은 1이상 입력해 주십시오.");
            result = false;
            return false;
        }

        io_type = $el_type.eq(index).val();
        if(io_type == "0")
            sum_qty += parseInt(val);
    });

    if(!result) {
        return false;
    }
	
    if(min_qty > 0 && sum_qty < min_qty) {
        alert("선택옵션 개수 총합 "+number_format(String(min_qty))+"개 이상 주문해 주십시오.");
        return false;
    }

    if(max_qty > 0 && sum_qty > max_qty) {
        alert("선택옵션 개수 총합 "+number_format(String(max_qty))+"개 이하로 주문해 주십시오.");
        return false;
    }

    return true;
}

// 바로구매, 장바구니 폼 전송
function fitem_submit(f)
{
    // 판매가격이 0 보다 작다면
    if (document.getElementById("it_price").value < 0) {
        alert("전화로 문의해 주시면 감사하겠습니다.");
        return false;
    }

    if($(".sit_opt_list").size() < 1) {
        alert("상품의 선택옵션을 선택해 주십시오.");
        return false;
    }

    var val, io_type, result = true;
    var sum_qty = 0;
    var min_qty = parseInt(1);
    var max_qty = parseInt(0);
    var $el_type = $("input[name^=io_type]");

    $("input[name^=ct_qty]").each(function(index) {
        val = $(this).val();

        if(val.length < 1) {
            alert("수량을 입력해 주십시오.");
            result = false;
            return false;
        }

        if(val.replace(/[0-9]/g, "").length > 0) {
            alert("수량은 숫자로 입력해 주십시오.");
            result = false;
            return false;
        }

        if(parseInt(val.replace(/[^0-9]/g, "")) < 1) {
            alert("수량은 1이상 입력해 주십시오.");
            result = false;
            return false;
        }

        io_type = $el_type.eq(index).val();
        if(io_type == "0")
            sum_qty += parseInt(val);
    });

    if(!result) {
        return false;
    }

    if(min_qty > 0 && sum_qty < min_qty) {
        alert("선택옵션 개수 총합 "+number_format(String(min_qty))+"개 이상 주문해 주십시오.");
        return false;
    }

    if(max_qty > 0 && sum_qty > max_qty) {
        alert("선택옵션 개수 총합 "+number_format(String(max_qty))+"개 이하로 주문해 주십시오.");
        return false;
    }

    return true;
}

$("#sit_btn_buy").click(function() {
	$("#fitem").attr("action", "<%=request.getContextPath()%>/index.jsp?part=shop/order&content=order_form");
	$("#memberForm").submit();
});
</script>

<script src="<%=request.getContextPath() %>/js/viewimageresize.js"></script>


<!-- 상품 정보 시작 { -->
<section id="sit_inf">
    <h2>상품 정보</h2>
        <ul class="sanchor">
	        <li><a href="#sit_inf" class="sanchor_on">상품정보</a></li>
	        <li><a href="#sit_use" >사용후기 <span class="item_use_count"><%=countReview %></span></a></li>
	        <li><a href="#sit_qa" >상품문의 <span class="item_qa_count"><%=countQA %></span></a></li>
	        <li><a href="#sit_dvr" >배송정보</a></li>        
	        <li><a href="#sit_ex" >교환정보</a></li>    
        </ul>

    <h3>상품 기본설명</h3>
    <div id="sit_inf_basic"><%=productDetails[0].replace("\n", "<br>")%></div>
    
    <h3>상품 상세설명</h3>
    <div id="sit_inf_explan">
        <% if (!productDetails[1].equals("NOPICS")) { %>
			<img src="<%=request.getContextPath() %>/img/product_images/<%=productDetails[1] %>" style="display: block; margin: 0px auto;">
		<% } %>
    </div>
    
</section>
<!-- } 상품 정보 끝 -->

<!-- 사용후기 시작 { -->
<section id="sit_use">
    <h2>사용후기</h2>
        <ul class="sanchor">
        <li><a href="#sit_inf" >상품정보</a></li>
        <li><a href="#sit_use" class="sanchor_on">사용후기 <span class="item_use_count"><%=countReview %></span></a></li>
        <li><a href="#sit_qa" >상품문의 <span class="item_qa_count"><%=countQA %></span></a></li>
        <li><a href="#sit_dvr" >배송정보</a></li>        
        <li><a href="#sit_ex" >교환정보</a></li>    
        </ul>
    <div id="itemuse">
<script src="<%=request.getContextPath() %>/js/viewimageresize.js"></script>

<!-- 상품 사용후기 시작 { -->
<section id="sit_use_list">
    <h3>등록된 사용후기</h3>

    <div class="sit_use_top">
    	<h4>고객 후기</h4>
        <img src="https://www.empery.kr/shop/img/s_star5.png" alt="" class="sit_star">
        <span class="st_bg "></span>
        	총 <strong><%=countReview %></strong> 건 사용후기
       	<% if (loginMember != null) { %>
    	<div id="sit_use_wbtn">
            <a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_write&category=3&productNum=<%=productNum %>" class="btn02">사용후기 쓰기<span class="sound_only"> 새 창</span></a>
        </div>
        <% } %>
    </div>
    
    <ol id="sit_use_ol">
    <% for (BoardDTO rv:reviewList) { %>
    	<% if (rv.getNum() == rv.getRef() && rv.getStatus() == 0) { //일반글 %>
        <li class="sit_use_li">
        	<div class="sit_use_tit"><%=rv.getSubject() %></div>
                <button type="button" class="sit_use_li_title">내용보기 <i class="fa fa-caret-down" aria-hidden="true"></i></button>
	                <% if(loginMember!=null && (loginMember.getId().equals(rv.getId()) || loginMember.getStatus()==9)) { //삭제버튼 %>
	                <a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_remove_processing&category=3&num=<%=rv.getNum() %>&productNum=<%=rv.getProductNum() %>" class="sit_use_li_title">삭제</a>
	                <% } %>
	                <% if(loginMember!=null && loginMember.getStatus() ==9) { //관리자 전용 댓글 %>
	                <a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_write&category=3&productNum=<%=productNum %>&ref=<%=rv.getRef() %>" class="sit_use_li_title">댓글</a>
	                <% } %>
            	<dl class="sit_use_dl">
                    <dt>작성자</dt>
                    <dd><%=rv.getWriter() %></dd>
                    <dt>작성일</dt>
                    <dd><i class="fa fa-clock-o" aria-hidden="true"></i> <%=rv.getRegDate().substring(2, 10) %></dd>
                </dl>

            <div id="sit_use_con_0" class="sit_use_con">
	            <div class="sit_use_p">
	            	<p>
	            	<% if (rv.getImage() != null) { %>
	            	<img src="<%=request.getContextPath()%>/shop/bbs_images/<%=rv.getImage() %>" width="609" height="381"/>
	            	<% } %>
	            	<br style="clear:both;" /></p>
	            	<%=rv.getContent() %>          
	            </div>
	 	<% } else if (rv.getNum() != rv.getRef()) { //답글 %>
	            <div class="sit_use_reply">
	            	<div class="use_reply_icon">답변</div>
	            	<div class="use_reply_tit"><%=rv.getSubject() %></div>
	                <div class="use_reply_name"><%=rv.getWriter() %></div>
	                <div class="use_reply_p"><%=rv.getContent() %></div>
	            </div>
	    <% } %>
	<% } %>
          	</div>
        </li>
    </ol>
    
</section>

<script>
$(function(){
    $(".itemuse_form").click(function(){
        window.open(this.href, "itemuse_form", "width=810,height=680,scrollbars=1");
        return false;
    });

    $(".itemuse_delete").click(function(){
        if (confirm("정말 삭제 하시겠습니까?\n\n삭제후에는 되돌릴수 없습니다.")) {
            return true;
        } else {
            return false;
        }
    });

    $(".sit_use_li_title").click(function(){
        var $con = $(this).siblings(".sit_use_con");
        if($con.is(":visible")) {
            $con.slideUp();
        } else {
            $(".sit_use_con:visible").hide();
            $con.slideDown(
                function() {
                    // 이미지 리사이즈
                    $con.viewimageresize2();
                }
            );
        }
    });

    $(".pg_page").click(function(){
        $("#itemuse").load($(this).attr("href"));
        return false;
    });
});
</script>
<!-- } 상품 사용후기 끝 -->
</div>
</section>
<!-- } 사용후기 끝 -->


<!-- 상품문의 시작 { -->
<section id="sit_qa">
    <h2>상품문의</h2>
        <ul class="sanchor">
	        <li><a href="#sit_inf" >상품정보</a></li>
	        <li><a href="#sit_use" >사용후기 <span class="item_use_count"><%=countReview %></span></a></li>
	        <li><a href="#sit_qa" class="sanchor_on">상품문의 <span class="item_qa_count"><%=countQA %></span></a></li>
	        <li><a href="#sit_dvr" >배송정보</a></li>        
	        <li><a href="#sit_ex" >교환정보</a></li>   
        </ul>

    <div id="itemqa">
<script src="<%=request.getContextPath() %>/js/viewimageresize.js"></script>

<!-- 상품문의 목록 시작 { -->
<section id="sit_qa_list">
    <h3>등록된 상품문의</h3>
	<% if (loginMember != null) { %>
    <div id="sit_qa_wbtn">
        <a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_write&category=4&productNum=<%=productNum %>" class="btn02">상품문의 쓰기<span class="sound_only"> 새 창</span></a>
    </div>
	<% } %>
	
    
    <ol id="sit_use_ol">
    <% for (BoardDTO qa:qaList) { %>
    	<% if (qa.getNum() == qa.getRef() && qa.getStatus() == 0) { //일반글 %>
        <li class="sit_use_li">
        	<div class="sit_use_tit"><%=qa.getSubject() %></div>
                <button type="button" class="sit_use_li_title">내용보기 <i class="fa fa-caret-down" aria-hidden="true"></i></button>
	                <% if(loginMember!=null && (loginMember.getId().equals(qa.getId()) || loginMember.getStatus()==9)) { //삭제버튼 %>
	                <a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_remove_processing&category=3&num=<%=qa.getNum() %>&productNum=<%=qa.getProductNum() %>" class="sit_use_li_title">삭제</a>
	                <% } %>
	                <% if(loginMember!=null && loginMember.getStatus() ==9) { //관리자 전용 댓글 %>
	                <a href="<%=request.getContextPath()%>/index.jsp?part=shop/bbs&content=board_write&category=4&productNum=<%=productNum %>&ref=<%=qa.getRef() %>" class="sit_use_li_title">댓글</a>
	                <% } %>
            	<dl class="sit_use_dl">
                    <dt>작성자</dt>
                    <dd><%=qa.getWriter() %></dd>
                    <dt>작성일</dt>
                    <dd><i class="fa fa-clock-o" aria-hidden="true"></i> <%=qa.getRegDate().substring(2, 10) %></dd>
                </dl>

            <div id="sit_use_con_0" class="sit_use_con">
	            <div class="sit_use_p">
	            	<p>
	            	<% if (qa.getImage() != null) { %>
	            	<img src="<%=request.getContextPath()%>/shop/bbs_images/<%=qa.getImage() %>" width="609" height="381"/>
	            	<% } %>
	            	<br style="clear:both;" /></p>
	            	<%=qa.getContent() %>          
	            </div>
	 	<% } else if (qa.getNum() != qa.getRef()) { //답글 %>
	            <div class="sit_use_reply">
	            	<div class="use_reply_icon">답변</div>
	            	<div class="use_reply_tit"><%=qa.getSubject() %></div>
	                <div class="use_reply_name"><%=qa.getWriter() %></div>
	                <div class="use_reply_p"><%=qa.getContent() %></div>
	            </div>
          	</div>
        </li>
    </ol>
</section>
	    <% } %>
	<% } %>


<script>
$(function(){
    $(".itemqa_form").click(function(){
        window.open(this.href, "itemqa_form", "width=810,height=680,scrollbars=1");
        return false;
    });

    $(".itemqa_delete").click(function(){
        return confirm("정말 삭제 하시겠습니까?\n\n삭제후에는 되돌릴수 없습니다.");
    });

    $(".sit_qa_li_title").click(function(){
        var $con = $(this).siblings(".sit_qa_con");
        if($con.is(":visible")) {
            $con.slideUp();
        } else {
            $(".sit_qa_con:visible").hide();
            $con.slideDown(
                function() {
                    // 이미지 리사이즈
                    $con.viewimageresize2();
                }
            );
        }
    });

    $(".qa_page").click(function(){
        $("#itemqa").load($(this).attr("href"));
        return false;
    });
});
</script>
<!-- } 상품문의 목록 끝 --></div>
</section>
<!-- } 상품문의 끝 -->

<!-- 배송정보 시작 { -->
<section id="sit_dvr">
    <h2>배송정보</h2>
        <ul class="sanchor">
	        <li><a href="#sit_inf" >상품정보</a></li>
	        <li><a href="#sit_use" >사용후기 <span class="item_use_count"><%=countReview %></span></a></li>
	        <li><a href="#sit_qa" >상품문의 <span class="item_qa_count"><%=countQA %></span></a></li>
	        <li><a href="#sit_dvr" class="sanchor_on">배송정보</a></li>        
	        <li><a href="#sit_ex" >교환정보</a></li>    
        </ul>
    <p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;">﻿</span>- 배송비 </span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">3000</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">원</span></p><p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">-</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;"> </span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">배송업체 </span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">:</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">우체국</span></p><p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">-</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;"> </span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">배송기간 </span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">: </span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">평일기준 </span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">2~3</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">일</span></p><p style="font-size:14pt;"><span style="font-family:'나눔고딕', NanumGothic;font-size:12pt;"><br /></span></p><p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">공휴일에는 발송되지 않습니다.</span></p><p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">생산자의 사정에 따라 상품 박스 및 포장재가 다를 수도 있습니다</span></p><p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">수령자가 수취를 거부하여 판매처로 반품 될 경우, 교환</span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">·</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">환불이 불가함을 알려드립니다</span></p><p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">제주도와 도서 산간지역 배송이 불가 할 수 있으며 배송가능 시 추가 요금이 발생할 수 있습니다</span></p></section>
<!-- } 배송정보 끝 -->

<!-- 교환/반품 시작 { -->
<section id="sit_ex">
    <h2>교환/반품</h2>
        <ul class="sanchor">
	        <li><a href="#sit_inf" >상품정보</a></li>
	        <li><a href="#sit_use" >사용후기 <span class="item_use_count"><%=countReview %></span></a></li>
	        <li><a href="#sit_qa" >상품문의 <span class="item_qa_count"><%=countQA %></span></a></li>
	        <li><a href="#sit_dvr" >배송정보</a></li>        
	        <li><a href="#sit_ex" class="sanchor_on">교환정보</a></li>    
        </ul>

    <p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">제품에 하자가 있는 경우에는 전자상거래법 제</span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">17</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">조 및 약관</span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">26</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">조에 의거 교환 반품처리해 드립니다.</span></p><p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">제품 교환 및 반품시에는 유선(054.673.8422)으로 연락하셔서 안내를 받으시기 바랍니다</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;"> </span></p><p style="font-size:14pt;"><span style="font-family:'나눔고딕', NanumGothic;font-size:14pt;"><br /></span></p><p style="letter-spacing:0pt;font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;background-color:rgb(241,226,234);"> - 반송주소 : 경북 봉화군 물야면 오전리 </span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;background-color:rgb(241,226,234);" xml:lang="en-us">186</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;background-color:rgb(241,226,234);">번지 </span><span style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;background-color:rgb(241,226,234);">「</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;background-color:rgb(241,226,234);">에덴의 동쪽</span><span style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;background-color:rgb(241,226,234);">」 </span></p><p style="letter-spacing:0pt;font-size:14pt;"><span style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;"> </span></p><p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">고객님의 변심으로 인한 반품의 경우 왕복 배송비는 고객님의 부담입니다.</span></p><p style="font-size:14pt;"><span style="font-family:'나눔고딕', NanumGothic;font-size:14pt;"><br /></span></p><p style="font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">전자상거래등에 있어서 소비자 보호에 관한 법률에서 교환</span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">/ </span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">반품 규정에 의하여 아래와 같은 경우 교환 및 반품</span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">(</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">환불</span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">)</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">이 불가하오니 구매전 반드시 참고하시기 바랍니다.</span></p><p style="letter-spacing:0pt;font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">상품을 사용하였거나 고객의 부주의로 훼손 및 파손의 경우 </span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">(</span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">단 내용물 확인을 위하여 포장 등을 훼손한 경우 제외</span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">),</span></p><p style="letter-spacing:0pt;font-size:14pt;"><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">주소불명이나 수취인 부재로 반송</span><span lang="en-us" style="letter-spacing:0pt;font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;" xml:lang="en-us">, </span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">배송이 안 된 경우 그로 인해 제품에 문제가 발생한 경우</span></p><p><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;">  </span><span style="font-family:'나눔바른고딕', NanumBarunGothic, NanumBarunGothicOTF;font-size:12pt;"> </span>  </p><p></p></section>
<!-- } 교환/반품 끝 -->

<script>
$(window).on("load", function() {
    $("#sit_inf_explan").viewimageresize2();
});
</script>
</div>



    </div>
    </div>
    <!-- } 콘텐츠 끝 -->