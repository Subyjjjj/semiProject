<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
	<div id="orderStatusBar">
		<ul>
			<li><a class="select">전체주문</a></li>
			<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=BF">입금대기</a></li>
			<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=CF">입금완료</a></li>
			<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=prepare">배송준비</a></li>
			<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=delivery">배송중</a></li>
			<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=arrive">배송완료</a></li>
			<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=confirm">구매확정</a></li>
			<li><a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=cancel">취소/교환/환불</a></li>
		</ul>
	</div>
	<hr>
	
	
	<p class="for_title">상품관리목록</p> 
		
	<div id="searchBox">
     <div class="board_t1" >
            <form action="">
               <table class="admin_t">
                  <tbody>
                 	 <tr>
	                    <th>검색어</th>
	                    <td colspan="3">
	                        <select class="fSelect eSearch" name="eField[]">
	                              <option value="product_name">상품명</option>
	                              <option value="product_no">상품번호</option>
	                              <option value="product_code">상품코드</option>
                            </select>
                            <input type="text" class="fText sBaseSearchBox" name="MSV[]" id="sBaseSearchBox" style="width:400px;">
                            <a href="#none" class="btnIcon icoPlus abtn"><span>추가</span></a>
	                    </td>
	                </tr>
	                
	                <tr>
                    	<th> 상품등록일 </th>
                  		<td colspan="3">
                              <a href="#none" class="btnDate" ><span>오늘</span></a>
                              <a href="#none" class="btnDate " ><span>3일</span></a>
                              <a href="#none" class="btnDate " ><span>7일</span></a>
                              <a href="#none" class="btnDate selected " ><span>1개월</span></a>
                              <a href="#none" class="btnDate " ><span>3개월</span></a>
                              <a href="#none" class="btnDate " ><span>1년</span></a>
                              <a href="#none" class="btnDate " ><span>전체</span></a>
	                           &nbsp;&nbsp; 
	                           <input type="date" value="<!-- 오늘날짜 함수 -->" class="fSelect"> 
	                           &nbsp;~&nbsp; 
	                           <input type="date" value="<!-- 오늘날짜 함수+1달(아무기간) -->" class="fSelect">
	                   </td>
	                </tr>
	                
                  </tbody>
               </table>
               <!-- 위 테이블 조건에 대한 검색 기능 구현 버튼  -->
               <div style="text-align: center;">
                  <a href="" class="btnSearch "><span
                     style="padding: 10px; font-size: 17px;"><i class="fas fa-search"></i>&nbsp;검색</span></a>
               </div>
            </form>
       </div>



         <div class="board_t2">
            <!-- 데이터 출력 테이블 -->
            <div class="mState">
               <div class="gLeft">
                  <p class="total">
                     [총 <strong>8</strong>개]
                  </p>
               </div>
               <div class="gRight">
                  <select class="fSelect" name="orderby">
                  	<option value="regist_d">등록일 역순</option>
                  	<option value="regist_a">등록일 순</option>
                  	<option value="empty1" disabled="disabled">---------------</option>
                  	<option value="name_d">상품명 역순</option>
                  	<option value="name_a">상품명 순</option>
                  	<option value="empty3" disabled="disabled">---------------</option>
                  	<option value="price_d">판매가 역순</option>
                  	<option value="price_a">판매가 순</option>
                  </select>
                   <select class="fSelect" id="" name="">
                     <option value="10" selected>10개씩보기</option>
                     <option value="20">20개씩보기</option>
                     <option value="30">30개씩보기</option>
                     <option value="50">50개씩보기</option>
                     <option value="100">100개씩보기</option>
                  </select>
               </div>
            </div>

            <div class="mCtrl">
             &nbsp;<a href="#none" class="btnNormal"><span><i class="fas fa-times" style="color: red;"></i> 삭제</span></a> 
              |&nbsp;<a href="#none" class="btnNormal"><span> 판매변경</span></a>
              |&nbsp;<a href="#none" class="btnNormal"><span> 상품등록</span></a>
            </div>
            
            <div class="mBoard">
	            <table class="admin_t">
	               <thead>
	                  <tr>
	                     <th><input type="checkbox" class="allChk"></th>
	                     <th>상품명</th>
	                     <th>상품코드</th>
	                     <th>판매가</th>
	                     <th>판매상태</th>
                       	 <th>옵션</th>
	                  </tr>
	               </thead>
	               <tbody>
	                  <tr>
	                     <td><input type="checkbox" name="bbs_no[]"class="rowChk"></td>
	                     <td>2</td>
	                     <td>와인시음회</td>
	                     <td>최태휘</td>
	                     <td>2020-01-11</td>
	                     <td></td>
	                  </tr>
	                  
	               </tbody>
	            </table> 
	        </div>
            <div class="mCtrl">
	             &nbsp;<a href="#none" class="btnNormal"><span><i class="fas fa-times" style="color: red;"></i> 삭제</span></a> 
	              |&nbsp;<a href="#none" class="btnNormal"><span> 판매변경</span></a>
	              |&nbsp;<a href="#none" class="btnNormal"><span> 상품등록</span></a>
            </div>
            
            <div class="mPaginate">
               <!-- 페이지 이동  -->
               <a href="#none" class="btnNormal" ><i class="fas fa-angle-double-left"></i></a>
               <a href="#none" class="btnNormal" ><i class="fas fa-angle-left"></i></a>&nbsp;
               <a href=""><span> <!-- 페이지 번호 들어갈 곳  -->1 </span></a>
               &nbsp;<a href="#none"  class="btnNormal"><i class="fas fa-angle-right"></i></a>
               <a href="#none" class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
                </div>
            
        </div>
   </div>


   <script type="text/javascript">
      /* 1일 3일 등 버튼 눌를때 이벤트 */
      $(".btnDate").click(function() {
	      if ($(".btnDate.selected").length == 1) {
	         $(".btnDate").removeClass("selected");
	         $(this).addClass("selected");
	      } else if($(".btnDate.selected").length==0) {
	         $(this).addClass("selected");
	      }
 	  });
      
      
      
   </script>

