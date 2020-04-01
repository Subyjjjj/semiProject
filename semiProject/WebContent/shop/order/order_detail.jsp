<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@page import="semiProject.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/login_status.jspf" %>
<%-- 마이페이지에서 주문서 번호를 클릭시 이동되는 페이지. order_no을 전달받아 페이지 정보를 출력하고 하단의 버튼을 이용해 주문의 상태를 바꾸는 기능 --%>
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getParameter("orderNo")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}	

	//마이페이지에서 온 orderNum 값을 받아서 저장
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String customMsg = request.getParameter("customMsg");
	if(customMsg == null) customMsg = "";
	
	OrderDTO order = OrderDAO.getDAO().selectOneOrder(orderNo);
	//이미지명
	String productImage = ProductDAO.getDAO().selectNumProduct(order.getProductNum()).getProductImage1(); 
	
	String delivery = "";
	//주문 취소를 받기 위한 변수
	if (request.getParameter("cancleBtn") != null) {
		int cancel = Integer.parseInt(request.getParameter("cancleBtn"));
		OrderDAO.getDAO().updateDetailAtOnce(orderNo, cancel, delivery, customMsg);
	} else if (request.getParameter("cancleBtn2") != null) {
		int cancel = Integer.parseInt(request.getParameter("cancleBtn2"));
		OrderDAO.getDAO().updateDetailAtOnce(orderNo, cancel, delivery, customMsg);
	} else if (request.getParameter("cancleBtn3") != null) {
		int cancel = Integer.parseInt(request.getParameter("cancleBtn3"));
		OrderDAO.getDAO().updateDetailAtOnce(orderNo, cancel, delivery, customMsg);
	}
%>
<!-- 콘텐츠 시작 { -->
<div id="container">
      <!-- <div id="wrapper_title">주문상세내역</div> -->
	<div id="wrapper_title">주문상세내역</div>       

<!-- 주문상세내역 시작 { -->
<div id="sod_fin">

    <div id="sod_fin_no">주문번호 <strong><%=order.getOrderNum() %></strong></div>

    <section id="sod_fin_list">
        <h2>주문하신 상품</h2>

        <div class="tbl_head03 tbl_wrap">
            <table>
            <thead>
            <tr>
                <th scope="col" rowspan="2">이미지</th>
                <th scope="col" colspan="7" id="th_itname">상품명</th>
            </tr>
            <tr class="th_line">
                <th scope="col" id="th_itopt">옵션명</th>
                <th scope="col" id="th_itqty">수량</th>
                <th scope="col" id="th_itprice">판매가</th>
                <th scope="col" id="th_itsum">소계</th>
                <th scope="col" id="th_itsd">배송비</th>
                <th scope="col" id="th_itst">상태</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td rowspan="2" class="td_imgsmall"><img src="<%=request.getContextPath()%>/img/product_images/<%=productImage%>" width="70" height="70" alt=""></td>
                <td headers="th_itname" colspan="7" class="td_bdno"><a href="<%=request.getContextPath()%>/index.jsp?part=shop/product&content=item&productNum=<%=order.getProductNum()%>">
                <%=order.getProductName()%></a></td>
            </tr>
            <tr>
                <td headers="th_itopt" class="td_bdno"><%=order.getProductName()%></td>
                <td headers="th_itqty" class="td_mngsmall"><%=order.getOrderAmount() %></td>
                <td headers="th_itprice" class="td_numbig text_right"><%=DecimalFormat.getInstance().format(order.getProductPrice()) %></td>
                <td headers="th_itsum" class="td_numbig text_right"><%=DecimalFormat.getInstance().format(order.getOrderTotal()) %></td>
                <td headers="th_itsd" class="td_dvr">무료</td>
                <td headers="th_itst" class="td_mngsmall">
        		<% if (order.getOrderStatus() == 1) { %>
					<span class="status_01">입금대기</span>
				<% } else if (order.getOrderStatus() == 2) { %>
					<span class="status_02">입금완료</span>
				<% } else if (order.getOrderStatus() == 3) { %>
					<span class="status_03">배송준비</span>
				<% } else if (order.getOrderStatus() == 4) { %>
					<span class="status_04">배송중</span>
				<% } else if (order.getOrderStatus() == 5) { %>
					<span class="status_05">배송완료</span>
				<% } else if (order.getOrderStatus() == 6) { %>
					<span class="status_06">구매확정</span>
				<% } else if (order.getOrderStatus() == 10) { %>
					<span class="status_06">취소요청</span>
				<% } else if (order.getOrderStatus() == 11) { %>
					<span class="status_06">취소완료</span>
				<% } else if (order.getOrderStatus() == 20) { %>
					<span class="status_04">교환요청</span>
				<% } else if (order.getOrderStatus() == 21) { %>
					<span class="status_04">교환완료</span>
				<% } else if (order.getOrderStatus() == 30) { %>
					<span class="status_02">환불요청</span>
				<% } else if (order.getOrderStatus() == 31) { %>
					<span class="status_02">환불완료</span>
				<% } %>
                </td>
            </tr>
            </tbody>
            </table>
        </div>
    
    </section>
    <div class="sod_left">
        <h2>결제/배송 정보</h2>
        
        <section id="sod_fin_pay">
            <h3>결제정보</h3>

            <div class="tbl_head01 tbl_wrap">
                <table>
                <tbody>
                <tr>
                    <th scope="row">주문번호</th>
                    <td><%=order.getOrderNum() %></td>
                </tr>
                <tr>
                    <th scope="row">주문일시</th>
                    <td><%=order.getOrderDate().substring(0, 19) %></td>
                </tr>
                <tr>
                    <th scope="row">결제방식</th>
                    <td>
                    <% if (order.getPaymentMethod() == 1) { %>
                    	무통장
                    <% } else { %>
                    	신용카드
                    <% } %>
                    </td>
                </tr>
                <tr>
                    <th scope="row">결제금액</th>
                    <td>아직 입금되지 않았거나 입금정보를 입력하지 못하였습니다.</td>
                </tr>
                <tr>
                    <th scope="row">입금자명</th>
                    <td><%=loginMember.getId() %></td>
                </tr>
                <% if (order.getPaymentMethod() == 1) { %>
                <tr>
                    <th scope="row">입금계좌</th>
                    <td>농협은행 753027-51-013550 이미희</td>
                </tr>
                <% } %>
                </tbody>
                </table>
            </div>
        </section>

        <section id="sod_fin_receiver">
            <h3>받으시는 분</h3>

            <div class="tbl_head01 tbl_wrap">
                <table>
          
                <tbody>
                <tr>
                    <th scope="row">이 름</th>
                    <td><%=order.getName() %></td>
                </tr>
                <tr>
                    <th scope="row">핸드폰</th>
                    <td><%=order.getPhone() %></td>
                </tr>
                <tr>
                    <th scope="row">주 소</th>
                    <td><%=order.getAddress() %></td>
                </tr>
                </tbody>
                </table>
            </div>
        </section>

        <section id="sod_fin_dvr">
            <h3>배송정보</h3>

            <div class="tbl_head01 tbl_wrap">
                <table>
   
                <tbody>
                <tr>
                <% if (order.getDelivery() != null) { %>
                	<td class="empty_table"><%=order.getDelivery() %></td>
                <% } else { %>
                    <td class="empty_table">아직 배송하지 않았거나 배송정보를 입력하지 못하였습니다.</td>
                <% } %>
                </tr>
                </tbody>
                </table>
            </div>
        </section>
    </div>

    <div class="sod_right">
        <ul id="sod_bsk_tot">
            <li class="sod_bsk_dvr">
                <span>주문총액</span>
                <strong><%=DecimalFormat.getInstance().format(order.getOrderTotal()) %> 원</strong>
            </li>
            <li class="sod_bsk_dvr">
                <span>취소금액</span>
                <strong>
                <% if (order.getOrderStatus() == 11 || order.getOrderStatus() == 21 || order.getOrderStatus() == 31) { %>
                	<%=DecimalFormat.getInstance().format(order.getOrderTotal()) %> 원
                <% } else { %>
                	0 원
                <% } %>
                </strong>
                
            </li>
            <li class="sod_bsk_cnt">
                <span>총계</span>
                <strong><%=DecimalFormat.getInstance().format(order.getOrderTotal()) %> 원</strong>
            </li>
        </ul>
        
        <section id="sod_fin_tot">
            <h2>결제합계</h2>

            <ul>
                <li>
                    총 구매액
                <% if (order.getOrderStatus() >= 1 && order.getOrderStatus() < 7) { %>
					<strong><%=DecimalFormat.getInstance().format(order.getOrderTotal()) %></strong>
                <% } else { %>
                    <strong>0원</strong>
                <% } %>
                </li>
                <li id="alrdy">
                    결제액
                <% if (order.getOrderStatus() >= 1 && order.getOrderStatus() < 7) { %>
					<strong><%=DecimalFormat.getInstance().format(order.getOrderTotal()) %></strong>
                <% } else { %>
                    <strong>0원</strong>
                <% } %>
                </li>
            </ul>
        </section>

    	<% if (order.getOrderStatus() <= 3) { %>
        <section id="sod_fin_cancel">
        <form action="#" method="post">
            <h2>주문취소</h2>
            <button type="submit" value="10" onclick="input()" id="cancleBtn" name="cancleBtn" style="background: #d50c0c; color: #fff; border: 0;">주문취소</button>		
			<input type="hidden" id="customMsg" name="customMsg"  value="">
		</form>
        </section>
        <% } else if (order.getOrderStatus() >= 4 && order.getOrderStatus() <= 6 && order.getOrderStatus() > 7) { %>
        <section id="sod_fin_cancel">
        <form action="#" method="post">
            <h2>교환 및 반품</h2>
            <button type="submit" value="20" onclick="input()" id="cancleBtn2" name="cancleBtn2" style="background: #d50c0c; color: #fff; border: 0;">교환요청</button>		
            <button type="submit" value="30" onclick="input()" id="cancleBtn3" name="cancleBtn3" style="background: #d50c0c; color: #fff; border: 0;">반품요청</button>		
			<input type="hidden" id="customMsg" name="customMsg"  value="">
		</form>
        </section>
        <% } %>
    </div>


   

    
</div>
<!-- } 주문상세내역 끝 -->

<script>
function input(){
	var input = prompt("취소 사유를 입력해주세요.");
	var message = $("#customMsg").val(input);
	}



$(function() {
    $("#sod_sts_explan_open").on("click", function() {
        var $explan = $("#sod_sts_explan");
        if($explan.is(":animated"))
            return false;

        if($explan.is(":visible")) {
            $explan.slideUp(200);
            $("#sod_sts_explan_open").text("상태설명보기");
        } else {
            $explan.slideDown(200);
            $("#sod_sts_explan_open").text("상태설명닫기");
        }
    });

    $("#sod_sts_explan_close").on("click", function() {
        var $explan = $("#sod_sts_explan");
        if($explan.is(":animated"))
            return false;

        $explan.slideUp(200);
        $("#sod_sts_explan_open").text("상태설명보기");
    });
});

function fcancel_check(f)
{
    if(!confirm("주문을 정말 취소하시겠습니까?"))
        return false;

    var memo = f.cancel_memo.value;
    if(memo == "") {
        alert("취소사유를 입력해 주십시오.");
        return false;
    }

    return true;
}
</script>


    </div>
    <!-- } 콘텐츠 끝 -->