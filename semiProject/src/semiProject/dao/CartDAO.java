package semiProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semiProject.dto.CartDTO;

public class CartDAO extends JdbcDAO {
	private static CartDAO _dao;
	
	private CartDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new CartDAO();
	}
	
	public static CartDAO getDAO() {
		return _dao;
	}
	
	//입력받은 id 값으로 해당 회원의 카트목록을 출력하는 메소드
	public List<CartDTO> selectIdCart(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CartDTO> cartList = new ArrayList<CartDTO>();
		
		try {
			con = getConnection();
			
			String sql="select * from cart where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setId(rs.getString("id"));
				cart.setProductNum(rs.getInt("product_num"));
				cart.setProductQTY(rs.getInt("product_qty"));
				cart.setProductPrice(rs.getInt("product_price"));
				cart.setProductTotal(rs.getInt("product_total"));
				cart.setProductImage(rs.getString("product_image"));
				cart.setProductName(rs.getString("product_name"));
				cart.setProductDetail(rs.getString("product_detail"));
				cart.setCartNum(rs.getInt("cart_num"));
				cartList.add(cart);
			}
		} catch (Exception e) {
			System.out.println("[에러]selectIdCart() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cartList;
	}
	
	//입력받은 cartNum 값으로 해당 회원의 카트목록을 출력하는 메소드
		public List<CartDTO> selectNumCart(int cartNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<CartDTO> cartList = new ArrayList<CartDTO>();
			
			try {
				con = getConnection();
				
				String sql="select * from cart where cart_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cartNum);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					CartDTO cart = new CartDTO();
					cart.setId(rs.getString("id"));
					cart.setProductNum(rs.getInt("product_num"));
					cart.setProductQTY(rs.getInt("product_qty"));
					cart.setProductPrice(rs.getInt("product_price"));
					cart.setProductTotal(rs.getInt("product_total"));
					cart.setProductImage(rs.getString("product_image"));
					cart.setProductName(rs.getString("product_name"));
					cart.setProductDetail(rs.getString("product_detail"));
					cart.setCartNum(rs.getInt("cart_num"));
					cartList.add(cart);
				}
			} catch (Exception e) {
				System.out.println("[에러]selectNumCart() 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return cartList;
		}
	
	//카트 테이블에 항목을 입력하기 위한 메소드
	public int insertCart(CartDTO cart) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con = getConnection();
			String sql="insert into cart values(?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cart.getId());
			pstmt.setInt(2, cart.getProductNum());
			pstmt.setInt(3, cart.getProductQTY());
			pstmt.setInt(4, cart.getProductPrice());
			pstmt.setInt(5, cart.getProductTotal());
			pstmt.setString(6, cart.getProductImage());
			pstmt.setString(7, cart.getProductName());
			pstmt.setString(8, cart.getProductDetail());
			pstmt.setInt(9, cart.getCartNum());
			
			rows=pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("[에러] insertCart() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	// 카트 삭제 메소드
	public int deleteCart(int cartNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con = getConnection();
			
			String sql="delete from cart where cart_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cartNum);

			rows=pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("[에러] deleteCart() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//CART_SEQ 시퀀스 객체의 다음값을 검색하여 반환하는 메소드
	public int selectCartNextNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int nextNum = 0;
		
		try {
			con = getConnection();
			
			String sql="select cart_seq.nextval from dual";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				nextNum = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("[에러]selectCartNextNum() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	// 카트 번호를 받아 해당하는 카트인스턴스를 반환하는 메소드
	public CartDTO selectNoCart(int cartNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		CartDTO cart=null;
		
		try {
			con = getConnection();
			
			String sql="select * from cart where cart_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cartNum);

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cart = new CartDTO();
				cart.setId(rs.getString("id"));
				cart.setProductNum(rs.getInt("product_num"));
				cart.setProductQTY(rs.getInt("product_qty"));
				cart.setProductPrice(rs.getInt("product_price"));
				cart.setProductTotal(rs.getInt("product_total"));
				cart.setProductImage(rs.getString("product_image"));
				cart.setProductName(rs.getString("product_name"));
				cart.setProductDetail(rs.getString("product_detail"));
				cart.setCartNum(rs.getInt("cart_num"));
			}
		} catch (Exception e) {
			System.out.println("[에러] selectNoCart() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cart;
	}
	
	// 제품 번호를 받아 해당하는 카트인스턴스를 반환하는 메소드
	public CartDTO selectProductNumIdCart(int productNum, String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		CartDTO cart=null;
		
		try {
			con = getConnection();
			
			String sql="select * from cart where product_num=? and id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			pstmt.setString(2, id);

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cart = new CartDTO();
				cart.setId(rs.getString("id"));
				cart.setProductNum(rs.getInt("product_num"));
				cart.setProductQTY(rs.getInt("product_qty"));
				cart.setProductPrice(rs.getInt("product_price"));
				cart.setProductTotal(rs.getInt("product_total"));
				cart.setProductImage(rs.getString("product_image"));
				cart.setProductName(rs.getString("product_name"));
				cart.setProductDetail(rs.getString("product_detail"));
				cart.setCartNum(rs.getInt("cart_num"));
			}
		} catch (Exception e) {
			System.out.println("[에러] selectProductNumIdCart() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cart;
	}
	
	// 동일 상품이 담겨 있는 수량이 늘어나는 메소드
	public int updateQtyCart(int productQty, int cartNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		
		try {
			con = getConnection();
			
			String sql="update cart set product_qty=product_qty+? where cart_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, productQty);
			pstmt.setInt(2, cartNum);

			rows=pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("[에러] updateQtyCart() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}
