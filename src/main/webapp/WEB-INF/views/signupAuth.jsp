<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OKEEDOKEE</title>
<link rel="icon" href="/okeedokee/media/logo/favicon.ico">
<link rel="stylesheet" href="/okeedokee/css/loginpage.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">


/* main */
main{
	margin-bottom:247px;
}

#arti1 {
	max-width:900px;
	min-height: 394px;
}

#arti1 #LoginBoard h1:nth-child(1)::after{
	content: "";
	display: block;
	width: 100%;
	border-bottom: 2px solid black;
	margin-top: 10px;
}

#arti1 #LoginBoard{
	width: 300px;
    line-height: 3;	
}

#arti1 #LoginBoard input{
	border : 1px solid #FBD157;
	outline: none;
}

#arti1 #LoginBoard form ul li:nth-of-type(4){
	border: 2px solid #FBD157;
    padding: 5px;
    border-radius: 13px;
}

#arti1 #LoginBoard form ul li a{
	padding: 5px;
	display: block;
}

#arti1 #LoginBoard form ul li a::after{
	content: "";
    display: block;
    width: 0px;
    border-bottom: 2px solid black;
    margin-top: 1px;
    transition: .5s ease;
}

#arti1 #LoginBoard form ul li a:hover::after{
	width: 15px;
}

#arti1 #LoginBoard form ul li a{transition:0.5s;}


.button {
  width: 180px;
  height: 60px;
  position: absolute;
}
button {
  width: 130px;
  height: 25px;
  cursor: pointer;
  background: transparent;
  border: 1px solid #FBD157;
  outline: none;
  transition: 1s ease-in-out;
}
svg {
  position: absolute;
  left: 0;
  top: 0;
  fill: none;
  stroke: #fff;
  stroke-dasharray: 150 480;
  stroke-dashoffset: 150;
  transition: 1s ease-in-out;
}
button:hover {
  transition: 1s ease-in-out;
  background: #FBD157;
}
button:hover svg {
  stroke-dashoffset: -480;
}
button span {
  color: black;
  font-size: 15px;
  font-weight: 500;
}
</style>
</head>
<body>

<div class="totalContainer">
	<!-- 헤더 불러오기 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	
	<main>
		<nav>
			<div class="mypageNav">
				<div>
					<div class="mypageTitle">
						<h3>로그인/회원가입</h3>
					</div>
					<div class="mypageSubTitle">
						<a href="loginPage" id="focus"><h4>로그인</h4></a>
						<a href="signupAuthMove" ><h4>회원가입</h4></a>
						<a href="findId" ><h4>아이디 찾기</h4></a>
						<a href="findPw" ><h4>비밀번호 찾기</h4></a>
					</div>
					<br /><br /><br /><br />
				</div>
				<br />
				
			</div>
		</nav>
		<section>
			<article id="arti1">
				<div id="LoginBoard">
					<h1>회원가입</h1><br />
					<form action="${pageContext.request.contextPath}/mail/signupAuth" method="post" id="submit">

                       	<input type="email" name="e_mail" placeholder=" 이메일주소를 입력하세요. " ><br />
						<input type="input" name="authNum" id="authNum" placeholder=" 인증번호를 입력해주세요. " style="display:none;"/><br />

 						<button type="button" id="submitBtn">
					         <svg width="60px" height="25px" viewBox="0 0 180 60" class="border">
					           <polyline points="179,1 179,59 1,59 1,1 179,1" class="bg-line" />
					           <polyline points="179,1 179,59 1,59 1,1 179,1" class="hl-line" />
					         </svg>
					         <span>인증 메일 보내기</span>
					    </button>
					    <button type="button" id="authBtn" style="display:none;">
					         <svg width="60px" height="25px" viewBox="0 0 180 60" class="border">
					           <polyline points="179,1 179,59 1,59 1,1 179,1" class="bg-line" />
					           <polyline points="179,1 179,59 1,59 1,1 179,1" class="hl-line" />
					         </svg>
					         <span>인증하기</span>
					    </button><br />
 					</form>
				</div>
			</article>
		</section>
	</main>
	
	<!-- 푸터 불러오기 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	<script type="text/javascript">
		$(function(){
			
			$(document).ready(function(){
				let path = window.location.pathname;
				let sepa = path.split('/');
				let di = $("#LoginSubTitle").children('a');

				for (let value of di) { 
					if( window.location.pathname === value.pathname){
						value.classList.add("thisPosition");
					}
				}
			});
			
			let dice = null;
			const $email = $('[name=e_mail]'); 
			const $authNum = $('[name=authNum]'); 
			$("#submitBtn").click(function(){
				if($email.val() != ""){
					$($(this)).attr('disabled',true);
					$.ajax({ 
						type: 'post', 
						url: '${pageContext.request.contextPath}/mail/signupAuth', 
						data: {email: $email.val()}, 
						success: function(data) { 
							dice = data;
							alert("이메일로 인증번호를 발송했습니다. 확인해주십시오.");
							$("#authNum").css("display","block");
							$("#authBtn").css("display","inline");
							$("#submitBtn").css("display","none");
							
						}, 
						error: function() { 
							alert("정보를 다시 확인해주십시오."); 
							$("#submitBtn").attr('disabled',false);
						}
					});
				}else {
					alert("이메일을 입력해주세요.");
				}
			});		
			
			$("#authBtn").click(function(){
				console.log($authNum.val());
				console.log(dice);
				if($authNum.val() == dice){
					alert("인증되었습니다.");
					location.href = '${pageContext.request.contextPath}/member/signUp';
				}else{
					alert("인증번호를 다시 확인해주십시오.");
				}
			});	
		});
		
		
	</script>
</div>
</body>
</html>