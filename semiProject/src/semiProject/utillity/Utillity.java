package semiProject.utillity;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Pattern;

//프로그램 작성에 필요한 공통적인 기능을 제공하는 클래스 (DAO 클래스 다음)
//접근을 용이하게 하기 위해 static으로 만들어 준다
//DB에 저장된 값에서 필요없는 문자열을 잘라 저장하는 클래스
public class Utillity {
	//문자열을 전달받아 태그관련 문자열을 모두 제거하여 반환하는 메소드(굉장히 강력한 형태로 태그를 제거한다)
	public static String stripTag(String source) {
		//Pattern: 정규표현식을 저장하기 위한 클래스
		//Pattern.compile(String regEx): 문자열을 정규표현식으로 변환하여 저장하는 Pattern 인스턴스를 반환받아 메소드
		//Pattern.CASE_INSENSITIVE: 대소문자를 구분하지 않도록 설정하기 위한 상수필드
		Pattern htmlScript=Pattern.compile("\\]*?<.*?\\/script\\>", Pattern.CASE_INSENSITIVE);
		Pattern htmlStlye=Pattern.compile("\\]*?<.*?\\/style\\>", Pattern.CASE_INSENSITIVE);
		Pattern htmlOption=Pattern.compile("\\]*?<.*?\\/option\\>", Pattern.CASE_INSENSITIVE);
		Pattern htmlTag=Pattern.compile("\\<.*?\\>", Pattern.CASE_INSENSITIVE);
		
		//Pattern.matcher(String source): 정규표현식과 전달값을 비교처리하기 위한 matcher 인스턴스를 반환하는 메소드
		//Matcher.replaceAll(String replacement): 정규표현식과 같은 패턴의 문자열을 검색하여 원하는 문자열로 변경하는 메소드
		source=htmlScript.matcher(source).replaceAll(""); //source를 전달해 비교하여 스크립트 태그를 제거한다
		source=htmlStlye.matcher(source).replaceAll(""); 
		source=htmlOption.matcher(source).replaceAll(""); 
		source=htmlTag.matcher(source).replaceAll(""); 
		
		return source;
	}
	
	//문자열을 전달받아 암호화 알고리즘을 이용하여 암호화 변환하여 반환하는 메소드
	public static String encrypt(String source) {
		//암호화된 문자열을 저장하기 위한 변수
		String password="";
		//MessageDigest: 암호화 알고리즘을 이용하여 암호화 처리하는 기능을 제공하는 클래스
		//MessageDigest.getInstance(String algorithm): 암호화 알고리즘을 전달받아 MessageDigest 인스턴스를 반환하는 메소드
		//=> NoSuchAlgorithmException 예외 발생 - 예외처리
		//암호화 알고리즘(단, 쌍방향)
		//=> 단방향: 암호화를 시킨뒤 풀 수 없다(MD5(MD5는 C언어로 해제 가능하기 때문에 사용해서는 안 된다), SHA-1, SHA-256(권장), SHA-512 등)
		//=> 쌍방향: 암호화를 시킨뒤 풀 수 있다
		try {
			MessageDigest md=MessageDigest.getInstance("SHA-256");
			
			//MessageDigest.update(byte[] input): MessageDigest 인스턴스에 암호화 하고자 문자열을 byte 배열로 전달하여 저장하는 메소드
			//=> 원시코드로 전송하기 위해 byte로 전송한다
			//String.getBytes(): 문자열을 byte 배열로 변환하여 반환하는 메소드
			md.update(source.getBytes());
			
			//MessageDigest.digets(): MessageDigest 인스턴스에 저장된 byte 배열을 암호화 알고리즘을 이용하여 암호화 처리후 byte 배열로 반환하는 메소드
			byte[] digest=md.digest(); //암호화 처리된 문자열들의 배열이 저장되어 있다
			
			//byte 배열의 요소값을 문자열(String 인스턴스)로 변환하여 저장
			//=> byte 배열의 요소 값에서 불필요한 값을 제거 후 16진수의 문자열로 변환하여 결합
			for(int i =0;i<digest.length;i++) {
				password+=Integer.toHexString(digest[i]&0xff);
			}
			
			} catch (NoSuchAlgorithmException e) {
				System.out.println("[에러]잘못된 암호화 알고리즘을 사용하였습니다.");
		}
		return password;
	}
}
