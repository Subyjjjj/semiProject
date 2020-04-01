package semiProject.dto;

/*
이름        				널?       				유형             
---------				 -------- 				-------------- 
NUM       				NOT 				NULL NUMBER(4)      
ID                 							VARCHAR2(20)   
WRITER             							VARCHAR2(50)   
SUBJECT           							VARCHAR2(500)  
REG_DATE           							DATE           
READCOUNT          							NUMBER(4)      
REF                							NUMBER(4)      
CONTENT            							VARCHAR2(4000) 
STATUS            							NUMBER(1)      
CATEGORY           							NUMBER(1) 
IMAGE             							 VARCHAR2(1000)
PRODUCT_NUM 								VARCHAR2()
 */

public class BoardDTO {
	public BoardDTO() {
		// TODO Auto-generated constructor stub
	}
	
	private int num;
	private String id;
	private String writer;
	private String subject;
	private String regDate;
	private int readCount;
	private int ref;
	private String content;
	private int status;
	private int category;
	private String image;
	private String productNum;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getProductNum() {
		return productNum;
	}
	public void setProductNum(String productNum) {
		this.productNum = productNum;
	}
	
}
