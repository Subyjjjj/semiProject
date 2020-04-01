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
	
	//BOARD 테이블에 저장된 게시글의 갯수를 검색하여 반환하는 메소드
	// => 검색 기능을 제공하기 위해 매개변수에 검색 관련 정보를 전달받아 저장 
	public int selectBoardCount(String search, String keyword, int category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			//메소드의 매개변수 저장값에 따라 다른 SQL 명령을 저장하여
			//실행되도록 설정하는 기능 - 동적 SQL
			
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
			System.out.println("[에러]selectBoardCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
	//시작 행번호와 종료 행번호를 전달받아 BOARD 테이블에 저장된 게시글 중
	//해당 범위의 게시글을 검색하여 반환하는 메소드
	// => 검색 기능을 제공하기 위해 매개변수에 검색 관련 정보를 전달받아 저장 
	public List<BoardDTO> selectAllBoard(int startRow, int endRow, String search, String keyword, int category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardDTO> boardList=new ArrayList<BoardDTO>();
		try {
			con=getConnection();
			
			if (keyword.equals("")) {
				//행번호를 이용하여 원하는 게시글을 검색하는 SQL 명령 - 페이징 처리
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
			System.out.println("[에러]selectBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardList;
	}
	
	
	// 게시판 등록을 위한 메소드
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
			System.out.println("[에러] insertBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//BOARD_SEQ 시퀀스 객체의 다음값을 검색하여 반환하는 메소드
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
			System.out.println("[에러]selectNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	
	
	
	
	//게시글번호와 카테고리를 전달받아 BOARD 테이블에 저장된 게시글을 검색하여 반환하는 메소드
	//전체페이지 쭉 뿌려주는 애 >>얘를 활용해서, 이전글 다음글 만들거임
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
			System.out.println("[에러]selectNumBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}
	
	//게시글번호를 전달받아 BOARD 테이블에 저장된 해당 게시글의 조회수를
	//1 증가 되도록 변경하고 변경행의 갯수를 반환하는 메소드
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
			System.out.println("[에러]updateReadCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 이전글 코딩
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
			System.out.println("[에러]beforeNumBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}

	// 이후글 코딩
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
			System.out.println("[에러]nextNumBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}
	
	// 게시글 삭제 관련
	public int deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "update board set status=9 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			// rows : 삭제처리된 갯수
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//게시글번호를 전달받아 BOARD테이블에 저장된 해당게시글 삭제처리하고 처리된행의 개수를 반환하는 메소드 >> 실제로는 상태변경
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
			System.out.println("[에러]UpdateBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	

	// 제품상세페이지에서 게시글을 출력하기 위한 메소드 
	public List<BoardDTO> selectProductBoard(int category, int productNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardDTO> boardList=new ArrayList<BoardDTO>();
		try {
			con=getConnection();
			
			//행번호를 이용하여 원하는 게시글을 검색하는 SQL 명령 - 페이징 처리
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
			System.out.println("[에러]selectProductBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardList;
	}
	
	//제품페이지에서 등록된 후기& 상품문의의 숫자를 계산하기 위한 메소드
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
			System.out.println("[에러]selectBoardCount() 관리자 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;		
	}
	
//	관리자 페이지용 메소드 (오버라이딩 되잇음)
	
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
			System.out.println("[에러]selectBoardCount() 관리자 메소드의 SQL 오류 = "+e.getMessage());
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
							
						} else { //카테고리없을때
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					} else { //날짜없을때
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //카테고리없을때
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					}
					
				} else { //키워드 없을때
					if(!startDay.equals("")) {
						sql+=dateSQL;
						
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //카테고리없을때
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					} else { //날짜없을때
						if(category!=0) {
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //카테고리없을때
							
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
			System.out.println("[에러]selectBoardCount() 관리자 메소드의 SQL 오류 = "+e.getMessage());
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
							
						} else { //카테고리없을때
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					} else { //날짜없을때
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //카테고리없을때
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					}
					
				} else { //키워드 없을때
					if(!startDay.equals("")) {
						sql+=dateSQL;
						
						if(category!=0) {
							sql+=addSQL;
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //카테고리없을때
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						}
						
					} else { //날짜없을때
						if(category!=0) {
							sql+=categorySQL;
							
							if(status!=10) {
								sql+=addSQL;
								sql+=statusSQL;
							}
							
						} else { //카테고리없을때
							
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
			System.out.println("[에러]selectAllBoard() 관리자 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardList;
	}
	
	// [메인페이지] 오늘날짜와 카테고리가 일치하는 행의 개수 출력하는 메소드
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
			System.out.println("[Error] dayBoardCount()의 SQL오류 >> "+e.getMessage());
		} finally {
			close(con, psm, rs);
		}
		return count;
	}
	
	
}
