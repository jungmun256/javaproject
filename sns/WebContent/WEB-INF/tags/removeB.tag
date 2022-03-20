<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- if(이글(이 댓글)의 작성자가 현재 로그인한 사람과 동일하다면,)
[삭제] -->
<!-- 태그 속성으로 값을 줌. reqest.getparameter가 아니다.** -->
<%@ attribute name="rmid" %>
<%@ attribute name="bid" %>

<c:if test="${rmid == mid}">
	<a href="board_controller.jsp?action=deleteB&bid=${bid}">[게시글 삭제]</a>
</c:if>


<a href="board_controller.jsp?action=fav&cnt=${cnt}&bid=${bid}">like♥</a>