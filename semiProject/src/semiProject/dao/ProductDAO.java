package semiProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semiProject.dto.ProductDTO;

public class ProductDAO extends JdbcDAO{
	private static ProductDAO _dao;
	
	private ProductDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ProductDAO();
	}
	
	public static ProductDAO getDAO() {
		return _dao;
	}
	
	
	// ��ǰ������ ���޹޾� PRODUCT���̺� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
	public int insertProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL,?,?,?,?,?,?,SYSDATE,?,?,1)";
			psm=con.prepareStatement(sql);
			psm.setString(1, product.getProductCode());
			psm.setString(2, product.getProductName());
			psm.setString(3, product.getProductImage1());
			psm.setString(4, product.getProductDetail());
			psm.setInt(5, product.getProductQty());
			psm.setInt(6, product.getProductPrice());
			psm.setString(7, product.getProductImage2());
			psm.setString(8, product.getProductImage3());
			
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] insertProduct()�޼ҵ��� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	
	// ��ǰ������ ���޹޾� PRODUCT���̺� ����� ���� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
	public int updateProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="UPDATE PRODUCT SET PRODUCT_CODE=?, PRODUCT_NAME=?, PRODUCT_IMAGE1=?, PRODUCT_DETAIL=?, PRODUCT_QTY=?, PRODUCT_PRICE=?, PRODUCT_IMAGE2=?, PRODUCT_IMAGE3=? WHERE PRODUCT_NUM=?";
			psm=con.prepareStatement(sql);
			psm.setString(1, product.getProductCode());
			psm.setString(2, product.getProductName());
			psm.setString(3, product.getProductImage1());
			psm.setString(4, product.getProductDetail());
			psm.setInt(5, product.getProductQty());
			psm.setInt(6, product.getProductPrice());
			psm.setString(7, product.getProductImage2());
			psm.setString(8, product.getProductImage3());
			psm.setInt(9, product.getProductNum());
			
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] updateProduct()�޼ҵ��� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}

	// ��ǰ������ ���޹޾� PRODUCT���̺� ����� ���� ����ó��(����=9�κ���)�ϴ� �޼ҵ�
	public int deleteProduct(int productNum) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			String sql="UPDATE PRODUCT SET PRODUCT_STATUS=9 WHERE PRODUCT_NUM=?";
			psm=con.prepareStatement(sql);
			psm.setInt(1, productNum);
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] deleteProduct()�޼ҵ��� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	// ���û�ǰ ǰ��ó��
	public int soldoutProduct(int productNum) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			String sql="UPDATE PRODUCT SET PRODUCT_QTY=0 WHERE PRODUCT_NUM=?";
			psm=con.prepareStatement(sql);
			psm.setInt(1, productNum);
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] deleteProduct()�޼ҵ��� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	
	// ��ǰ��ȣ �Է¹޾� �ش� ��ǰ�� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	public ProductDTO selectNumProduct(int productNum) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		ProductDTO product=null;
		
		try {
			con= getConnection();
			String sql="SELECT * FROM PRODUCT WHERE PRODUCT_NUM=?";
			psm=con.prepareStatement(sql);
			psm.setInt(1, productNum);
			
			rs=psm.executeQuery();
			
			if(rs.next()) {
				product=new ProductDTO();
				product.setProductNum(rs.getInt("PRODUCT_NUM"));
				product.setProductCode(rs.getString("PRODUCT_CODE"));
				product.setProductName(rs.getString("PRODUCT_NAME"));
				product.setProductImage1(rs.getString("PRODUCT_IMAGE1"));
				product.setProductImage2(rs.getString("PRODUCT_IMAGE2"));
				product.setProductImage3(rs.getString("PRODUCT_IMAGE3"));
				product.setProductDetail(rs.getString("PRODUCT_DETAIL"));
				product.setProductQty(rs.getInt("PRODUCT_QTY"));
				product.setProductPrice(rs.getInt("PRODUCT_PRICE"));
				product.setAddDate(rs.getString("ADD_DATE"));
				product.setProductStatus(rs.getInt("PRODUCT_STATUS"));
			}
		} catch (SQLException e) {
			System.out.println("[Error] selectNumProduct()�޼ҵ��� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return product;
	}
	
	// ��ǰ�ڵ�� �̸��� ���޹޾� PRODUCT���̺� ����� ��ǰ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	public ProductDTO selectCodeNameProduct(String productCode, String productName) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		ProductDTO product=null;
		try {
			con= getConnection();
			String sql="SELECT * FROM PRODUCT WHERE PRODUCT_CODE=? AND PRODUCT_NAME=?";
			psm=con.prepareStatement(sql);
			psm.setString(1, productCode);
			psm.setString(2, productName);
			rs=psm.executeQuery();
			if(rs.next()) {
				product=new ProductDTO();
				product.setProductNum(rs.getInt("PRODUCT_NUM"));
				product.setProductCode(rs.getString("PRODUCT_CODE"));
				product.setProductName(rs.getString("PRODUCT_NAME"));
				product.setProductImage1(rs.getString("PRODUCT_IMAGE1"));
				product.setProductImage2(rs.getString("PRODUCT_IMAGE2"));
				product.setProductImage3(rs.getString("PRODUCT_IMAGE3"));
				product.setProductDetail(rs.getString("PRODUCT_DETAIL"));
				product.setProductQty(rs.getInt("PRODUCT_QTY"));
				product.setProductPrice(rs.getInt("PRODUCT_PRICE"));
				product.setAddDate(rs.getString("ADD_DATE"));
				product.setProductStatus(rs.getInt("PRODUCT_STATUS"));
			}
		} catch (SQLException e) {
			System.out.println("[Error] selectCodeNameProduct()�޼ҵ��� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return product;
	}
	
	// [���� ���� �Ǵ� ��������] ��ü�˻� >> ����¡�߰��� ���߰˻������� �Ű����� �߰��ؼ� �����ؾ���
	// => ���� ��ǰ ��ϰ� ����������� ���������� ���������!!!!��_��
	public List<ProductDTO> selectAllProduct() {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		List<ProductDTO> productList= new ArrayList<ProductDTO>();
		try {
			con=getConnection();
			String sql="SELECT * FROM PRODUCT ORDER BY PRODUCT_NUM";
			psm=con.prepareStatement(sql);
			rs=psm.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product=new ProductDTO();
				product.setProductNum(rs.getInt("PRODUCT_NUM"));
				product.setProductCode(rs.getString("PRODUCT_CODE"));
				product.setProductName(rs.getString("PRODUCT_NAME"));
				product.setProductImage1(rs.getString("PRODUCT_IMAGE1"));
				product.setProductImage2(rs.getString("PRODUCT_IMAGE2"));
				product.setProductImage3(rs.getString("PRODUCT_IMAGE3"));
				product.setProductDetail(rs.getString("PRODUCT_DETAIL"));
				product.setProductQty(rs.getInt("PRODUCT_QTY"));
				product.setProductPrice(rs.getInt("PRODUCT_PRICE"));
				product.setAddDate(rs.getString("ADD_DATE"));
				product.setProductStatus(rs.getInt("PRODUCT_STATUS"));
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[Error] selectAllProduct()�� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return productList;
	}
	
	//�������������� ��ǰ ���÷��̸� ����  �޼ҵ� ���� selectAllProduct���� �����ε�� ����¡ó���� ���� �Ķ���͸� ���ڷ� �޴´�.
	//���� ���� ���� �����ϱ� ���� �÷��� ������ ��ǰ�ڵ带 �޴´�. ����Ʈ ������ �ֽż� ��ϼ� ��������.
	public List<ProductDTO> selectAllProduct(int startRow, int endRow, String search, String keyword, String color, String country, String sort) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		List<ProductDTO> productList= new ArrayList<ProductDTO>();
		try {
			con=getConnection();
			
			if(keyword.equals("")) {
				String sql="select * from (select rownum rn,temp.* from "
						+ "(select * from product where product_code like '%'||?||'%' and product_code like '%'||?||'%' and product_status!=9 "+sort+") "
						+ "temp) where rn between ? and ?";
				psm=con.prepareStatement(sql);
				psm.setString(1, color);
				psm.setString(2, country);
				psm.setInt(3, startRow);
				psm.setInt(4, endRow);
			} else {
				String sql="select * from (select rownum rn,temp.* from "
						+ "(select * from product where "+search+" like '%'||?||'%' and product_code like '%'||?||'%' and product_code like '%'||?||'%' and product_status!=9 "+sort+") "
						+ "temp) where rn between ? and ?";
				psm=con.prepareStatement(sql);
				psm.setString(1, keyword);
				psm.setString(2, color);
				psm.setString(3, country);
				psm.setInt(4, startRow);
				psm.setInt(5, endRow);	
			}
			
			rs=psm.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product=new ProductDTO();
				product.setProductNum(rs.getInt("PRODUCT_NUM"));
				product.setProductCode(rs.getString("PRODUCT_CODE"));
				product.setProductName(rs.getString("PRODUCT_NAME"));
				product.setProductImage1(rs.getString("PRODUCT_IMAGE1"));
				product.setProductImage2(rs.getString("PRODUCT_IMAGE2"));
				product.setProductImage3(rs.getString("PRODUCT_IMAGE3"));
				product.setProductDetail(rs.getString("PRODUCT_DETAIL"));
				product.setProductQty(rs.getInt("PRODUCT_QTY"));
				product.setProductPrice(rs.getInt("PRODUCT_PRICE"));
				product.setAddDate(rs.getString("ADD_DATE"));
				product.setProductStatus(rs.getInt("PRODUCT_STATUS"));
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[Error] selectAllProduct()�� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return productList;
	}
	
	//PRODUCT ���̺� ����� �Խñ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�  => �˻� ����� �����ϱ� ���� �Ű������� �˻� ���� ������ ���޹޾� ���� 
	public int selectProductCount(String search, String keyword, String color, String country) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			if(keyword.equals("")) {
				String sql="select count(*) from product where product_code like '%'||?||'%' and product_code like '%'||?||'%' and product_status!=9";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, color);
				pstmt.setString(2, country);
			}else {
				String sql="select count(*) from product where "+search+" like '%'||?||'%' and product_code like '%'||?||'%' and product_code like '%'||?||'%' and product_status!=9";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setString(2, color);
				pstmt.setString(3, country);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectProductCount() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
	/* �̰�... �s �������ؾߵɲ�����..��...^_^ ���߰˻�... �˿� �����ŵ�� ����..
	 * //product ���̺� ����� �Խñ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ� // => �˻�� ���޹��� ���� �ش� �˻������ �ش��ϴ�
	 * �Խñ۰�����ȯ // => ???????????????????????? public int selectProductCount(String
	 * search, String keyword, String productCode, int price1, int price2, int qty1,
	 * int qty2,String date1, String date2 ) { Connection con=null;
	 * PreparedStatement psm=null; ResultSet rs=null; int count=0; try { con=
	 * getConnection(); if(keyword.equals("")) { if(productCode.equals("")) {
	 * if(price1==0 && price2==0) { if(qty1==0 && qty2==0) { if(date1.equals("") &&
	 * date2.equals("")) { String sql="SELECT COUNT(*) FROM PRODUCT";
	 * psm=con.prepareStatement(sql); } else if (date1.equals("") ||
	 * date2.equals("")){ //����¥�˻��� ���õȰ��� ���߿� �ٽ��ۼ� } } } }
	 * 
	 * } else { String
	 * sql="SELECT COUNT(*) FROM BOARD WHERE "+search+" LIKE '%'||?||'%'";
	 * psm=con.prepareStatement(sql); psm.setString(1, keyword); }
	 * 
	 * rs=psm.executeQuery(); if(rs.next()) { count=rs.getInt(1); } } catch
	 * (SQLException e) {
	 * System.out.println("[Error] selectBoardCount()�� SQL���� >> "+e.getMessage()); }
	 * finally { close(con, psm, rs); } return count; }
	 */
	
// 	������ ������ ���߰˻� �޼ҵ�
	public int selectProductCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from product";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectProductCount() ������ �޼ҵ�1�� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
//	������ ������ ���߰˻� ���� �޼ҵ�
	public int selectProductCount(String search, String keyword , String startDay, String endDay, String price1, String price2, String qty1, String qty2) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			String sql="";
			String addSQL="AND ";
			String startSQL="SELECT COUNT(*) FROM PRODUCT ";
			String searchSQL=search+" LIKE '%'||'"+keyword+"'||'%' ";
			String dateSQL="to_char(ADD_DATE,'yyyy-mm-dd') BETWEEN '"+startDay+"' AND '"+endDay+"' ";
			String qtySQL="PRODUCT_QTY between '"+qty1+"' and '"+qty2+"' ";
			String priceSQL="PRODUCT_PRICE between '"+price1+"' and '"+price2+"' ";
			
			if (!keyword.equals("") || !startDay.equals("") || !(price1.equals("")&&price2.equals("")) || !(qty1.equals("")&&qty2.equals(""))) {
				sql=startSQL+"WHERE ";
				
				if (!keyword.equals("")) {
					sql+=searchSQL;
					
					if(!startDay.equals("")){
						sql+=addSQL;
						sql+=dateSQL;
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// ������ ������
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					} else { //��¥������
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// ������ ������
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					}
					
				} else { //Ű���� ������
					if(!startDay.equals("")){
						sql+=dateSQL;
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// ������ ������
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					} else { //��¥������
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// ������ ������
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					}
					
				}
			} else {
				sql=startSQL; // ��ü�˻�
			}
			
			pstmt=con.prepareStatement(sql);
			System.out.println("sql = "+sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectProductCount() ������ �޼ҵ�2�� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
	// String wType, String wColor, String origin
	public List<ProductDTO> selectAllProduct(int startRow, int endRow, String search, String keyword , String startDay, String endDay, String price1, String price2, String qty1, String qty2, String sort) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		List<ProductDTO> productList= new ArrayList<ProductDTO>();
		try {
			con=getConnection();
			String sql="";
			String addSQL="AND ";
			String startSQL="SELECT * FROM PRODUCT ";
			String searchSQL=search+" LIKE '%'||'"+keyword+"'||'%' ";
			String dateSQL="to_char(ADD_DATE,'yyyy-mm-dd') BETWEEN '"+startDay+"' AND '"+endDay+"' ";
			String qtySQL="PRODUCT_QTY between '"+qty1+"' and '"+qty2+"' ";
			String priceSQL="PRODUCT_PRICE between '"+price1+"' and '"+price2+"' ";
			String endSQL="order by "+sort+" ";
			
			if (!keyword.equals("") || !startDay.equals("") || !(price1.equals("")&&price2.equals("")) || !(qty1.equals("")&&qty2.equals(""))) {
				sql=startSQL+"WHERE ";
				
				if (!keyword.equals("")) {
					sql+=searchSQL;
					
					if(!startDay.equals("")){
						sql+=addSQL;
						sql+=dateSQL;
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// ������ ������
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					} else { //��¥������
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// ������ ������
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					}
					
				} else { //Ű���� ������
					if(!startDay.equals("")){
						sql+=dateSQL;
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// ������ ������
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					} else { //��¥������
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// ������ ������
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					}
					
				}
				sql+=endSQL;
			} else {
				sql=startSQL+endSQL; // ��ü�˻�
			}
			
			String result="SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM ("+sql+") TEMP) WHERE RN BETWEEN ? AND ?";
			psm=con.prepareStatement(result);
			psm.setInt(1, startRow);
			psm.setInt(2, endRow);
			System.out.println("sql = "+sql);
			rs=psm.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product=new ProductDTO();
				product.setProductNum(rs.getInt("PRODUCT_NUM"));
				product.setProductCode(rs.getString("PRODUCT_CODE"));
				product.setProductName(rs.getString("PRODUCT_NAME"));
				product.setProductImage1(rs.getString("PRODUCT_IMAGE1"));
				product.setProductImage2(rs.getString("PRODUCT_IMAGE2"));
				product.setProductImage3(rs.getString("PRODUCT_IMAGE3"));
				product.setProductDetail(rs.getString("PRODUCT_DETAIL"));
				product.setProductQty(rs.getInt("PRODUCT_QTY"));
				product.setProductPrice(rs.getInt("PRODUCT_PRICE"));
				product.setAddDate(rs.getString("ADD_DATE"));
				product.setProductStatus(rs.getInt("PRODUCT_STATUS"));
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[Error] selectAllProduct()�� ������������ �޼ҵ� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return productList;
	}
	
	// ��ǰ������ ��ǰ��ȣ�� ���޹޾� PRODUCT���̺� ����� ��ǰ������ �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
	public int updateQTYProduct(int productQTY, int productNum) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update product set product_qty=? where product_num=?";
			psm=con.prepareStatement(sql);
			psm.setInt(1, productQTY);
			psm.setInt(2, productNum);
			
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] updateQTYProduct()�޼ҵ��� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
}
