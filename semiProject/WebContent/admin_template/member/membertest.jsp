<%@page import="semiProject.dao.MemberDAO"%>
<%@page import="semiProject.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%
	for(int i=1; i<500; i++){
		MemberDTO member =new MemberDTO();
		member.setId("Taewhi"+i);
		member.setPasswd("asdfqwer!"+i+(i+1));
		member.setName("최태휘"+i);
		member.setEmail("Taewhi"+i+"@naver.com");
		member.setPhone("010-1"+i+"3-1594");
		member.setZipcode("asdf"+i);
		member.setAddress1("asdsadasd");
		member.setAddress2("asdfasfew");
		
		MemberDAO.getMemberDAO().insertMember(member);
	}


%>


<h2>태휘형 아이디 500개 만들기</h2>