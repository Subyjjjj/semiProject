<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>select</title>

   
<link href="<%=request.getContextPath()%>/admin_template/css/m_css.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/76211070e2.js"></script>  

<style type="text/css">

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

</style>

</head>
<body>


   <p class="for_title">문의관리 목록</p> 
      <div id="wrap">

         <div class="board_t1">
            <form action="">
               <table class="admin_t">
                  <tbody>
                   <tr>
                       <th>상품</th>
                     <td colspan="1">
                        <select class="fSelect" id="eProductSearchType" name="product_search_type" style="width:20%;">
                            <option value="product_name" selected="selected">상품명</option>
                      <option value="product_code">상품코드</option>
                      <option value="item_code">품목코드</option>
                        </select>
                        <input type="text" id="eOrderProductText" name="order_product_text" class="fText" style="width:75%;" value="">
                      </td>
                   </tr>
                      
                  </tbody>
               </table>
               <!-- 위 테이블 조건에 대한 검색 기능 구현 버튼  -->
               <div style="text-align: center;">
                  <a href="" class="btnSearch"><span style="padding: 10px; font-size: 17px;">검색</span></a>
               </div>
            </form>
         </div>



         <div class="board_t2" >
            <!-- 데이터 출력 테이블 -->
            <div class="mState">
               <div class="gRight">
                  <select name="searchSorting" class="fSelect">
                      <option value="order_asc">등록일순</option>
                      <option value="order_desc" selected>등록일역순</option>
                      <option value="settle_price_asc">상품명순</option>
                      <option value="settle_price_desc">상품명역순</option>
                  </select>
               </div>
            </div>
          
               <table class="admin_t">
                  <thead>
                     <tr>
                        <th>상품코드</th>
                        <th>상품명</th>
                        <th>옵션</th>
                        <th>선택</th>
                     </tr>
                  </thead>
                  <tbody>
                     <tr>
                        <td>2</td>
                        <td>와인시음회</td>
                        <td>최태휘</td>
                        <td>2020-01-11</td>
                     </tr>
                     
                  </tbody>
               </table> 
            
            <div class="mPaginate">
               <!-- 페이지 이동  -->
               <a href="#none" class="btnNormal"><i class="fas fa-angle-double-left"></i></a>
               <a href="#none" class="btnNormal"><i class="fas fa-angle-left"></i></a>&nbsp;
               <a href="" class="btnNormal"><span> <!-- 페이지 번호 들어갈 곳  -->1 </span></a>
               &nbsp;<a href="#none" class="btnNormal"><i class="fas fa-angle-right"></i></a>
               <a href="#none" class="btnNormal"><i class="fas fa-angle-double-right"></i></a>
                </div>
            
         </div>
      
      <div id="footer">
       <a href="#none" class="btnEm" onclick="window.close();"><span>닫기</span></a>
     </div>
    </div>
   


   <script type="text/javascript">
   
   </script>

</body>
</html>