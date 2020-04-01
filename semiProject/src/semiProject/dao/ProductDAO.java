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
	
	
	// 제품정보를 전달받아 PRODUCT테이블에 저장하고 저장행의 개수를 반환하는 메소드
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
			System.out.println("[Error] insertProduct()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	
	// 제품정보를 전달받아 PRODUCT테이블에 저장된 행을 수정하고 수정행의 개수를 반환하는 메소드
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
			System.out.println("[Error] updateProduct()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}

	// 제품정보를 전달받아 PRODUCT테이블에 저장된 행을 삭제처리(상태=9로변경)하는 메소드
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
			System.out.println("[Error] deleteProduct()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	// 선택상품 품절처리
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
			System.out.println("[Error] deleteProduct()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	
	// 상품번호 입력받아 해당 상품을 검색하여 반환하는 메소드
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
			System.out.println("[Error] selectNumProduct()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return product;
	}
	
	// 상품코드와 이름을 전달받아 PRODUCT테이블에 저장된 상품정보를 검색하여 반환하는 메소드
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
			System.out.println("[Error] selectCodeNameProduct()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return product;
	}
	
	// [추후 삭제 또는 수정예정] 전체검색 >> 페이징추가랑 다중검색에따른 매개벼수 추가해서 수정해야함
	// => 현재 상품 등록과 수정삭제기능 돌려보려구 만들었서용!!!!ㅠ_ㅠ
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
			System.out.println("[Error] selectAllProduct()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return productList;
	}
	
	//상점페이지에서 제품 디스플레이를 위한  메소드 기존 selectAllProduct에서 오버로드로 페이징처리를 위한 파라미터를 인자로 받는다.
	//와인 색과 나라를 구분하기 위해 컬러와 나라의 상품코드를 받는다. 디폴트 정렬은 최신순 등록순 내림차순.
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
			System.out.println("[Error] selectAllProduct()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return productList;
	}
	
	//PRODUCT 테이블에 저장된 게시글의 갯수를 검색하여 반환하는 메소드  => 검색 기능을 제공하기 위해 매개변수에 검색 관련 정보를 전달받아 저장 
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
			System.out.println("[에러]selectProductCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
	/* 이거... 쬼 생각좀해야될꺼같아..요...^_^ 다중검색... 늪에 빠졌거든요 저는..
	 * //product 테이블에 저장된 게시글의 갯수를 검색하여 반환하는 메소드 // => 검색어를 전달받은 경우는 해당 검색결과에 해당하는
	 * 게시글개수반환 // => ???????????????????????? public int selectProductCount(String
	 * search, String keyword, String productCode, int price1, int price2, int qty1,
	 * int qty2,String date1, String date2 ) { Connection con=null;
	 * PreparedStatement psm=null; ResultSet rs=null; int count=0; try { con=
	 * getConnection(); if(keyword.equals("")) { if(productCode.equals("")) {
	 * if(price1==0 && price2==0) { if(qty1==0 && qty2==0) { if(date1.equals("") &&
	 * date2.equals("")) { String sql="SELECT COUNT(*) FROM PRODUCT";
	 * psm=con.prepareStatement(sql); } else if (date1.equals("") ||
	 * date2.equals("")){ //♣날짜검색에 관련된것은 나중에 다시작성 } } } }
	 * 
	 * } else { String
	 * sql="SELECT COUNT(*) FROM BOARD WHERE "+search+" LIKE '%'||?||'%'";
	 * psm=con.prepareStatement(sql); psm.setString(1, keyword); }
	 * 
	 * rs=psm.executeQuery(); if(rs.next()) { count=rs.getInt(1); } } catch
	 * (SQLException e) {
	 * System.out.println("[Error] selectBoardCount()의 SQL오류 >> "+e.getMessage()); }
	 * finally { close(con, psm, rs); } return count; }
	 */
	
// 	관리자 페이지 다중검색 메소드
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
			System.out.println("[에러]selectProductCount() 관리자 메소드1의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
//	관리자 페이지 다중검색 조건 메소드
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
						}else {	// 가격이 없을때
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					} else { //날짜없을때
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// 가격이 없을때
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					}
					
				} else { //키워드 없을때
					if(!startDay.equals("")){
						sql+=dateSQL;
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// 가격이 없을때
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					} else { //날짜없을때
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// 가격이 없을때
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					}
					
				}
			} else {
				sql=startSQL; // 전체검색
			}
			
			pstmt=con.prepareStatement(sql);
			System.out.println("sql = "+sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCount() 관리자 메소드2의 SQL 오류 = "+e.getMessage());
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
						}else {	// 가격이 없을때
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					} else { //날짜없을때
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// 가격이 없을때
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					}
					
				} else { //키워드 없을때
					if(!startDay.equals("")){
						sql+=dateSQL;
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=addSQL;
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// 가격이 없을때
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					} else { //날짜없을때
						if(!(price1.equals("")&&price2.equals(""))) {
							sql+=priceSQL;
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}else {	// 가격이 없을때
							if(!(qty1.equals("")&&qty2.equals(""))) {
								sql+=addSQL;
								sql+=qtySQL;
							}
						}
					}
					
				}
				sql+=endSQL;
			} else {
				sql=startSQL+endSQL; // 전체검색
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
			System.out.println("[Error] selectAllProduct()의 관리자페이지 메소드 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return productList;
	}
	
	// 제품수량과 제품번호를 전달받아 PRODUCT테이블에 저장된 제품수량을 수정하고 수정행의 개수를 반환하는 메소드
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
			System.out.println("[Error] updateQTYProduct()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
}
