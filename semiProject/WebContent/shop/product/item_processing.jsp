<%@page import="semiProject.dao.CartDAO"%>
<%@page import="semiProject.dto.CartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/login_status.jspf" %>
<%-- cart에 등록하기 위한 jsp 파일 --%>
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getParameter("productNum")==null || request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}

	//시퀸스 객체의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출
	int num = CartDAO.getDAO().selectCartNextNum();

	//입력값(전달값)을 반환받아 저장
	String id = loginMember.getId();
	int productNum = Integer.parseInt(request.getParameter("productNum"));
	//기존 자바스크립트 때문에 ct_qty 사용
	int productQTY = Integer.parseInt(request.getParameter("ct_qty")); 
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int productTotal = productPrice * productQTY;
	String productImage = request.getParameter("productImage");
	String productName = request.getParameter("productName");
	String productDetail = request.getParameter("productDetail");
	
	//테스트용
	//System.out.println(id);
	//System.out.println(productNum);
	//System.out.println(productQTY);
	//System.out.println(productPrice);
	//System.out.println(productTotal);
	//System.out.println(productImage);
	
	//필드값 변경
	CartDTO cart = new CartDTO();
	cart.setId(id);
	cart.setProductNum(productNum);
	cart.setProductQTY(productQTY);
	cart.setProductPrice(productPrice);
	cart.setProductTotal(productTotal);
	cart.setProductImage(productImage);
	cart.setProductName(productName);
	cart.setProductDetail(productDetail);
	cart.setCartNum(num);
	
	if (CartDAO.getDAO().selectProductNumIdCart(productNum, id) != null) {
		//CART 테이블에서 중복검사를 하기 위한 값 저장
		//System.out.println("DAO = " + CartDAO.getDAO().selectProductNumIdCart(productNum, id).getProductNum());
		int oldCartNum = CartDAO.getDAO().selectProductNumIdCart(productNum, id).getCartNum();
		
		CartDAO.getDAO().updateQtyCart(productQTY, oldCartNum);
		
	} else {
		//CART 테이블에 저장하는 DAO 클래스의 메소드 호출
		CartDAO.getDAO().insertCart(cart);
	}
	
	//카트 출력페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/order&content=cart';");
	out.println("</script>");
%>