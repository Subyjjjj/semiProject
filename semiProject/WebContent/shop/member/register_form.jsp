<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 콘텐츠 시작 { -->
<div id="container">
	<!-- <div id="wrapper_title">회원 가입</div> -->
	<div id="wrapper_title">회원 가입</div>
	<!-- 회원정보 입력/수정 시작 { -->

	<form id="fregisterform" name="fregisterform" action="<%=request.getContextPath()%>/index.jsp?part=shop/member&content=register_processing" 
		method="POST" autocomplete="off">
		<%-- input 태그 : 아이디 중복검사 실행 유무를 판단하기 위한 입력태그 --%>
		<%-- 	=> 입력값 : 0 - 아이디 중복 검사 미실행(사용 불가능 아이디; 검사도 안 한 아이디이므로) --%>
		<%-- 	=> 입력값 : 1 - 아이디 중복 검사 실행(사용 가능 아이디) --%>
		<%-- hidden으로 준 이유는 개발자가 필요한 값을 위한 것이며 name 속성에 value가 들어가고 id를 지정한 이유는 jQuery의 사용을 위한 것 --%>
		<input type="hidden" name="idCheckResult" id="idCheckResult" value="0">

		<div id="register_form" class="form_01">
			<div>
				<h2>사이트 이용정보 입력</h2>
				<ul>
					<li>
						<label for="reg_mb_id" class="sound_only">아이디<strong>필수</strong></label>
						<input type="text" name="id" value="" id="id" required
						class="frm_input half_input required " maxlength="20" placeholder="아이디">
						
						<!-- id 중복검색 버튼 -->
						<button type="button" id="idCheck" class="btn_frmline">ID 중복검색</button>
						
						<span id="idMsg" class="frm_info">아이디를 입력해 주세요.</span>
						<span id="idRegMsg" class="frm_info">아이디는 영문자로 시작되는 영문자,숫자,_의 6~20범위의 문자로만 작성 가능합니다.</span>
						<span id="idCheckMsg" class="frm_info">아이디 중복 검사를 반드시 실행해 주세요.</span>
					</li>
						 
					<li>
						<label for="reg_mb_password" class="sound_only">비밀번호<strong class="sound_only">필수</strong></label> 
						<input type="password" name="passwd" id="passwd"  required class="frm_input half_input required" maxlength="20" placeholder="비밀번호"> 
						
						<label for="reg_mb_password_re" class="sound_only">비밀번호 확인<strong>필수</strong></label> 
						<input type="password" name="repasswd" id="repasswd" required class="frm_input half_input right_input required" maxlength="20" placeholder="비밀번호 확인">
						
						<span id="passwdMsg" class="frm_info">비밀번호를 입력해 주세요.</span>
						<span id="passwdRegMsg" class="frm_info">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</span>
						
						<span id="repasswdMsg" class="frm_info">비밀번호 확인을 입력해 주세요.</span>
						<span id="repasswdMatchMsg" class="frm_info">비밀번호와 비밀번호 확인이 서로 맞지 않습니다.</span>
					</li>
				</ul>
			</div>

			<div class="tbl_frm01 tbl_wrap">
				<h2>개인정보 입력</h2>

				<ul>
					<li>
						<label for="reg_mb_name" class="sound_only">이름<strong>필수</strong></label>
						<input type="text" id="name" name="name" value="" 
						required class="frm_input half_input required " size="10" placeholder="이름">
						<span id="nameMsg" class="frm_info">이름을 입력해 주세요.</span>
					</li>


					<li>
						<label for="reg_mb_email" class="sound_only">E-mail<strong>필수</strong></label>

						<input type="text" name="email" value="" id="email" required
						class="frm_input email full_input required" size="70" maxlength="100" placeholder="E-mail">
						<span id="emailMsg" class="frm_info">이메일을 입력해 주세요.</span>
						<span id="emailRegMsg" class="frm_info">입력한 이메일이 형식에 맞지 않습니다.</span>
					</li>


					<li>
						<label for="reg_mb_hp" class="sound_only">휴대폰번호<strong>필수</strong></label>

						<input type="text" name="phone" value="" id="phone" required class="frm_input right_input full_input required" 
						maxlength="20" placeholder="휴대폰번호">
						<span id="mobileMsg" class="frm_info">전화번호를 입력해 입력해 주세요.</span>
						<span id="mobileRegMsg" class="frm_info">전화번호는 11 자리의 숫자로만 입력해 주세요.</span>
					</li>


					<li>
						<strong class="sound_only">필수</strong> 
						<label for="reg_mb_zip" class="sound_only">우편번호<strong class="sound_only"> 필수</strong></label> 
						<input type="text" name="zipcode" value="" id="zipcode" required class="frm_input required"
						size="5" maxlength="6" placeholder="우편번호" style="width: 95px">
						
						<!-- 우편번호 주소검색 -->
						<button type="button" class="btn_frmline" onclick="Postcode()">주소검색</button>
						<span id="zipcodeMsg" class="frm_info">우편번호를 입력해 주세요.</span>
						
						<br> 
						<input type="text" name="address1" value="" id="address1"  
						required class="frm_input frm_address full_input required" size="50" placeholder="기본주소"> 
						<label for="reg_mb_addr1" class="sound_only">기본주소<strong> 필수</strong></label>
						<span id="address1Msg" class="frm_info">기본주소를 입력해 주세요.</span>
						
						<br> 
						<input type="text" name="address2" value="" id="address2"
						class="frm_input frm_address full_input" size="50" placeholder="상세주소"> 
						<label for="reg_mb_addr2" class="sound_only">상세주소</label>
						<span id="address2Msg" class="frm_info">상세주소를 입력해 주세요.</span>
					</li>
				</ul>
			</div>

		</div>
		<div class="btn_confirm">
			<a href="<%=request.getContextPath()%>/index.jsp?part=shop&content=main" class="btn_cancel">취소</a> 
			<input type="submit" value="회원가입" id="btn_submit" class="btn_submit" accesskey="s">
		</div>
	</form>

<script type="text/javascript">
$("#id").focus();

$("#fregisterform").submit(function() {
	var submitResult=true;
	
	$(".frm_info").css("display","none");
	
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		submitResult=false;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		submitResult=false;
	} else if($("#idCheckResult").val()=="0") {
		$("#idCheckMsg").css("display","block");
		submitResult=false;
	}
		
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#passwd").val()=="") {
		$("#passwdMsg").css("display","block");
		submitResult=false;
	} else if(!passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	
	if($("#repasswd").val()=="") {
		$("#repasswdMsg").css("display","block");
		submitResult=false;
	} else if($("#passwd").val()!=$("#repasswd").val()) {
		$("#repasswdMatchMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	}

	var mobileReg=/\d{11}/;
	if($("#phone").val()=="") {
		$("#mobileMsg").css("display","block");
		submitResult=false;
	} else if(!mobileReg.test($("#phone").val())) {
		$("#mobileRegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#address1").val()=="") {
		$("#address1Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#address2").val()=="") {
		$("#address2Msg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
});

//메세지 영역 초기화
$("#idCheck").click(function() {
	$("#idMsg").css("display","none");
	$("#idRegMsg").css("display","none");
	
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		return;
		//submitResult=false;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		//submitResult=false;
		return;
	}
	
	window.open("<%=request.getContextPath()%>/shop/member/id_check.jsp?id="
			+$("#id").val(),"idcheck", "width=400, height=125,left=450, top=250");
});
//아이디 중복체크시 인증 실패경우 타 아이디 등록 방지 역할	
$("#id").keyup(function () {
	if($("#idCheckResult").val()=="1") {
		$("#idCheckResult").val("0");
	}
});
</script>
	
	<script>
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function Postcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('zipcode').value = data.zonecode;
							document.getElementById("address1").value = data.jibunAddress;

							var guideTextBox = document.getElementById("guide");
							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							if (data.autoRoadAddress) {
								var expRoadAddr = data.autoRoadAddress
										+ extraRoadAddr;
								guideTextBox.innerHTML = '(예상 도로명 주소 : '
										+ expRoadAddr + ')';
								guideTextBox.style.display = 'block';

							} else if (data.autoJibunAddress) {
								var expJibunAddr = data.autoJibunAddress;
								guideTextBox.innerHTML = '(예상 지번 주소 : '
										+ expJibunAddr + ')';
								guideTextBox.style.display = 'block';
							} else {
								guideTextBox.innerHTML = '';
								guideTextBox.style.display = 'none';
							}
						}
					}).open();
		}
	</script>
	<!-- } 회원정보 입력/수정 끝 -->
</div>
<!-- } 콘텐츠 끝 -->