<%-- <%@page import="model.board.BoardSet"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="model.board.BoardDAO"/>
<jsp:useBean id="vo" class="model.board.BoardVO"/>
<jsp:setProperty property="*" name="vo"/>
<jsp:useBean id="rvo" class="model.board.ReplyVO"/>
<jsp:setProperty property="*" name="rvo"/>

<%
	String action=request.getParameter("action");
	//request값은 string , 하지만 값이 없을 때 null일때는 nullpointException 발생
	String cnt = request.getParameter("cnt");
	
	//최초에는 2개의 게시글을 볼 수 있음
	//url파라미터에 현재 게시글을 몇개까지 열람할 수 있는지에 대한 정보를 저장해야한다.
	int mcnt=2;
	if(cnt != null){
		mcnt = Integer.parseInt(cnt);
	}

	String url="board_controller.jsp?action=main";
	
	if(action.equals("main")){
		ArrayList<BoardSet> datas = dao.selectAll(mcnt);
		request.setAttribute("datas",datas);
		request.setAttribute("cnt",mcnt);
		pageContext.forward("main.jsp");		
	}
	else if(action.equals("fav")){
		if(dao.update(vo)){
			pageContext.forward(url);
		} else{
			System.out.println("fav action에서 문제발생");
		}
	}
	else if(action.equals("deleteB")){
		if(dao.deleteB(vo)){
			response.sendRedirect(url);  //CUD : res.sR()    R:pC.f()
		} else{
			System.out.println("delete action에서 문제발생");
		}
	}
	else if(action.equals("deleteR")){
		if(dao.deleteR(rvo)){
			//cnt 유지
			pageContext.forward(url);
		} else{
			System.out.println("deleteR action에서 문제발생");
		}
	}
	else if(action.equals("insertB")){
		if(dao.insert(vo)){
			response.sendRedirect(url);  
		} else{
			System.out.println("insertB action에서 문제발생");
		}
	}
	else if(action.equals("insertR")){
		if(dao.insertR(rvo)){
			//cnt 유지
			pageContext.forward(url);
		} else{
			System.out.println("insertR action에서 문제발생");
		}
	}
%> --%>