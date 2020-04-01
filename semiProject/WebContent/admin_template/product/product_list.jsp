<%@page import="semiProject.dto.BoardDTO"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<style type="text/css">
.searchBoxbtns {
	background: #F15F5F;
	color: white;
	width: 150px;
	height: 50px;
	border: none;
	border-radius: 5px; 
}
.searchBoxbtns:hover {
	background: white;
	color: #F15F5F;
	border: 1px solid #F15F5F;
}
</style>

<%
	
	String currentDate= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	//String monthAgo=new SimpleDateFormat("yyyy-MM-dd").format(new Date().getTime()-((long)(60*60*24*1000)*30));	

	// 날짜 조건
	String startDay = request.getParameter("startDay");
	if(startDay == null)startDay ="";
	
	String endDay = request.getParameter("endDay");
	if(endDay == null)endDay = "";
	
	/* 원산지, 색 조건
	String orgin=request.getParameter("orgin"); //FRA
	if (orgin == null)orgin ="";
	String wColor=request.getParameter("wColor"); //RED
	if (wColor == null)wColor ="";
	
	// 품종 조건
	String wType=request.getParameter("wType"); //이건..... 
	if (wType == null)wType ="";
	*/
	
 	// 검색 조건
	String search=request.getParameter("search");
	if(search==null) search="";
	String keyword=request.getParameter("keyword");
	if(keyword==null) keyword="";
	
	// 날짜 버튼 변수
	/*int dateAttr=0;
	if(request.getParameter("dateAttr")!=null){
		dateAttr=Integer.parseInt(request.getParameter("dateAttr"));
	}*/
	String dateAttr=request.getParameter("dateAttr");
	if(dateAttr == null)dateAttr ="All";
	
	
	// 가격 조건
	String price1=request.getParameter("price1");
	if(price1 == null)price1 ="";
	
	String price2=request.getParameter("price2");
	if(price2 == null)price2 ="";
	
	
	// 개수 조건
	String qty1=request.getParameter("qty1");
	if(qty1 == null)qty1 ="";
	
	String qty2=request.getParameter("qty2");
	if(qty2 == null)qty2 ="";


	String sort = request.getParameter("sort");
	if(sort==null) sort="ADD_DATE DESC";
	
	// 페이징처리값
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}

 	// 보여질 게시글개수 처리값
	int pageSize=10;
	if(request.getParameter("pageSize")!= null) {
		pageSize=Integer.parseInt(request.getParameter("pageSize"));
	}
	
	int total = ProductDAO.getDAO().selectProductCount();
	int totalBoard = ProductDAO.getDAO().selectProductCount(search, keyword, startDay, endDay, price1, price2, qty1, qty2);

	// 전제페이지개수 계산
	int totalPage = (int) Math.ceil((double) totalBoard / pageSize);

	if (pageNum <= 0 || pageNum > totalPage) {
		pageNum = 1;
	}

	int startRow = (pageNum - 1) * pageSize + 1;
	int endRow = pageNum * pageSize;

	if (endRow > totalBoard) {
		endRow = totalBoard;
	}
	
	int number = totalBoard-(pageNum-1)*pageSize; 
	
	List<ProductDTO> productList= ProductDAO.getDAO().selectAllProduct(startRow, endRow, search, keyword, startDay, endDay, price1, price2, qty1, qty2, sort);
	
%>

<div style="float: right; margin-right: 10px;">
	<button id="addBtn" class="searchBoxbtns" type="button" style="font-size: 18px;" ><i class="fas fa-plus-square"></i>&nbsp;상품등록</button>
</div>

<p class="for_title" style="margin-top: 100px;">&nbsp;&nbsp;<i class="fas fa-wine-glass-alt"></i>&nbsp;상품목록</p> 

<form method="post" id="searchForm" >
<div class="board_t1">
		<table class="admin_t">
			<tbody>
				<tr>
					<th>검색어</th>
					<td colspan="5">
						<select class="fSelect eSearch" id="search" name="search">
							<option value="product_Name" <%if(search.equals("product_Name")){ %>selected="selected"<%} %>>상품명</option>
							<option value="product_Num" <%if(search.equals("product_Num")){ %>selected="selected"<%} %>>상품번호</option>
							<option value="product_Code" <%if(search.equals("product_Code")){ %>selected="selected"<%} %>>상품코드</option>
						</select> 
						<input type="text" class="fText sBaseSearchBox" name="keyword" id="keyword" style="width: 400px;" value="<%=keyword%>">
					</td>
				</tr>
				<!-- <tr>
					<th>상품분류</th>
					<td colspan="2">원산지&nbsp; 
						<select class="fSelect eSearch"name="origin">
							<option value="NONE">선택안함</option>
							<option value="FRA">프랑스</option>
							<option value="SPA">스페인</option>
							<option value="CHI">칠레</option>
							<option value="ITA">이탈리아</option>
							<option value="ARG">아르헨티나</option>
							<option value="AUS">호주</option>
							<option value="USA">미국</option>
							<option value="GER">독일</option>
							<option value="ECT">기타</option>
						</select> &nbsp;와인컬러&nbsp; 
						<select class="fSelect eSearch" name="wColor">
							<option value="NONE">선택안함</option>
							<option value="RED">레드와인</option>
							<option value="WHI">화이트와인</option>
							<option value="ROS">로제와인</option>
							<option value="SHA">샴페인</option>
						</select>
					</td>
					<th>품종</th>
					<td colspan="2">
						<input type="text" class="fText sBaseSearchBox" name="wType" id="sBaseSearchBox" style="width: 300px;"> 
						<span style="font-size: 12px; color: tomato;">&nbsp;* 품종은 영어로만 입력가능합니다.</span></td>
				</tr> -->
				<tr>
					<th>상품등록일</th>
					<td colspan="5">
					<input type="hidden" value="30" class="dateAttr" name="dateAttr" />
                       	<a title="1" class="btnDate <%if(dateAttr.equals("1")){%>selected<%}%>"><span>오늘</span></a> 
						<a title="7" class="btnDate <%if(dateAttr.equals("7")){%>selected<%}%>"><span>7일</span></a> 
						<a title="30" class="btnDate <%if(dateAttr.equals("30")){%>selected<%}%>"><span>1개월</span></a> 
						<a title="90" class="btnDate <%if(dateAttr.equals("90")){%>selected<%}%>"><span>3개월</span></a> 
						<a title="180" class="btnDate <%if(dateAttr.equals("180")){%>selected<%}%>"><span>6개월</span></a>
						<a title="365" class="btnDate <%if(dateAttr.equals("365")){%>selected<%}%>"><span>1년</span></a>
						<a title="All" id="ALLPeriod" class="btnDate <%if(dateAttr.equals("All")){%>selected<%}%>"><span>전체</span></a> &nbsp;&nbsp; 
						<input type="date" value="<%=startDay%>" id="startDay" name="startDay" class="fSelect" id="fDate"> &nbsp;~&nbsp; 
						<input type="date" value="<%=endDay %>" id="endDay" name="endDay" class="fSelect"></td>
				</tr>
				<tr>
					<th>가격범위</th>
					<td colspan="2">
						<input value="<%=price1 %>" type="text" class="fText sBaseSearchBox" name="price1" id="price1" style="width: 150px;">&nbsp;~&nbsp; 
						<input value="<%=price2 %>" type="text" class="fText sBaseSearchBox" name="price2" id="price2" style="width: 150px;">원
					</td>
					<th>재고범위</th>
					<td colspan="2">
						<input value="<%=qty1 %>" type="text" class="fText sBaseSearchBox" name="qty1" id="qty1" style="width: 150px;">&nbsp;~&nbsp; 
						<input value="<%=qty2 %>" type="text" class="fText sBaseSearchBox" name="qty2" id="qty2" style="width: 150px;">개
							&nbsp;&nbsp;&nbsp;<input type="checkbox" id="soldoutCheck">품절상품
					</td>
				</tr>
			</tbody>
		</table>
		<div style="text-align: center;">
			<div id="searchMessage" style="color: red;"></div><br>
        	<button class="searchBoxbtns" type="submit"><i class="fas fa-search"></i>&nbsp;검색</button>
      		<button id="resetBtn" class="searchBoxbtns" type="button"><i class="fas fa-eraser"></i>&nbsp;초기화</button>
      	</div>

</div>



<%-- 결과출력테이블 --%>
<div class="board_t2">
	<div class="mState">
		<div class="gLeft">
			<p class="total">
				[총 <%=total %>개] 검색결과 <strong><%= totalBoard %></strong> 건
			</p>
		</div>
		<div class="gRight">
			<select class="fSelect" id="sort" name="sort">
				<option value="ADD_DATE DESC" <%if (sort.equals("ADD_DATE DESC")) {%> selected <%}%>>등록일(최신순)</option>
				<option value="ADD_DATE ASC" <%if (sort.equals("ADD_DATE ASC")) {%> selected <%}%>>등록일(오래된순)</option>
				<option value="empty1" disabled="disabled">---------------</option>
				<option value="PRODUCT_NAME ASC" <%if (sort.equals("PRODUCT_NAME ASC")) {%> selected <%}%>>상품명 순</option>
				<option value="PRODUCT_NAME DESC" <%if (sort.equals("PRODUCT_NAME DESC")) {%> selected <%}%>>상품명 역순</option>
				<option value="empty3" disabled="disabled">---------------</option>
				<option value="PRODUCT_PRICE DESC" <%if (sort.equals("PRODUCT_PRICE DESC")) {%> selected <%}%>>높은가격순</option>
				<option value="PRODUCT_PRICE ASC" <%if (sort.equals("PRODUCT_PRICE ASC")) {%> selected <%}%>>낮은가격순</option>
			</select>&nbsp;
			<select class="fSelect" id="rows" name="rows">
				<option value="10" <%if (pageSize == 10) {%> selected <%}%>>10개씩보기</option>
				<option value="30" <%if (pageSize == 30) {%> selected <%}%>>30개씩보기</option>
				<option value="50" <%if (pageSize == 50) {%> selected <%}%>>50개씩보기</option>
				<option value="100" <%if (pageSize == 100) {%> selected <%}%>>100개씩보기</option>
			</select>
		</div>
	</div>

		<div class="mCtrl">
			<button type="button" id="deleteBtn" style="border: 1px solid gray; background: white; padding: 5px;"><i class="fas fa-times" style="color: red;"></i>&nbsp;선택상품 삭제</button>&nbsp;&nbsp;|&nbsp;
			<button type="button" id="soldoutBtn" style="border: 1px solid gray; background: white; padding: 5px;"><i class="fas fa-exclamation" style="color: red;"></i>&nbsp;선택상품 품절</button>
			<div id="message" style="color: red;"></div>
		</div>

		<div class="mBoard">
			<table class="admin_t">
				<thead>
					<tr>
						<th><input type="checkbox" class="allChk"></th>
						<th width="30">상품코드</th>
						<th>이미지</th>
						<th>상품명</th>
						<th>상품가격</th>
						<th>원산지</th>
						<th>와인컬러</th>
						<th>품종</th>
						<th>브랜드</th>
						<th>재고량</th>
						<th>등록일</th>
						<th>상품수정</th>
					</tr>
				</thead>
				<%-- 검색내용출력 --%>
				<tbody>
					<% if(productList.isEmpty()) { %>
					<tr>
						<td colspan="12">등록된 제품이 하나도 없습니다.</td>
					</tr>
					<%} else {%>
					<%for(ProductDTO product: productList) { %>
					<%-- 모든상품이 삭제된 경우 안내문 추후 추가 >> total보드값으로 출력 --%>
					<%if(product.getProductStatus()!=9) { %>
					<tr>
						<td><input type="checkbox" name="checkedProductNum" class="rowChk" value="<%=product.getProductNum()%>"></td>
						<td><%=product.getProductCode() %></td>
						<td>
						<img src="<%=request.getContextPath() %>/img/product_images/<%=product.getProductImage1() %>" width="100" height="100"></td>
						<td>
						<a href="<%=request.getContextPath() %>/admin_template/index.jsp?part=product&work=detail&productNum=<%=product.getProductNum()%>" style="text-decoration: underline; color: #F15F5F;"><%=product.getProductName() %></a></td>
						<td><%=DecimalFormat.getCurrencyInstance().format(product.getProductPrice()) %></td>
						<%if (product.getProductCode().split("_")[0].equals("FRA")) { %>
						<td>프랑스</td>
						<%} else if(product.getProductCode().split("_")[0].equals("SPA")) { %>
						<td>스페인</td>
						<%} else if(product.getProductCode().split("_")[0].equals("CHI")) { %>
						<td>칠레</td>
						<%} else if(product.getProductCode().split("_")[0].equals("ITA")) { %>
						<td>이탈리아</td>
						<%} else if(product.getProductCode().split("_")[0].equals("ARG")) { %>
						<td>아르헨티나</td>
						<%} else if(product.getProductCode().split("_")[0].equals("AUS")) { %>
						<td>호주</td>
						<%} else if(product.getProductCode().split("_")[0].equals("USA")) { %>
						<td>미국</td>
						<%} else if(product.getProductCode().split("_")[0].equals("GER")) { %>
						<td>독일</td>
						<%} else if(product.getProductCode().split("_")[0].equals("ECT")) { %>
						<td>기타</td>
						<%} else { %>
						<td>-</td>
						<%} %>

						<%if (product.getProductCode().split("_")[1].equals("RED")) { %>
						<td>레드와인</td>
						<%} else if(product.getProductCode().split("_")[1].equals("WHI")) { %>
						<td>화이트와인</td>
						<%} else if(product.getProductCode().split("_")[1].equals("ROS")) { %>
						<td>로제</td>
						<%} else if(product.getProductCode().split("_")[1].equals("SHA")) { %>
						<td>샴페인</td>
						<%} else {%>
						<td>-</td>
						<%} %>
						<td><%=product.getProductCode().split("_")[2]%></td>
						<td><%=product.getProductCode().split("_")[3]%></td>
						<td><%if (product.getProductQty()==0) {%><label style="color: red;">품절</label><%} else { %><%= DecimalFormat.getInstance().format(product.getProductQty())%><%} %></td>
						<td><%=product.getAddDate().substring(0,19) %></td>
						<td><button class="btnDate" id="modifyBtn" type="button"
								style="height: 50px; font-size: 13px;"
								onclick="location.href='<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=modify&productNum=<%=product.getProductNum()%>';">수정</button></td>
					</tr>
					<%} %>
					<% } %>
					<% } %>
				</tbody>
			</table>
		</div>
<!-- 
		<div class="mCtrl">
			<button type="button" id="deleteBtn" style="border: 1px solid gray; background: white; padding: 5px;"><i class="fas fa-times" style="color: red;"></i>&nbsp;선택상품 삭제</button>&nbsp;&nbsp;|&nbsp;
			<button type="button" id="soldoutBtn" style="border: 1px solid gray; background: white; padding: 5px;"><i class="fas fa-exclamation" style="color: red;"></i>&nbsp;선택상품 품절</button>
		</div>
 -->
	<%-- 페이징처리 --%>
	<div class="mPaginate">

		<%
				int blockSize = 5;
				int startPage = (pageNum - 1) / blockSize * blockSize + 1;
				int endPage = startPage + blockSize - 1;
				if (endPage > totalPage) {
					endPage = totalPage;
				}
			%>
		<!-- 페이지 이동  -->
		<%if (startPage > blockSize) {%>
		<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list&pageNum=1&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&price1=<%=price1 %>&price2=<%=price2 %>&qty1=<%=qty1 %>&qty2=<%=qty2 %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-double-left"></i></a> 
		<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list&pageNum=<%=startPage - blockSize%>&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&price1=<%=price1 %>&price2=<%=price2 %>&qty1=<%=qty1 %>&qty2=<%=qty2 %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-left"></i></a>&nbsp;
		<%} else {%>
		<a href="#none" class="btnNormal"><i class="fas fa-angle-double-left"></i></a> 
		<a href="#none" class="btnNormal"><i class="fas fa-angle-left"></i>&nbsp;</a>
		<%}%>

		<%for (int i = startPage; i <= endPage; i++) {%>
		<%if (pageNum != i) {%>
		<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list&pageNum=<%=i%>&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&price1=<%=price1 %>&price2=<%=price2 %>&qty1=<%=qty1 %>&qty2=<%=qty2 %>&sort=<%=sort %>" class="btnNormal"><%=i%></a>&nbsp;
		<% } else { %>
		&nbsp;<a href="" class="btnNormal"><%=i%></a>&nbsp;
		<% } %>
		<% } %>


		<% if (endPage != totalPage) { %>
		<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list&pageNum=<%=startPage + blockSize%>&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&price1=<%=price1 %>&price2=<%=price2 %>&qty1=<%=qty1 %>&qty2=<%=qty2 %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-right"></i></a> 
		<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list&pageNum=<%=totalPage%>&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&price1=<%=price1 %>&price2=<%=price2 %>&qty1=<%=qty1 %>&qty2=<%=qty2 %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
		<% } else {%>
		<a href="#" class="btnNormal"><i class="fas fa-angle-right"></i></a> 
		<a href="#" class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
		<% } %>
	</div>
</div>
</form>


<script type="text/javascript">
	/* 1일 3일 등 버튼 눌를때 이벤트 */
	$(".btnDate").click(function() {
	   if ($(".btnDate.selected").length == 1) {
	      $(".btnDate").removeClass("selected");
	      $(this).addClass("selected");
	      
	      var today = new Date();
	      today.setDate(-$(this).attr("title")+12);
	      var dd = today.getDate();
	      var mm = today.getMonth()+1; //January is 0!
	      var yyyy = today.getFullYear();
			
	      
	      if(dd<10) {
	          dd='0'+dd
	      } 
	
	      if(mm<10) {
	          mm='0'+mm
	      } 
	
	      today = yyyy+'-'+mm+'-'+dd;
	     
	      $("#startDay").val(today);
	      
	      var now = new Date();
	      var dd = now.getDate();
	      var mm = now.getMonth()+1; 
	      var yyyy = now.getFullYear();

	      if(dd<10) {
	          dd='0'+dd
	      } 

	      if(mm<10) {
	          mm='0'+mm
	      } 
	      
	      now = yyyy+'-'+mm+'-'+dd;
	      $("#endDay").val(now);
	      
	   } else if($(".btnDate.selected").length==0) {
	      $(this).addClass("selected");
	   }
	   var inter=$(".selected").attr("title");
	      $(".dateAttr").attr("value",inter);
	});
	
	$("#ALLPeriod").click(function() {
		$("#startDay").val("");
		$("#endDay").val("");
	});
   
	/* 검색결과 체크박스 */
	$(".allChk").change(function() {
	 	if($(this).is(":checked")){
	 		$(".rowChk").prop("checked", true)
	 	}else{
	$(".rowChk").prop("checked", false)
	 	}
	 });
	 
	/* 페이지 보기(10개 50개 등) 셀렉문 선택시 이벤트 */
	 $("#rows").change(function() {
		var sort=$("#sort option:selected").val();
	 	var rows=$("#rows option:selected").val();
	 	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list&pageNum=<%=pageNum%>&pageSize="+rows+"&sort="+sort;
	});
	 $("#sort").change(function() {
		var sort=$("#sort option:selected").val();
		var rows=$("#rows option:selected").val();
	 	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list&pageNum=<%=pageNum%>&pageSize="+rows+"&sort="+sort;
	 });
	
	
	
$("#searchForm").submit(function() {
	
});	
$("#soldoutCheck").change(function() {
 	if($(this).is(":checked")){
 		$("#qty2").val("0");
 	}else{
 		$("#qty2").val("100000000");
 	}
});
$("#resetBtn").click(function() {
	$("#keyword").focus();
	$("#search option:eq(0)").prop("selected", true);
	$("#keyword").val("");
	$("#price1").val("");
	$("#price2").val("");
	$("#qty1").val("");
	$("#qty2").val("");
	$("#searchMessage").text("");
	$("#ALLPeriod").click();
	$("#startDay").val("");
	$("#endDay").val("");
});
$("#deleteBtn").click(function() {
	if($(".rowChk").filter(":checked").size()==0){
		$("#message").text("선택된 상품이 없습니다.");
    	return;
	} else {
		if(confirm("선택된 상품을 삭제하시겠습니까?")) {
			$("#searchForm").attr("method", "post");
			$("#searchForm").attr("action", "<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=check_delete_action");
			$("#searchForm").submit();
		}
   }
});
$("#soldoutBtn").click(function() {
	if($(".rowChk").filter(":checked").size()==0){
		$("#message").text("선택된 상품이 없습니다.");
    	return;
	} else {
		$("#searchForm").attr("method", "post");
		$("#searchForm").attr("action", "<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=check_soldout_action");
		$("#searchForm").submit();
   }
});
$("#addBtn").click(function() {
		location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=add";
});

  
 
</script>

