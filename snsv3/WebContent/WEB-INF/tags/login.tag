<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- if(로그인상태라면)
로그아웃 
else
로그인 -->

<!-- 컨트롤러에서 mdao로 login() = Read, selectOne
-> 컨트롤러가 만들어내는 데이터 -> mid*** -->


<c:choose>

	<c:when test="${mid == null}">
		<form method="post" action="login.mem">
			ID : <input type="text" name="mid" required placeholder="아이디를 입력하세요">
			PW : <input type="password" name="mpw" required placeholder="비밀번호를 입력하세요">
			<input type="submit" value="LOGIN">
		</form>
	</c:when>
	
	<c:otherwise>
		<form method="post" action="logout.mem">
			${mid}님 환영합니다!<br>
			<input type="submit" value="LOGOUT">
		</form>
	</c:otherwise>
	
</c:choose>


<!-- 1. form을 각각의 상황에 대해 사용할 수 있도록 분리 -->
<!-- 2. action 파라미터를 이용 : frontController에서 분류-->
