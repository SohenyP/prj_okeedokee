<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"  href="css/mnw.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="smartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>

	<div class="container">
		<!-- 헤더 불러오기 -->
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

		<main>
			<nav>
				<!-- missing and witnessing 줄여서 mnw -->
				<div id="mnwNav">
					<div id="mnwTitle">
						<h3>유기견 실종 / 목격 신고</h3>
					</div>
					<div id="mnwSubTitle">
						<a href="missing"><h4>유기견 실종 신고</h4></a> 
						<a href="witnessing" id="focus"><h4>유기견 목격 신고</h4></a> 
						<a href="selfFlyer"><h4>셀프 전단지</h4></a>
					</div>
				</div> 
			</nav>
			<section>
				<article id="arti1">
					<div id="menuText"><span>유기견 목격 신고 게시판</span></div>
				</article>
				<div class="buttonBox">
				<!-- article 사이 패딩용 -->
				</div>
				<!-- 글쓰기 -->
				<article id="arti2">
					<div id="boardBox">
						<div id="board">
							<div id="boardContent">
								<input type="text" id="title" name="title" readonly="readonly" value="${mnwVO.title}"/>
								<label for="id">작성자&nbsp; |</label>
								<input type="text" name="id" id="id" readonly="readonly" value="${mnwVO.id}"/>
								<div class="btnBox">
									<!-- 실제 세션 정보 수정 필!!!! -->
									<c:if test="${sessionScope.account == mnwVO.id}">
										<a href="${pageContext.request.contextPath}/revise?bdiv=4&num=${mnwVO.num}">수정</a>
										<a href="${pageContext.request.contextPath}/back?bdiv=4&num=${mnwVO.num}">귀가</a>
										<a href="${pageContext.request.contextPath}/end?bdiv=4&num=${mnwVO.num}">종료</a>
										<a href="${pageContext.request.contextPath}/isdelete?bdiv=3&num=${mnwVO.num}">삭제</a>
									</c:if>
									<c:if test="${sessionScope.account != mnwVO.id}">
										<a href="${pageContext.request.contextPath}/missing/revise?bdiv=4&num=${mnwVO.num}">신고</a>
									</c:if>
								</div>
								<div id="informBox">
									<div id="informTitle"><span>* 기본정보</span></div>
									<div id="inform">
										<div class="imgBox">
											<c:if test="${mnwVO.hasimg == 'Y'}">
												<c:forEach var="img" items="${filelist }">
													<img alt="" src="media/img/${img.localName}" class="mySlides fade">
												</c:forEach>
											</c:if>
											<c:if test="${mnwVO.hasimg == 'N'}">
												<img src="media/logo/mainLogo.png" alt=>
											</c:if>
											
											<div class="dotbox"></div>
										</div>
										<table id="informTable">
											<tr>
												<td>성별</td>
												 <td>
													<input type="text" name="sex" id="sex" readonly="readonly" value="${mnwVO.sex }"/>
												</td>
											</tr>
											
											<tr>
												<td>견종</td>
												<td>
													<input type="text" name="species" id="species" readonly="readonly" value="${mnwVO.species }"/>
												</td>
											</tr>
											
											<tr>
												<td>특징</td>
												<td>
													<input type="text" name="characters" id="characters" readonly="readonly" value="${mnwVO.characters }"/>
												</td>
											</tr>
											
											<tr>
												<td>목격 장소</td>
												<td>
													<input type="text" name="location" id="location" readonly="readonly" value="${mnwVO.location }"/>
												</td>
											</tr>
											
											<tr>
												<td>목격일</td>
												<td>
													<input type="date" name="date" id="date" readonly="readonly" value="${mnwVO.date }"/>
												</td>
											</tr>
										</table>
										
										<div id="readContent" >${mnwVO.content }</div><br/>
										
										<div class="comment"></div>
									</div>
								</div>
								<input type="hidden" value="${mnwVO.bdiv }"/>
							</div>
						</div>
					</div>
				</article>
			</section>
		</main>

		<!-- 푸터 불러오기 -->
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</div>
	
	<script type="text/javascript" src="js/mnwRead.js"></script>
</body>
</html>