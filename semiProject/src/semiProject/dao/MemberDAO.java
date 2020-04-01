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
	
	//ȸ�������� ���޹޾� MEMBER ���̺� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]insertMember() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//ȸ�������� ���޹޾� MEMBER ���̺��� �������� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]updateMember() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}
	
	//ID�� ���޹޾� MEMBER ���̺��� �������� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]deleteMember() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//���̵� ���޹޾� MEMBER ���̺��� �ش� ���̵��� ȸ�������� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ� - ������ �˻�
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
			System.out.println("[����]selectIdMember() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}
	
	//���̵� ���޹޾� MEMBER ���̺� ����� �ش� ȸ�������� ������ �α��� ��¥�� ����� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]updateLastLogin() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//���̵�� ���¸� ���޹޾� MEMBER ���̺� ����� �ش� ȸ���� ���¸� 
	//�����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]updateStatus() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
//	===================�������������� �޼ҵ� =========================
//	��ü ȸ������ ����ϴ� �޼ҵ�
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
			System.out.println("[����]selectMemberCount �޼ҵ��� SQL ���� = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		
		return count;
	}
	
	
	// ���ǿ� �����ϴ� ȸ������ ����ϴ� �޼ҵ�
	
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
					}else {  // �˻� ������ 
						if(!startDay.equals("")){
							sql+=dateSQL;
						}
					}
				}else {
					sql=startSQL;
				}
			}else if(status!=10){			// ���°� 10�� �ƴҶ�
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
					}else {  // �˻� ������ 
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
			System.out.println("[����]selectMemberCount ������ �޼ҵ��� SQL ���� = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		
		return count;
	}
	
	
	
//	���۹�ȣ�� ����ȣ�� �������� ȸ������Ʈ�� ����ϴ� �޼ҵ�
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
				
				if(!keyword.equals("") || !startDay.equals("")) { // �˻� �Ǵ� ��¥ ������
					sql=startSQL+"WHERE ";
					
					if (!keyword.equals("")) {
						sql+=searchSQL;
						
						if(!startDay.equals("")){
							sql+=addSQL;
							sql+=dateSQL;
						}
						
					} else {  // �˻� ������ 
						
						if(!startDay.equals("")) {
							sql+=dateSQL;
						}

					}
					
				} 
				
			} else if (status!=10) {			// ���°� 10�� �ƴҶ�
				
				sql=startSQL+"WHERE ";
				sql+=statusSQL;
				
				if(!keyword.equals("") || !startDay.equals("")) { // �˻� �Ǵ� ��¥ �ִ°��
					if (!keyword.equals("")) {
						sql+=addSQL;
						sql+=searchSQL;
						
						if(!startDay.equals("")){
							sql+=addSQL;
							sql+=dateSQL;
						}
						
					} else {  // �˻� ������ 
						
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
			System.out.println("[����]selectAllMember ������ �޼ҵ��� SQL ���� = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		
		return memberList;
	}
	
//	�����ڷ� ��ȯ
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
			System.out.println("[����]updateManger() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
//	�Ϲ�ȸ������ ��ȯ
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
			System.out.println("[����]updateDefault() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//���̵� ã��(�̸��� e���� �Է½�)
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
			System.out.println("[����]selectEmailMember() �޼ҵ��� SQL ���� ="+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return id;
	}

	//��й�ȣ ã��(id�� e���� �Է½�)
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
				System.out.println("[����]selectIdMemberPw() �޼ҵ��� SQL ���� ="+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return passwd;
		}
	
	//��й�ȣ �缳��
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
			System.out.println("[����]updateNewPw() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//ȸ�������� ���޹޾� MEMBER ���̺� ����� �л������� �����ϰ� �������� ������ ��ȯ�ϴ� �޼ҵ�
	// => ��й�ȣ,�̸�,�̸���,��ȭ��ȣ,�����ȣ,�⺻�ּ�,���ּ� ����
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
			System.out.println("[����]updateMember() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	  
}