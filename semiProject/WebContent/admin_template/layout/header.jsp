<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
    <div id="hd">
    <div id="btns">
    	<a href="<%=request.getContextPath()%>/index.jsp" class="header_a">shop</a>&nbsp;&nbsp;&nbsp;
    	<a href="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=logout" class="header_a">ADMIN Logout</a>&nbsp;&nbsp;&nbsp;
    </div>
    <div class="hd_title">
		<a href="<%=request.getContextPath()%>/admin_template/index.jsp?part=main&work=display" style="margin-left: 20px;"> EAST OF EDEN's <span style="color: #FFA7A7;">ADMIN</span> </a>
	</div>
    </div>
	<div id="category">
		<ul>
		<li><a class="header_cat_a" href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list">주문관리</a></li>
		<li><a class="header_cat_a" href="<%=request.getContextPath()%>/admin_template/index.jsp?part=product&work=list">상품관리</a></li>
		<li><a class="header_cat_a" href="<%=request.getContextPath()%>/admin_template/index.jsp?part=member&work=list">회원관리</a></li>
		<li><a class="header_cat_a" href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list">게시물관리</a></li>
		</ul>
	</div>
