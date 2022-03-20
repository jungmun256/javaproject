package model.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import model.common.JNDI;

//mid varchar(20) primary key,
//mpw varchar(20) not null,
//mname varchar(15) not null

public class MemberDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	String sql_selectOne = "select * from member where mid=?";
	String sql_insert = "insert into member values(?,?,?)";
	String sql_delete = "delete from member where mid=?";
	String sql_update = "update member set mpw=?, mname=? where mid=?";
	
	
	public boolean selectOne(MemberVO vo) {
		//로그인 성공여부를 반환하는 메서
		conn=JNDI.getConnection();
		
		try {
			pstmt = conn.prepareStatement(sql_selectOne);
			pstmt.setString(1, vo.getMid());
			ResultSet rs = pstmt.executeQuery();
				
			if(rs.next()) {
				System.out.println("해당하는 id 존재");
				if(rs.getString("mpw").equals(vo.getMpw())) {
					System.out.println("pw 일치");
					return true;
				}
			}
		} catch (Exception e) {
			System.out.println("MemberDAO selectOne()에서 문제발생");
			e.printStackTrace();
			return false;
		} 
		return false;
	}
	
	public boolean insert(MemberVO vo) {
		conn=JNDI.getConnection();
		try {
			pstmt = conn.prepareStatement(sql_insert);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getMpw());
			pstmt.setString(3, vo.getMname());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("MemberDAO insert()에서 문제발생");
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
}
