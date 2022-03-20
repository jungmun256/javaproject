package controller;

public class ActionForward {
	
	// 데이터 전송 여부 방식
	private boolean redirect;
	// 경로
	private String path;
	
	// redirect 방식이 T -> 전달할 정보가 없음
	// forward 방식 F -> 전달할 정보가 있음
	
	public boolean isRedirect() {
		return redirect;
	}
	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	
}
