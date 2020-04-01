package semiProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semiProject.dto.OrderDTO;


public class OrderDAO extends JdbcDAO {
	private static OrderDAO _dao;
	
	private OrderDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao= new OrderDAO();
	}
	
	public static OrderDAO getDAO() {
		return _dao;
	}

	
	
	// 내부에서 상태 일괄변경 메소드 (송장번호) => 고유값으로 행값 하나하나변경
	public int updateDetailAtOnce(int orderNo, int orderStatus, String delivery) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			
			if ((delivery.equals("") || delivery.equals("_")) && orderStatus!=0) {
				if (orderStatus<10) {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, CS_STATUS=0 WHERE ORDER_NO=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setInt(2, orderNo);
				} else {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, CS_STATUS=1 WHERE ORDER_NO=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setInt(2, orderNo);
				}
			} else if(orderStatus==0 && !(delivery.equals("") || delivery.equals("_"))) { 
				String sql="UPDATE ORDER_TABLE SET DELIVERY=? WHERE ORDER_NO=?";
				psm=con.prepareStatement(sql);
				psm.setString(1, delivery);
				psm.setInt(1, orderNo);
			} else if (!(delivery.equals("") || delivery.equals("_")) && orderStatus!=0) {
				if (orderStatus<10) {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, CS_STATUS=0, DELIVERY=? WHERE ORDER_NO=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setString(2, delivery);
					psm.setInt(3, orderNo);
				} else {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, DELIVERY=?, CS_STATUS=1 WHERE ORDER_NO=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setString(2, delivery);
					psm.setInt(3, orderNo);
				}
			}
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] updateDetailAtOnce()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	
	
	// 내부에서 상태 일괄변경 메소드 (송장번호) => 고유값으로 행값 하나하나변경 => 고객 메세지 추가
	public int updateDetailAtOnce(int orderNo, int orderStatus, String delivery, String customMsg) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			
			if (delivery.equals("") && orderStatus!=0) {
				if (orderStatus<10) {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, CUSTOM_MSG=? CS_STATUS=0 WHERE ORDER_NO=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setString(2, customMsg);
					psm.setInt(3, orderNo);
				} else {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, CUSTOM_MSG=?, CS_STATUS=1 WHERE ORDER_NO=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setString(2, customMsg);
					psm.setInt(3, orderNo);
				}
			} else if (!delivery.equals("") && orderStatus!=0) {
				if (orderStatus<10) {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, CS_STATUS=0, DELIVERY=?, CUSTOM_MSG=? WHERE ORDER_NO=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setString(2, delivery);
					psm.setString(3, customMsg);
					psm.setInt(4, orderNo);
				} else {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, DELIVERY=?, CUSTOM_SMG=? CS_STATUS=1 WHERE ORDER_NO=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setString(2, delivery);
					psm.setString(3, customMsg);
					psm.setInt(4, orderNo);
				}
			}
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] updateDetailAtOnce()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	
	
	// 메인에서 상태 일괄변경 메소드 => 주문번호로 묶음전체처리
	public int updateMainAtOnce(String orderNum, int orderStatus) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			if (orderStatus!=0) {
				if (orderStatus<10) {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, CS_STATUS=0 WHERE ORDER_NUM=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setString(2, orderNum);
				} else {
					String sql="UPDATE ORDER_TABLE SET ORDER_STATUS=?, CS_STATUS=1 WHERE ORDER_NUM=?";
					psm=con.prepareStatement(sql);
					psm.setInt(1, orderStatus);
					psm.setString(2, orderNum);
				}
			}
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] updateMainAtOnce()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	
	
	// 메모 일괄변경 메소드 => 주문번호로 묶음전체처리
	public int updateAdminMemo(String orderNum, String adminMemo) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			String sql="UPDATE ORDER_TABLE SET ADMIN_MSG=? WHERE ORDER_NUM=?";
			psm=con.prepareStatement(sql);
			psm.setString(1, adminMemo);
			psm.setString(2, orderNum);
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] updateAdminMemo()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	public int updatedelivery(String orderNum, String name, String phone, String address, String customMsg) {
		Connection con=null;
		PreparedStatement psm=null;
		int rows=0;
		try {
			con=getConnection();
			String sql="UPDATE ORDER_TABLE SET NAME=?, PHONE=?, ADDRESS=?, CUSTOM_MSG=? WHERE ORDER_NUM=?";
			psm=con.prepareStatement(sql);
			psm.setString(1, name);
			psm.setString(2, phone);
			psm.setString(3, address);
			psm.setString(4, customMsg);
			psm.setString(5, orderNum);
			rows=psm.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[Error] updatedelivery()메소드의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm);
		}
		return rows;
	}
	
	//검색행 개수 출력 메소드 >> 전체 주문개수
	public int totalOrderCount() {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			String sql="SELECT COUNT (*) FROM ORDER_TABLE";
			psm=con.prepareStatement(sql);
			rs=psm.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[Error] totalOrderCount()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return count;
	}
	
	// 동일한 주문번호인 주문의개수
	public int sameOrderCount(String orderNum) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			String sql="SELECT COUNT (*) FROM ORDER_TABLE WHERE ORDER_NUM="+orderNum;
			psm=con.prepareStatement(sql);
			rs=psm.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[Error] countSameOrder()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return count;
	}
	
	// [메인페이지] 오늘날짜와 카테고리가 일치하는 행의 개수 출력하는 메소드
	public int dayOrderCount(String today, int category) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			String sql="SELECT COUNT (*) FROM ORDER_TABLE WHERE to_char(order_date,'yyyy-mm-dd')=? AND ORDER_STATUS=?";
			psm=con.prepareStatement(sql);
			psm.setString(1, today);
			psm.setInt(2, category);
			rs=psm.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[Error] dayOrderCount()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return count;
	}
	
	// [메인페이지용] 매출액테이블 메소드
	public List<OrderDTO> salesAccount(String orderDate1, String orderDate2, int CSStatus) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		List<OrderDTO> orderList=new ArrayList<OrderDTO>();
		
		try {
			con=getConnection();
			
			if (CSStatus==2) {
				String sql="SELECT * FROM ORDER_TABLE WHERE to_char(order_date,'yyyy-mm-dd') BETWEEN ? AND ? ORDER BY ORDER_NO DESC";
				psm=con.prepareStatement(sql);
				psm.setString(1, orderDate1);
				psm.setString(2, orderDate2);
			} else {
				String sql="SELECT * FROM ORDER_TABLE WHERE to_char(order_date,'yyyy-mm-dd') BETWEEN ? AND ? AND CS_STATUS=? ORDER BY ORDER_NO DESC";
				psm=con.prepareStatement(sql);
				psm.setString(1, orderDate1);
				psm.setString(2, orderDate2);
				psm.setInt(3, CSStatus);
			}
			rs=psm.executeQuery();
			
			while(rs.next()) {
				OrderDTO order=new OrderDTO();
				order.setOrderNo(rs.getInt("ORDER_NO"));
				order.setOrderNum(rs.getString("ORDER_NUM"));
				order.setId(rs.getString("ID"));
				order.setName(rs.getString("NAME"));
				order.setPhone(rs.getString("PHONE"));
				order.setAddress(rs.getString("ADDRESS"));
				order.setEmail(rs.getString("EMAIL"));
				order.setCustomMsg(rs.getString("CUSTOM_MSG"));
				order.setOrderDate(rs.getString("ORDER_DATE"));
				order.setOrderStatus(rs.getInt("ORDER_STATUS"));
				order.setPaymentMethod(rs.getInt("PAYMENT_METHOD"));
				order.setOrderAmount(rs.getInt("ORDER_AMOUNT"));
				order.setProductNum(rs.getInt("PRODUCT_NUM"));
				order.setProductName(rs.getString("PRODUCT_NAME"));
				order.setProductPrice(rs.getInt("PRODUCT_PRICE"));
				order.setOrderTotal(rs.getInt("ORDER_TOTAL"));
				order.setDelivery(rs.getString("DELIVERY"));
				order.setAdminMsg(rs.getString("ADMIN_MSG"));
				order.setCSStatus(rs.getInt("CS_STATUS"));
				orderList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[Error] salesAccount()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return orderList;
	}
	
	
	
	// [단일검색] 주문고유값으로 주문 하나검색
	public OrderDTO selectOneOrder(int orderNo) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		OrderDTO order=null;
		
		try {
			con=getConnection();
			String sql="SELECT * FROM ORDER_TABLE WHERE ORDER_NO=?";
			psm=con.prepareStatement(sql);
			psm.setInt(1, orderNo);
			rs=psm.executeQuery();
			
			while(rs.next()) {
				order=new OrderDTO();
				order.setOrderNo(rs.getInt("ORDER_NO"));
				order.setOrderNum(rs.getString("ORDER_NUM"));
				order.setId(rs.getString("ID"));
				order.setName(rs.getString("NAME"));
				order.setPhone(rs.getString("PHONE"));
				order.setAddress(rs.getString("ADDRESS"));
				order.setEmail(rs.getString("EMAIL"));
				order.setCustomMsg(rs.getString("CUSTOM_MSG"));
				order.setOrderDate(rs.getString("ORDER_DATE"));
				order.setOrderStatus(rs.getInt("ORDER_STATUS"));
				order.setPaymentMethod(rs.getInt("PAYMENT_METHOD"));
				order.setOrderAmount(rs.getInt("ORDER_AMOUNT"));
				order.setProductNum(rs.getInt("PRODUCT_NUM"));
				order.setProductName(rs.getString("PRODUCT_NAME"));
				order.setProductPrice(rs.getInt("PRODUCT_PRICE"));
				order.setOrderTotal(rs.getInt("ORDER_TOTAL"));
				order.setDelivery(rs.getString("DELIVERY"));
				order.setAdminMsg(rs.getString("ADMIN_MSG"));
				order.setCSStatus(rs.getInt("CS_STATUS"));
			}
		} catch (SQLException e) {
			System.out.println("[Error] selectOneOrder()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return order;
	}
	
	
	// [상세페이지- 주문묶기에 사용] 주문전호를 전달하여 ORDER_TABLE에서 저장행을 검색하여 해당주문 반환하는 메소드
	public List<OrderDTO> selectNumOrder(String orderNum) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		List<OrderDTO> orderList=new ArrayList<OrderDTO>();
		
		try {
			con=getConnection();
			String sql="SELECT * FROM ORDER_TABLE WHERE ORDER_NUM=? ORDER BY ORDER_NO DESC";
			psm=con.prepareStatement(sql);
			psm.setString(1, orderNum);
			rs=psm.executeQuery();
			
			while(rs.next()) {
				OrderDTO order=new OrderDTO();
				order.setOrderNo(rs.getInt("ORDER_NO"));
				order.setOrderNum(rs.getString("ORDER_NUM"));
				order.setId(rs.getString("ID"));
				order.setName(rs.getString("NAME"));
				order.setPhone(rs.getString("PHONE"));
				order.setAddress(rs.getString("ADDRESS"));
				order.setEmail(rs.getString("EMAIL"));
				order.setCustomMsg(rs.getString("CUSTOM_MSG"));
				order.setOrderDate(rs.getString("ORDER_DATE"));
				order.setOrderStatus(rs.getInt("ORDER_STATUS"));
				order.setPaymentMethod(rs.getInt("PAYMENT_METHOD"));
				order.setOrderAmount(rs.getInt("ORDER_AMOUNT"));
				order.setProductNum(rs.getInt("PRODUCT_NUM"));
				order.setProductName(rs.getString("PRODUCT_NAME"));
				order.setProductPrice(rs.getInt("PRODUCT_PRICE"));
				order.setOrderTotal(rs.getInt("ORDER_TOTAL"));
				order.setDelivery(rs.getString("DELIVERY"));
				order.setAdminMsg(rs.getString("ADMIN_MSG"));
				order.setCSStatus(rs.getInt("CS_STATUS"));
				orderList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[Error] selectNumOrder()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return orderList;
	}
	
	
	// 다중검색시 결과 개수 출력
	public int selectOrderCount(String search, String keyword, String startDay, String endDay, int paymentMethod, int orderStatus, String[] check) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();

			String startSQL="SELECT COUNT(*) FROM ORDER_TABLE ";
			String searchSQL=search+" LIKE '%'||'"+keyword+"'||'%' ";
			String dateSQl="to_char(order_date,'yyyy-mm-dd') BETWEEN '"+startDay+"' AND '"+endDay+"' ";
			String payMethodSQl="PAYMENT_METHOD="+paymentMethod+" "; 
			String statusSQl="ORDER_STATUS="+orderStatus+" ";
			String addSQL="AND ";
			String CheckSQL="";
			

			System.out.println("check.length= "+check.length);
			
			
			if (orderStatus==100) {
				CheckSQL+="(";
				for (int i=0;i<check.length;i++) {
					System.out.println("check[i]="+check[i]);
					CheckSQL+="ORDER_STATUS="+Integer.parseInt(check[i])+" ";
					if(i+1!=check.length) {
						CheckSQL+="OR ";
					} 
				}
				CheckSQL+=") ";
			}
			
			System.out.println("CheckSQL="+CheckSQL);
			String sql="";
			
			if (!keyword.equals("") || !startDay.equals("") || paymentMethod!=0 || orderStatus!=0) {
				sql=startSQL+"WHERE ";
				
				if (!keyword.equals("")) {
					sql+=searchSQL;
					
					if(!startDay.equals("")) {
						sql+=addSQL;
						sql+=dateSQl;
						
						if(paymentMethod!=0) {
							sql+=addSQL;
							sql+=payMethodSQl;
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						} else { //결제없을때
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						}
						
					} else { //날짜없을때
						if(paymentMethod!=0) {
							sql+=addSQL;
							sql+=payMethodSQl;
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						} else { //결제없을때
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						}
						
					}
					
				} else { //키워드 없을때
					if(!startDay.equals("")) {
						sql+=dateSQl;
						
						if(paymentMethod!=0) {
							sql+=addSQL;
							sql+=payMethodSQl;
							
							if(orderStatus!=0) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						} else { //결제없을때
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						}
						
					} else { //날짜없을때
						if(paymentMethod!=0) {
							sql+=payMethodSQl;
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						} else { //결제없을때
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=CheckSQL;
							}
							
						}
						
					}
					
				}
				
			} else {
				sql=startSQL;
			}
			psm=con.prepareStatement(sql);
			rs=psm.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[Error] selectOrderCount()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return count;
	}
	

	
	// 다중조건검색 +페이징 메소드
	public List<OrderDTO> selectSearchOrder(int startRow, int endRow, String search, String keyword, String startDay, String endDay, int paymentMethod, int orderStatus, String[] check, String sort) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		List<OrderDTO> orderList= new ArrayList<OrderDTO>();
		try {
			con=getConnection();
			
			String startSQL="SELECT * FROM ORDER_TABLE ";
			String searchSQL=search+" LIKE '%'||'"+keyword+"'||'%' ";
			String dateSQl="to_char(order_date,'yyyy-mm-dd') BETWEEN '"+startDay+"' AND '"+endDay+"' ";
			String payMethodSQl="PAYMENT_METHOD="+paymentMethod+" "; 
			String statusSQl="ORDER_STATUS="+orderStatus+" ";
			String addSQL="AND ";
			String CheckSQL="";
			String endSQL="ORDER BY "+sort+" ";
			
			if (orderStatus==100) {
				CheckSQL+="(";
				for (int i=0;i<check.length;i++) {
					System.out.println("check[i]="+check[i]);
					CheckSQL+="ORDER_STATUS="+Integer.parseInt(check[i])+" ";
					if(i+1!=check.length) {
						CheckSQL+="OR ";
					} 
				}
				CheckSQL+=") ";
			}
			
			String sql="";
			
			if (!keyword.equals("") || !startDay.equals("") || paymentMethod!=0 || orderStatus!=0) {
				sql=startSQL+"WHERE ";
				
				if (!keyword.equals("")) {
					sql+=searchSQL;
					
					if(!startDay.equals("")) {
						sql+=addSQL;
						sql+=dateSQl;
						
						if(paymentMethod!=0) {
							sql+=addSQL;
							sql+=payMethodSQl;
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						} else { //결제없을때
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						}
						
					} else { //날짜없을때
						if(paymentMethod!=0) {
							sql+=addSQL;
							sql+=payMethodSQl;
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						} else { //결제없을때
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						}
						
					}
					
				} else { //키워드 없을때
					if(!startDay.equals("")) {
						sql+=dateSQl;
						
						if(paymentMethod!=0) {
							sql+=addSQL;
							sql+=payMethodSQl;
							
							if(orderStatus!=0) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						} else { //결제없을때
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						}
						
					} else { //날짜없을때
						if(paymentMethod!=0) {
							sql+=payMethodSQl;
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=addSQL;
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=addSQL;
								sql+=CheckSQL;
							}
							
						} else { //결제없을때
							
							if(orderStatus!=0 && orderStatus!=100) {
								sql+=statusSQl;
							} else if(orderStatus==100) {
								sql+=CheckSQL;
							}
							
						}
						
					}
					
				}
			} else {
				sql=startSQL; // 전체검색
			}
			
			sql+=endSQL;
			
			System.out.println("sql = "+sql);
			String result="SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM ("+sql+") TEMP) WHERE RN BETWEEN ? AND ?";
			psm=con.prepareStatement(result);
			psm.setInt(1, startRow);
			psm.setInt(2, endRow);
			System.out.println("sql = "+sql);
			rs=psm.executeQuery();
			
			while(rs.next()) {
				OrderDTO order=new OrderDTO();
				order.setOrderNo(rs.getInt("ORDER_NO"));
				order.setOrderNum(rs.getString("ORDER_NUM"));
				order.setId(rs.getString("ID"));
				order.setName(rs.getString("NAME"));
				order.setPhone(rs.getString("PHONE"));
				order.setAddress(rs.getString("ADDRESS"));
				order.setEmail(rs.getString("EMAIL"));
				order.setCustomMsg(rs.getString("CUSTOM_MSG"));
				order.setOrderDate(rs.getString("ORDER_DATE"));
				order.setOrderStatus(rs.getInt("ORDER_STATUS"));
				order.setPaymentMethod(rs.getInt("PAYMENT_METHOD"));
				order.setOrderAmount(rs.getInt("ORDER_AMOUNT"));
				order.setProductNum(rs.getInt("PRODUCT_NUM"));
				order.setProductName(rs.getString("PRODUCT_NAME"));
				order.setProductPrice(rs.getInt("PRODUCT_PRICE"));
				order.setOrderTotal(rs.getInt("ORDER_TOTAL"));
				order.setDelivery(rs.getString("DELIVERY"));
				order.setAdminMsg(rs.getString("ADMIN_MSG"));
				order.setCSStatus(rs.getInt("CS_STATUS"));
				orderList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[Error] selectSearchOrder()의 SQL오류 >> "+e.getMessage());
			
		} finally {
			close(con, psm, rs);
		}
		return orderList;
	}
	
	// 주문 등록을 위한 메소드
	public int insertOrder(OrderDTO order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			String sql = "insert into order_table values(ORDER_seq.nextval, ?, ?, ?, ?, ?, ?, ?, sysdate, 1, ?, ?, ?, ? ,? ,? ,? ,? ,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, order.getOrderNum());
			pstmt.setString(2, order.getId());
			pstmt.setString(3, order.getName());
			pstmt.setString(4, order.getPhone());
			pstmt.setString(5, order.getAddress());
			pstmt.setString(6, order.getEmail());
			pstmt.setString(7, order.getCustomMsg());
			pstmt.setInt(8, order.getPaymentMethod());
			pstmt.setInt(9, order.getOrderAmount());
			pstmt.setInt(10, order.getProductNum());
			pstmt.setString(11, order.getProductName());
			pstmt.setInt(12, order.getProductPrice());
			pstmt.setInt(13, order.getOrderTotal());
			pstmt.setString(14, order.getDelivery());
			pstmt.setString(15, order.getAdminMsg());
			
			rows=pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("[에러] insertOrder() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		} 
		
		return rows;
	}

	// 아이디로 주문검색
	public List<OrderDTO> selectOrderProduct(String id) {
	      Connection con=null;
	      PreparedStatement psm=null;
	      ResultSet rs=null;
	      List<OrderDTO> orderList= new ArrayList<OrderDTO>();
	      try {
	         con=getConnection();
	      
	         
	         String sql="SELECT * FROM ORDER_TABLE WHERE ID=? ORDER BY ORDER_NO DESC";
	         psm=con.prepareStatement(sql);
	         psm.setString(1, id);
	         
	         rs=psm.executeQuery();
	         
	         while(rs.next()) {
	            OrderDTO order=new OrderDTO();
	            order.setOrderNo(rs.getInt("ORDER_NO"));
	            order.setOrderNum(rs.getString("ORDER_NUM"));
	            order.setId(rs.getString("ID"));
	            order.setName(rs.getString("NAME"));
	            order.setPhone(rs.getString("PHONE"));
	            order.setAddress(rs.getString("ADDRESS"));
	            order.setEmail(rs.getString("EMAIL"));
	            order.setCustomMsg(rs.getString("CUSTOM_MSG"));
	            order.setOrderDate(rs.getString("ORDER_DATE"));
	            order.setOrderStatus(rs.getInt("ORDER_STATUS"));
	            order.setPaymentMethod(rs.getInt("PAYMENT_METHOD"));
	            order.setOrderAmount(rs.getInt("ORDER_AMOUNT"));
	            order.setProductNum(rs.getInt("PRODUCT_NUM"));
	            order.setProductName(rs.getString("PRODUCT_NAME"));
	            order.setProductPrice(rs.getInt("PRODUCT_PRICE"));
	            order.setOrderTotal(rs.getInt("ORDER_TOTAL"));
	            order.setDelivery(rs.getString("DELIVERY"));
	            order.setAdminMsg(rs.getString("ADMIN_MSG"));
	            order.setCSStatus(rs.getInt("CS_STATUS"));
	            orderList.add(order);
	         }
	      } catch (SQLException e) {
	         System.out.println("[Error] selectOrderProduct()의 관리자메소드 SQL오류 >> "+e.getMessage());
	      } finally {
	         close(con, psm, rs);
	      }
	      return orderList;
	   }
	
	
	// main 출력용 제품금액 합계
	public List<OrderDTO> selectSum(int kinds, String Day) {
	      Connection con=null;
	      PreparedStatement psm=null;
	      ResultSet rs=null;
	      List<OrderDTO> orderList= new ArrayList<OrderDTO>();
	      try {
	         con=getConnection();
	         
	         String sql="SELECT * FROM ORDER_TABLE WHERE to_char(order_date,'yyyy-mm-dd')=?";
	         if(kinds==1) {
	        	sql+="AND ORDER_STATUS BETWEEN 1 AND 6";
	         }else if(kinds==2) {
	        	 sql+="AND ORDER_STATUS BETWEEN 10 AND 31";
	         }
	         
	         psm=con.prepareStatement(sql);
	         psm.setString(1, Day);
	         
	         rs=psm.executeQuery();
	         
	         while(rs.next()) {
	            OrderDTO order=new OrderDTO();
	            order.setOrderNo(rs.getInt("ORDER_NO"));
	            order.setOrderNum(rs.getString("ORDER_NUM"));
	            order.setId(rs.getString("ID"));
	            order.setName(rs.getString("NAME"));
	            order.setPhone(rs.getString("PHONE"));
	            order.setAddress(rs.getString("ADDRESS"));
	            order.setEmail(rs.getString("EMAIL"));
	            order.setCustomMsg(rs.getString("CUSTOM_MSG"));
	            order.setOrderDate(rs.getString("ORDER_DATE"));
	            order.setOrderStatus(rs.getInt("ORDER_STATUS"));
	            order.setPaymentMethod(rs.getInt("PAYMENT_METHOD"));
	            order.setOrderAmount(rs.getInt("ORDER_AMOUNT"));
	            order.setProductNum(rs.getInt("PRODUCT_NUM"));
	            order.setProductName(rs.getString("PRODUCT_NAME"));
	            order.setProductPrice(rs.getInt("PRODUCT_PRICE"));
	            order.setOrderTotal(rs.getInt("ORDER_TOTAL"));
	            order.setDelivery(rs.getString("DELIVERY"));
	            order.setAdminMsg(rs.getString("ADMIN_MSG"));
	            order.setCSStatus(rs.getInt("CS_STATUS"));
	            orderList.add(order);
	         }
	      } catch (SQLException e) {
	         System.out.println("[Error] selectOrderProduct()의 관리자메소드 SQL오류 >> "+e.getMessage());
	      } finally {
	         close(con, psm, rs);
	      }
	      return orderList;
	   }
}