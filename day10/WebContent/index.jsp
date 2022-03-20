<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mo" class="model.melonDAO"></jsp:useBean>
<!-- index - controller - main - model에서데이터가져옴 -->
<%	
	// 웹크롤링을 통해 "초기 데이터"를 세팅하는 코드 : listener 사용

	pageContext.forward("controller.jsp?action=main");
%>