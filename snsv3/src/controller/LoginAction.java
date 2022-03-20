package controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.member.MemberDAO;
import model.member.MemberVO;

public class LoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = new MemberVO();
		vo.setMid(request.getParameter("mid"));
		vo.setMpw(request.getParameter("mpw"));
		
		ActionForward forward= null;
		
		//t , f 에 따라 다음 액션이 달라진다
		if(dao.selectOne(vo)) {
			//브라우저 scope
			HttpSession session = request.getSession();
			session.setAttribute("mid", vo.getMid());
			//성공했을 때에만 페이지 전환
			forward = new ActionForward();
			forward.setPath("main.do");
			forward.setRedirect(false);
		}
		else {
			response.setContentType("text/html; charset=UTF-8");
			//html, CSS, JS 변경했는데도 변화가 없을 때
			// -> 기존 데이터를 참고해서 화면을 구성해서 -> 인터넷 기록을 삭제해보기
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인 실패');history.go(-1);</script>");
		}
		//로그인 실패했을 때에 forward는 null값 전달
		return forward;
	}
}