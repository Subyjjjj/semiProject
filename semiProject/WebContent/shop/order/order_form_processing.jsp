<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dao.CartDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="semiProject.dto.CartDTO"%>
<%@page import="semiProject.dto.OrderDTO"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- order_form.jsp에서 전달된 값들을 처리하는 JSP 문서. 주문서에 있는 입력값을 등록. 마지막 처리후 카트 id들을 삭제 --%>
<%@include file="/shop/security/login_status.jspf" %>
<% 
	//비정상적인 요청에 대한 응답처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/error&content=error400';");
		out.println("</script>");
		return;
	}

	//카트 항목을 받기 위한 인스턴스와 파라미터들을 받기 위한 스트링배열
	List<CartDTO> cartList = new ArrayList<CartDTO>();
	CartDTO cartDTO = null;
	String[] cartNums = request.getParameterValues("cartNum");

	//서버 시스템의 현재 날짜(시간)정보 저장
	String orderNum = new SimpleDateFormat("yyyyMMddHHmmssSS").format(new Date());
	
	//전달 메세지
	String customMsg = request.getParameter("od_memo").replace("<", "&lt;").replace(">", "&gt;");
	//결제방법
	int paymentMethod = Integer.parseInt(request.getParameter("od_settle_case"));
	//수취인 정보 전달
	String name = request.getParameter("od_b_name");
	String phone = request.getParameter("od_b_hp");
	String address = request.getParameter("od_b_zip") + " " + request.getParameter("od_b_addr1") + " " + request.getParameter("od_b_addr2");
	//초기값 널
	String delivery = "";
	String adminMsg = "";
	
	
	//카트에서 전달값을 구분하기 위한 조건문 
	if(cartNums == null) {
		//전달값을 반환받아 저장
		
		int productNum = Integer.parseInt(request.getParameter("productNum"));
		int orderAmount = Integer.parseInt(request.getParameter("orderAmount"));
		String productName = request.getParameter("productName");
		int productPrice = Integer.parseInt(request.getParameter("productPrice"));
		int orderTotal = Integer.parseInt(request.getParameter("orderTotal"));
		
		//DTO 인스턴스를 생성하고 필드값 변경
		OrderDTO order = new OrderDTO();
		order.setOrderNum(orderNum);
		//System.out.println("orderNum = " + orderNum);
		order.setId(loginMember.getId());
		//System.out.println("id = " + loginMember.getId());
		order.setName(name);
		//System.out.println("name = " + name);
		order.setPhone(phone);
		//System.out.println("phone = " + phone);
		order.setAddress(address);
		//System.out.println("address = " + address);
		order.setEmail(loginMember.getEmail());
		//System.out.println("Email = " + loginMember.getEmail());
		order.setCustomMsg(customMsg);
		//System.out.println("customMsg = " + customMsg);
		order.setPaymentMethod(paymentMethod);
		//System.out.println("paymentMethod = " + paymentMethod);
		order.setOrderAmount(orderAmount);
		//System.out.println("orderAmount = " + orderAmount);
		order.setProductNum(productNum);
		//System.out.println("productNum = " + productNum);
		order.setProductName(productName);
		//System.out.println("productName = " + productName);
		order.setProductPrice(productPrice);
		//System.out.println("productPrice = " + productPrice);
		order.setOrderTotal(orderTotal);
		//System.out.println("orderTotal = " + orderTotal);
		order.setDelivery(delivery);
		//System.out.println("delivery = " + delivery);
		order.setAdminMsg(adminMsg);
		//System.out.println("adminMsg = " + adminMsg);
		
		//테이블에 자료를 삽입하는 메소드 호출
		OrderDAO.getDAO().insertOrder(order);
		//System.out.println("order = " + order);
		
		//제품 테이블에서 수량을 감소시키기 위한 메소드 호출
		ProductDAO.getDAO().updateQTYProduct(ProductDAO.getDAO().selectNumProduct(productNum).getProductQty()-orderAmount, productNum);
	} else {
		
		for (String cart: cartNums) {
			int number = Integer.parseInt(cart);
			
			//메소드 호출
			cartDTO = CartDAO.getDAO().selectNoCart(number);
			
			//DTO 인스턴스를 생성하고 필드값 변경
			OrderDTO order = new OrderDTO();
			order.setOrderNum(orderNum);
			order.setId(loginMember.getId());
			order.setName(name);
			order.setPhone(phone);
			order.setAddress(address);
			order.setEmail(loginMember.getEmail());
			order.setCustomMsg(customMsg);
			order.setPaymentMethod(paymentMethod);
			order.setOrderAmount(cartDTO.getProductQTY());
			//System.out.println("orderAmount = " + orderAmount);
			order.setProductNum(cartDTO.getProductNum());
			//System.out.println("productNum = " + productNum);
			order.setProductName(cartDTO.getProductName());
			//System.out.println("productName = " + productName);
			order.setProductPrice(cartDTO.getProductPrice());
			//System.out.println("productPrice = " + productPrice);
			order.setOrderTotal(cartDTO.getProductTotal());
			//System.out.println("orderTotal = " + orderTotal);
			order.setDelivery(delivery);
			order.setAdminMsg(adminMsg);
			
			//테이블에 자료를 삽입하는 메소드 호출
			OrderDAO.getDAO().insertOrder(order);
			CartDAO.getDAO().deleteCart(number);
			ProductDAO.getDAO().updateQTYProduct(ProductDAO.getDAO().selectNumProduct(cartDTO.getProductNum()).getProductQty()-cartDTO.getProductQTY(), cartDTO.getProductNum());
		}
	}
	
	//구매 완료 후 마이페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?part=shop/member&content=mypage'");
	out.println("</script>");
%>