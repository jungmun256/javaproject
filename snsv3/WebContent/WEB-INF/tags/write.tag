<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="type"%>

<c:if test="${mid != null}">
	<c:choose>
		<c:when test="${type=='board'}">
			<input type="text" name="msg" required placeholder="글 입력해주세요" size="50">
			<input type="submit" value="글 등록">
		</c:when>
		<c:when test="${type=='reply'}">
			<input type="text" name="rmsg" required placeholder="댓글 입력해주세요" size="50">
			<input type="submit" value="글 등록">
		</c:when>
	</c:choose>	
</c:if>

<c:if test="${mid == null}">
	<c:choose>
		<c:when test="${type=='board'}">
			<input type="text" name="msg" disabled="disabled" value="로그인 후 이용해주세요.">
		</c:when>
		<c:when test="${type=='reply'}">
			<input type="text" name="rmsg" disabled="disabled" value="로그인 후 이용해주세요.">
		</c:when>
	</c:choose>
</c:if>
