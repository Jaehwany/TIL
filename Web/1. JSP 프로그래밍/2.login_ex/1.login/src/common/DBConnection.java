package common;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnection {
	public static Connection getConnection() throws SQLException {
		try {
			Context context = new InitialContext();
			Context root = (Context) context.lookup("java:comp/env");
			DataSource ds = (DataSource) root.lookup("jdbc/ssafy");
			return ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void close(AutoCloseable... closeables) {
		for (AutoCloseable c : closeables) {
			if (c != null) {
				try {
					c.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
//----------------------------------------------------------------------
/*
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/ssafyweb?serverTimezone=UTC&useUniCode=yes&characterEncoding=UTF-8";
	private static final String DB_ID = "ssafy";
	private static final String DB_PASS = "ssafy";
	
	static {
		try {
			Class.forName(DRIVER);
//			System.out.println("드라이버 로딩 성공!!");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
//			System.out.println("드라이버 로딩 실패!!");
		}
	}
	
	public static Connection getConnection() throws SQLException{
		return DriverManager.getConnection(URL, DB_ID, DB_PASS);
	}
}
*/
