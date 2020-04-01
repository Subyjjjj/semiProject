<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@page import="semiProject.dto.OrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<style>
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
   String monthAgo=new SimpleDateFormat("yyyy-MM-dd").format(new Date().getTime()-((long)(60*60*24*1000)*30));   
   
   String search=request.getParameter("search");
   if(search==null) search="";
   String keyword=request.getParameter("keyword");
   if(keyword==null) keyword="";
   
	String startDay = request.getParameter("startDay");
	if(startDay == null)startDay ="";
	
	String endDay = request.getParameter("endDay");
	if(endDay == null)endDay = "";
   
	// 날짜버튼 활성화
	String dateAttr=request.getParameter("dateAttr");
	if(dateAttr == null)dateAttr ="All";
	
   String payment=request.getParameter("paymentMethod");
   
   int paymentMethod=0;
   if (request.getParameter("paymentMethod")!=null){
      paymentMethod=Integer.parseInt(request.getParameter("paymentMethod"));
   }
     
   String[] wantStatus={"0"};
   int orderStatus=0;
   if(request.getParameterValues("orderStatus")!=null) {
      wantStatus=request.getParameterValues("orderStatus");
	  orderStatus=100;
   }
   
   
   if(wantStatus.length==1){
      orderStatus=Integer.parseInt(wantStatus[0]);
   }
   
   String sort = request.getParameter("sort");
	if(sort==null)sort="ORDER_DATE DESC";

   // 페이징처리
   int pageNum=1;
   if(request.getParameter("pageNum")!=null) {
      pageNum=Integer.parseInt(request.getParameter("pageNum"));
   }

   int pageSize=10;
   if(request.getParameter("pageSize")!= null) {
      pageSize=Integer.parseInt(request.getParameter("pageSize"));
   }
   
   int total=OrderDAO.getDAO().totalOrderCount();
   int searchTotal=OrderDAO.getDAO().selectOrderCount(search, keyword, startDay, endDay, paymentMethod, orderStatus, wantStatus);
   
   int totalPage = (int)Math.ceil((double)searchTotal/pageSize);
   
   if(pageNum<=0 || pageNum>totalPage){
      pageNum=1;
   }
   
   int startRow=(pageNum-1)*pageSize+1;
   int endRow=pageNum*pageSize;
   
   if (endRow>searchTotal) {
      endRow=searchTotal;
   }
   
   int blockSize=5;
   int startPage=(pageNum - 1)/blockSize*blockSize+1;
   int endPage=startPage+blockSize-1;
   if (endPage>totalPage) {
      endPage=totalPage;
   }
   
   List<OrderDTO> orderList=OrderDAO.getDAO().selectSearchOrder(startRow, endRow, search, keyword, startDay, endDay, paymentMethod, orderStatus, wantStatus, sort);
   
   
%>
<div id="orderStatusBar">
   <ul>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=0" <% if(orderStatus==0) { %>class="select"<%} %>>전체주문</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=1" <% if(orderStatus==1) { %>class="select"<%} %>>결제대기</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=2" <% if(orderStatus==2) { %>class="select"<%} %>>결제완료</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=3" <% if(orderStatus==3) { %>class="select"<%} %>>배송준비중</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=4" <% if(orderStatus==4) { %>class="select"<%} %>>배송중</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=5" <% if(orderStatus==5) { %>class="select"<%} %>>배송완료</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=6" <% if(orderStatus==6) { %>class="select"<%} %>>구매확정</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=10" <% if(orderStatus==10) { %>class="select"<%} %>>취소요청</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=11" <% if(orderStatus==11) { %>class="select"<%} %>>취소완료</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=20" <% if(orderStatus==20) { %>class="select"<%} %>>교환요청</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=21" <% if(orderStatus==21) { %>class="select"<%} %>>교환완료</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=30" <% if(orderStatus==30) { %>class="select"<%} %>>환불요청</a></li>
      <li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=31" <% if(orderStatus==31) { %>class="select"<%} %>>환불완료</a></li>
   </ul>
</div>

<hr>
<p class="for_title">&nbsp;&nbsp;<i class="fas fa-wine-glass-alt"></i>&nbsp;<span style="color: #FFA7A7;">
<%if (orderStatus==0) { %>
   전체
<%} else if (orderStatus==1) {%>
   결제대기
<%} else if (orderStatus==2) {%>
   결제완료
<%} else if (orderStatus==3) {%>
   배송준비중
<%} else if (orderStatus==4) {%>
   배송중
<%} else if (orderStatus==5) {%>
   배송완료
<%} else if (orderStatus==6) {%>
   구매확정
<%} else if (orderStatus==10 || orderStatus==11) {%>
   주문취소
<%} else if (orderStatus==20 ||orderStatus==21) {%>
   주문교환
<%} else if (orderStatus==30 || orderStatus==31) {%>
   주문환불
<%} %>
</span>주문목록</p> 

<form method="post"  id="searchForm">
<div id="searchBox">
<div class="board_t1">
      <table class="admin_t">
         <tbody>
            <tr>
               <th>검색어</th>
               <td colspan="3">
                  <select class="fSelect" id="search" name="search" style="width:163px;">
                     <option value="NONE" selected>검색선택</option>
                     <option value="empty1" disabled="disabled">---------------</option>
                     <option value="ORDER_NUM" <%if(search.equals("ORDER_NUM")) {%>selected<%} %>>주문번호</option>
                     <option value="DELIVERY" <%if(search.equals("DELIVERY")) {%>selected<%} %>>운송장번호</option>
                     <option value="empty1" disabled="disabled">---------------</option>
                     <option value="NAME" <%if(search.equals("NAME")) {%>selected<%} %>>주문자명</option>
                     <option value="ID" <%if(search.equals("ID")) {%>selected<%} %>>주문자ID</option>
                     <option value="PHONE" <%if(search.equals("PHONE")) {%>selected<%} %>>주문자 전화번호</option>
                     <option value="empty1" disabled="disabled">---------------</option>
                     <option value="NAME" <%if(search.equals("NAME")) {%>selected<%} %>>수취인명</option>
                     <option value="PHONE" <%if(search.equals("PHONE")) {%>selected<%} %>>수취인 전화번호</option>
                     <option value="ADDRESS" <%if(search.equals("ADDRESS")) {%>selected<%} %>>배송지</option>
                     <option value="CUSTOM_MSG" <%if(search.equals("CUSTOM_MSG")) {%>selected<%} %>>주문메모</option>
                     <option value="empty1" disabled="disabled">---------------</option>
                     <option value="PRODUCT_NAME" <%if(search.equals("PRODUCT_NAME")) {%>selected<%} %>>상품명</option>
                  </select>
                  <input type="text" class="fText sBaseSearchBox" name="keyword" id="keyword" style="width:400px;" value="<%=keyword%>">
               </td>
            </tr>
            <tr>
               <th>주문일</th>
               <td colspan="3">
               <input type="hidden" value="30" class="dateAttr" name="dateAttr" />
                    <a title="1" class="btnDate <%if(dateAttr.equals("1")){%>selected<%}%>"><span>오늘</span></a> 
					<a title="7" class="btnDate <%if(dateAttr.equals("7")){%>selected<%}%>"><span>7일</span></a> 
					<a title="30" class="btnDate <%if(dateAttr.equals("30")){%>selected<%}%>"><span>1개월</span></a> 
					<a title="90" class="btnDate <%if(dateAttr.equals("90")){%>selected<%}%>"><span>3개월</span></a> 
					<a title="180" class="btnDate <%if(dateAttr.equals("180")){%>selected<%}%>"><span>6개월</span></a>
					<a title="365" class="btnDate <%if(dateAttr.equals("365")){%>selected<%}%>"><span>1년</span></a>
					<a title="All" id="ALLPeriod" class="btnDate <%if(dateAttr.equals("All")){%>selected<%}%>"><span>전체</span></a> &nbsp;&nbsp;  
                  <input id="startDay" type="date" value="<%=startDay%>" name="startDay" class="fSelect" > &nbsp;~&nbsp; 
                  <input id="endDay" type="date" value="<%=endDay %>" name="endDay" class="fSelect" ></td>
            </tr>
            <tr>
               <th>입금/결제상태</th>
               <td>
                  <label class="gLabel eSelected">
                     <input type="checkbox" id="checkAllPay" > 전체
                  </label>
                  <label class="gLabel eSelected">
                     <input type="checkbox" class="checkPay"  name="orderStatus" value="1"> 결제대기
                  </label>
                  <label class="gLabel eSelected">
                     <input type="checkbox" class="checkPay"  name="orderStatus"  value="2"> 결제완료
                  </label>
               </td>
               <th>결제수단</th>
               <td>
                  <label class="gLabel eSelected">
                     <input type="radio" id="paymentMethod" class="payMethod" name="paymentMethod" value="0" checked> 전체
                  </label>
                  <label class="gLabel">
                     <input type="radio" name="paymentMethod" value="1" class="fChk" <%if(paymentMethod==1) {%> checked <%} %>> 무통장입금
                  </label>
                  <label class="gLabel">
                     <input type="radio" name="paymentMethod" value="2" class="fChk" <%if(paymentMethod==2) {%> checked <%} %>> 신용카드
                  </label>
               </td>      
            </tr>
            <tr>
               <th>배송상태</th>
               <td colspan="3">
                  <label class="gLabel eSelected">
                     <input type="checkbox" id="checkAllDelivary"> 전체
                  </label>
                  <label class="gLabel eSelected">
                     <input type="checkbox" class="checkDelivary"  name="orderStatus" value="3"> 배송준비중
                  </label>
                  <label class="gLabel eSelected">
                     <input type="checkbox" class="checkDelivary"  name="orderStatus"  value="4"> 배송중
                  </label>
                  <label class="gLabel eSelected">
                     <input type="checkbox" class="checkDelivary"  name="orderStatus"  value="5"> 배송완료
                  </label>
                  <label class="gLabel eSelected">
                     <input type="checkbox" class="checkDelivary"  name="orderStatus"  value="6"> 구매확정
                  </label>
               </td>
            </tr>
            <tr>
               <th>CS요청상태</th>
               <td colspan="3">
                  <label class="gLabel eSelected">
                     <input type="checkbox" id="checkAllCS"> 전체
                  </label>
                  <label class="gLabel eSelected">
                     <input type="checkbox" class="checkCS"  name="orderStatus" value="10"> 취소건
                  </label>
                  <label class="gLabel eSelected">
                     <input type="checkbox" class="checkCS"  name="orderStatus"  value="20"> 교환건
                  </label>
                  <label class="gLabel eSelected">
                     <input type="checkbox" class="checkCS"  name="orderStatus"  value="30"> 환불건
                  </label>
               </td>
            </tr>
         </tbody>
      </table>
      <%-- 검색버튼 --%>
      <div style="text-align: center;">
	      <div id="searchMessage" style="color: red;"></div><br>
	      <button class="searchBoxbtns" type="submit"><i class="fas fa-search"></i>&nbsp;검색</button>
	      <button id="resetBtn" class="searchBoxbtns" type="button"><i class="fas fa-eraser"></i>&nbsp;초기화</button>
      </div>
</div>
</div>

<%-- 결과데이터 출력테이블 --%>
<div class="board_t2">
   <%-- 결과테이블상단머리부 --%>
   <div class="mState">
      <div class="gLeft">
         <p class="total">
            &nbsp;총<strong style="color: black;">&nbsp;<%=total %></strong>건&nbsp;중&nbsp;[검색결과&nbsp;<strong><%= searchTotal %></strong>건]
         </p>
      </div>
      <div class="gRight">
        <select class="fSelect" id="sort" name="sort">
			<option value="ORDER_DATE DESC" <%if (sort.equals("ORDER_DATE DESC")) {%> selected <%}%>>주문일(최신순)</option>
			<option value="ORDER_DATE ASC" <%if (sort.equals("ORDER_DATE ASC")) {%> selected <%}%>>주문일(오래된순)</option>
			<option value="ORDER_TOTAL DESC" <%if (sort.equals("ORDER_TOTAL DESC")) {%> selected <%}%>>높은주문금액순</option>
			<option value="ORDER_TOTAL ASC" <%if (sort.equals("ORDER_TOTAL ASC")) {%> selected <%}%>>낮은주문금액순</option>
			<option value="ID ASC" <%if (sort.equals("ID ASC")) {%> selected <%}%>>아이디 순</option>
			<option value="PRODUCT_NAME ASC" <%if (sort.equals("PRODUCT_NAME ASC")) {%> selected <%}%>>상품명 순</option>
		</select>&nbsp;
		<select class="fSelect" id="rows" name="rows">
            <option value="10" <% if(pageSize==10){ %> selected <% } %>>10개씩보기</option>
            <option value="30" <% if(pageSize==30){ %> selected <% } %>>30개씩보기</option>
            <option value="50" <% if(pageSize==50){ %> selected <% } %>>50개씩보기</option>
            <option value="100" <%if (pageSize == 100) {%> selected <%}%>>100개씩보기</option>
         </select>
      </div>
   </div>
   
   <%-- 테이블상단박스 --%>
   <div class="mCtrl">
      <div>
      <i class="fas fa-check" style="color: red;"></i>&nbsp;선택한 주문의 상태를&nbsp;
       <select class="fSelect" name="orderStatusBotttom">
          <option value="0" selected>주문상태</option>
         <option value="empty1" disabled="disabled">---------------</option>
          <option value="1" >결제대기</option>
             <option value="2" >결제완료</option>
             <option value="3" >배송준비중</option>
             <option value="4" >배송중</option>
             <option value="5" >배송완료</option>
             <option value="6" >구매확정</option>
             <option value="empty1" disabled="disabled">---------------</option>
          <option value="10" >취소요청</option>
             <option value="11" >취소완료</option>
             <option value="20" >교환요청</option>
             <option value="21" >교환완료</option>
             <option value="30" >환불요청</option>
             <option value="31" >환불완료</option>
        </select>&nbsp;<button type="button" id="changeStatusBtn" style="border: 1px solid gray; background: white; padding: 5px;">일괄처리</button>
      </div><div id="message" style="color: red;"></div>
   </div>
   
   <div class="mBoard">
      <table class="admin_t">
         <thead>
            <tr>
               <th><input type="checkbox" id="checkAll"></th>
               <th>주문일시</th>
               <th>주문번호</th>
               <th>주문자(ID)</th>
               <th>주문상품</th>
               <th>총 주문금액</th>
               <th>결제수단</th>
               <th>결제상태</th>
               <th>배송상태</th>
               <th>취소요청</th>
               <th>교환요청</th>
               <th>환불요청</th>
            </tr>
         </thead>
         <%-- 검색내용출력 --%>
         <tbody>
         	<%-- <%MemberDTO member=null; %> --%>
            <%if(orderList.isEmpty()){ %>
               <tr>
                  <td colspan="13">검색된 주문이 존재하지 않습니다.</td>
               </tr>
            <%} else { %>
               <%for (OrderDTO order:orderList){ %>
              <%--  <% member=MemberDAO.getMemberDAO().selectIdMember(order.getId()); %> --%>
                  <tr>
                     <td><input type="checkbox" class="check" name="checkOrder" value="<%=order.getOrderNum()%>"><input type="hidden" name="adminMemo" value="NONE"></td>
                     <td><%=order.getOrderDate().substring(0, 19) %></td>
                     <td><a href="<%=request.getContextPath() %>/admin_template/index.jsp?part=order&work=detail&orderNum=<%=order.getOrderNum() %>&orderNo=<%=order.getOrderNo() %>" style="text-decoration: underline; color: #F15F5F;"><%=order.getOrderNum()%></a></td>
                     <td><%= order.getName() %>(<%=order.getId() %>)</td>
                     <td><%=order.getProductName()%></td>
                     <td><%=DecimalFormat.getCurrencyInstance().format(order.getOrderTotal())%></td>
                     <td><%if(order.getPaymentMethod()==1){ %>무통장입금<%} else { %>신용카드<%} %></td>
                     <td><%if (order.getOrderStatus()==1) {%>결제대기<%} else {%>결제완료<%}%></td>
                     <td><%if (order.getOrderStatus()==3) {%>배송준비중<%} else if (order.getOrderStatus()==4) {%>배송중<%} else if (order.getOrderStatus()==5) {%>배송완료<%} else if (order.getOrderStatus()==6) {%>구매확정<%} else {%>-<%} %></td>
                     <td><%if (order.getOrderStatus()==10) {%><i class="fas fa-exclamation-circle"></i>취소요청<%} else if (order.getOrderStatus()==11) { %>취소완료<%} else {%>-<%} %> </td>
                     <td><%if (order.getOrderStatus()==20) {%><i class="fas fa-exclamation-circle"></i>교환요청<%} else if (order.getOrderStatus()==21) { %>교환완료<%} else {%>-<%}%> </td>
                     <td><%if (order.getOrderStatus()==30) {%><i class="fas fa-exclamation-circle"></i>환불요청<%} else if (order.getOrderStatus()==31) { %>환불완료<%} else {%>-<%}%> </td>
                  </tr>
               <%} %>
            <%} %>
         </tbody>
      </table> 
         
   </div>
   
   <%-- 페이징처리 --%>
   <%-- (search, keyword, startDay, endDay, paymentMethod, orderStatus) --%>
   <div class="mPaginate">
   <%if (startPage > blockSize) {%>
      <a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&pageNum=1&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&paymentMethod=<%=paymentMethod %>&orderStatus=<%=orderStatus %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-double-left"></i></a> 
      <a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&pageNum=<%=startPage - blockSize%>&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&paymentMethod=<%=paymentMethod %>&orderStatus=<%=orderStatus %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-left"></i></a>&nbsp;
   <%} else {%>
      <a href="#none" class="btnNormal"><i class="fas fa-angle-double-left"></i></a> 
      <a href="#none" class="btnNormal"><i class="fas fa-angle-left"></i>&nbsp;</a>
   <%}%>

   <%for (int i = startPage; i <= endPage; i++) {%>
      <%if (pageNum != i) {%>
         <a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&pageNum=<%=i%>&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&paymentMethod=<%=paymentMethod %>&orderStatus=<%=orderStatus %>&sort=<%=sort %>" class="btnNormal"><%=i%></a>&nbsp;
      <% } else { %>
         &nbsp;<a href="" class="btnNormal"><%=i%></a>&nbsp;
      <% } %>
   <% } %>


   <% if (endPage != totalPage) { %>
      <a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&pageNum=<%=startPage + blockSize%>&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&paymentMethod=<%=paymentMethod %>&orderStatus=<%=orderStatus %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-right"></i></a> 
      <a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&pageNum=<%=totalPage%>&pageSize=<%=pageSize%>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&paymentMethod=<%=paymentMethod %>&orderStatus=<%=orderStatus %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
   <% } else {%>
      <a href="#" class="btnNormal"><i class="fas fa-angle-right"></i></a> 
      <a href="#" class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
   <% } %>
   </div>
</div>
</form>




<script type="text/javascript">

/* 날짜버튼 클릭 */
$(".btnDate").click(function() {
	if ($(".btnDate.selected").length == 1) {
      $(".btnDate").removeClass("selected");
      $(this).addClass("selected");
      
      var today = new Date();
      today.setDate(-$(this).attr("title")+12);
      var dd = today.getDate();
      var mm = today.getMonth()+1; 
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

/* 검색 : 상태체크박스 */
$("#checkAllPay").change(function(){
   if($(this).is(":checked")){
      $(".checkPay").prop("checked", true);
   } else {
      $(".checkPay").prop("checked", false);
   }
});
$("#checkAllDelivary").change(function(){
   if($(this).is(":checked")){
      $(".checkDelivary").prop("checked", true);
   } else {
      $(".checkDelivary").prop("checked", false);
   }
});
$("#checkAllCS").change(function(){
   if($(this).is(":checked")){
      $(".checkCS").prop("checked", true);
   } else {
      $(".checkCS").prop("checked", false);
   }
});
$("#checkAll").change(function(){
   if($(this).is(":checked")){
      $(".check").prop("checked", true);
   } else {
      $(".check").prop("checked", false);
   }
});

$("#rows").change(function() {
   	var rows=$("#rows option:selected").val();
   	var sort=$("#sort option:selected").val();
   	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&pageNum=<%=pageNum%>&pageSize="+rows+"&sort="+sort;
});
 
$("#sort").change(function() {
  	var sort=$("#sort option:selected").val();
  	var rows=$("#rows option:selected").val();
  	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&pageNum=<%=pageNum%>&pageSize="+rows+"&sort="+sort;
});

// 검색서브밋 전 체크사항
$("#searchForm").submit(function() {
	if($("#search option:eq(0)").is(":selected") && $("#keyword").val()!=""){
		$("#searchMessage").text("입력하신 검색어에 해당하는 검색 종류를 선택해주세요.");
		$("#search").focus();
		return false;
	} 
 	var numOnlyReg=/\d{1,17}/;
	if(!numOnlyReg.test($("#keyword").val()) && $("#search option:eq(2)").is(":selected")) {
		$("#searchMessage").text("주문번호는 숫자만 입력가능합니다.");
		$("#keyword").focus();
		return false;
	}
		if(!numOnlyReg.test($("#keyword").val()) && $("#search option:eq(3)").is(":selected")) {
		$("#searchMessage").text("운송장 번호는 숫자만 입력가능합니다.");
		$("#keyword").focus();
		return false;
	} 
	var phoneReg=/^(\d{1~3})-/g;
	if(!phoneReg.test($("#keyword").val()) && $("#search option:eq(9)").is(":selected")) {
		$("#searchMessage").text("전화번호는 숫자와 '-'기호만 입력가능합니다.");
		$("#keyword").focus();
		return false;
	} 
});
$("#resetBtn").click(function() {
	$("#keyword").focus();
	$("#search option:eq(0)").prop("selected", true);
	$("#keyword").val("");
	$(".payMethod").prop("checked", true);
    $("#searchMessage").text("");
    $(".checkPay").prop("checked", false);
    $(".checkDelivary").prop("checked", false);
    $(".checkCS").prop("checked", false);
	$("#searchMessage").text("");
	$("#ALLPeriod").click();
	$("#startDay").val("");
	$("#endDay").val("");
});

//일괄처리버튼
$("#changeStatusBtn").click(function() {
   if($(".check").filter(":checked").size()==0){
      $("#message").text("선택된 주문이 없습니다.");
      return;
   } else {
      $("#searchForm").attr("method", "post");
      $("#searchForm").attr("action", "<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=main_modify_action");
      $("#searchForm").submit();
   }
});

$("#rows").change(function() {
  	var rows=$("#rows option:selected").val();
  	location.href="<%= request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&pageNum=<%=pageNum%>&pageSize="+rows;
 });

</script>