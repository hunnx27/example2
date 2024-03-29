package mybean.board;

import java.sql.*;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDao_bak1 {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	//생성자를 통한 JNDI를통한 DB연결객체만들기
	public BoardDao_bak1(){
		try{
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/DBExam");  //가상도메인
			con = ds.getConnection();
		}
		catch(Exception err){
			System.out.println("DB연결 객체 가져오기 실패 : " + err);
		}
	}
	
	//글쓰기
	public void insertBoard(BoardDto dto){
		try{
			
			String sql = "insert into tblBoard(num, name, email, homepage,subject,content,pos, depth, regdate, pass, count, ip)"
		               + " values(seq_num.nextVal, ?,?,?,?,?,0,0,sysdate,?,0,?)";
		         pstmt = con.prepareStatement(sql);
		         pstmt.setString(1, dto.getName());
		         pstmt.setString(2, dto.getEmail());
		         pstmt.setString(3, dto.getHomepage());
		         pstmt.setString(4, dto.getSubject());
		         pstmt.setString(5, dto.getContent());
		         pstmt.setString(6, dto.getPass());
		         pstmt.setString(7, dto.getIp());
		       
		         
			pstmt.executeUpdate();
			
		}	
		catch(Exception err){
			System.out.println("글쓰기에러 : " + err);
		}
		finally{
			freeResource();
		}
	}
	
	//리스트가져오기
	public Vector getBoardList(String keyField,String keyWord){
		Vector v = new Vector();
		String sql = "";
		try{
			if(keyWord == null || keyWord.isEmpty()){
				sql = "select * from tblBoard order by num desc";
				System.out.println("테스투111");
				System.out.println(sql);
			}
			else{
				sql = "select * from tblBoard where " + keyField + " like '%" + keyWord + "%' order by num desc";
				System.out.println(sql);
			}
			
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				//번호제목이름날짜조회수
				BoardDto dto = new BoardDto();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setName(rs.getString("name"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setCount(rs.getInt("count"));
				dto.setEmail(rs.getString("email"));
				
				v.add(dto);
			}			
		}
		catch(Exception err){
			System.out.println("리스트가져오기 에러 : "+err);
		}
		finally{
			freeResource();
		}
		return v;
	}
	
	//글보기
	public BoardDto getBoard(int num){
		BoardDto dto = new BoardDto();
		String sql;
		try{
			
			sql = "update tblBoard set count=count+1 where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from tblBoard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			rs.next();
			
				dto.setContent(rs.getString("Content"));
				dto.setCount(rs.getInt("count"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setPass(rs.getString("pass"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setIp(rs.getString("ip"));
				dto.setName(rs.getString("name"));
		}
		catch(Exception err){
			System.out.println("글보기에러 : " + err);
		}
		finally{
			freeResource();
		}
		
		return dto;
	}
	
	//글수정하기
	public void updateBoard(BoardDto dto){
		String sql;
		try{
			con = ds.getConnection();
			sql = "update tblBoard set name=?,email=?,subject=?,content=? where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getNum());
			pstmt.executeUpdate();

		}
		catch(Exception err){
			System.out.println("글수정하기에러 : " + err);
		}
		finally{
			freeResource();
		}
	}
	
	//글삭제
	public void delBoard(int num){
		try{
			con = ds.getConnection();
			String sql = "delete from tblBoard where num=" +num;
			
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("글삭제하기에러 : " + err);
		}
		finally{
			freeResource();
		}
	}
	
	//JNDI를통한 연결된객체 끊기
	private void freeResource(){
		if(con != null){//연결이되었다면.
			try{
				con.close();
			}catch(Exception err){}
		}
		if(pstmt != null){
			try{
				pstmt.close();
			}catch(Exception err){}
		}
		if(rs != null){
			try{
				rs.close();
			}catch(Exception err){}
		}
	}
}
