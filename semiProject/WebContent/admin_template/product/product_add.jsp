<%@page import="semiProject.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<%
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	ProductDTO product=(ProductDTO)session.getAttribute("product");
	if(product!=null) {
		session.removeAttribute("product");
	}
%>
<style type="text/css">
.error {
	color: red;
	background: #FFFFDA;
}
</style>
<p class="for_title" style="margin-top: 100px;">상품등록</p> 
<div id="searchBox">
	<div class="board_t1" >
		<div id="message" style="color: red; text-align: center; font-size: 30px;"></div>
		<form action="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=add_action" method="post" enctype="multipart/form-data" id="productForm">
			<table class="admin_t">
				<tr>
					<th>원산지</th>
					<td>
		                <select class="fSelect eSearch" name="origin">
			                <option value="FRA" <%if (product!=null && product.getProductCode().split("_")[0].equals("FRA")) { %> selected <%} %>>프랑스</option>
			                <option value="SPA" <%if (product!=null && product.getProductCode().split("_")[0].equals("SPA")) { %> selected <%} %>>스페인</option>
			                <option value="CHI" <%if (product!=null && product.getProductCode().split("_")[0].equals("CHI")) { %> selected <%} %>>칠레</option>
			                <option value="ITA" <%if (product!=null && product.getProductCode().split("_")[0].equals("ITA")) { %> selected <%} %>>이탈리아</option>
			                <option value="ARG" <%if (product!=null && product.getProductCode().split("_")[0].equals("ARG")) { %> selected <%} %>>아르헨티나</option>
			                <option value="AUS" <%if (product!=null && product.getProductCode().split("_")[0].equals("AUS")) { %> selected <%} %>>호주</option>
			                <option value="USA" <%if (product!=null && product.getProductCode().split("_")[0].equals("USA")) { %> selected <%} %>>미국</option>
			                <option value="GER" <%if (product!=null && product.getProductCode().split("_")[0].equals("GER")) { %> selected <%} %>>독일</option>
			                <option value="ECT" <%if (product!=null && product.getProductCode().split("_")[0].equals("ECT")) { %> selected <%} %>>기타</option>
	                    </select> 
	                </td>
                    <th>와인컬러</th>
                    <td>
		                <select class="fSelect eSearch" name="wColor">
			                <option value="RED" <%if (product!=null && product.getProductCode().split("_")[1].equals("RED")) { %> selected <%} %>>레드와인</option>
			                <option value="WHI" <%if (product!=null && product.getProductCode().split("_")[1].equals("WHI")) { %> selected <%} %>>화이트와인</option>
			                <option value="ROS" <%if (product!=null && product.getProductCode().split("_")[1].equals("ROS")) { %> selected <%} %>>로제와인</option>
			                <option value="SHA" <%if (product!=null && product.getProductCode().split("_")[1].equals("SHA")) { %> selected <%} %>>샴페인</option>
	                    </select> 
	                </td>
				</tr>
				<tr>
					<th>제조사</th>
					<td>
						<input type="text" class="required" name="brand" id="brand" style="width:200px;" <%if (product!=null) { %> value="<%=product.getProductCode().split("_")[3] %>" <%} %>>
						<div id="brandMsg" class="error"></div>
					</td>
                    <th>품종</th>
                    <td>
	                	<input type="text" class="required" name="wType" id="wType" style="width:200px;" <%if (product!=null) { %> value="<%=product.getProductCode().split("_")[2] %>" <%} %>>
	                	<span style="font-size: 12px; color: tomato;">&nbsp;&nbsp;* 품종은 영어로만 입력가능</span>
						<div id="wTypeMsg" class="error"></div>
	                </td>
				</tr>
				<tr>
					<th>상품명</th>
					<td colspan="3">
						<input type="text" class="required" name="productName" id="productName" style="width:600px;" <%if (product!=null) { %> value="<%=product.getProductName()%>" <%} %>>
						<div id="productNameMsg" class="error"></div>
					</td>
				</tr>
				<tr>
					<th>대표이미지</th>
					<td colspan="3">
						<input type="file" class="required" name="productImage1" id="productImage1">
						<div id="productImage1Msg" class="error"></div>
					</td>
				</tr>
				<tr>
					<th>추가이미지1</th>
					<td>
						<input type="file" name="productImage2" id="productImage2">
					</td>
					<th>추가이미지2</th>
					<td>
						<input type="file" name="productImage3" id="productImage3">
					</td>
				</tr>
				<tr>
					<th rowspan="2">제품 상세설명</th>
					<td colspan="3">
						<div id="productDetailMsg" class="error"></div>
						<textarea rows="15" cols="150" name="detailText" id="detailText"><%if (product!=null) { %> <%=product.getProductDetail()%> <%} %></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<span style="font-size: 12px; color: tomato;">&nbsp;* 제품 상세설명에 삽입할 이미지를 선택해주세요.&nbsp;&nbsp;</span>
						<input type="file" name="detailImage" id="detailImage">
					</td>
				</tr>
				<tr>
					<th>재고</th>
					<td>
						<input type="text" class="required" name="productQty" id="productQty" <%if (product!=null) { %> value="<%=product.getProductQty()%>" <%} %>>&nbsp;개
						<div id="productQtyMsg" class="error"></div>
					</td>
					<th>제품 가격</th>
					<td>
						<input type="text" class="required" name="productPrice" id="productPrice" <%if (product!=null) { %> value="<%=product.getProductPrice()%>" <%} %>>&nbsp;원
						<div id="productPriceMsg" class="error"></div>
					</td>
				</tr>
			</table>

			<div style="text-align: right;">
				<button class="btnDate" id="resetBtn" type="reset" style="width: 70px; height: 50px;">초기화</button>
				<button class="btnDate" id="cancelBtn" type="button" style="width: 70px; height: 50px;">취소</button>
				<button class="btnDate selected" type="submit" style="width: 160px; height: 50px;"><span style="font-size: 17px;">상품등록</span></button>
				&nbsp;&nbsp;&nbsp;
			</div>
		</form>
	</div>
</div>

<!-- 
 "productDetail":"상품에 대한 상세설명을 텍스트로 입력하거나 이미지 파일로 등록해주세요.",
 -->

<script>
/* 유효성검사 추가필요 */
$("#productForm").submit(function() {
	$(".error").text("");		
	var result=true;
	var message={"brand":"제조사를 입력해주세요.", "wType":"품종을 입력해주세요.", "productName": "상품명을 입력해주세요.",
			"productImage1":"상품의 대표 이미지를 꼭 등록해주세요.",
			"productQty":"재고수량을 꼭 입력해 주세요.", "productPrice":"상품 가격을 꼭 입력해주세요."};
	var $essence=$("#productForm").find(".required");
	$essence.each(function() {
		if($(this).val()=="") {
			var idAttr=$(this).attr("id");
			$("#"+idAttr+"Msg").text(message[idAttr]);
			result=false;
		}
	});
	if(!result) return false;
	
	if ($("#detailText").val()=="" && $("#detailImage").val()=="") {
		$("#productDetailMsg").text("상품에 대한 상세설명을 텍스트로 입력하거나 이미지 파일로 등록해주세요.");
		return false;
	}
	
});

$("#resetBtn").click(function() {
	$(".error").text("");	
	$("#brand").focus();
});

$("#cancelBtn").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list";
});
</script>