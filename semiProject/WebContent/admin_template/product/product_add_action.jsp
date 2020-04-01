<%@page import="java.io.File"%>
<%@page import="semiProject.dao.ProductDAO"%>
<%@page import="semiProject.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
	// 에러페이지 만들기
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=error&work=error400';");
		out.println("</script>");
		return;
	}

	String saveDirectory=request.getServletContext().getRealPath("/img/product_images");
	MultipartRequest mr=new MultipartRequest(request, saveDirectory, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());

	String productCode=(mr.getParameter("origin")+"_"+mr.getParameter("wColor")+"_"+mr.getParameter("wType")+"_"+mr.getParameter("brand")).replace(" ", "");
	String productName=mr.getParameter("productName");
	// 이미지파일 전부다 등록 안한경우?
	String productImage1=mr.getFilesystemName("productImage1");
	String productImage2=mr.getFilesystemName("productImage2");
	if (productImage2==null) {
		productImage2="NOPICS";
	}
	String productImage3=mr.getFilesystemName("productImage3");
	if (productImage3==null) {
		productImage3="NOPICS";
	}
	String detailText=mr.getParameter("detailText");
	String detailImage=mr.getFilesystemName("detailImage");
	if (detailImage==null) {
		detailImage="NOPICS";
	}
	String productDetail=detailText+"___"+detailImage;
	int productQty=Integer.parseInt(mr.getParameter("productQty"));
	int productPrice=Integer.parseInt(mr.getParameter("productPrice"));
	
	ProductDTO product=new ProductDTO();
	product.setProductCode(productCode);
	product.setProductName(productName);
	product.setProductImage1(productImage1);
	product.setProductImage2(productImage2);
	product.setProductImage3(productImage3);
	product.setProductDetail(productDetail);
	product.setProductQty(productQty);
	product.setProductPrice(productPrice);
	
	// 제품코드와 상품명이 같은경우 저장불가
	if (ProductDAO.getDAO().selectCodeNameProduct(productCode, productName)!=null) {
		new File(saveDirectory,productImage1).delete();
		new File(saveDirectory,productImage2).delete();
		new File(saveDirectory,productImage3).delete();
		session.setAttribute("message", "동일한 상품이 존재합니다.");
		session.setAttribute("product", product);
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=product&work=add';");
		out.println("</script>");		
		return;
	}
	
	ProductDAO.getDAO().insertProduct(product);
	
	// 제품목록출력페이지로 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=product&work=list';");
	out.println("</script>");
	

%>