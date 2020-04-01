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

    int productNum=Integer.parseInt(mr.getParameter("productNum"));
    String currentImage1=mr.getParameter("currentImage1");
    String currentImage2=mr.getParameter("currentImage2");
    String currentImage3=mr.getParameter("currentImage3");
    String  currentDetail=mr.getParameter("currentDetail");
	String productCode=(mr.getParameter("origin")+"_"+mr.getParameter("wColor")+"_"+mr.getParameter("wType")+"_"+mr.getParameter("brand")).replace(" ", "");
	String productName=mr.getParameter("productName");
	// 이미지파일 전부다 등록 안한경우? >> 추후처리
	String productImage1=mr.getFilesystemName("productImage1");
	String productImage2=mr.getFilesystemName("productImage2");
	String productImage3=mr.getFilesystemName("productImage3");
	String detailText=mr.getParameter("detailText");
	String detailImage=mr.getFilesystemName("detailImage");
	if (detailImage==null) {
		detailImage=currentDetail;
	} else {
		new File(saveDirectory,currentDetail).delete();
	}
	String productDetail=detailText+"___"+detailImage;
	int productQty=Integer.parseInt(mr.getParameter("productQty"));
	int productPrice=Integer.parseInt(mr.getParameter("productPrice"));
	
	ProductDTO product=new ProductDTO();
	product.setProductNum(productNum);
	product.setProductCode(productCode);
	product.setProductName(productName);
	if(productImage1!=null){ 
		product.setProductImage1(productImage1);
		new File(saveDirectory,currentImage1).delete();
	} else { 
		product.setProductImage1(currentImage1); 
	}
	if(productImage2!=null){ 
		product.setProductImage2(productImage2);
		new File(saveDirectory,currentImage2).delete();
	} else { 
		product.setProductImage2(currentImage2); 
	}
	if(productImage3!=null){ 
		product.setProductImage3(productImage3);
		new File(saveDirectory,currentImage3).delete();
	} else { 
		product.setProductImage3(currentImage3); 
	}
	product.setProductDetail(productDetail);
	product.setProductQty(productQty);
	product.setProductPrice(productPrice);
	
	ProductDAO.getDAO().updateProduct(product);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/admin_template/index.jsp?part=product&work=detail&productNum="+productNum+"';");
	out.println("</script>");
	

%>