package mybean.board;

import java.sql.*;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDao {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	//�����ڸ� ���� JNDI������ DB���ᰴü�����
	public BoardDao(){
		try{
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/DBExam");  //���󵵸���
			con = ds.getConnection();
		}
		catch(Exception err){
			System.out.println("DB���� ��ü �������� ���� : " + err);
		}
	}
	
	
	
	//�۾���
	public void upPos(){
		try{
			//�μ�Ʈ�� ������ �⺻�� ��� pos�� 1�� �������Ѷ�!
			String sql = "update tblboard set pos = pos+1";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			System.out.println("������Ʈ�������μ�Ʈ");
		}catch(Exception err){
			System.out.println("upPos()���� ���� " + err);
		}
		//finally�Ⱦ�
	}
	
	public void insertBoard(BoardDto dto){
		try{
			
			System.out.println("1�������μ�Ʈ");
			upPos();
			System.out.println("2�������μ�Ʈ");
			
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
			System.out.println("�۾��⿡�� : " + err);
		}
		finally{
			freeResource();
		}
	}
	
	//����Ʈ��������
	public Vector getBoardList(String keyField,String keyWord){
		Vector v = new Vector();
		String sql = "";
		try{
			if(keyWord == null || keyWord.isEmpty()){
				sql = "select * from tblBoard order by pos asc";
				System.out.println("�׽���111");
				System.out.println(sql);
			}
			else{
				sql = "select * from tblBoard where " + keyField + " like '%" + keyWord + "%' order by num pos asc";
				System.out.println(sql);
			}
			
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				//��ȣ�����̸���¥��ȸ��
				BoardDto dto = new BoardDto();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setName(rs.getString("name"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setCount(rs.getInt("count"));
				dto.setEmail(rs.getString("email"));
				dto.setDepth(rs.getInt("depth"));
				
				v.add(dto);
			}			
		}
		catch(Exception err){
			System.out.println("����Ʈ�������� ���� : "+err);
		}
		finally{
			freeResource();
		}
		return v;
	}
	
	//�ۺ���
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
				dto.setPos(rs.getInt("pos"));
				dto.setDepth(rs.getInt("depth"));
		}
		catch(Exception err){
			System.out.println("�ۺ��⿡�� : " + err);
		}
		finally{
			freeResource();
		}
		
		return dto;
	}
	
	//�ۼ����ϱ�
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
			System.out.println("�ۼ����ϱ⿡�� : " + err);
		}
		finally{
			freeResource();
		}
	}
	
	//�ۻ���
	public void delBoard(int num){
		try{
			con = ds.getConnection();
			String sql = "delete from tblBoard where num=" +num;
			
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("�ۻ����ϱ⿡�� : " + err);
		}
		finally{
			freeResource();
		}
	}
	
	//�亯�ϱ�
	public void replyUpPos(BoardDto dto){//�θ��dto
		try{
			con = ds.getConnection();
			int pos = dto.getPos();
			String sql ="update tblBoard set pos=pos+1 where pos>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pos);
			pstmt.executeUpdate();
		
			
		}catch(Exception err){
			System.out.println("���ö��̾����� ���� : " + err);
		}finally{freeResource();}
	}
	
	public void replyBoard(BoardDto dto){//�ڽı�dto
		try{
			con = ds.getConnection();
			int depth = dto.getDepth()+1;
			int pos = dto.getPos() +1;
			
			String sql = "insert into tblBoard(num, name, email, homepage,subject,content,pos, depth, regdate, pass, count, ip)"
		               +			 " values(seq_num.nextVal, ?,?,?,?,?,?,?,sysdate,?,0,?)";
		         pstmt = con.prepareStatement(sql);
		         pstmt.setString(1, dto.getName());
		         pstmt.setString(2, dto.getEmail());
		         pstmt.setString(3, dto.getHomepage());
		         pstmt.setString(4, dto.getSubject());
		         pstmt.setString(5, dto.getContent());
		         pstmt.setInt(6, pos);
		         pstmt.setInt(7, depth);
		         pstmt.setString(8, dto.getPass());
		         pstmt.setString(9, dto.getIp());
		       
		      
			pstmt.executeUpdate();
			
		}catch(Exception err){
			System.out.println("���ú��� ���� : " + err);
		}finally{freeResource();}
	}
	
	//�鿩����
	public String useDepth(int depth){
		String result = "";
		for(int i=0;i<depth+3; i++){
			result += "&nbsp;&nbsp;&nbsp;";
			System.out.println("depth~~");
		}
		return result;
	}
	
	//JNDI������ ����Ȱ�ü ����
	private void freeResource(){
		if(con != null){//�����̵Ǿ��ٸ�.
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
