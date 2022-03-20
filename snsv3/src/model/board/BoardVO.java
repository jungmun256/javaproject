package model.board;

//	bid int primary key,
//	mid varchar(20) not null,
//	msg varchar(50) not null,
//	favcnt int default 0
public class BoardVO {
	private int bid;
	private String mid;
	private String msg;
	private int favcnt;
	//테이블 칼럼으로는 존재하지 않으나, 로직적으로 필요한 속성!
	private int rcnt;
	
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getFavcnt() {
		return favcnt;
	}
	public void setFavcnt(int favcnt) {
		this.favcnt = favcnt;
	}
	public int getRcnt() {
		return rcnt;
	}
	public void setRcnt(int rcnt) {
		this.rcnt = rcnt;
	}
	@Override
	public String toString() {
		return "BoardVO [bid=" + bid + ", mid=" + mid + ", msg=" + msg + ", favcnt=" + favcnt + ", rcnt=" + rcnt + "]";
	}
	
	
	
	
}
