package model.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.common.JDBCUtil;

public class BoardDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//로그인에 성공한 경우에만 Create 진행
	String sql_insert="insert into cboard(bid,mid,msg) values((select nvl(max(bid),0)+1 from cboard),?,?)";
	//좋아요 + 1
	String sql_update="update cboard set favcnt=favcnt+1 where bid=?";
	//해당 게시글의 작성자만이 삭제가능
	String sql_delete="delete from cboard where bid=?";
	//"더보기"기능 : pagination(페이지네이션)
	String sql_selectAll="select * from cboard WHERE ROWNUM >= 1 AND ROWNUM <= ? order by bid desc";
	
	
	//댓글 추가, 삭제
	//댓글 수정은 현재없지만 ,  추가한다면 -> 해당 "게시글"에맞게가 아니라 선택한 "댓글"에 맞는! 이 올바를것같습니다!
	String sql_insertR="insert into reply values((select nvl(max(rid),0)+1 from reply),?,?,?)";
	String sql_deleteR="delete from reply where rid=?";
	
	//몇개의 글을 볼 수 있는지에 대한 정보를 받아옴
	public ArrayList<BoardSet> selectAll(int mcnt){
		ArrayList<BoardSet> datas = new ArrayList<BoardSet>();
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_selectAll);
			pstmt.setInt(1, mcnt);
			System.out.println("mcnt:"+mcnt);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardSet bs = new BoardSet();
				BoardVO b = new BoardVO();
				ArrayList<ReplyVO> rdatas = new ArrayList<ReplyVO>();
				
				b.setBid(rs.getInt("bid"));
				b.setFavcnt(rs.getInt("favcnt"));
				b.setMid(rs.getString("mid"));
				b.setMsg(rs.getString("msg"));
				
				String sql = "select * from reply where bid=? order by rid desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b.getBid()); //rs.getInt("bid")
				ResultSet rs2 = pstmt.executeQuery();
				//댓글의 개수
				//int cnt = 0; 
				while(rs2.next()) {
					ReplyVO r = new ReplyVO();
					r.setBid(rs2.getInt("bid"));
					r.setMid(rs2.getString("mid"));
					r.setRid(rs2.getInt("rid"));
					r.setRmsg(rs2.getString("rmsg"));
					
					rdatas.add(r);
					//cnt++;
				}
//				System.out.println(b+"에 대한 댓글의 개수 : "+cnt+"개");
//				System.out.println(rdatas.size());
				//게시물에 대한 댓글의 개수
				b.setRcnt(rdatas.size());

				bs.setBoard(b);
				bs.setRdatas(rdatas);
				datas.add(bs);
			}
		} catch (SQLException e) {
			System.out.println("BoardDAO selectAll()에서 문제 발생");
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return datas;
	}
	public boolean insert(BoardVO vo) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_insert);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getMsg());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO insert()에서 문제 발생");
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	
	public boolean update(BoardVO vo) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_update);
			pstmt.setInt(1, vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO update()에서 문제 발생");
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	
	public boolean deleteB(BoardVO vo) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_delete);
			pstmt.setInt(1, vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO delete()에서 문제 발생");
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	
	public boolean insertR(ReplyVO vo) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_insertR);
			pstmt.setInt(1, vo.getBid());
			pstmt.setString(2, vo.getMid());
			pstmt.setString(3, vo.getRmsg());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO insertR()에서 문제 발생");
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	
	
	public boolean deleteR(ReplyVO vo) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_deleteR);
			pstmt.setInt(1, vo.getRid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO deleteR()에서 문제 발생");
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
}





