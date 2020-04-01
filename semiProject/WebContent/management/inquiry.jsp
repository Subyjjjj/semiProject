<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inquiry</title>
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
            <h1 style="font-size: 2.2em;">문의 관리</h1>
         </li>

         <li class="board_t1">
            <form action="">
               <table>
                  <tbody>
                     <tr>
                        <th>기간</th>
                        <td colspan="3">
                           <a href="#none" title="0" class="btnDate selected"><span>1일</span></a>
                           <a href="#none" title="3" class="btnDate"><span>3일</span></a>
                           <a href="#none" title="7" class="btnDate"><span>7일</span></a>
                           <a href="#none" title="30" class="btnDate"><span>1개월</span></a>
                           &nbsp;&nbsp; 
                           <input type="date" value="<!-- 오늘날짜 함수 -->" class="fSelect"> 
                           &nbsp;~&nbsp; 
                           <input type="date" value="<!-- 오늘날짜 함수+1달(아무기간) -->" class="fSelect">
                        </td>

                     </tr>
                     <tr>
                        <th>문의 선택</th>
                        <td colspan="3">
                           <select name="notice-type" id="display_select" class="fSelect">
                                 <option value="1" selected>전체 게시물</option>
                                 <option value="2">상품후기</option>
                                 <option value="3">상품문의</option>
                                 <option value="4">1:1 문의</option>
                           </select>
                        </td>
                     </tr>
                     
                     <tr>
                        <th>답변상태</th>
                        <td>
                           <label class="gLabel eSelected">
                           <input type="radio" class="fChk" name="is_reply" id="is_reply1" value="" checked> 전체보기</label> 
                           <label class="gLabel">
                           <input type="radio" class="fChk" name="is_reply" id="is_reply2" value="N"> 답변 전</label> 
                           <label class="gLabel">
                           <input type="radio" class="fChk" name="is_reply" id="is_reply3" value="Y"> 답변 완료</label>
                        </td>
                        <th>댓글여부</th>
                        <td>
                           <label class="gLabel eSelected">
                           <input type="radio" class="fChk" name="is_comment" id="is_comment1" value="" checked> 전체보기</label>
                           <label class="gLabel">
                           <input type="radio" class="fChk" name="is_comment" id="is_comment2" value="T"> 있음</label> 
                           <label class="gLabel">
                           <input type="radio" class="fChk" name="is_comment" id="is_comment3" value="F"> 없음</label>
                        </td>
                     </tr>
                     
                     <tr>
                        <th>문의 찾기</th>
                        <td colspan="3">
                           <select id="search" name="search" class="fSelect">
                                 <option value="subject">제목</option>
                                 <option value="content">내용</option>
                                 <option value="writer_name">작성자</option>
                                 <option value="product">상품명</option>
                                 <option value="member_id">아이디</option>
                           </select> 
                           <input type="text" id="search_key" name="search_key" value="" class="fText" style="width: 400px;">
                            <span style="display: none;"> 
                               <a href="" class="btnSearch"><span>검색</span></a>
                            </span> 
                            <span> 
                               <label for="no_member_article">
                               <input type="checkbox" name="no_member_article" id="no_member_article" value="F" > 비회원</label>
                           </span>
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
            <h2>전체문의 목록</h2>
            <div class="mState">
               <div class="gLeft">
                  <p class="total">
                     [오늘 등록된 새 글 <strong>8</strong>건] 검색결과 <strong>9</strong> 건
                  </p>
               </div>
               <div class="gRight">
                  <select class="fSelect" id="" name="">
                     <option value="" selected="selected">기본정렬</option>
                     <option value="H">조회수많은순</option>
                  </select> <select class="fSelect" id="" name="">
                     <option value="10" selected>10개씩보기</option>
                     <option value="20">20개씩보기</option>
                     <option value="30">30개씩보기</option>
                     <option value="50">50개씩보기</option>
                     <option value="100">100개씩보기</option>
                  </select>
               </div>
            </div>

            <div class="mCtrl">
               &nbsp;<a href="#none" class="btnNormal"><span><i class="fas fa-times" style="color: red;"></i> 전체삭제</span></a> &nbsp;
               <a href="#none" class="btnNormal"><span><i class="fas fa-times" style="color: red;" ></i> 삭제</span></a>
            </div>
            
            <div class="mBoard">
            <table>
               <thead>
                  <tr>
                     <th><input type="checkbox" class="allChk"></th>
                     <th>회원번호</th>
                     <th>제목</th>
                     <th>내용</th>
                     <th>회원아이디</th>
                     <th>조회수</th>
                     <th>작성일</th>
                     <th>분류</th>
                     <th>상태</th>
                     <th>답변</th>
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
                  </tr>
                  
               </tbody>
            </table> 
            </div>
            
            <div class="mCtrl">
               &nbsp;<a href="#none" class="btnNormal"><span><i class="fas fa-times" style="color: red;"></i> 전체삭제</span></a> &nbsp;
               <a href="#none" class="btnNormal"><span><i class="fas fa-times" style="color: red;"></i> 삭제</span></a>
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