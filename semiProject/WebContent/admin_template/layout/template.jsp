<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 응답페이지 : controller --%>
<%
	// 요청(index)에따른 content영역에 포함시킬 응답결과 JSP문서 작성
	String part=request.getParameter("part");
	String work=request.getParameter("work");
	
	if (part==null || work==null) {
		// 에러페이지 추가
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}
	
	// 이동될 JSP문서 경로
	String contentFilePath="/admin_template/"+part+"/"+part+"_"+work+".jsp";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>	
<script src="https://kit.fontawesome.com/76211070e2.js"></script>     

<link href="<%=request.getContextPath()%>/admin_template/css/style.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div id=header>
		<jsp:include page="header.jsp"/>
	</div>

	<div id="content">
		<jsp:include page="<%= contentFilePath %>"/>
	</div>


	<div id=footer  style="position: relative; z-index: 10;">
	<jsp:include page="footer.jsp"/>
	</div>
	

</body>
</html>