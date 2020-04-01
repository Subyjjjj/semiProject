package semiProject.dto;

/*
이름            널?       유형           
------------- -------- ------------ 
ID             NOT NULL VARCHAR2(20)   
PRODUCT_NUM             NUMBER         
PRODUCT_QTY             NUMBER         
PRODUCT_PRICE           NUMBER         
PRODUCT_TOTAL           NUMBER         
PRODUCT_IMAGE           VARCHAR2(500)  
PRODUCT_NAME            VARCHAR2(500)  
PRODUCT_DETAIL          VARCHAR2(1000) 
CART_NUM                NUMBER  
 * */

public class CartDTO {
	
	private String id;
	private int productNum;
	private int productQTY;
	private int productPrice;
	private int productTotal;
	private String productImage;
	private String productName;
	private String productDetail;
	private int cartNum;

	public CartDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public int getProductQTY() {
		return productQTY;
	}

	public void setProductQTY(int productQYT) {
		this.productQTY = productQYT;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductTotal() {
		return productTotal;
	}

	public void setProductTotal(int productTotal) {
		this.productTotal = productTotal;
	}
	
	public String getProductImage() {
		return productImage;
	}
	
	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}
	
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductDetail() {
		return productDetail;
	}

	public void setProductDetail(String productDetail) {
		this.productDetail = productDetail;
	}

	public int getCartNum() {
		return cartNum;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}
	
	
}
