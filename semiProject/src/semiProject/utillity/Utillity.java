package semiProject.utillity;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Pattern;

//���α׷� �ۼ��� �ʿ��� �������� ����� �����ϴ� Ŭ���� (DAO Ŭ���� ����)
//������ �����ϰ� �ϱ� ���� static���� ����� �ش�
//DB�� ����� ������ �ʿ���� ���ڿ��� �߶� �����ϴ� Ŭ����
public class Utillity {
	//���ڿ��� ���޹޾� �±װ��� ���ڿ��� ��� �����Ͽ� ��ȯ�ϴ� �޼ҵ�(������ ������ ���·� �±׸� �����Ѵ�)
	public static String stripTag(String source) {
		//Pattern: ����ǥ������ �����ϱ� ���� Ŭ����
		//Pattern.compile(String regEx): ���ڿ��� ����ǥ�������� ��ȯ�Ͽ� �����ϴ� Pattern �ν��Ͻ��� ��ȯ�޾� �޼ҵ�
		//Pattern.CASE_INSENSITIVE: ��ҹ��ڸ� �������� �ʵ��� �����ϱ� ���� ����ʵ�
		Pattern htmlScript=Pattern.compile("\\]*?<.*?\\/script\\>", Pattern.CASE_INSENSITIVE);
		Pattern htmlStlye=Pattern.compile("\\]*?<.*?\\/style\\>", Pattern.CASE_INSENSITIVE);
		Pattern htmlOption=Pattern.compile("\\]*?<.*?\\/option\\>", Pattern.CASE_INSENSITIVE);
		Pattern htmlTag=Pattern.compile("\\<.*?\\>", Pattern.CASE_INSENSITIVE);
		
		//Pattern.matcher(String source): ����ǥ���İ� ���ް��� ��ó���ϱ� ���� matcher �ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
		//Matcher.replaceAll(String replacement): ����ǥ���İ� ���� ������ ���ڿ��� �˻��Ͽ� ���ϴ� ���ڿ��� �����ϴ� �޼ҵ�
		source=htmlScript.matcher(source).replaceAll(""); //source�� ������ ���Ͽ� ��ũ��Ʈ �±׸� �����Ѵ�
		source=htmlStlye.matcher(source).replaceAll(""); 
		source=htmlOption.matcher(source).replaceAll(""); 
		source=htmlTag.matcher(source).replaceAll(""); 
		
		return source;
	}
	
	//���ڿ��� ���޹޾� ��ȣȭ �˰����� �̿��Ͽ� ��ȣȭ ��ȯ�Ͽ� ��ȯ�ϴ� �޼ҵ�
	public static String encrypt(String source) {
		//��ȣȭ�� ���ڿ��� �����ϱ� ���� ����
		String password="";
		//MessageDigest: ��ȣȭ �˰����� �̿��Ͽ� ��ȣȭ ó���ϴ� ����� �����ϴ� Ŭ����
		//MessageDigest.getInstance(String algorithm): ��ȣȭ �˰����� ���޹޾� MessageDigest �ν��Ͻ��� ��ȯ�ϴ� �޼ҵ�
		//=> NoSuchAlgorithmException ���� �߻� - ����ó��
		//��ȣȭ �˰���(��, �ֹ���)
		//=> �ܹ���: ��ȣȭ�� ��Ų�� Ǯ �� ����(MD5(MD5�� C���� ���� �����ϱ� ������ ����ؼ��� �� �ȴ�), SHA-1, SHA-256(����), SHA-512 ��)
		//=> �ֹ���: ��ȣȭ�� ��Ų�� Ǯ �� �ִ�
		try {
			MessageDigest md=MessageDigest.getInstance("SHA-256");
			
			//MessageDigest.update(byte[] input): MessageDigest �ν��Ͻ��� ��ȣȭ �ϰ��� ���ڿ��� byte �迭�� �����Ͽ� �����ϴ� �޼ҵ�
			//=> �����ڵ�� �����ϱ� ���� byte�� �����Ѵ�
			//String.getBytes(): ���ڿ��� byte �迭�� ��ȯ�Ͽ� ��ȯ�ϴ� �޼ҵ�
			md.update(source.getBytes());
			
			//MessageDigest.digets(): MessageDigest �ν��Ͻ��� ����� byte �迭�� ��ȣȭ �˰����� �̿��Ͽ� ��ȣȭ ó���� byte �迭�� ��ȯ�ϴ� �޼ҵ�
			byte[] digest=md.digest(); //��ȣȭ ó���� ���ڿ����� �迭�� ����Ǿ� �ִ�
			
			//byte �迭�� ��Ұ��� ���ڿ�(String �ν��Ͻ�)�� ��ȯ�Ͽ� ����
			//=> byte �迭�� ��� ������ ���ʿ��� ���� ���� �� 16������ ���ڿ��� ��ȯ�Ͽ� ����
			for(int i =0;i<digest.length;i++) {
				password+=Integer.toHexString(digest[i]&0xff);
			}
			
			} catch (NoSuchAlgorithmException e) {
				System.out.println("[����]�߸��� ��ȣȭ �˰����� ����Ͽ����ϴ�.");
		}
		return password;
	}
}
