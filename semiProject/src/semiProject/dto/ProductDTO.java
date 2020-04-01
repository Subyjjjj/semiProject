package semiProject.dto;

/*이름             널?       유형             
-------------- -------- -------------- 
PRODUCT_NUM    NOT NULL NUMBER(4)      - sq
PRODUCT_CODE   NOT NULL VARCHAR2(50)   
PRODUCT_NAME            VARCHAR2(1000) 
PRODUCT_IMAGE1          VARCHAR2(1000) 
PRODUCT_DETAIL          VARCHAR2(3000) 
PRODUCT_QTY             NUMBER(8)      
PRODUCT_PRICE           NUMBER(8)      
ADD_DATE                DATE           
PRODUCT_IMAGE2          VARCHAR2(1000) 
PRODUCT_IMAGE3          VARCHAR2(1000) 
PRODUCT_STATUS          NUMBER(1)   */

public class ProductDTO {
	private int productNum;
	private String productCode;
	private String productName;
	private String productImage1;
	private String productDetail;
	private int productQty;
	private int productPrice;
	private String addDate;
	private String productImage2;
	private String productImage3;
	private int productStatus;
	
	public ProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductImage1() {
		return productImage1;
	}

	public void setProductImage1(String productImage1) {
		this.productImage1 = productImage1;
	}

	public String getProductDetail() {
		return productDetail;
	}

	public void setProductDetail(String productDetail) {
		this.productDetail = productDetail;
	}

	public int getProductQty() {
		return productQty;
	}

	public void setProductQty(int productQty) {
		this.productQty = productQty;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getAddDate() {
		return addDate;
	}

	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}

	public String getProductImage2() {
		return productImage2;
	}

	public void setProductImage2(String productImage2) {
		this.productImage2 = productImage2;
	}

	public String getProductImage3() {
		return productImage3;
	}

	public void setProductImage3(String productImage3) {
		this.productImage3 = productImage3;
	}

	public int getProductStatus() {
		return productStatus;
	}

	public void setProductStatus(int productStatus) {
		this.productStatus = productStatus;
	}
	
}
