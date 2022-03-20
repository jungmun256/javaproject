package model;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
/*
 * create table melonchart(
	mid int primary key,
	rank int,
	about varchar(50) not null,
	singer varchar(30) not null,
	album varchar(50) not null
);
 */
public class melonDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql_selectAll = "select * from melonchart";
	String sql_insert = "insert into melonchart values((select nvl(max(mid),0)+1 from melonchart),?,?,?,?)";
	String url ="https://www.melon.com/chart/index.htm";
	
	public ArrayList<melonVO> selectAll(){
		conn = JDBCUtil.connect();
		
		ArrayList<melonVO> mdatas = new ArrayList<melonVO>();
		try {
			pstmt = conn.prepareStatement(sql_selectAll);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				melonVO mo = new melonVO();
				mo.setMid(rs.getInt("mid"));
				mo.setRank(rs.getString("rank"));
				mo.setAbout(rs.getString("about"));
				mo.setSinger(rs.getString("singer"));
				mo.setAlbum(rs.getString("album"));
				
				mdatas.add(mo);
			}
			rs.close();
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt,conn);
		}
		return mdatas;
	}
	
	public static void insert() {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql_insert = "insert into melonchart values((select nvl(max(mid),0)+1 from melonchart),?,?,?,?)";
		String url ="https://www.melon.com/chart/index.htm";
		
		conn = JDBCUtil.connect();
		
		try {
			pstmt = conn.prepareStatement(sql_insert);
			
			Document doc = Jsoup.connect(url).get();
			Elements ele = doc.select("tr.lst50");
			
			int cnt = 0;

			Iterator <Element>  itr_rank = ele.select("div.t_center.wrap >span.rank").iterator();
			Iterator <Element>  itr_title = ele.select("div.rank01 >span > a").iterator();
			Iterator <Element>  itr_name = ele.select("div.rank02 >span > a").iterator();
			Iterator <Element>  itr_album = ele.select("div.rank03 > a").iterator();
			while(itr_title.hasNext()) {
				
				pstmt.setString(1, itr_rank.next().text());
				pstmt.setString(2, itr_title.next().text());
				pstmt.setString(3, itr_name.next().text());
				pstmt.setString(4, itr_album.next().text());
				
				pstmt.executeUpdate();
				cnt++;
				if(cnt == 10) break;
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
	}
	
	public static void delete() {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql_delete = "truncate table melonchart";
		
		conn = JDBCUtil.connect();
		
		try {
			pstmt = conn.prepareStatement(sql_delete);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
			
	}
}
