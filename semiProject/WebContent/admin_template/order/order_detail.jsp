<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@page import="semiProject.dto.OrderDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<%
	String orderNum=request.getParameter("orderNum");
	int orderNo=Integer.parseInt(request.getParameter("orderNo"));
	List<OrderDTO> orderList=OrderDAO.getDAO().selectNumOrder(orderNum);
	OrderDTO standardOrder=OrderDAO.getDAO().selectOneOrder(orderNo);
	MemberDTO member=MemberDAO.getMemberDAO().selectIdMember(OrderDAO.getDAO().selectOneOrder(orderNo).getId());
	System.out.println(orderNum);
%>

<p class="for_title" style="margin-top: 100px;">주문 상세보기<span style="color: #050099; font-size: 14px;">&nbsp;&nbsp;&nbsp;&nbsp;주문번호 </span><span style="color: #F15F5F; font-size: 14px;"><%=orderNum %></span></p>
<div class="board_t2" style="margin-bottom: 5px;">
	<div class="gLeft">
		<p class="total">
			<strong>결제정보</strong>
		</p>
	</div>
	<table class="admin_t">
		<tr>
			<th>결제금액</th>
			<td style="color: #050099;">
			<%int payment=0; %>
			<%for (OrderDTO order:orderList){ %>
				<% payment+=order.getOrderTotal(); %>
			<%} %>
			<%=DecimalFormat.getCurrencyInstance().format(payment) %>
			</td>
			<th>결제수단</th>
			<td><%if(standardOrder.getPaymentMethod()==1){ %>무통장입금<%} else { %>신용카드<%} %></td>
			<th>결제일</th>
			<td><%=standardOrder.getOrderDate().substring(0, 19)%></td>
		</tr>
	</table>
	<form id="orderForm">
	<div class="gLeft">
		<p class="total">
			<strong>주문내역 및 주문상태</strong>
		</p>
	</div>
	<div class="mCtrl">
		<i class="fas fa-check"></i>선택한 주문의 상태를&nbsp;
    	<select class="fSelect" name="orderStatus">
    		<option value="99">주문상태</option>
			<option value="empty1" disabled="disabled">---------------</option>
    		<option value="1" >결제대기</option>
          	<option value="2" >결제완료</option>
          	<option value="3" >배송준비중</option>
          	<option value="4" >배송중</option>
          	<option value="5" >배송완료</option>
          	<option value="6" >구매확정</option>
			<option value="empty1" disabled="disabled">---------------</option>
          	<option value="11" >취소요청</option>
          	<option value="11" >취소완료</option>
          	<option value="21" >교환요청</option>
          	<option value="21" >교환완료</option>
          	<option value="31" >반품요청</option>
          	<option value="31" >반품완료</option>
        </select>&nbsp;
        <select class="fSelect" name=deliveryName>
    		<option value="NONE">배송사</option>
			<option value="empty1" disabled="disabled">---------------</option>
    		<option value="EMS" >우체국택배</option>
          	<option value="CJ" >CJ</option>
          	<option value="LOTTE" >롯데</option>
          	<option value="DEAHAN" >대한통운</option>
          	<option value="ECT" >기타</option>
        </select>&nbsp;
        <input type="text" name="deliveryNum">&nbsp;<button id="changeBtn" style="border: 1px solid gray; color: white; background: #F15F5F; border:none; padding: 5px;">&nbsp;일괄처리</button>
    	<div id="message1" style="color: red;"></div>
    </div>
	<table class="admin_t">
		<thead>
		<tr>
			<th><input type="checkbox" id="checkAll"></th><th width="40">번호</th><th>상품번호</th><th>이미지</th><th>상품명</th><th>수량</th><th>금액</th><th>송장번호</th><th>처리상태</th>
		</tr>
		</thead>
		<tbody>
		<% int orderTotalPrice=0, number=0; %>
		<%for(OrderDTO order:orderList) { %>
			<%if(order.getCSStatus()==0) { %>
			<% orderTotalPrice+=order.getOrderTotal(); %>
			<% number++; %>
			<tr>
				<td><input type="checkbox" class="check" name="checkOrder" value="<%=order.getOrderNo()%>"></td>
				<td><%=number %><input type="hidden" name="orderNum" value="<%=order.getOrderNum()%>"></td>
				<td><%=order.getProductNum() %></td>
				
				<td><img src="<%=request.getContextPath() %>/img/product_images/<%=ProductDAO.getDAO().selectNumProduct(order.getProductNum()).getProductImage1() %>" width="80" height="80"></td>
				<td><%=order.getProductName() %></td>
				<td><%=order.getOrderAmount() %>개</td>
				<td><%=DecimalFormat.getCurrencyInstance().format(order.getProductPrice()) %> 원</td>
				<td><strong><%if (order.getDelivery()!=null) {%><%=order.getDelivery().replace("_", " ") %><%} else { %>*<%} %></strong></td>
				<td>
					<select id="statusBtn_<%=order.getProductNum() %>" class="fSelect" name="<%=order.getOrderNo()%>">
			    		<option value="1" <%if (order.getOrderStatus()==1) { %> selected <%} %>>결제대기</option>
			          	<option value="2" <%if (order.getOrderStatus()==2) { %> selected <%} %>>결제완료</option>
			          	<option value="3" <%if (order.getOrderStatus()==3) { %> selected <%} %>>배송준비중</option>
			          	<option value="4" <%if (order.getOrderStatus()==4) { %> selected <%} %>>배송중</option>
			          	<option value="5" <%if (order.getOrderStatus()==5) { %> selected <%} %>>배송완료</option>
			          	<option value="6" <%if (order.getOrderStatus()==6) { %> selected <%} %>>구매확정</option>
			          	<option value="10" <%if (order.getOrderStatus()==10) { %> selected <%} %>>취소요청</option>
			          	<option value="11" <%if (order.getOrderStatus()==11) { %> selected <%} %>>취소완료</option>
			          	<option value="20" <%if (order.getOrderStatus()==20) { %> selected <%} %>>교환요청</option>
			          	<option value="21" <%if (order.getOrderStatus()==21) { %> selected <%} %>>교환완료</option>
			          	<option value="30" <%if (order.getOrderStatus()==30) { %> selected <%} %>>반품요청</option>
			          	<option value="31" <%if (order.getOrderStatus()==31) { %> selected <%} %>>반품완료</option>
			        </select>&nbsp;
			        <script type="text/javascript">
			        $("#statusBtn_<%=order.getProductNum()%>").change(function() {
			        	var checkOrder=$(this).attr("name");
			        	var orderStatus=$(this).val();
			        	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=detail_modify_action&checkOrder="+checkOrder+"&orderNum=<%=orderNum%>&orderStatus="+orderStatus;
			        });
			        </script>
				</td>
			</tr>
			<%} %>
		<%} %>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="9" style="text-align: right; line-height: 20px;"><p style="font-weight: bold; margin-right: 30px;">주문금액 = <span style="font-size: 20px; color: #050099;"><%=DecimalFormat.getInstance().format(orderTotalPrice)%></span> 원</p></td>
			</tr>
		</tfoot>
	</table>
	</form>
	
	<form id="CSForm">
	<div class="gLeft">
		<p class="total">
			<strong>취소/교환/환불 처리</strong>
		</p>
	</div>
	<div class="mCtrl">
		<i class="fas fa-check"></i>선택한 주문의 상태를&nbsp;
    	<select class="fSelect" name="orderStatus">
    		<option value="0">처리상태</option>
			<option value="empty1" disabled="disabled">---------------</option>
          	<option value="10" >취소요청</option>
          	<option value="11" >취소완료</option>
			<option value="empty1" disabled="disabled">---------------</option>
          	<option value="20" >교환요청</option>
          	<option value="21" >교환완료</option>
			<option value="empty1" disabled="disabled">---------------</option>
          	<option value="30" >반품요청</option>
          	<option value="31" >반품완료</option>
        </select>&nbsp;
        <button id="CSchangeBtn" style="border: 1px solid gray; color: white; background: #F15F5F; border:none; padding: 5px;">&nbsp;일괄처리</button>
        <div id="message2" style="color: red;"></div>
    </div>
	<table class="admin_t">
		<thead>
		<tr>
			<th><input type="checkbox" id="checkAllCS"><th>주문번호</th><th>처리상태</th><th>이미지</th><th>상품명</th><th>수량</th><th>사유</th>
		</tr>
		</thead>
		<tbody>
		<% int cancelTotalPrice=0; %>
		<% for(OrderDTO order:orderList) { %>
			<%if(order.getCSStatus()==1) { %>
			<% cancelTotalPrice+=order.getOrderTotal(); %>
			<tr>
				<td><input type="checkbox" class="checkCS" name="checkOrder" value="<%=order.getOrderNo()%>"></td>
				<td><%=order.getOrderNum() %><input type="hidden" name="orderNum" value="<%=order.getOrderNum()%>"><input type="hidden" name="deliveryName" value="NONE"></td>
				<td>
				<strong><% if (order.getOrderStatus()==10){ %>취소요청
						<%} else if (order.getOrderStatus()==11){ %>취소완료
						<%} else if (order.getOrderStatus()==20){ %>교환요청
						<%} else if (order.getOrderStatus()==21){ %>교환완료
						<%} else if (order.getOrderStatus()==30){ %>반품요청
						<%} else if (order.getOrderStatus()==31){ %>반품완료
						<%} %></strong>
				</td>
				<td><img src="<%=request.getContextPath() %>/img/product_images/<%=ProductDAO.getDAO().selectNumProduct(order.getProductNum()).getProductImage1() %>" width="80" height="80"></td>
				<td><%=order.getProductName() %></td>
				<td><%=order.getOrderAmount() %>개</td>
				<td><%=order.getCustomMsg() %></td>
			</tr>
			<%} %>
		<%} %>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="7" style="text-align: right; line-height: 20px;"><p style="font-weight: bold; margin-right: 30px;">결제취소금액 = <span style="font-size: 20px; color: #050099;">- <%=DecimalFormat.getCurrencyInstance().format(cancelTotalPrice)%></span> 원</p></td>
			</tr>
		</tfoot>
	</table>
	<div style="font-weight: bold; text-align: center;">
	<p>총 정산예정 금액 = <span style="font-size: 30px; color: red;"><%=DecimalFormat.getInstance().format(orderTotalPrice)%></span> 원</p>
	</div>
	</form>
</div>

	
<form action="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=delivery_modify&orderNo=<%=standardOrder.getOrderNo()%>" method="post">
<div class="board_t2" style="width: 100%; margin: 0 auto; background: none; border: none;">
<div class="board_t2" style="width: 45%; display: inline-block; margin-right: 20px;" >
	<div class="gLeft">
		<p class="total">
			<strong>주문자정보</strong>
		</p>
	</div>
	<table class="admin_t">
		<tr>
			<th style="line-height: 40px;">주문자명(ID)</th>
			<td style="color: #F15F5F;"><%= member.getId() %>(<%= member.getName() %>)</td>
		</tr>
		<tr>
			<th>주문자 전화번호</th>
			<td><%= member.getPhone() %></td>
		</tr>
		<tr>
			<th style="line-height: 40px;">주문자 주소</th>
			<td>[<%=member.getZipcode() %>]&nbsp;<%=member.getAddress1() %><%=member.getAddress2() %></td>
		</tr>
	</table>
	<div style="text-align:right; margin-top: 10px;">
		<%--<button class="btnDate" id="memberBtn" type="button" style="width: 180px; height: 50px;">회원누적주문보기</button>&nbsp; --%>
		<a href="<%=request.getContextPath()%>/admin_template/member/member_orderProduct.jsp?id=<%=member.getId()%>" onclick="window.open(this.href,'orderProduct','width=1100,height=770'); return false;"
			style="width: 180px; border: 0.7px solid #98989b; padding: 15px 10px;">회원누적주문보기</a>
		
	</div>
</div>


<div class="board_t2" style="width: 45%; display: inline-block;" >
	<div class="gLeft">
		<p class="total">
			<strong>수취인정보</strong>
		</p>
	</div>
	<table class="admin_t">
		<tr>
			<th>수취인명</th>
			<td><%= standardOrder.getName() %></td>
		</tr>
		<tr>
			<th>배송지</th>
			<td>[<%= standardOrder.getAddress().substring(0, 5) %>]&nbsp;<%= standardOrder.getAddress().substring(5) %></td>
		</tr>
		<tr>
			<th>수취인 전화번호</th>
			<td><%= standardOrder.getPhone() %></td>
		</tr>
		<tr>
			<th>배송메모</th>
			<td><%if(standardOrder.getCustomMsg()!=null) { %><%=standardOrder.getCustomMsg() %><%} else { %>*<%} %></td>
		</tr>
	</table>
	<div style="text-align:right; margin-top: 10px;">
		<button class="btnDate" type="submit" style="width: 120px; height: 50px;">배송정보수정</button>&nbsp;
	</div>
</div>
</div>
</form>

<div class="board_t2">
	<div class="gLeft">
		<p class="total">
			<strong>관리자 메모</strong>
		</p>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=memo_modify_action" >
	<div class="mCtrl">
	<input type="hidden" name="orderNum" value="<%=standardOrder.getOrderNum()%>">
	<input type="hidden" name="orderNo" value="<%=standardOrder.getOrderNo()%>">
	<input hidden="orderStatus" value="0">
	<textarea id="adminMemo" name="adminMemo" rows="10" style="width: 100%;"><%if(standardOrder.getAdminMsg()!=null){ %><%=standardOrder.getAdminMsg() %><%} else { %>&nbsp;<%} %></textarea>
		<div style="text-align:center; margin-top: 10px;">
			<button class="btnDate" id="resetMemo" type="button" style= "width: 120px; height: 50px;">메모초기화</button>&nbsp;
			<button class="btnDate" type="submit" style="width: 120px; height: 50px;">메모저장</button>&nbsp;
		</div>
	</div>
	</form>
</div>
		
<div style="text-align:center;">
	<button class="btnDate selected" id="listBtn" type="button" style="width: 160px; height: 50px;"><span style="font-size: 15px;">주문목록</span></button>&nbsp;
</div>

<script type="text/javascript">
$("#checkAll").change(function(){
	if($(this).is(":checked")){
		$(".check").prop("checked", true);
	} else {
		$(".check").prop("checked", false);
	}
});
$("#checkAllCS").change(function(){
	if($(this).is(":checked")){
		$(".checkCS").prop("checked", true);
	} else {
		$(".checkCS").prop("checked", false);
	}
});
$("#changeBtn").click(function() {
	if($(".check").filter(":checked").size()==0){
		$("#message1").text("선택된 주문이 없습니다.");
		return false;
	} else {
		$("#orderForm").attr("method", "post");
		$("#orderForm").attr("action", "<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=detail_modify_action");
		$("#orderForm").submit();
	}
});
$("#CSchangeBtn").click(function() {
	if($(".checkCS").filter(":checked").size()==0){
		$("#message2").text("선택된 주문이 없습니다.");
		return false;
	} else {
		$("#CSForm").attr("method", "post");
		$("#CSForm").attr("action", "<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=detail_modify_action");
		$("#CSForm").submit();
	}
});

$("#deliveryBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=detail_modify_action&orderStatus=";
});


$("#deliveryModifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=delivery_modify&orderNum=<%=standardOrder.getOrderNum()%>";
});

$("#resetMemo").click(function() {
	$('#adminMemo').val('');
});



$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list";
});
</script>