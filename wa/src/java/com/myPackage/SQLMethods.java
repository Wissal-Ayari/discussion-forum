/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myPackage;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author ines
 */
public class SQLMethods {

    /**
     *
     * @param port
     * @param sql
     * @param props
     * @return
     */
    private static final HashMap<String, String> sqlTokens;
    private static Pattern sqlTokenPattern;
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/discussion_forum";
    private static final String USER = "root";
    private static final String PASS = "";

    static {
        //MySQL escape sequences: http://dev.mysql.com/doc/refman/5.1/en/string-syntax.html
        String[][] search_regex_replacement = new String[][]{
            //search string     search regex        sql replacement regex
            {"\u0000", "\\x00", "\\\\0"},
            {"'", "'", "\\\\'"},
            {"\"", "\"", "\\\\\""},
            {"\b", "\\x08", "\\\\b"},
            {"\n", "\\n", "\\\\n"},
            {"\r", "\\r", "\\\\r"},
            {"\t", "\\t", "\\\\t"},
            {"\u001A", "\\x1A", "\\\\Z"},
            {"\\", "\\\\", "\\\\\\\\"}
        };
        sqlTokens = new HashMap<String, String>();
        String patternStr = "";
        for (String[] srr : search_regex_replacement) {
            sqlTokens.put(srr[0], srr[2]);
            patternStr += (patternStr.isEmpty() ? "" : "|") + srr[1];
        }
        sqlTokenPattern = Pattern.compile('(' + patternStr + ')');
    }

    public static String escape(String s) {
        Matcher matcher = sqlTokenPattern.matcher(s);
        StringBuffer sb = new StringBuffer();
        while (matcher.find()) {
            matcher.appendReplacement(sb, sqlTokens.get(matcher.group(1)));
        }
        matcher.appendTail(sb);
        return sb.toString();
    }


    public static Connection connect() {
        try {
            //Etape 2: Choisir le JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            //Etape 3: Ouvrir une connection
            System.out.println("Connecting to database...");
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

            return conn;
        } catch (SQLException | ClassNotFoundException se) {
            return null;
        }
    }

    public static int getCountRowsSQL(String sql, Connection con) {
        ResultSet rs;
        Statement stmt;

        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            rs.last();
            int count = rs.getRow();
            return count;
        } catch (SQLException e) {
            Logger.getLogger(SQLMethods.class.getName()).log(Level.SEVERE, "sql :{0}error :{1}", new Object[]{sql, e.getMessage()});
            return 0;
        }

    }

    public static int InsertNewLine(String sql) {
        try {
            Connection base = connect();

            Statement stmt = base.createStatement();
            stmt.executeUpdate(sql);

            return 1;

        } catch (SQLException e) {
            e.getMessage();
            Logger.getLogger(SQLMethods.class.getName()).log(Level.SEVERE, "sql :{0}error :{1}", new Object[]{sql, e.getMessage()});
            System.out.println(sql + e.getMessage());

            return (0);
        }
    }

    /**
     * *
     * @param username
     * @param password
     * @param port
     * @param sql
     * @return
     */

    public static Boolean verifyUser(String username, String password) {
        
        String query = "SELECT * FROM Users WHERE username='" + username
                + "' AND PASSWORD='" + password +"';";
        
        int rows = SQLMethods.getCountRowsSQL(query, SQLMethods.connect());
        return (rows == 1);
    }

    
    public static ResultSet getUserInfo(String username) {
        
        ResultSet info = null;
        ResultSet rs;
        Statement stmt;
        try {
            String query = "SELECT * FROM Users WHERE username='" + username
                        +"' LIMIT 1;";
            stmt = SQLMethods.connect().createStatement();
            rs = stmt.executeQuery(query);
            if(rs.next())
                info = rs;
            return info;
            
            
            
        } catch (SQLException ex) {
            Logger.getLogger(SQLMethods.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static ResultSet selectQuery(Connection con, String sql) {
        
        ResultSet rs = null;
        Statement stmt;
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            return rs;
          
        } catch (SQLException ex) {
            Logger.getLogger(SQLMethods.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
   
}
        
