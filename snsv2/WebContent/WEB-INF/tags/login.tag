<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- if(로그인상태라면)
로그아웃 
else
로그인 -->

<!-- 컨트롤러에서 mdao로 login() = Read, selectOne
-> 컨트롤러가 만들어내는 데이터 -> mid*** -->

<form method="post" action="member_controller.jsp">
	<c:choose>
		<c:when test="${mid == null}">
			<input type="hidden" name="action" value="login">
			ID : <input type="text" name="mid" required placeholder="아이디를 입력하세요">
			PW : <input type="password" name="mpw" required placeholder="비밀번호를 입력하세요">
			<input type="submit" value="LOGIN">
		</c:when>
		<c:otherwise>
			<input type="hidden" name="action" value="logout">
			${mid}님 환영합니다!<br>
			<input type="submit" value="LOGOUT">
		</c:otherwise>
	</c:choose>
</form>
