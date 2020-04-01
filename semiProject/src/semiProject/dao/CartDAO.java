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
	
	//�Է¹��� id ������ �ش� ȸ���� īƮ����� ����ϴ� �޼ҵ�
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
			System.out.println("[����]selectIdCart() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cartList;
	}
	
	//�Է¹��� cartNum ������ �ش� ȸ���� īƮ����� ����ϴ� �޼ҵ�
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
				System.out.println("[����]selectNumCart() �޼ҵ��� SQL ���� = " + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return cartList;
		}
	
	//īƮ ���̺� �׸��� �Է��ϱ� ���� �޼ҵ�
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
			System.out.println("[����] insertCart() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	// īƮ ���� �޼ҵ�
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
			System.out.println("[����] deleteCart() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//CART_SEQ ������ ��ü�� �������� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]selectCartNextNum() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	// īƮ ��ȣ�� �޾� �ش��ϴ� īƮ�ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����] selectNoCart() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cart;
	}
	
	// ��ǰ ��ȣ�� �޾� �ش��ϴ� īƮ�ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����] selectProductNumIdCart() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cart;
	}
	
	// ���� ��ǰ�� ��� �ִ� ������ �þ�� �޼ҵ�
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
			System.out.println("[����] updateQtyCart() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}
