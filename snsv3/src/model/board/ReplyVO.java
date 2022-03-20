package model.board;

//rid int primary key,
//bid int not null,
//mid varchar(20) not null,
//rmsg varchar(30) not null,
//constraint cboard_fk foreign ke
public class ReplyVO {
	private int rid;
	private int bid;
	private String mid;
	private String rmsg;

	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
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
	public String getRmsg() {
		return rmsg;
	}
	public void setRmsg(String rmsg) {
		this.rmsg = rmsg;
	}
	@Override
	public String toString() {
		return "ReplyVO [rid=" + rid + ", bid=" + bid + ", mid=" + mid + ", rmsg=" + rmsg + "]";
	}
	
	
	
	
}
