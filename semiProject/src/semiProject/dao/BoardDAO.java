package semiProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semiProject.dto.BoardDTO;

public class BoardDAO extends JdbcDAO {
	private static BoardDAO _dao;
	
	private BoardDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new BoardDAO();
	}
	
	public static BoardDAO getDAO() {
		return _dao;
	}
	
	//BOARD ���̺� ����� �Խñ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	// => �˻� ����� �����ϱ� ���� �Ű������� �˻� ���� ������ ���޹޾� ���� 
	public int selectBoardCount(String search, String keyword, int category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			//�޼ҵ��� �Ű����� ���尪�� ���� �ٸ� SQL ����� �����Ͽ�
			//����ǵ��� �����ϴ� ��� - ���� SQL
			
			if(category == 0) {
				if(keyword.equals("")) {
					String sql="select count(*) from board";
					pstmt=con.prepareStatement(sql);
				}else {
					String sql="select count(*) from board where "+search+" like '%'||?||'%'";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				}
			} else if(keyword.equals("")) {
				String sql="select count(*) from board where category=" + category;
				pstmt=con.prepareStatement(sql);
			} else if(category != 0 && !keyword.equals("")) {
				String sql="select count(*) from board where "+search+" like '%'||?||'%' and category=" + category;
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectBoardCount() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
	//���� ���ȣ�� ���� ���ȣ�� ���޹޾� BOARD ���̺� ����� �Խñ� ��
	//�ش� ������ �Խñ��� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	// => �˻� ����� �����ϱ� ���� �Ű������� �˻� ���� ������ ���޹޾� ���� 
	public List<BoardDTO> selectAllBoard(int startRow, int endRow, String search, String keyword, int category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardDTO> boardList=new ArrayList<BoardDTO>();
		try {
			con=getConnection();
			
			if (keyword.equals("")) {
				//���ȣ�� �̿��Ͽ� ���ϴ� �Խñ��� �˻��ϴ� SQL ��� - ����¡ ó��
				String sql="select * from (select rownum rn,temp.* from "
					+ "(select * from board where category="+category+" order by ref desc, num asc) "
					+ "temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else if (category != 0  && !keyword.equals("")) {
				String sql="select * from (select rownum rn,temp.* from "
						+"(select * from board where "
						+search+" like '%'||?||'%' and status!=9 and category=" + category
						+" order by ref desc, num asc) "
						+"temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setRegDate(rs.getString("reg_date"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setContent(rs.getString("content"));
				board.setStatus(rs.getInt("status"));
				boardList.add(board);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectBoard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardList;
	}
	
	
	// �Խ��� ����� ���� �޼ҵ�
	public int insertBoard(BoardDTO board) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con = getConnection();
			String sql="insert into board values(?,?,?,?,sysdate,0,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			pstmt.setString(2, board.getId());
			pstmt.setString(3, board.getWriter());
			pstmt.setString(4, board.getSubject());
			pstmt.setInt(5, board.getRef());
			pstmt.setString(6, board.getContent());
			pstmt.setInt(7, board.getStatus());
			pstmt.setInt(8, board.getCategory());
			pstmt.setString(9, board.getImage());
			pstmt.setString(10, board.getProductNum());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[����] insertBoard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//BOARD_SEQ ������ ��ü�� �������� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select board_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectNextNum() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	
	
	
	
	//�Խñ۹�ȣ�� ī�װ��� ���޹޾� BOARD ���̺� ����� �Խñ��� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	//��ü������ �� �ѷ��ִ� �� >>�긦 Ȱ���ؼ�, ������ ������ �������
	public BoardDTO selectNumBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardDTO board=null;
		try {
			con=getConnection();
			
			String sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setRegDate(rs.getString("reg_date"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setContent(rs.getString("content"));
				board.setStatus(rs.getInt("status"));
				board.setCategory(rs.getInt("category"));
				board.setImage(rs.getString("image"));
				board.setProductNum(rs.getString("product_num"));
			}
		} catch (SQLException e) {
			System.out.println("[����]selectNumBoard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}
	
	//�Խñ۹�ȣ�� ���޹޾� BOARD ���̺� ����� �ش� �Խñ��� ��ȸ����
	//1 ���� �ǵ��� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
	public int updateReadCount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update board set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[����]updateReadCount() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// ������ �ڵ�
	public BoardDTO beforeNumBoard(int num, int category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardDTO board=null;
		try {
			con=getConnection();
			
			String sql="select nvl(num, '0') as num, nvl(subject, '0') as subject from board where num = (select max(num) from board where num < ?) and category=?";
			// String sql="select nvl(a.num, 0), nvl(a.subject,0) from ( select nvl(num, '0') as num, nvl(subject, '0') as subject from board where num = (select max(num) from board where num < ?)) a, (select '' as num, '' as subject from dual) b where   1=1 and b.num = a.num(+) and b.subject = a.subject(+)";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, category);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				//board.setId(rs.getString("id"));
				//board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				//board.setRegDate(rs.getString("reg_date"));
				//board.setReadCount(rs.getInt("readcount"));
				//board.setRef(rs.getInt("ref"));
				//board.setContent(rs.getString("content"));
				//board.setStatus(rs.getInt("status"));
				//board.setCategory(rs.getInt("category"));
				//board.setImage(rs.getString("image"));
			}
		} catch (SQLException e) {
			System.out.println("[����]beforeNumBoard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}

	// ���ı� �ڵ�
	public BoardDTO nextNumBoard(int num, int category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardDTO board=null;
		try {
			con=getConnection();
			
			String sql="select nvl(num, '0') as num, nvl(subject, '0') as subject from board where num = (select min(num) from board where num > ?) and category=?";
			// String sql="select nvl(a.num, 0), nvl(a.subject,0) from ( select nvl(num, '0') as num, nvl(subject, '0') as subject from board where num = (select min(num) from board where num > ?)) a, (select '' as num, '' as subject from dual) b where   1=1 and b.num = a.num(+) and b.subject = a.subject(+)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, category);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				//board.setId(rs.getString("id"));
				//board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				//board.setRegDate(rs.getString("reg_date"));
				//board.setReadCount(rs.getInt("readcount"));
				//board.setRef(rs.getInt("ref"));
				//board.setContent(rs.getString("content"));
				//board.setStatus(rs.getInt("status"));
				//board.setCategory(rs.getInt("category"));
				//board.setImage(rs.getString("image"));
			}
		} catch (SQLException e) {
			System.out.println("[����]nextNumBoard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}
	
	// �Խñ� ���� ����
	public int deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "update board set status=9 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			// rows : ����ó���� ����
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[����]deleteMember() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//�Խñ۹�ȣ�� ���޹޾� BOARD���̺� ����� �ش�Խñ� ����ó���ϰ� ó�������� ������ ��ȯ�ϴ� �޼ҵ� >> �����δ� ���º���
	public int updateBoard(BoardDTO board) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update board set SUBJECT=?, STATUS=?, CONTENT=?, IMAGE=? WHERE NUM=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setInt(2, board.getStatus());
			pstmt.setString(3, board.getContent());
			pstmt.setString(4, board.getImage());
			pstmt.setInt(5, board.getNum());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[����]UpdateBoard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	

	// ��ǰ������������ �Խñ��� ����ϱ� ���� �޼ҵ� 
	public List<BoardDTO> selectProductBoard(int category, int productNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardDTO> boardList=new ArrayList<BoardDTO>();
		try {
			con=getConnection();
			
			//���ȣ�� �̿��Ͽ� ���ϴ� �Խñ��� �˻��ϴ� SQL ��� - ����¡ ó��
			String sql="select * from board where category="+ category +" and product_num="+ productNum +"order by ref desc, num asc";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setRegDate(rs.getString("reg_date"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setContent(rs.getString("content"));
				board.setStatus(rs.getInt("status"));
				board.setCategory(rs.getInt("category"));
				board.setImage(rs.getString("image"));
				board.setProductNum(rs.getString("product_num"));
				boardList.add(board);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectProductBoard() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardList;
	}
	
	//��ǰ���������� ��ϵ� �ı�& ��ǰ������ ���ڸ� ����ϱ� ���� �޼ҵ�
	public int selectBoardCount(int category, int productNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from board where status!=9 and category="+ category +" and product_num="+ productNum;
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectBoardCount() ������ �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
//	������ �������� �޼ҵ� (�������̵� ������)
	
	public int selectBoardCount(int category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			System.out.println(category);
			if(category==0) {
				String sql="select count(*) from board";
				pstmt=con.prepareStatement(sql);
			}else {
				String sql="select count(*) from board where category=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, category);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectBoardCount() ������ �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
	
	public int selectBoardCount(String search, String keyword, int category, String startDay, String endDay, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			String sql="";
			String addSQL="AND ";
			String startSQL="SELECT COUNT(*) FROM BOARD ";
			String searchSQL=search+" LIKE '%'||'"+keyword+"'||'%' ";
			String dateSQL="to_char(reg_date,'yyyy-mm-dd') BETWEEN '"+startDay+"' AND '"+endDay+"' ";
			String statusSQL="status="+status+" ";
			String categorySQL="category="+category+" ";
			
			if (!keyword.equals("") || !startDay.equals("") || category!=0 || status!=10) {
				sql=startSQL+"WHERE ";
				
				if (!keyword.equals("")) {
					sql+=searchSQL;
					
					if(!startDay.equals("")) {
						sql+=addSQL;
						sql+=dateSQL;
						
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //ī�װ�������
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					} else { //��¥������
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //ī�װ�������
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					}
					
				} else { //Ű���� ������
					if(!startDay.equals("")) {
						sql+=dateSQL;
						
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //ī�װ�������
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					} else { //��¥������
						if(category!=0) {
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //ī�װ�������
							
							if(status!=10) {
								sql+=statusSQL;
							}
							
						}
						
					}
					
				}
				
			} else {
				sql=startSQL;
			}
			
			System.out.println(sql);
			
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectBoardCount() ������ �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
	public List<BoardDTO> selectAllBoard(int startRow, int endRow, String search, String keyword, int category, String startDay, String endDay, int status, String sort) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardDTO> boardList=new ArrayList<BoardDTO>();
		try {
			con=getConnection();
			String sql="";
			String addSQL="AND ";
			String startSQL="SELECT * FROM BOARD ";
			String searchSQL=search+" LIKE '%'||'"+keyword+"'||'%' ";
			String dateSQL="to_char(reg_date,'yyyy-mm-dd') BETWEEN '"+startDay+"' AND '"+endDay+"' ";
			String statusSQL="status="+status+" ";
			String categorySQL="category="+category+" ";
			String endSQL="order by "+sort+" ";
			
			if (!keyword.equals("") || !startDay.equals("") || category!=0 || status!=10) {
				sql=startSQL+"WHERE ";
				
				if (!keyword.equals("")) {
					sql+=searchSQL;
					
					if(!startDay.equals("")) {
						sql+=addSQL;
						sql+=dateSQL;
						
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //ī�װ�������
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					} else { //��¥������
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //ī�װ�������
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					}
					
				} else { //Ű���� ������
					if(!startDay.equals("")) {
						sql+=dateSQL;
						
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //ī�װ�������
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					} else { //��¥������
						if(category!=0) {
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //ī�װ�������
							
							if(status!=10) {
								sql+=statusSQL;
							}
							
						}
						
					}
					
				}
				sql+=endSQL;
			} else {
				sql=startSQL+endSQL;
			}
			String result="SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM ("+sql+") TEMP) WHERE RN BETWEEN ? AND ?";
			System.out.println(sql);
			
			pstmt=con.prepareStatement(result);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setRegDate(rs.getString("reg_date"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setContent(rs.getString("content"));
				board.setStatus(rs.getInt("status"));
				board.setCategory(rs.getInt("category"));
				board.setImage(rs.getString("image"));
				boardList.add(board);
			}
		} catch (SQLException e) {
			System.out.println("[����]selectAllBoard() ������ �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardList;
	}
	
	// [����������] ���ó�¥�� ī�װ��� ��ġ�ϴ� ���� ���� ����ϴ� �޼ҵ�
	public int dayBoardCount(String today, int category) {
		Connection con=null;
		PreparedStatement psm=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			String sql="SELECT COUNT (*) FROM BOARD WHERE to_char(REG_DATE,'yyyy-mm-dd')=? AND CATEGORY=?";
			psm=con.prepareStatement(sql);
			psm.setString(1, today);
			psm.setInt(2, category);
			rs=psm.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[Error] dayBoardCount()�� SQL���� >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return count;
	}
	
	
}
