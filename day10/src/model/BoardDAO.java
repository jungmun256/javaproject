package model;

import model.BoardVO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {
		//1. DBMS 와 연동(JDBC) -> 공통로직 : JDBCUtil 클래스에서 불러와서 사용
		//2. 비즈니스 메서드 (CRUD) -> 각각의 DAO마다 사용하는 로직
	
		//코드를 분리하는 이유
		//1)코드의 재사용성 증가 2) 유지보수 용이 3) 협업 용이
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql_selectAll = "select * from pboard order by bid desc";
		String sql_selectOne = "select * from pboard where bid=?";
		String sql_insert = "insert into pboard values((select nvl(max(bid),0)+1 from pboard),?,?,?)";
		String sql_delete = "delete from pboard where bid=?";
		String sql_update = "update pboard set title=?, writer=?, content=? where bid=?";
		
		public ArrayList<BoardVO> selectAll(){
			conn = JDBCUtil.connect();
			//return을 위한 arraylist
			ArrayList<BoardVO> datas = new ArrayList<BoardVO>();
			try {
				pstmt = conn.prepareStatement(sql_selectAll);
				ResultSet rs = pstmt.executeQuery();
				while(rs.next()) {
					BoardVO vo = new BoardVO();
					//db데이터가 객체 데이터가 될 수 있는 부분 - model의 역할
					vo.setBid(rs.getInt("bid"));
					vo.setContent(rs.getString("content"));
					vo.setTitle(rs.getString("title"));
					vo.setWriter(rs.getString("writer"));
					
					datas.add(vo);
				}
				rs.close();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} finally {
				JDBCUtil.disconnect(pstmt,conn);
			}
			return datas;
		}
		//JSP식 코드 -> Spring 식으로
		//인자를 int타입으로 고정 하게 되면 유지보수가 매우 불리
		// 인자를 title, content, writer 등 뭐가 될지 모른다. -> VO를 인자로 설정하면 
		public BoardVO selectOne(BoardVO vo) {
			
			conn = JDBCUtil.connect();
			BoardVO data = null;
			try {
				pstmt = conn.prepareStatement(sql_selectOne);
				pstmt.setInt(1, vo.getBid());
				ResultSet rs = pstmt.executeQuery();
					
				if(rs.next()) {
					data = new BoardVO();
					data.setBid(rs.getInt("bid"));
					data.setContent(rs.getString("content"));
					data.setTitle(rs.getString("title"));
					data.setWriter(rs.getString("writer"));
				}
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.disconnect(pstmt, conn);
			}
			return data;
		}
		
		public boolean insert(BoardVO vo) {
			conn = JDBCUtil.connect();
			try {
				pstmt = conn.prepareStatement(sql_insert);
				pstmt.setString(1, vo.getWriter());
				pstmt.setString(2, vo.getTitle());
				pstmt.setString(3, vo.getContent());
				//결과를 보지 않아도 되기 때문에 update()
				pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
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
				pstmt.setString(1, vo.getTitle());
				pstmt.setString(2, vo.getWriter());
				pstmt.setString(3, vo.getContent());
				pstmt.setInt(4, vo.getBid());
				//결과를 보지 않아도 되기 때문에 update()
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			} finally {
				JDBCUtil.disconnect(pstmt, conn);
			}
			return true;
		}
		
		public boolean delete(BoardVO vo) {
			conn = JDBCUtil.connect();
			try {
				pstmt = conn.prepareStatement(sql_delete);
				pstmt.setInt(1, vo.getBid());
				pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			} finally {
				JDBCUtil.disconnect(pstmt, conn);
			}
			return true;
		}
	}

