<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mvo" class="model.member.MemberVO"/>
<jsp:useBean id="mdao" class="model.member.MemberDAO"/>
<jsp:setProperty property="*" name="mvo"/>
<%
	String action=request.getParameter("action");
	
	if(action.equals("new")){
		// MemberDAO를 통해 insert()를 수행
	    // 화면에 회원가입 성공여부출력
	    if(mdao.insert(mvo)){
	    	out.println("<script>alert('회원가입성공! 로그인하여 이용해주세요');window.close();</script>");
	    }
	    else{
	         out.println("<script>alert('회원가입실패!');history.go(-1);</script>");
	      }
	   }
	   else if(action.equals("login")){
		   System.out.println("로그인 확인");				   
		   //mid : id1 , mpw : pw1 , mname : null
		   System.out.println("mvo");
		   
		   //login에 해당하는 비즈니스 메서드를 수행해야함. DAO
		   //input : VO	 output= T of F
	       //${mid}를 결과로 줘야함
	       //session.setAttribute()
	       
	       if(mdao.selectOne(mvo)){
	    	   session.setAttribute("mid",mvo.getMid());
	    	   response.sendRedirect("board_controller.jsp?action=main");
	       } else{
	    	   out.println("<script>alert('로그인 실패');history.go(-1);</script>");
	       }
	   }
	   else if(action.equals("logout")){
		   //세션에 저장된 값을 제거
		   session.removeAttribute("mid");
		   response.sendRedirect("board_controller.jsp?action=main");
	   }

%> --%>