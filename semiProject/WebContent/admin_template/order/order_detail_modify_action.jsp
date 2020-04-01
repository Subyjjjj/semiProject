<%@page import="semiProject.dto.OrderDTO"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 디테일페이지에서 요청한경우 :  고유값, 주문상태, 배송정보--%>
<%
	System.out.println("==============");
	String[] orderNo=request.getParameterValues("checkOrder");
	String standardNo=orderNo[0];
	System.out.println(orderNo[0]);
	String orderNum=request.getParameter("orderNum");
	System.out.println(orderNum);
	String changeStatus=request.getParameter("orderStatus");
	System.out.println(changeStatus);
		
	int orderStatus=0;
	if(changeStatus!=null) {
		orderStatus=Integer.parseInt(request.getParameter("orderStatus"));
	}
	
	String deliveryName="";
	if(request.getParameter("deliveryName")!=null) {
		deliveryName=request.getParameter("deliveryName");
	}		
	String deliveryNum="";
	if(request.getParameter("deliveryNum")!=null) {
		deliveryNum=request.getParameter("deliveryNum");
	}
	
	String delivery="";
	if (deliveryNum!=null && !deliveryName.equals("NONE")) {
		delivery=deliveryName+"_"+deliveryNum;
	} 
	
	for(String no:orderNo){
		int now=Integer.parseInt(no);
		OrderDAO.getDAO().updateDetailAtOnce(now, orderStatus, delivery);
	}
	
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=order&work=detail&orderNum="+orderNum+"&orderNo="+standardNo+"';");
	out.println("</script>");
 
%>

