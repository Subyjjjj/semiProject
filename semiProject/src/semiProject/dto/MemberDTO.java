package semiProject.dto;

/*
이름         널?       유형            
---------- -------- ------------- 
ID         NOT NULL VARCHAR2(20)  
PASSWD              VARCHAR2(200) 
NAME                VARCHAR2(20)  
EMAIL               VARCHAR2(20)  
PHONE               VARCHAR2(20)  
ZIPCODE             VARCHAR2(10)  
ADDRESS1            VARCHAR2(200) 
ADDRESS2            VARCHAR2(50)  
JOIN_DATE           DATE          
LAST_LOGIN          DATE          
STATUS              NUMBER(1) 
 */
public class MemberDTO {
	private String id;
	private String passwd;
	private String name;
	private String email;
	private String phone;
	private String zipcode;
	private String address1;
	private String address2;
	private String join_date;
	private String last_login;
	private int status;
	
	public MemberDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getLast_login() {
		return last_login;
	}

	public void setLast_login(String last_login) {
		this.last_login = last_login;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
