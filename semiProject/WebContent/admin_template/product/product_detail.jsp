<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<%
	int productNum=Integer.parseInt(request.getParameter("productNum"));
	ProductDTO product=ProductDAO.getDAO().selectNumProduct(productNum);
%>

<p class="for_title" style="margin-top: 100px;">선택상품 상세보기</p> 
<div id="searchBox">
	<div class="board_t1" >
			<table class="admin_t">
			<tr>
				<th>상품코드</th>
				<td colspan="3"><%=product.getProductCode() %></td>
				<td rowspan="6" width="580">
					<img src="<%=request.getContextPath() %>/img/product_images/<%=product.getProductImage1() %>" width="350">
					<%if(!product.getProductImage2().equals("NOPICS")) { %>
						<img src="<%=request.getContextPath() %>/img/product_images/<%=product.getProductImage2() %>" width="100" height="100">
					<%} %>
					<%if(!product.getProductImage3().equals("NOPICS")) { %>
						<img src="<%=request.getContextPath() %>/img/product_images/<%=product.getProductImage3() %>" width="100" height="100">
					<%} %>
				</td>
			</tr>
			<tr>
				<th>상품명</th>
				<td colspan="3" style="font-size: 18px; font-weight: bold;"><%=product.getProductName() %></td>
			</tr>
			<tr>
				<th>상품 상세정보</th>
				   <%if (product.getProductCode().split("_")[0].equals("FRA")) { %>
	                   <td colspan="3" >프랑스
                   <%} else if(product.getProductCode().split("_")[0].equals("SPA")) { %>
	                   <td colspan="3" >스페인
                   <%} else if(product.getProductCode().split("_")[0].equals("CHI")) { %>
	                   <td colspan="3" >칠레
                   <%} else if(product.getProductCode().split("_")[0].equals("ITA")) { %>
	                   <td colspan="3" >이탈리아
                   <%} else if(product.getProductCode().split("_")[0].equals("ARG")) { %>
	                   <td colspan="3" >아르헨티나
                   <%} else if(product.getProductCode().split("_")[0].equals("AUS")) { %>
	                   <td colspan="3" >호주
                   <%} else if(product.getProductCode().split("_")[0].equals("USA")) { %>
	                   <td colspan="3" >미국
                   <%} else if(product.getProductCode().split("_")[0].equals("GER")) { %>
	                   <td colspan="3" >독일
                   <%} else if(product.getProductCode().split("_")[0].equals("ECT")) { %>
	                   <td colspan="3" >기타국가
                   <%} else { %>
	                   <td colspan="3" >-
                   <%} %>
                   <%if (product.getProductCode().split("_")[1].equals("RED")) { %>
		                   ,&nbsp;레드와인
	               <%} else if(product.getProductCode().split("_")[1].equals("WHI")) { %>
		                   ,&nbsp;화이트와인
	               <%} else if(product.getProductCode().split("_")[1].equals("ROS")) { %>
		                   ,&nbsp;로제
	               <%} else if(product.getProductCode().split("_")[1].equals("SHA")) { %>
		                   ,&nbsp;샴페인
	               <%} else {%>
		                  ,&nbsp;-
	               <%} %>	
	               ,&nbsp;<%=product.getProductCode().split("_")[2]%></td>
			</tr>
			<tr>
				<th>제조사(브랜드)</th>
				<td colspan="3"><%=product.getProductCode().split("_")[3]%></td>
			</tr>
			<tr>
				<th>상품 등록일</th>
				<td colspan="3"><%=product.getAddDate().substring(0,19) %></td>
			</tr>
			<tr>
				<th>상품가격</th>
				<td class="value"><%= DecimalFormat.getCurrencyInstance().format(product.getProductPrice()) %></td>
				<th>재고</th>
				<td class="value" style="color: red;"><%= DecimalFormat.getInstance().format(product.getProductQty()) %>&nbsp;개</td>
			</tr>
			<tr>
				<th style="text-align: center; font-size: 16px;">제품 상세설명</th>
				<td colspan="4" style="min-height: 500px;"><%=product.getProductDetail().split("___")[0].replace("\n", "<br>")%><br><br><br>
				<%if (!product.getProductDetail().split("___")[1].equals("NOPICS")) { %>
					<img src="<%=request.getContextPath() %>/img/product_images/<%=product.getProductDetail().split("___")[1] %>">
				<%} %>
				</td>
			</tr>
			</table>

			<div style="text-align:center;">
				<button class="btnDate" id="listBtn" type="button" style="width: 120px; height: 50px;">목록보기</button>&nbsp;
				<button class="btnDate selected" id="modifyBtn" type="button" style="width: 160px; height: 50px;"><span style="font-size: 15px;">상품수정</span></button>&nbsp;
				<button class="btnDate selected" id="removeBtn" type="button" style="width: 160px; height: 50px;"><span style="font-size: 15px;">상품삭제</span></button>
			</div>
	</div>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=modify&productNum=<%=productNum%>";
});

$("#removeBtn").click(function() {
	if (confirm("<%=product.getProductName()%>[<%=product.getProductCode() %>]을 삭제하시겠습니까?")){
		location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=remove_action&productNum=<%=productNum%>";
	}
});

$("#listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list";
});
</script>
