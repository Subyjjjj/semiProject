<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="semiProject.dao.CartDAO"%>
<%@page import="semiProject.dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/login_status.jspf" %>
<%	
	//세션에 저장된 로그인멤버의 id 값 호출
	String id = loginMember.getId();
	
	//해당 회원의 카트를 불러오는 메소드
	List<CartDTO> cartList = CartDAO.getDAO().selectIdCart(id);
	
	//카트에 있는 모든 항목의 합계 가격
	int total = 0;
%>
	<!-- 콘텐츠 시작 { -->
	<div id="container">
		<!-- <div id="wrapper_title">장바구니</div> -->
		<div id="wrapper_title">장바구니</div>


		<!-- 장바구니 시작 { -->


		<div id="sod_bsk" class="od_prd_list">

			<form name="frmcartlist" id="sod_bsk_list" class="2017_renewal_itemform" method="post"
				action="<%=request.getContextPath()%>/index.jsp?part=shop/order&content=order_form">
				<input type="hidden" name="cert_type" value="">
				<input type="hidden" name="cartConfirm" value="1">

				<div class="tbl_head03 tbl_wrap">
					<table>
						<thead>
							<tr>
								<th scope="col"><label for="ct_all" class="sound_only">상품전체</label> 
								<input type="checkbox" name="ct_all" value="1" id="ct_all" checked></th>
								<th scope="col">상품명</th>
								<th scope="col">총수량</th>
								<th scope="col">판매가</th>
								<th scope="col">배송비</th>
								<th scope="col">소계</th>
							</tr>
						</thead>
						<tbody>
						<% for (CartDTO cart: cartList) { %>
							<% if (cartList == null) { //카트에 담긴 제품이 없을때 %>
								<tr><td colspan="8" class="empty_table">장바구니에 담긴 상품이 없습니다.</td></tr>
							<% } else { %>
							<% total += cart.getProductTotal(); %>
							<tr>
								<td class="td_chk"><label for="ct_chk_0" class="sound_only">상품</label>
									<input type="checkbox" name="ct_chk" value="<%=cart.getCartNum() %>" id="ct_chk" class="check" checked></td>

								<td class="td_prd">
									<div class="sod_img">
										<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=<%=cart.getProductNum()%>">
										<img src="<%=request.getContextPath()%>/img/product_images/<%=cart.getProductImage()%>"
											width="80" height="80" alt=""></a>
									</div>
									<div class="sod_name" style="padding-top: 20px;">
										<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=<%=cart.getProductNum()%>" class="prd_name">
										<b><%=cart.getProductName() %></b></a>
										<div class="sod_opt">
											<ul>
												<li><%=cart.getProductDetail() %> <%=cart.getProductQTY() %>개</li>
											</ul>
										</div>
									</div>
								</td>
								<td class="td_num"><%=cart.getProductQTY() %></td>
								<td class="td_numbig text_right"><%=DecimalFormat.getCurrencyInstance().format(cart.getProductPrice()) %></td>
								<td class="td_dvr">무료</td>
								<td class="td_numbig text_right"><span id="sell_price_0"
									class="total_prc"><%=DecimalFormat.getCurrencyInstance().format(cart.getProductTotal()) %></span></td>

							</tr>
							<% } %>
						<% } %>
						</tbody>
					</table>
					<div class="btn_cart_del">
						<button id="removeBtn" type="button" onclick="return form_check('seldelete');">선택삭제</button>
					</div>
				</div>

				<div id="sod_bsk_tot">
					<ul>
						<li class="sod_bsk_dvr"><span>배송비</span> <strong>무료</strong>
							</li>

						<li class="sod_bsk_cnt"><span>총계 가격</span> <strong><%=DecimalFormat.getInstance().format(total)%></strong>
							원</li>

					</ul>
				</div>

				<div id="sod_bsk_act">
					<input type="hidden" name="url" value="./orderform.php"> 
					<input type="hidden" name="records" value="2"> 
					<input type="hidden" name="act" value=""> 
					<a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=product_list" class="btn01">쇼핑 계속하기</a>
					<button type="button" onclick="return form_check('buy');" class="btn_submit">
						<i class="fa fa-credit-card" aria-hidden="true"></i> 주문하기
					</button>

				</div>

			</form>

		</div>



<script>
// 모두선택
$("#ct_all").change(function() {
    if($(this).is(":checked")) {
        $(".check").prop("checked", true);
    } else {
        $(".check").prop("checked", false);
    }
});
    

function fsubmit_check(f) {
    if($("input[name^=ct_chk]:checked").length < 1) {
        alert("구매하실 상품을 하나이상 선택해 주십시오.");
        return false;
    }

    return true;
}

function form_check(act) {
    var f = document.frmcartlist;
    var cnt = f.records.value;

    if (act == "buy")
    {
		//성인인증
		
        if($("input[name^=ct_chk]:checked").length < 1) {
            alert("주문하실 상품을 하나이상 선택해 주십시오.");
            return false;
        }

        f.act.value = act;
        f.submit();
    }
    else if (act == "alldelete")
    {
        f.act.value = act;
        f.submit();
    }
    else if (act == "seldelete")
    {
        if($("input[name^=ct_chk]:checked").length < 1) {
            alert("삭제하실 상품을 하나이상 선택해 주십시오.");
            return false;
        }

        f.act.value = act;
        f.submit();
    }

    return true;
}

$("#removeBtn").click(function() {
	$("#sod_bsk_list").attr("action", "<%=request.getContextPath()%>/index.jsp?part=shop/order&content=cart_remove_processing");
	$("#sod_bsk_list").submit();
});
</script>
<!-- } 장바구니 끝 -->


</div>
<!-- } 콘텐츠 끝 -->
