<%@page import="java.util.List"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@page import="semiProject.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/login_status.jspf" %>
<%-- 회원정보의 수정 삭제 및 아이디와 일치하는 제품번호를 출력하고 주문번호의 상태를 간단히 표시하는 페이지 --%>
<%-- 주문번호를 클릭하면 제품의 상세페이지로 이동한다 --%>
<%
	List<OrderDTO> orderList = OrderDAO.getDAO().selectOrderProduct(loginMember.getId());
%>
	<!-- 콘텐츠 시작 { -->
	<div id="container">
		<!-- <div id="wrapper_title">마이페이지</div> -->
		<div id="wrapper_title">마이페이지</div>


		<!-- 마이페이지 시작 { -->
		<div id="smb_my">

			<!-- 회원정보 개요 시작 { -->
			<section id="smb_my_ov">
				<h2>회원정보 개요</h2>
				<strong class="my_ov_name"> <%=loginMember.getName() %></strong>
				
				<div id="smb_my_act">
					<ul>
						<li>
							<a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=modify_confirm" class="btn01">회원정보수정</a>
						</li>
						<li>
							<a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=remove_confirm" onclick="return member_leave();" class="btn01">회원탈퇴</a>
						</li>
					</ul>
				</div>

				<dl class="op_area">
					<dt>연락처</dt>
					<dd><%=loginMember.getPhone() %></dd>
					<dt>E-Mail</dt>
					<dd><%=loginMember.getEmail() %></dd>
					<dt>최종접속일시</dt>
					<dd><%=loginMember.getLast_login().substring(0, 19) %></dd>
					<dt>회원가입일시</dt>
					<dd><%=loginMember.getJoin_date().substring(0, 19) %></dd>
					<dt id="smb_my_ovaddt">주소</dt>
					<dd id="smb_my_ovaddd">(<%=loginMember.getZipcode() %>) <%=loginMember.getAddress1() %>, <%=loginMember.getAddress2() %></dd>
				</dl>
				<div class="my_ov_btn">
					<button type="button" class="btn_op_area">
						<i class="fa fa-caret-up" aria-hidden="true"></i><span
							class="sound_only">상세정보 보기</span>
					</button>
				</div>

			</section>
			<script>
    
        $(".btn_op_area").on("click", function() {
            $(".op_area").toggle();
            $(".fa-caret-up").toggleClass("fa-caret-down")
        });

    </script>
			<!-- } 회원정보 개요 끝 -->

			<!-- 최근 주문내역 시작 { -->
			<section id="smb_my_od">
				<h2>최근 주문내역</h2>

				<!-- 주문 내역 목록 시작 { -->
				<div class="tbl_head03 tbl_wrap">
					<table>
						<thead>
							<tr>
								<th scope="col">주문서번호</th>
								<th scope="col">주문일시</th>
								<th scope="col">상품수</th>
								<th scope="col">주문금액</th>
								<th scope="col">상품명</th>
								<th scope="col">받으시는 분</th>
								<th scope="col">상태</th>
							</tr>
						</thead>
						<tbody>
						<% for (OrderDTO order:orderList) { %>
							<tr>
								<td><input type="hidden" name="orderNo" value="<%=order.getOrderNo()%>">
								<a href="<%=request.getContextPath()%>/index.jsp?part=shop/order&content=order_detail&orderNo=<%=order.getOrderNo()%>">
								<%=order.getOrderNum() %></a>
								</td>
								<td><%=order.getOrderDate().substring(0, 19) %></td>
								<td class="td_numbig"><%=order.getOrderAmount() %></td>
								<td class="td_numbig text_right"><%=order.getOrderTotal() %></td>
								<td class="td_numbig text_right"><%=order.getProductName() %></td>
								<td class="td_numbig text_right"><%=order.getName() %></td>
								<td>
								<% if (order.getOrderStatus() == 1) { %>
									<span class="status_01">입금대기</span>
								<% } else if (order.getOrderStatus() == 2) { %>
									<span class="status_02">입금완료</span>
								<% } else if (order.getOrderStatus() == 3) { %>
									<span class="status_03">배송준비</span>
								<% } else if (order.getOrderStatus() == 4) { %>
									<span class="status_04">배송중</span>
								<% } else if (order.getOrderStatus() == 5) { %>
									<span class="status_05">배송완료</span>
								<% } else if (order.getOrderStatus() == 6) { %>
									<span class="status_06">구매확정</span>
								<% } else if (order.getOrderStatus() == 10) { %>
									<span class="status_06">취소요청</span>
								<% } else if (order.getOrderStatus() == 11) { %>
									<span class="status_06">취소완료</span>
								<% } else if (order.getOrderStatus() == 20) { %>
									<span class="status_04">교환요청</span>
								<% } else if (order.getOrderStatus() == 21) { %>
									<span class="status_04">교환완료</span>
								<% } else if (order.getOrderStatus() == 30) { %>
									<span class="status_02">환불요청</span>
								<% } else if (order.getOrderStatus() == 31) { %>
									<span class="status_02">환불완료</span>
								<% } %>
								</td>
							</tr>
						<% } %>
						</tbody>
					</table>
				</div>
				<!-- } 주문 내역 목록 끝 -->
			</section>
			<!-- } 최근 주문내역 끝 -->

		</div>

<script>
function member_leave()
{
    return confirm('정말 회원에서 탈퇴 하시겠습니까?')
}
</script>
		<!-- } 마이페이지 끝 -->


	</div>
	<!-- } 콘텐츠 끝 -->
