package semiProject.dto;

/*
이름             널?       유형             
-------------- -------- -------------- 
ORDER_NO       NOT NULL NUMBER          >> SEQ
ORDER_NUM               VARCHAR2(1000)  >> [ORDER_DATE시분초까지]
ID                      VARCHAR2(20)   
NAME                    VARCHAR2(20)   
PHONE                   VARCHAR2(20)   
ADDRESS                 VARCHAR2(500)  
EMAIL                   VARCHAR2(100)  
CUSTOM_MSG              VARCHAR2(1000) 
ORDER_DATE              DATE           
ORDER_STATUS            NUMBER           >>전체 : 0 입금대기 : 1 입금완료 : 2 배송준비 : 3 배송중   : 4 배송완료 : 5 구매확정 : 6 [취소요청10취소완료11/ 교환요청20교환완료21/ 환불요청30환불완료31] 
PAYMENT_METHOD          NUMBER           >>무통장입금 :1 신용카드 :2
ORDER_AMOUNT            NUMBER         
PRODUCT_NUM             NUMBER         
PRODUCT_NAME            VARCHAR2(20)   
PRODUCT_PRICE           NUMBER         
ORDER_TOTAL             NUMBER         
DELIVERY                VARCHAR2(500)    >> 배송사+송장번호
ADMIN_MSG               VARCHAR2(1000)
CS_STATUS               NUMBER           >> 취소교환반품- 요청없음0, 요청있음1 
 */
public class OrderDTO {
	private int orderNo;
	private String orderNum;
	private String id;
	private String name;
	private String phone;
	private String address;
	private String email;
	private String customMsg;
	private String orderDate;
	private int orderStatus;
	private int paymentMethod;
	private int orderAmount;
	private int productNum;
	private String productName;
	private int productPrice;
	private int orderTotal;
	private String delivery;
	private String adminMsg;
	private int CSStatus;
	
	public OrderDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCustomMsg() {
		return customMsg;
	}

	public void setCustomMsg(String customMsg) {
		this.customMsg = customMsg;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public int getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}

	public int getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(int paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public int getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(int orderAmount) {
		this.orderAmount = orderAmount;
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getOrderTotal() {
		return orderTotal;
	}

	public void setOrderTotal(int orderTotal) {
		this.orderTotal = orderTotal;
	}

	public String getDelivery() {
		return delivery;
	}

	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}

	public String getAdminMsg() {
		return adminMsg;
	}

	public void setAdminMsg(String adminMsg) {
		this.adminMsg = adminMsg;
	}

	public int getCSStatus() {
		return CSStatus;
	}

	public void setCSStatus(int cSStatus) {
		CSStatus = cSStatus;
	}
	
}
