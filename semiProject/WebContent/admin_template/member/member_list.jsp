<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="semiProject.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
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
	
	String startDay = request.getParameter("startDay");
	if (startDay == null)startDay ="";
	
	String endDay = request.getParameter("endDay");
	if (endDay == null)endDay = "";
	
	String search = request.getParameter("search");
	if (search == null)search = "";
	
	String keyword = request.getParameter("keyword");
	if (keyword == null)keyword = "";
	
	String sort = request.getParameter("sort");
	if(sort==null)sort="join_date DESC";
	
	String dateAttr=request.getParameter("dateAttr");
	if(dateAttr == null)dateAttr ="All";
	
	int status =1;
	if(request.getParameter("status")!=null){
		status=Integer.parseInt(request.getParameter("status"));
	}
	
	int pageNum=1;
	
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize=10;
	
	if(request.getParameter("pageSize")!=null){
		pageSize=Integer.parseInt(request.getParameter("pageSize"));
	}
	
	int total=MemberDAO.getMemberDAO().selectMemberCount();
	
	int totalMember=MemberDAO.getMemberDAO().selectMemberCount(search, keyword, startDay, endDay, status);
	
	int totalPage=(int)Math.ceil((double)totalMember/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage){
		pageNum=1;
	}
	
	int startRow=(pageNum-1)*pageSize+1;
	int endRow=pageNum*pageSize;
	
	if(endRow>totalMember){
		endRow=totalMember;
	}
	
	List<MemberDTO> memberList=MemberDAO.getMemberDAO().selectAllMember(search, keyword, startRow, endRow, startDay, endDay, status, sort);
			
	int number=totalMember-(pageNum-1)*pageSize;
	
	
%>    

<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<p class="for_title" style="margin-top: 100px;">&nbsp;&nbsp;<i class="fas fa-wine-glass-alt"></i>&nbsp;회원관리 목록</p> 
<style type="text/css">
	 
</style>

<form method="post" id="searchForm">
	<div class="board_t1">
             <table class="admin_t">
                <tbody>
               	 <tr>
                   <th>검색어</th>
                   
                   <td colspan="3">
                       <select class="fSelect" id="search" name="search" style="width:163px;">
                  			<option value="NONE" selected>검색선택</option>
                    		<option value="empty1" disabled="disabled">---------------</option>
                            <option value="name" <%if(search.equals("name")){ %>selected<%} %>>이름</option>
                            <option value="id" <%if(search.equals("member_id")){ %>selected<%} %>>아이디</option>
                            <option value="email" <%if(search.equals("email")){ %>selected<%} %>>이메일</option>
                            <option value="phone" <%if(search.equals("mobile")){ %>selected<%} %>>휴대폰번호</option>
                       </select>
                       <input type="text" class="fText sBaseSearchBox" name="keyword" id="keyword" value="<%=keyword%>" style="width:400px;">
                   </td>
              	 </tr>
               <%--
            	 <tr>
            	 	 
                     <th>구매금액/건수</th>
                     <td colspan="3">
                           <select name="sales_type" onchange="checkBtn()" class="fSelect">
                                <option value="" selected>전체</option>
                                <option value="3">총 주문금액</option>
                                <option value="4">총 실결제금액</option>
                                <option value="2">총 주문건수</option>
                                <option value="5">총 실주문건수</option>
                           </select>
                      </td>
                     
				 </tr>
				 --%>
			
             	 <tr>
                  	<th>회원가입일</th>
                		<td colspan="1">
                		<input type="hidden" value="" class="dateAttr" name="dateAttr" />
                       	<a title="1" class="btnDate <%if(dateAttr.equals("1")){%>selected<%}%>"><span>오늘</span></a> 
						<a title="7" class="btnDate <%if(dateAttr.equals("7")){%>selected<%}%>"><span>7일</span></a> 
						<a title="30" class="btnDate <%if(dateAttr.equals("30")){%>selected<%}%>"><span>1개월</span></a> 
						<a title="90" class="btnDate <%if(dateAttr.equals("90")){%>selected<%}%>"><span>3개월</span></a> 
						<a title="180" class="btnDate <%if(dateAttr.equals("180")){%>selected<%}%>"><span>6개월</span></a>
						<a title="365" class="btnDate <%if(dateAttr.equals("365")){%>selected<%}%>"><span>1년</span></a>
						<a title="All" id="ALLPeriod" class="btnDate <%if(dateAttr.equals("All")){%>selected<%}%>"><span>전체</span></a> &nbsp;&nbsp;  
                         <input type="date" value="<%=startDay %>" id="startDay"  name="startDay" class="fSelect"> 
                         &nbsp;~&nbsp; 
                         <input type="date" value="<%=endDay %>" id="endDay" name="endDay" class="fSelect">
                        </td>
                        <th>회원상태</th>
	            	 	<td colspan="1">
	            	 		 <select class="fSelect" id="status" name="status" style="width:163px;">
	                            <option value="10" <%if(status==10){ %>selected<%} %>>전체회원</option>
	                            <option value="1" <%if(status==1){ %>selected<%} %>>일반회원</option>
	                            <option value="0" <%if(status==0){ %>selected<%} %>>삭제회원</option>
	                            <option value="9" <%if(status==9){ %>selected<%} %>>관리자</option>
	                     	  </select>
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



         <div class="board_t2" >
            <!-- 데이터 출력 테이블 -->
            <div class="mState">
               <div class="gLeft">
                  <p class="total">
                     [총 회원수 <strong><%= total %></strong>건] 검색결과 <strong><%= totalMember %></strong> 건
                  </p>
               </div>
               <div class="gRight">
	              <select class="fSelect" id="sort" name="sort">
					<option value="join_date DESC" <%if (sort.equals("join_date DESC")) {%> selected <%}%>>기본정렬(최신순)</option>
					<option value="id ASC" <%if (sort.equals("id ASC")) {%> selected <%}%>>아이디 순</option>
					<option value="ADDRESS1 ASC" <%if (sort.equals("ADDRESS1 ASC")) {%> selected <%}%>>주소 순</option>
					<option value="last_login DESC" <%if (sort.equals("last_login DESC")) {%> selected <%}%>>최근 로그인 날짜 순</option>
				  </select>&nbsp;
                  <select class="fSelect" id="rows" name="rows">
                     <option value="10" <% if(pageSize==10){ %> selected <% } %>>10개씩보기</option>
                     <option value="30" <% if(pageSize==30){ %> selected <% } %>>30개씩보기</option>
                     <option value="50" <% if(pageSize==50){ %> selected <% } %>>50개씩보기</option>
                     <option value="100" <%if (pageSize == 100) {%> selected <%}%>>100개씩보기</option>
                  </select>
               </div>
            </div>
            <div class="mCtrl">
	            &nbsp;<a class="btnNormal removeAllBtn"><span><i class="fas fa-times" style="color: red;"></i> 전체삭제</span></a> 
				&nbsp;<a class="btnNormal removeBtn"><span><i class="fas fa-times" style="color: red;"></i> 삭제</span></a>
				<div id="message" style="color: red;"></div>
            </div>
            
            <div class="mBoard">
            <table class="admin_t">
               <thead>
                  <tr>
                     <th><input type="checkbox" class="allChk"></th>
                     <th>아이디</th>
                     <th>이름</th>
                     <th>이메일</th>
                     <th>전화번호</th>
                     <th>주소</th>
                     <th>회원가입한 날짜</th>
                     <th>마지막 로그인 날짜</th>
                     <th>회원등급</th>
                  </tr>
               </thead>
               <tbody>
               		<%if(totalMember==0){ %>
               		<tr>
               			<td colspan="11">검색된 회원정보가 하나도 없습니다.</td>
               		</tr>
               		<%}else{ %>
               			<% for(MemberDTO member:memberList){ %>
						<tr>
							<td><input type="checkbox" name="checkedId" class="rowChk" value="<%=member.getId()%>"></td>
							<td><a href="<%=request.getContextPath()%>/admin_template/member/member_orderProduct.jsp?id=<%=member.getId()%>" onclick="window.open(this.href,'orderProduct','width=1100,height=770'); return false;" style="text-decoration: underline; color:#F15F5F "><%=member.getId()%></a>
							<td><%=member.getName() %></td>
							<td><%=member.getEmail() %></td>
							<td><%=member.getPhone() %></td>
							<td>[<%=member.getZipcode() %>] <%= member.getAddress1() %> <%= member.getAddress2() %></td>
							<td><%=member.getJoin_date().substring(0,10) %></td>
							<td><% if(member.getLast_login()==null){ %>로그인 한 적이 없습니다.<%}else{ %><%=member.getLast_login()%><%} %></td>
							<td><% if(member.getStatus()==0){ %>삭제회원<%} else if(member.getStatus()==9){%>관리자<%}else{ %>일반회원<%} %></td>
						</tr>
	                  	<%} %>
	                  <%} %>
                  
               </tbody>
            </table> 
            </div>
            
            <div class="mCtrl">
            	<span>
		            &nbsp;<a class="btnNormal removeAllBtn"><span><i class="fas fa-times" style="color: red;"></i> 전체삭제</span></a> 
					&nbsp;<a class="btnNormal removeBtn"><span><i class="fas fa-times" style="color: red;"></i> 삭제</span></a>
				</span>
				<span style="float: right;">
					&nbsp;<a class="btnNormal" id="updateToMan"><span><i class="fas fa-user-edit"></i> 관리자로 변환</span></a>
					&nbsp;<a class="btnNormal" id="updateToDe"><span> 일반회원으로 변환</span></a>
				</span>
            </div>
            
            <div class="mPaginate">
            
            	<%
            		int blockSize=5;
            		int startPage=(pageNum-1)/blockSize*blockSize+1;
            		int endPage=startPage+blockSize-1;
            		if(endPage>totalPage){
            			endPage=totalPage;
            		}
            		
            	%>
               <!-- 페이지 이동  -->
               <%if(startPage>blockSize){ %>
	               <a href="<%= request.getContextPath()%>/admin_template/index.jsp?part=member&work=list&pageNum=1&pageSize=<%= pageSize %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-double-left"></i></a>
		           <a href="<%= request.getContextPath()%>/admin_template/index.jsp?part=member&work=list&pageNum=<%= startPage-blockSize %>&pageSize=<%= pageSize %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-left"></i></a>&nbsp;
               <%}else{ %>
	               <a href="#none" class="btnNormal"><i class="fas fa-angle-double-left"></i></a>
	               <a href="#none" class="btnNormal"><i class="fas fa-angle-left"></i>&nbsp;</a>
               <%} %>
               
               <% for(int i=startPage; i<=endPage; i++){ %>
					<% if(pageNum!=i){ %>
						 <a href="<%= request.getContextPath()%>/admin_template/index.jsp?part=member&work=list&pageNum=<%= i%>&pageSize=<%= pageSize %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %>" class="btnNormal"><%= i %></a>&nbsp;
					<% } else{ %>
						&nbsp;<a href="" class="btnNormal"><%= i %></a>&nbsp;
					<%} %>
				<% } %>
               
               
               <%if(endPage!=totalPage){ %>
	               <a href="<%= request.getContextPath()%>/admin_template/index.jsp?part=member&work=list&pageNum=<%= startPage+blockSize %>&pageSize=<%= pageSize %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-right"></i></a>
		           <a href="<%= request.getContextPath()%>/admin_template/index.jsp?part=member&work=list&pageNum=<%= totalPage %>&pageSize=<%= pageSize %>&search=<%= search%>&keyword=<%= keyword%>&startDay=<%=startDay %>&endDay=<%=endDay %>&status=<%=status %>&sort=<%=sort %>" class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
               <%}else{ %>
		           <a href="#none" class="btnNormal"><i class="fas fa-angle-right"></i></a>
		           <a href="#none" class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
               <%} %>
            </div>
            <div id="message" style="color: red; text-align: center;"></div>
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
      
	$(".removeAllBtn").click(function() {
	if(confirm("정말로 모든 회원들을 삭제하시겠습니까?")){
		$(".rowChk").prop("checked", true);
		$("#searchForm").attr("method","post");
		$("#searchForm").attr("action","<%=request.getContextPath()%>/admin_template/index.jsp?part=member&work=removes_action");
		$("#searchForm").submit();
		}
	});
	  
	  
	$(".removeBtn").click(function(){
		if($(".rowChk").filter(":checked").size()==0){
			$("#message").text("선택한 회원이 하나도 없습니다.");
			return;
		}else if(confirm("정말로 선택한 회원들을 삭제하시겠습니까?")){
			$("#searchForm").attr("method","post");
			$("#searchForm").attr("action","<%=request.getContextPath()%>/admin_template/index.jsp?part=member&work=removes_action");
			$("#searchForm").submit();
		}
	});
	
	$("#updateToDe").click(function(){
		if($(".rowChk").filter(":checked").size()==0){
			$("#message").text("선택한 회원이 하나도 없습니다.");
			return;
		}else if(confirm("정말로 선택한 회원들을 일반회원으로 변환시키겠습니까?")){
			$("#searchForm").attr("method","post");
			$("#searchForm").attr("action","<%=request.getContextPath()%>/admin_template/index.jsp?part=member&work=Default_action");
			$("#searchForm").submit();
		}
	});
	
	$("#updateToMan").click(function(){
		if($(".rowChk").filter(":checked").size()==0){
			$("#message").text("선택한 회원이 하나도 없습니다.");
			return;
		}else if(confirm("정말로 선택한 회원들을 관리자로 전환시키겠습니까?")){
			$("#searchForm").attr("method","post");
			$("#searchForm").attr("action","<%=request.getContextPath()%>/admin_template/index.jsp?part=member&work=Manager_action");
			$("#searchForm").submit();
		}
	});
	
	
	      
      
      /* 페이지 보기(10개 50개 등) 셀렉문 선택시 이벤트 */
      
      
      $("#rows").change(function() {
       	var rows=$("#rows option:selected").val();
       	var sort=$("#sort option:selected").val();
       	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=member&work=list&pageNum=<%=pageNum%>&pageSize="+ rows+"&sort="+sort;
  	});
     
     $("#sort").change(function() {
      	var sort=$("#sort option:selected").val();
      	var rows=$("#rows option:selected").val();
      	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=member&work=list&pageNum=<%=pageNum%>&pageSize="+rows+"&sort="+sort;
  	});
      
    
	// $(".orderProduct").click(function() {
	// 	window.open("<%=request.getContextPath()%>/admin_template/member/member_orderProduct.jsp?id="+$(".orderProductTo").val(),"orderProduct","width=1100,height=770");
	// });

     
	
	// 검색서브밋 전 체크사항
	$("#seachForm").submit(function() {
	   //if(orderStatus)
	});
	$("#resetBtn").click(function() {
		$("#keyword").focus();
		$("#search option:eq(0)").prop("selected", true);
		$("#keyword").val("");
		$("#status option:eq(0)").prop("selected", true);
		$("#ALLPeriod").click();
		$("#startDay").val("");
		$("#endDay").val("");
		$("#searchMessage").text("");
	});

      
      
   </script>
