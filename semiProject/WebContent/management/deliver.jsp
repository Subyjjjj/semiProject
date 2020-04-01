<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delivery</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/management/m_css.css">

<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
   
<script src="https://kit.fontawesome.com/76211070e2.js"></script>      <!-- icon 이미지 출력하기 위한 링크 -->

<style type="text/css">
</style>

</head>
<body>

   <section>
      <ul>
         <li style="margin: 40px 0 25px; background: #ecf0f7">
            <h1 style="font-size: 2.2em;">배송 관리</h1>
         </li>

         <li class="board_t1">
            <form action="">
               <table>
                  <tbody>
                 	 <tr>
	                    <th>검색어</th>
	                    <td colspan="3">
	                        <select class="fSelect" name="MSK[]" style="width:163px;">
                                <option value="choice">-검색항목선택-</option>
                                <option value="order_id" selected>주문번호</option>
                                <option value="ord_item_code">품목별 주문번호</option>
                                <option value="delivery_code">배송번호</option>
                                <option value="invoice_no">운송장번호</option>
                                <option value="line1">-----------------</option>
                                <option value="o_name">주문자명</option>
                                <option value="member_id">주문자 아이디</option>
                                <option value="o_phone2">주문자 휴대전화</option>
                                <option value="line2">-----------------</option>
                                <option value="c_p_name">입금자명</option>
                                <option value="r_name">수령자명</option>
                                <option value="r_phone2">수령자 휴대전화</option>
                                <option value="r_addr">배송지 주소</option>
                                <option value="ord_add_item">주문서 추가항목</option>
                            </select>
                            <input type="text" class="fText sBaseSearchBox" name="MSV[]" id="sBaseSearchBox" style="width:400px;">
                            <a href="#none" class="btnIcon icoPlus"><span>추가</span></a>
	                    </td>
	                </tr>
	                
	                <tr>
                    	<th> 기간 </th>
                  		<td colspan="3">
                              <select name="date_type" style="width:115px;" class="fSelect disabled">
                                <option value="order_date" selected="selected">주문일</option>
                                <option value="pay_date">결제일</option>
                                <option value="shipready_date">송장번호입력일</option>
                                <option value="shipbegin_date">배송시작일</option>
                                <option value="shipend_date">배송완료일</option>
                      		  </select>
                              <a href="#none" class="btnDate" ><span>오늘</span></a>
                              <a href="#none" class="btnDate" ><span>어제</span></a>
                              <a href="#none" class="btnDate" ><span>3일</span></a>
                              <a href="#none" class="btnDate" ><span>7일</span></a>
                              <a href="#none" class="btnDate" ><span>15일</span></a>
                              <a href="#none" class="btnDate selected " ><span>1개월</span></a>
                              <a href="#none" class="btnDate" ><span>3개월</span></a>
                              <a href="#none" class="btnDate" ><span>6개월</span></a>
	                           &nbsp;&nbsp; 
	                           <input type="date" value="<!-- 오늘날짜 함수 -->" class="fSelect"> 
	                           &nbsp;~&nbsp; 
	                           <input type="date" value="<!-- 오늘날짜 함수+1달(아무기간) -->" class="fSelect">
	                   </td>
	                </tr>
	                
	                <tr>
                   	 <th>상품</th>
                     <td colspan="3">
                        <select class="fSelect" id="eProductSearchType" name="product_search_type" style="width:110px;">
                            <option value="product_name" selected="selected">상품명</option>
						    <option value="product_code">상품코드</option>
						    <option value="item_code">품목코드</option>
                        </select>
                        <input type="text" id="eOrderProductText" name="order_product_text" class="fText" style="width:490px;" value="">
                        <a href="#none" id="productSearchBtn" class="btnNormal"  onClick="window.open('select.jsp', '상품찾기', 'width=700, height=900'); return false;"><span>상품찾기 ▶</span></a>
	                   </td>
	                </tr>
	                
	                <tr>
	                    <th>입금상태</th>
	                    <td id="depositStatus">
                           <label class="gLabel">
                          		 <input type="radio" name="orderStatusPayment" class="fChk" value="all"> 전체
                           </label>
                           <label class="gLabel eSelected">
                          		 <input type="radio" name="orderStatusPayment" class="fChk" value="F" checked="checked"> 입금전
                           </label>
                           <label class="gLabel">
                         		  <input type="radio" name="orderStatusPayment" class="fChk" value="M"> 추가입금대기
                           </label>
                           <label class="gLabel">
                          		 <input type="radio" name="orderStatusPayment" class="fChk" value="T"> 입금완료(수동)
                           </label>
                           <label class="gLabel">
                           		<input type="radio" name="orderStatusPayment" class="fChk" value="A"> 입금완료(자동)
                           </label>
	               		</td>
	
	                    <th>입금은행</th>
	                    <td>
	                        <select class="fSelect" name="bank_info" id="bank_info" style="max-width:100%;">
		                        <option value="0">전체</option>
		                        <option value="bank_04:1234000123">국민은행 : 1234000123 (홍길동)</option>
	                        </select>
	                    </td>
               		 </tr>
                     
                     <tr>
                        <th>회원구분</th>
                        <td colspan="3">
					    <label class="gLabel eSelected">
					    	<input type="radio" name="memberType" class="fChk" value="1" checked="checked"> 전체
					    </label>
					    <label class="gLabel">
					    	<input type="radio" name="memberType" value="2" class="fChk"> 회원
					    </label>
					    <label class="gLabel">
					    	<input type="radio" name="memberType" value="3" class="fChk"> 비회원
					    </label>
					    </td>      
    				 </tr>
		                
		                
                  </tbody>
               </table>
               <!-- 위 테이블 조건에 대한 검색 기능 구현 버튼  -->
               <div style="text-align: center;">
                  <a href="" class="btnSearch"><span
                     style="padding: 10px; font-size: 17px;">검색</span></a>
               </div>
            </form>
         </li>



         <li class="board_t2" >
            <!-- 데이터 출력 테이블 -->
            <div class="mState">
               <div class="gLeft">
                  <p class="total">
                     [검색결과 <strong>8</strong>건] 
                  </p>
               </div>
               <div class="gRight">
                  <select name="searchSorting" class="fSelect">
                     <option value="order_asc">주문일순</option>
                     <option value="order_desc" selected="selected">주문일역순</option>
                     <option value="pay_amount_asc">입금액순</option>
                     <option value="pay_amount_desc">입금액역순</option>
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
               &nbsp;<a href="#none" class="btnNormal deliverybtn"><span> 입금확인</span></a> &nbsp;
               <a href="#none" class="btnNormal deliverybtn" ><span>주문취소</span></a>
            </div>
            
            <div class="mBoard">
            <table>
               <thead>
                  <tr>
                     <th><input type="checkbox" class="allChk"></th>
                     <th>주문일</th>
                     <th>주문번호</th>
                     <th>상품명</th>
                     <th>주문자</th>
                     <th>총 상품구매금액</th>
                     <th>총 주문금액</th>
                     <th>총 실결제금액</th>
                     <th>입금자</th>
                     <th>입금액</th>
                     <th>입금은행</th>
                     <th>처리여부</th>
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
                     <td></td>
                     <td></td>
                     <td></td>
                     <td></td>
                     <td></td>
                     <td></td>
                  </tr>
                  
               </tbody>
            </table>
            </div>
             
            <div class="mCtrl">
                   &nbsp;<a href="#none" class="btnNormal deliverybtn" ><span> 입금확인</span></a> &nbsp;
               <a href="#none" class="btnNormal deliverybtn"><span>주문취소</span></a>
            </div>
            
            <div class="mPaginate">
               <!-- 페이지 이동  -->
               <a href="#none" ><i class="fas fa-angle-double-left"></i></a>
               <a href="#none" ><i class="fas fa-angle-left"></i></a>&nbsp;
               <a href=""><span> <!-- 페이지 번호 들어갈 곳  -->1 </span></a>
               &nbsp;<a href="#none" ><i class="fas fa-angle-right"></i></a>
               <a href="#none"><i class="fas fa-angle-double-right"></i></a>
                </div>
            
         </li>
      </ul>
   </section>


   <script type="text/javascript">
      /* 1일 3일 등 버튼 눌를때 이벤트 */
      $("a").click(function() {
         if ($("a.selected").length == 0) {
            $(this).addClass("selected");
         } else {
            $(this).removeClass("selected");
         }
      });
   </script>

</body>
</html>