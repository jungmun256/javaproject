package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session =  request.getSession();
		//세션 삭제 = session.removeAttribute("mid");
		session.invalidate();
		
		ActionForward forward = new ActionForward();
		forward.setPath("main.do");
		forward.setRedirect(false);
		
		return forward;
	}

}
