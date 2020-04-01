<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="semiProject.dao.CartDAO"%>
<%@page import="java.util.List"%>
<%@page import="semiProject.dto.CartDTO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- item과 cart에서 받아온 값을 입력란에 출력하는 jsp 문서 --%>
<%@include file="/shop/security/login_status.jspf" %>
<%
	//세션에 저장된 로그인멤버의 id 값 호출
	String id = loginMember.getId();
	
	//바로구매 제품을 받기 위한 변수
	ProductDTO product = null;
	int itemCtQty = 0;
	
	//카트 항목을 받기 위한 인스턴스와 파라미터들을 받기 위한 스트링배열
	List<CartDTO> cartList = new ArrayList<CartDTO>();
	CartDTO cartDTO = null;
	//cart.jsp에서 온 전달값들
	String[] cartNums = request.getParameterValues("ct_chk");
	//카트 항목의 총합계를 계산.
	int totalprice = 0;
		
	if (request.getParameter("cartConfirm") == null) {
		//item.jsp에서 바로구매로 전달값
		int itemProductNum = Integer.parseInt(request.getParameter("productNum"));
		
		itemCtQty = Integer.parseInt(request.getParameter("ct_qty"));
		product = ProductDAO.getDAO().selectNumProduct(itemProductNum);
	} else {
		
		for (String cart: cartNums) {
			int number = Integer.parseInt(cart);
			
			//메소드 호출
			cartDTO = CartDAO.getDAO().selectNoCart(number);
			cartList.add(cartDTO);
		}
	}

	
%>
<!-- 콘텐츠 시작 { -->
<div id="container">
	<div id="wrapper_title">주문서 작성</div>       

<form name="forderform" id="forderform" method="post" 
	action="<%=request.getContextPath()%>/index.jsp?part=shop/order&content=order_form_processing" autocomplete="off">
<div id="sod_frm">
    <!-- 주문상품 확인 시작 { -->
    <div class="tbl_head03 tbl_wrap od_prd_list">
        <table id="sod_list">
        <thead>
        <tr>
            <th scope="col">상품명</th>
            <th scope="col">총수량</th>
            <th scope="col">판매가</th>
            <th scope="col">소계</th>
            <th scope="col">배송비</th>
        </tr>
        </thead>
        <tbody>
	<% if (request.getParameter("cartConfirm") == null) { //바로구매에서 접근 했을시에 %>
        <tr>
            <td class="td_prd">
                <div class="sod_img"><img src="<%=request.getContextPath()%>/img/product_images/<%=product.getProductImage1()%>" width="80" height="80" alt=""></div>
                <div class="sod_name">
                	<%-- 제품정보 전송 --%>
                    <input type="hidden" name="productNum" value="<%=product.getProductNum()%>">
                    <input type="hidden" name="orderAmount" value="<%=itemCtQty%>">
                    <input type="hidden" name="productName" value="<%=product.getProductName()%>">                    
                    <input type="hidden" name="productPrice" value="<%=product.getProductPrice()%>">                    
                    <input type="hidden" name="orderTotal" value="<%=product.getProductPrice() * itemCtQty%>">                    
                    
                    <b><%=product.getProductName() %></b>
                    <div class="sod_opt"><ul>
					<li><%=product.getProductName() %> <%=itemCtQty %>개 (+<%=DecimalFormat.getInstance().format(product.getProductPrice()) %>원)</li>
					</ul></div>                    
                 </div>
            </td>
            <td class="td_num"><%=itemCtQty %></td>
            <td class="td_numbig  text_right"><%=DecimalFormat.getInstance().format(product.getProductPrice()) %></td>
            <td class="td_numbig  text_right"><span class="total_price"><%=DecimalFormat.getInstance().format(product.getProductPrice() * itemCtQty) %></span></td>
            <td class="td_dvr">무료</td>
         </tr>
	<% } else { // 카트에서 접근했을 때%>
    	<% for (CartDTO cart:cartList) { %>
         <tr>
            <td class="td_prd">
                <div class="sod_img"><img src="<%=request.getContextPath()%>/img/product_images/<%=cart.getProductImage()%>" width="80" height="80" alt=""></div>
                <div class="sod_name">
                	<%-- 제품정보 전송 --%>
                    <input type="hidden" name="productNum" value="<%=cart.getProductNum()%>">
                    <input type="hidden" name="orderAmount" value="<%=cart.getProductQTY()%>">
                    <input type="hidden" name="productName" value="<%=cart.getProductName()%>">                    
                    <input type="hidden" name="productPrice" value="<%=cart.getProductPrice()%>">                    
                    <input type="hidden" name="orderTotal" value="<%=cart.getProductTotal()%>">
                    <input type="hidden" name="cartNum" value="<%=cart.getCartNum()%>">
                    
                    <b><%=cart.getProductName() %></b>
                    <div class="sod_opt"><ul>
					<li><%=cart.getProductName() %> <%=cart.getProductQTY() %>개 (+<%=DecimalFormat.getInstance().format(cart.getProductPrice()) %>원)</li>
					</ul></div>                    
                 </div>
            </td>
            <td class="td_num"><%=cart.getProductQTY() %></td>
            <td class="td_numbig  text_right"><%=DecimalFormat.getInstance().format(cart.getProductPrice()) %></td>
            <td class="td_numbig  text_right"><span class="total_price"><%=DecimalFormat.getInstance().format(cart.getProductTotal()) %></span></td>
            <td class="td_dvr">무료</td>
        </tr>
        <% totalprice += cart.getProductTotal(); %>
        <% } %>     
	<% } %>
		
        </tbody>
        </table>
    </div>

        <!-- } 주문상품 확인 끝 -->

    <div class="sod_left">

        <!-- 주문하시는 분 입력 시작 { -->
        <section id="sod_frm_orderer">
            <h2>주문하시는 분</h2>

            <div class="tbl_frm01 tbl_wrap">
                <table>
                <tbody>
                <tr>
                    <th scope="row"><label for="od_name">이름<strong class="sound_only"> 필수</strong></label></th>
                    <td><input type="text" name="od_name" value="<%=loginMember.getName() %>" id="od_name" required class="frm_input required" maxlength="20">
					</td>
                </tr>

                <tr>
                    <th scope="row"><label for="od_hp">핸드폰</label></th>
                    <td><input type="text" name="od_hp" value="<%=loginMember.getPhone() %>" id="od_hp" class="frm_input" maxlength="20"></td>
                </tr>
                <tr>
                    <th scope="row">주소</th>
                    <td>
                        <label for="od_zip" class="sound_only">우편번호<strong class="sound_only"> 필수</strong></label>
                        <input type="text" name="od_zip" value="<%=loginMember.getZipcode() %>" id="od_zip" required class="frm_input required" size="8" maxlength="6" placeholder="우편번호">
                        <input type="text" name="od_addr1" value="<%=loginMember.getAddress1() %>" id="od_addr1" required class="frm_input frm_address required" size="60" placeholder="기본주소">
                        <label for="od_addr1" class="sound_only">기본주소<strong class="sound_only"> 필수</strong></label><br>
                        <input type="text" name="od_addr2" value="<%=loginMember.getAddress2() %>" id="od_addr2" class="frm_input frm_address" size="60" placeholder="상세주소">
                        <label for="od_addr2" class="sound_only">상세주소</label>
                        
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="od_email">E-mail<strong class="sound_only"> 필수</strong></label></th>
                    <td><input type="text" name="od_email" value="<%=loginMember.getEmail() %>" id="od_email" required class="frm_input required" size="35" maxlength="100"></td>
                </tr>

                </tbody>
                </table>
            </div>
        </section>
        <!-- } 주문하시는 분 입력 끝 -->

        <!-- 받으시는 분 입력 시작 { -->
        <section id="sod_frm_taker">
            <h2>받으시는 분</h2>

            <div class="tbl_frm01 tbl_wrap">
                <table>
                <tbody>
            	<tr>
                    <th scope="row">배송지선택</th>
                    <td>
					<input type="checkbox" name="ad_sel_addr" id="ad_sel_addr_1"> 
					<label for="ad_sel_addr_1">주문자와 동일</label>
					</td>
                </tr>
                
                <tr>
                    <th scope="row"><label for="od_b_name">이름<strong class="sound_only"> 필수</strong></label></th>
                    <td><input type="text" name="od_b_name" id="od_b_name" required class="frm_input required" maxlength="20"></td>
                </tr>

                <tr>
                    <th scope="row"><label for="od_b_hp">핸드폰</label></th>
                    <td><input type="text" name="od_b_hp" id="od_b_hp" class="frm_input" maxlength="20"></td>
                </tr>
                <tr>
                    <th scope="row">주소</th>
                    <td id="sod_frm_addr">
                        <label for="od_b_zip" class="sound_only">우편번호<strong class="sound_only"> 필수</strong></label>
                        <input type="text" name="od_b_zip" id="od_b_zip" required class="frm_input required" size="8" maxlength="6" placeholder="우편번호">
                        <button type="button" class="btn_address" onclick="Postcode()">주소 검색</button><br>
                        <input type="text" name="od_b_addr1" id="od_b_addr1" required class="frm_input frm_address required" size="60" placeholder="기본주소">
                        <label for="od_b_addr1" class="sound_only">기본주소<strong> 필수</strong></label><br>
                        <input type="text" name="od_b_addr2" id="od_b_addr2" class="frm_input frm_address" size="60" placeholder="상세주소">
                        <label for="od_b_addr2" class="sound_only">상세주소</label>
                        <br>

                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="od_memo">전하실말씀</label></th>
                    <td><textarea name="od_memo" id="od_memo"></textarea></td>
                </tr>
                </tbody>
                </table>
            </div>
        </section>
        <!-- } 받으시는 분 입력 끝 -->
    </div>

    <div class="sod_right">
        <!-- 주문상품 합계 시작 { -->
        <div id="sod_bsk_tot">
            <ul>
                <li class="sod_bsk_sell">
                    <span>주문</span>
                    <strong>
                    <% if (request.getParameter("cartConfirm") == null) { %>
	            		<%=DecimalFormat.getInstance().format(product.getProductPrice() * itemCtQty) %>
	            	<% } else { %>
	            		<%=DecimalFormat.getInstance().format(totalprice)%>
	            	<% } %>
                    </strong>원
                </li>
                <li class="sod_bsk_dvr">
                    <span>배송비</span>
                    <strong>무료</strong>
                </li>
               <li class="sod_bsk_cnt">
                    <span>총계</span>
                    <strong id="ct_tot_price">
                    <% if (request.getParameter("cartConfirm") == null) { %>
                    	<%=DecimalFormat.getInstance().format(product.getProductPrice() * itemCtQty) %>
                    <% } else { %>
                    	<%=DecimalFormat.getInstance().format(totalprice)%>
                    <% } %>
                    </strong>원
                </li>

            </ul>
        </div>
        <!-- } 주문상품 합계 끝 -->


        <!-- 결제정보 입력 시작 { -->
        
        <section id="sod_frm_pay">
            <h2>결제정보</h2>

            <div class="pay_tbl">
                <table>
                <tbody>
                                
                <tr>
                    <th>추가배송비</th>
                    <td><strong id="od_send_cost2">0</strong>원<br>(지역에 따라 추가되는 도선료 등의 배송비입니다.)</td>
                </tr>
                </tbody>
                </table>
            </div>
            <div id="od_tot_price">
                <span>총 주문금액</span>
                <strong class="print_price">
	            <% if (request.getParameter("cartConfirm") == null) { %>
	            	<%=DecimalFormat.getInstance().format(product.getProductPrice() * itemCtQty) %>
	            <% } else { %>
	            	<%=DecimalFormat.getInstance().format(totalprice)%>
	            <% } %>
                </strong>원
            </div>

            <div id="od_pay_sl">
                <h3>결제수단</h3>
                <fieldset id="sod_frm_paysel"><legend>결제방법 선택</legend>
                <input type="radio" id="od_settle_bank" name="od_settle_case" value="1" checked="checked"> <label for="od_settle_bank" class="lb_icon bank_icon">무통장입금</label>
				<input type="radio" id="od_settle_card" name="od_settle_case" value="2" > <label for="od_settle_card" class="lb_icon card_icon">신용카드</label>
				<div id="settle_bank" style="">
				<label for="od_bank_account" class="sound_only">입금할 계좌</label><input type="hidden" name="od_bank_account" value="농협은행 753027-51-013550 이미희">농협은행 753027-51-013550 이미희
				</div></fieldset>      
			</div>
        </section>
        <!-- } 결제 정보 입력 끝 -->

        
<div id="display_pay_button" class="btn_confirm">
    <input id="submitBtn" type="submit" value="주문하기" class="btn_submit" onclick=""/>
    <a href="javascript:history.go(-1);" class="btn01">취소</a>
</div>
<div id="display_pay_process" style="display:none">
    <img src="https://www.empery.kr/shop/img/loading.gif" alt="">
    <span>주문완료 중입니다. 잠시만 기다려 주십시오.</span>
</div>

</div>

</div>
</form>


<script>
// 구매자 정보와 동일합니다.
$("#ad_sel_addr_1").change(function() {
	$("#od_b_name").val($("#od_name").val());
	$("#od_b_hp").val($("#od_hp").val());
	$("#od_b_zip").val($("#od_zip").val());
	$("#od_b_addr1").val($("#od_addr1").val());
	$("#od_b_addr2").val($("#od_addr2").val());
});

</script>

	<script>
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function Postcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('od_b_zip').value = data.zonecode;
							document.getElementById("od_b_addr1").value = data.jibunAddress;

							var guideTextBox = document.getElementById("guide");
							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							if (data.autoRoadAddress) {
								var expRoadAddr = data.autoRoadAddress
										+ extraRoadAddr;
								guideTextBox.innerHTML = '(예상 도로명 주소 : '
										+ expRoadAddr + ')';
								guideTextBox.style.display = 'block';

							} else if (data.autoJibunAddress) {
								var expJibunAddr = data.autoJibunAddress;
								guideTextBox.innerHTML = '(예상 지번 주소 : '
										+ expJibunAddr + ')';
								guideTextBox.style.display = 'block';
							} else {
								guideTextBox.innerHTML = '';
								guideTextBox.style.display = 'none';
							}
						}
					}).open();
		}
	</script>
    </div>
    <!-- } 콘텐츠 끝 -->
