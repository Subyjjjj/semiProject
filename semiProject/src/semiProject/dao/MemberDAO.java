package semiProject.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semiProject.dto.MemberDTO;

public class MemberDAO extends JdbcDAO {
	private static MemberDAO _dao;
	
	private MemberDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new MemberDAO();
	}
	
	public static MemberDAO getMemberDAO() {
		return _dao;
	}
	
	//회원정보를 전달받아 MEMBER 테이블에 저장하고 변경행의 갯수를 반환하는 메소드
	public int insertMember(MemberDTO member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "insert into member values(?,?,?,?,?,?,?,?,sysdate,null,1)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());			
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getZipcode());
			pstmt.setString(7, member.getAddress1());
			pstmt.setString(8, member.getAddress2());
			
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertMember() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//회원정보를 전달받아 MEMBER 테이블의 저장행을 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateMember(MemberDTO member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "update member set passwd=?, name=?,  email=?, phone=?, zipcode=?, address1=?, address2=? where id=? ";

			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());			
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getZipcode());
			pstmt.setString(6, member.getAddress1());
			pstmt.setString(7, member.getAddress2());
			pstmt.setString(8, member.getId());
			

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateMember() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}
	
	//ID를 전달받아 MEMBER 테이블의 저장행을 삭제하고 삭제행의 갯수를 반환하는 메소드
	public int deleteMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "delete from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//아이디를 전달받아 MEMBER 테이블에서 해당 아이디의 회원정보를 검색하여 반환하는 메소드 - 단일행 검색
	public MemberDTO selectIdMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberDTO member=null;
		try {
			con=getConnection();
				
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
				
			rs=pstmt.executeQuery();
				
			if(rs.next()) {
				member=new MemberDTO();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setPhone(rs.getString("phone"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setJoin_date(rs.getString("join_date"));
				member.setLast_login(rs.getString("last_login"));
				member.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectIdMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 해당 회원정보의 마지막 로그인 날짜를 현재로 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateLastLogin(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			String sql = "update member set last_login=sysdate where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
				
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateLastLogin() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//아이디와 상태를 전달받아 MEMBER 테이블에 저장된 해당 회원의 상태를 
	//변경하고 변경행의 갯수를 반환하는 메소드
	public int updateStatus(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set status=0 where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
//	===================관리자페이지용 메소드 =========================
//	전체 회원수를 계산하는 메소드
	public int selectMemberCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			String sql ="select count(*) from member";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectMemberCount 메소드의 SQL 오류 = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		
		return count;
	}
	
	
	// 조건에 만족하는 회원수를 계산하는 메소드
	
	public int selectMemberCount(String search, String keyword, String startDay, String endDay, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();
			String sql="";
			String addSQL="AND ";
			String startSQL="SELECT COUNT(*) FROM member ";
			String searchSQL=search+" LIKE '%'||'"+keyword+"'||'%' ";
			String dateSQL="to_char(join_date,'yyyy-mm-dd') BETWEEN '"+startDay+"' AND '"+endDay+"' ";
			String statusSQL="status="+status+" ";
			System.out.println(status);
			if(status==10) {
				if(!keyword.equals("") || !startDay.equals("")) {
					sql=startSQL+"WHERE ";
					
					if (!keyword.equals("")) {
						sql+=searchSQL;
						
						if(!startDay.equals("")){
							sql+=addSQL;
							sql+=dateSQL;
							
						}
					}else {  // 검색 없을때 
						if(!startDay.equals("")){
							sql+=dateSQL;
						}
					}
				}else {
					sql=startSQL;
				}
			}else if(status!=10){			// 상태가 10이 아닐때
				sql=startSQL+"WHERE ";
				sql+=statusSQL;
				if(!keyword.equals("") || !startDay.equals("")) {
					if (!keyword.equals("")) {
						sql+=addSQL;
						sql+=searchSQL;
						
						if(!startDay.equals("")){
							sql+=addSQL;
							sql+=dateSQL;
						}
					}else {  // 검색 없을때 
						if(!startDay.equals("")){
							sql+=addSQL;
							sql+=dateSQL;
						}
					}
				}
			}else {
				sql=startSQL;
			}
			System.out.println(sql);
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectMemberCount 관리자 메소드의 SQL 오류 = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		
		return count;
	}
	
	
	
//	시작번호와 끝번호를 기준으로 회원리스트를 출력하는 메소드
	public List<MemberDTO> selectAllMember(String search, String keyword, int startRow, int endRow, String startDay, String endDay, int status, String sort){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		
		try {
			con=getConnection();
			String sql="";
			String addSQL="AND ";
			String startSQL="SELECT * FROM member ";
			String searchSQL=search+" LIKE '%'||'"+keyword+"'||'%' ";
			String dateSQL="to_char(join_date,'yyyy-mm-dd') BETWEEN '"+startDay+"' AND '"+endDay+"' ";
			String statusSQL="status="+status+" ";
			String endSQL="order by "+sort+" ";
			
			if(status==10) {
				
				if(!keyword.equals("") || !startDay.equals("")) { // 검색 또는 날짜 있을때
					sql=startSQL+"WHERE ";
					
					if (!keyword.equals("")) {
						sql+=searchSQL;
						
						if(!startDay.equals("")){
							sql+=addSQL;
							sql+=dateSQL;
						}
						
					} else {  // 검색 없을때 
						
						if(!startDay.equals("")) {
							sql+=dateSQL;
						}

					}
					
				} 
				
			} else if (status!=10) {			// 상태가 10이 아닐때
				
				sql=startSQL+"WHERE ";
				sql+=statusSQL;
				
				if(!keyword.equals("") || !startDay.equals("")) { // 검색 또는 날짜 있는경우
					if (!keyword.equals("")) {
						sql+=addSQL;
						sql+=searchSQL;
						
						if(!startDay.equals("")){
							sql+=addSQL;
							sql+=dateSQL;
						}
						
					} else {  // 검색 없을때 
						
						if(!startDay.equals("")){
							sql+=addSQL;
							sql+=dateSQL;
						}
					}
					
				}
				
			} else {
				
				sql=startSQL;
				
			}
			sql+=endSQL;
			
			String result="SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM ("+sql+") TEMP) WHERE RN BETWEEN ? AND ?";
			System.out.println(sql);
			pstmt=con.prepareStatement(result);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO member = new MemberDTO();
				
				member.setId(rs.getString("id"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setPhone(rs.getString("phone"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setJoin_date(rs.getString("join_date"));
				member.setLast_login(rs.getString("last_login"));
				member.setStatus(rs.getInt("status"));
				memberList.add(member);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectAllMember 관리자 메소드의 SQL 오류 = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		
		return memberList;
	}
	
//	관리자로 전환
	public int updateManger(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set status=9 where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateManger() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
//	일반회원으로 전환
	public int updateDefault(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set status=1 where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateDefault() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//아이디 찾기(이름과 e메일 입력시)
	public String selectNameMemberId(String name, String email) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;		
		String id=null;

		try {
			con=getConnection();
			String sql="select id from member where name=? and email=?";	
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, name);		
			pstmt.setString(2, email);		
			
			rs=pstmt.executeQuery();			

			if(rs.next()) {
				id=rs.getString("id");
			}

		} catch (SQLException e) {
			System.out.println("[에러]selectEmailMember() 메소드의 SQL 오류 ="+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return id;
	}

	//비밀번호 찾기(id와 e메일 입력시)
	public String selectIdMemberPw(String id, String email) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String passwd=null;
	

			try {
				con=getConnection();
				String sql="select passwd from member where id=? and email=?";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, id);			
				pstmt.setString(2, email);	
				
				rs=pstmt.executeQuery();
	
				if(rs.next()) {
					passwd=rs.getString("passwd");
				}

			} catch (SQLException e) {
				System.out.println("[에러]selectIdMemberPw() 메소드의 SQL 오류 ="+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return passwd;
		}
	
	//비밀번호 재설정
	public int updateNewPw(String passwd, String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set passwd=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, passwd);
			pstmt.setString(2, id);
			
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateNewPw() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//회원정보를 전달받아 MEMBER 테이블에 저장된 학생정보를 변경하고 변경행의 갯수를 반환하는 메소드
	// => 비밀번호,이름,이메일,전화번호,우편번호,기본주소,상세주소 변경
	public int updateMemberPw(String id, String passwd) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set passwd=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, passwd);
			pstmt.setString(2, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateMember() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	  
}