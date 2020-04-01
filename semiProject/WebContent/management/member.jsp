<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member</title>
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
            <h1 style="font-size: 2.2em;">고객 관리</h1>
         </li>

         <li class="board_t1">
            <form action="">
               <table>
                  <tbody>
                 	 <tr>
	                    <th>검색어</th>
	                    <td colspan="3">
	                        <select class="fSelect" name="MSK[]" style="width:163px;">
                              <option value="">- 선택 -</option>
                              <option value="name">이름</option>
                              <option value="member_id" selected>아이디</option>
                              <option value="email">이메일</option>
                              <option value="mobile">휴대폰번호</option>
                            </select>
	                    </td>
	                </tr>
	                
	                <tr>
                       <th>구매금액/건수</th>
                       <td>
                          <div style="float:left;">
                              <select name="sales_type" onchange="checkBtn()" class="fSelect">
                                  <option value="" selected>전체</option>
                                  <option value="3">총 주문금액</option>
                                  <option value="4">총 실결제금액</option>
                                  <option value="2">총 주문건수</option>
                                  <option value="5">총 실주문건수</option>
                              </select>
                          </div>
                        </td>
	 					<th>주문상품</th>
						<td>
							<input type="text" name="sOrderPrdtName" value="" class="fText" style="width:160px;">
							<a href="#none" class="btnNormal" ><span>초기화</span></a>
							<a class="btnNormal" onClick="window.open('select.html', '상품찾기', 'width=700, height=900'); return false;"><span>상품검색▶</span></a>
						</td>      
					</tr>
					
					
	                <tr>
                    	<th>주문일/결제완료일 </th>
                  		<td colspan="3">
                            <select name="date_type" style="width:115px;" class="fSelect disabled">
                               <option value="order_date" selected="selected">주문일</option>
                               <option value="pay_date">결제완료일</option>
                     		</select>
                           &nbsp;&nbsp; 
                           <input type="date" value="<!-- 오늘날짜 함수 -->" class="fSelect"> 
                           &nbsp;~&nbsp; 
                           <input type="date" value="<!-- 오늘날짜 함수+1달(아무기간) -->" class="fSelect">
	                   </td>
	                </tr>
	                
	                <tr>
						<th>SMS수신</th>
						<td>
						    <label class="gLabel eSelected">
						    	<input type="radio" name="is_sms" value="1" class="fChk" checked="checked"> 전체
						    </label>
						    <label class="gLabel">
						    	<input type="radio" name="is_sms" value="2" class="fChk"> 수신허용
						    </label>
						    <label class="gLabel">
						   		 <input type="radio" name="is_sms" value="3" class="fChk"> 수신안함
						    </label>
						</td>   				
						<th>이메일수신</th>
						<td>
						    <label class="gLabel eSelected">
						   		 <input type="radio" name="is_news_mail" value="1" class="fChk" checked="checked"> 전체
						    </label>
						    <label class="gLabel">
						    	<input type="radio" name="is_news_mail" value="2" class="fChk"> 수신허용
						    </label>
						    <label class="gLabel">
						    	<input type="radio" name="is_news_mail" value="3" class="fChk"> 수신안함
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
            <h2>회원 목록</h2>
            <div class="mState">
               <div class="gLeft">
                  <p class="total">
                     [총 회원수 <strong>8</strong>건] 검색결과 <strong>3</strong> 건
                  </p>
               </div>
               <div class="gRight">
                  <select class="fSelect" id="" name="">
                     <option value="20">20개씩보기</option>
                     <option value="30">30개씩보기</option>
                     <option value="50">50개씩보기</option>
                  </select>
               </div>
            </div>

            <div class="mCtrl">
            </div>
            
            <div class="mBoard">
            <table>
               <thead>
                  <tr>
                     <th><input type="checkbox" class="allChk"></th>
                     <th>주문일(결제일)</th>
                     <th>주문번호</th>
                     <th>주문자</th>
                     <th>상품명</th>
                     <th>총 결제금액</th>
                     <th>결제수단</th>
                     <th>결제상태</th>
                     <th>배송상태</th>
                     <th>취소</th>
                     <th>교환</th>
                     <th>반품</th>
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