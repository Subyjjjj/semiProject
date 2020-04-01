<%@page import="java.util.ArrayList"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@page import="semiProject.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<%
	// 입력값을 반환받아 저장
	String id = request.getParameter("id");
	List<OrderDTO> orderList=OrderDAO.getDAO().selectOrderProduct(id);
	
%>
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<style>
#footer {
   position: fixed;
   left: 0px;
   bottom: 0px;
   z-index: 300;
   width: 100%;
   margin: 0;
   padding: 15px 0;
   text-align: center;
   border-top: 1px solid #dedede;
   background-color: #fafafa;
}

.board_t1 .admin_t tr>th{
	width: 70px;
	height: 20px;
}

.board_t1{
	height: auto;
}


</style>
</head>
<body>
	<p class="for_title" style="text-align: center;">개인 주문 목록</p> 
	<div class="board_t1" style="width:90%;" >
		<table class="admin_t">
			<thead>
				<tr>
					<th>주문자(ID)</th>
					<th>주문번호</th>
					<th>주문상품</th>
					<th>상품이미지</th>
					<th>총 주문금액</th>
					<th>결제수단</th>
					<th>주문상태</th>
					<th>주문일시</th>
				</tr>
			</thead>
			<%-- 검색내용출력 --%>
			<tbody>
				<%if(orderList.isEmpty()){ %>
					<tr style="text-align: center;">
						<td colspan="13">검색된 주문이 존재하지 않습니다.</td>
					</tr>
				<%} else { %>
					<%for (OrderDTO order:orderList){ %>
						<tr>
							<td><%=order.getName()%>(<%=order.getId()%>)</td>
							<td><a href="<%=request.getContextPath() %>/admin_template/index.jsp?part=order&work=detail&orderNum=<%=order.getOrderNum() %>&orderNo=<%=order.getOrderNo() %>" style="text-decoration: underline; color: #F15F5F;"><%=order.getOrderNum()%></a></td>
							<td><%=order.getProductName()%></td>
							<td><img src="<%=request.getContextPath() %>/img/product_images/<%=ProductDAO.getDAO().selectNumProduct(order.getProductNum()).getProductImage1() %>" width="100" height="100"></td>
							<td><%=DecimalFormat.getCurrencyInstance().format(order.getOrderTotal())%></td>
							<td><%if(order.getPaymentMethod()==1){ %>무통장입금<%} else { %>신용카드<%} %></td>
							<td><%if (order.getOrderStatus()==1) {%>결제대기<%} else if(order.getOrderStatus()==2) {%>결제완료<% }else if (order.getOrderStatus()==3) {%>배송준비중<%} else if (order.getOrderStatus()==4) {%>배송중<%} else if (order.getOrderStatus()==5) {%>배송완료<%} else if (order.getOrderStatus()==6) {%>구매확정<%} else if (order.getOrderStatus()==1 || order.getOrderStatus()==2 || order.getOrderStatus()>=10) {%>-<%} %></td>
							<td><%=order.getOrderDate().substring(0, 19) %></td>
						</tr>
					<%} %>
				<%} %>
			</tbody>
			
		</table>
	</div>


	<div id="footer">
       <a href="#none" class="btnEm" onclick="window.close();"><span>닫기</span></a>
    </div>

</body>
</html>