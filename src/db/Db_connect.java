package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class Db_connect {
	private static Connection conn =null;
	private static Statement stmt =null;
	private static ResultSet rs = null;
	public static Connection Db_conn(){
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/learnweb?useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "123456";
		try{
			Class.forName(driver);
			conn=DriverManager.getConnection(url,username,password);
		}catch (Exception e) {
			System.out.println("数据库连接出错");
			e.printStackTrace();
			// TODO: handle exception
		}
		return conn;
	}
	public static ResultSet executeQuery(String sql){
		try{
			conn = Db_connect.Db_conn();
			stmt = (Statement)conn.createStatement();
			rs = stmt.executeQuery(sql);
		}catch (SQLException ex) {
			System.out.println("查询语句出错！");
			ex.printStackTrace();
			// TODO: handle exception
		}
		return rs;
	}
	public static int executeUpdate(String sql){
		int flag = 0;
		
		try {
			conn = Db_conn();
			stmt = (Statement)conn.createStatement();
			flag = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.err.println(e.getMessage());
			e.printStackTrace();
		}		
		return flag;
		
	}
	public static void close(){
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
