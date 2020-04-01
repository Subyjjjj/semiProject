<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<%
	String part = request.getParameter("part");
	String content = request.getParameter("content");
	
	if (part == null || content == null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
	
	String contentFilePath = part + "/" + content + ".jsp";
	
	//contentFilePath = "shop/bbs/boardNotice.jsp";
	
	//part=  shop/bbs   &content=   boardNotice    
%>
<html lang="ko">
<head>
<link rel="shortcut icon" href="http://eastofeden2.webtro.kr/favi.ico">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/default_shop.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/shop_style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board_style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/boardNotice_style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/boardQA_style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/member_style.css">
<title>에덴의동쪽</title>

<!-- 다음 우편번호 api 스크립트 postcode v2 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>	
<script src="<%=request.getContextPath()%>/js/jquery.bxslider.js"></script>
<script src="https://kit.fontawesome.com/76211070e2.js"></script>   
</head>
<body>
<!-- 상단 헤더 영역 -->
<jsp:include page="shop/header.jsp"/>
<!-- 상단 헤더 종료 -->


<!-- 컨텐츠 시작 -->
<jsp:include page="<%=contentFilePath %>"/>
<!-- 컨텐츠 종료 -->


<!-- 하단 풋터 시작 -->
<jsp:include page="shop/footer.jsp"/>
<!-- 하단 풋터 종료 -->

</body>
</html>