<%@page import="model.melonVO"%>
<%@page import="model.BoardVO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/error.jsp"%>
<jsp:useBean id="dao" class="model.BoardDAO"/>
<jsp:useBean id="vo" class="model.BoardVO"/>
<jsp:setProperty property="*" name="vo"/>
<jsp:useBean id="mdao" class="model.melonDAO"/>
<%	
	//model과 view 를 잇는 페이
	//index가 controller에게 main페이지 요청
	//controller : main페이지는 데이터가 있어야 되는데
	//	Model 데이터가져와, 
	// DB 연동하여 데이터 가져옴.
	// Controller가 main페이지 완성됬으니까 가져가서 보여줘.
	// View가 main페이지 사용자에게 보여줌 (브라우저 v)

	//main값 들어감
	String action = request.getParameter("action");
	
	if (action.equals("main")){
		//메인페이지 보여줘.
		//로깅
		//System.out.println("확인");
		
		//1.M에게서 데이터를 확보
		//BoardDAO dao = new BoardDAO();
		ArrayList<BoardVO> datas = dao.selectAll();
		//2.V한테 데이터를 전달
		request.setAttribute("datas", datas);
		pageContext.forward("main.jsp");
		
	} else if(action.equals("board")){
		//상세 페이지 보여줘.
		//1. M에게서 데이터를 확보		
		//System.out.println("전"+vo);
		// BoardVO vo = new BoardVO(); -> useBean
		//	vo.set ~   ->setproperty
		BoardVO data = dao.selectOne(vo);
		//System.out.println("후"+data);
		//2. V한테 데이터를 전달
		request.setAttribute("data", data);
		pageContext.forward("board.jsp");
		
	} else if(action.equals("insert")){
		//w t c (bid값은 null)
		//System.out.println(vo);
		if(dao.insert(vo)){
			//다음페이지 갈 수 있음
			// form -> controller-> controller -> main
			// 버튼 누르는 액션(조회액션)
			response.sendRedirect("controller.jsp?action=main");
		}
		throw new Exception("insert 수행 중에 오류 발생");
		
	} else if(action.equals("delete")){
		if(dao.delete(vo)){
			//System.out.println("삭제확인");
			response.sendRedirect("controller.jsp?action=main");
		}
		throw new Exception("delete 수행 중에 오류발생!");
	} else if(action.equals("update")){
		//CRUD 비즈니스 메서드의 인자로 VO객체를 사용하는 것은 Spring식
		//다른 데이터들을 길게 쓰지 않아도 되기 때문에 가독성 좋아지고, 유지보수에 용이, 협업이 유리
		if(dao.update(vo)){
			//System.out.println("수정확인");
			response.sendRedirect("controller.jsp?action=main");
		}
		throw new Exception("update 수행 중에 오류발생!");
	} else if(action.equals("melon")){
		ArrayList<melonVO> mdatas = mdao.selectAll();
		request.setAttribute("mdatas", mdatas);
		pageContext.forward("melon.jsp");
	} else{
		out.println("<script>alert('action파라미터의 값이 올바르지 않습니다.')</script>");
	}
%>