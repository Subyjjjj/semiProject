<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap&subset=korean" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>	

<style type="text/css">
.img{
    position: relative;
    background-image: url("<%=request.getContextPath() %>/shop/error/image/elsa.jpg"); 
    height: 100vh;
    background-size: cover;                                                              
}

.img-cover{
   position: absolute;
   height: 100%;
   width: 100%;
   background-color: rgba(0, 0, 0, 0.4);                                                                 
   z-index:1;
}
.img .content{
     position: absolute;
     top:50%;
     left:38%;
     transform: translate(-60%, -55%);                                                                   
     font-size:2.7em;
     color: white;
     z-index: 2;
     font-family: 'Nanum Pen Script', cursive;
}
h1{
	margin: 5%;
	font-family: 'Nanum Pen Script', cursive;
}
p{
	margin-left: 5%;
	margin-bottom: 5%;
}

button{
	padding: 10px;
	background: rgb(150,50,120);
	color: white;
	float: right;
	font-size: 40px;
	border-radius: 0.5em;
	font-family: 'Nanum Pen Script', cursive;
}

button:hover {
	transform: scale(3,3);
	opacity: 1.0;
}
</style>

</head>
<body>
	<div class="img">
		<div class="content">
			<h1 style="text-align: left;">To. 이 페이지에 접근하는 당신에게...♡</h1>
			<p>
            &nbsp;이 편지는 영국에서 최초로 시작되어 일년에 한 바퀴 돌면서 받는 사람에게 행운을 주었고 지금은 당신에게로 <br />
             옮겨진 이 편지는 4일 안에 당신 곁을 떠나야 합니다. <br />
              이 편지를 포함해서 7통을 행운이 필요한 사람에게 보내 주셔야 합니다. 복사를 해도 좋습니다. 
              혹 미신이라 하실지 모르지만 사실입니다. 영국에서 HGXWCH이라는 사람은 1930년에 이 편지를 받았습니다.<br />
             그는 비서에게 복사해서 보내라고 했습니다. 며칠 뒤에 복권이 당첨되어 20억을 받았습니다.<br />
             어떤 이는 이 편지를 받았으나 96시간 이내 자신의 손에서 떠나야 한다는 사실을 잊었습니다. 그는 곧 사직되었습니다. <br />
             나중에야 이 사실을 알고 7통의 편지를 보냈는데 다시 좋은 직장을 얻었습니다. 미국의 케네디 대통령은 이 편지를 받았지만 그냥 버렸습니다.<br />
             결국 9일 후 그는 암살 당했습니다. 기억해 주세요. 이 편지를 보내면 7년의 행운이 있을 것이고 그렇지 않으면 3년의 불행이 있을 것입니다. <br />
             그리고 이 편지를 버리거나 낙서를 해서는 절대로 안됩니다. 7통입니다. 이 편지를 받은 사람은 행운이 깃들 것입니다.<br />
              힘들겠지만 좋은게 좋다고 생각하세요. 7년의 행운을 빌면서..
              </p>
	 		<button type="submit">메인 페이지로</button>
        </div>
	 	<div class="img-cover"></div>
	</div>
	
	
	<script type="text/javascript">
		$("button").click(function() {
			location.href="<%=request.getContextPath()%>/index.jsp";
		});
	
	
	</script>
	
	
</body>
</html>


