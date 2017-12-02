<%-- 
    Document   : topics
    Created on : Dec 18, 2016, 11:29:06 AM
    Author     : admin
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.myPackage.SQLMethods" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="addComment.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="mystyle.css"> 
        <title>Topics </title>
    </head>
    <body> <br> 
        <%            
            if(session.getAttribute("username") != null){ 
        %>
        <a href="logout.jsp" style=" float : right;" ><img src="logout.png">&nbsp;</a>
        <%
          if(request.getParameter("title") == null || request.getParameter("description") == null) 
          {
  
        %>
    <div class="container">
        <div class="row">
            <div class="comments-container">
                    		
       <h1>Hello, <%= session.getAttribute("firstName") + " " +
                        session.getAttribute("lastName") +" !"%> </h1>
         <div class="detailBox" >
            <div class="titleBox">     
                <div class="form-group">
                    <form method="post" action="topics.jsp" >
                           <h4>Add new topic :</h4>
                           Title : <input type="text" name="title" class="form-control">
                           Description :<textarea name="description"class="form-control" type="text" id="comment"  placeholder="What's on your mind ?">
                                        </textarea><br>
                                        <center><input type="submit" value="Post" class="button"></center>
                    </form>
                </div>
            </div>
        </div>
        <ul id="comments-list" class="comments-list">
        <% } 
            else { 
                    String title = request.getParameter("title");
                    String description = request.getParameter("description");
                    int user_id = (int)session.getAttribute("id");
                    java.sql.Date date = new java.sql.Date(new java.util.Date().getTime());
                    String sql = "INSERT INTO Topics(title, description, date, user_id) "
                + "VALUES(?, ?, ?, ?)";
                    Connection con = SQLMethods.connect();
                    PreparedStatement stmt = con.prepareStatement(sql);
                    stmt.setString(1, title);
                    stmt.setString(2, description);
                    stmt.setDate(3, date);
                    stmt.setInt(4, user_id);
                    stmt.executeUpdate(); %>
         
        </ul>
    <div class="container">
        <div class="row">
            <div class="comments-container">
                 <h1>Hello, <%= session.getAttribute("firstName") + " " +
                        session.getAttribute("lastName") +" !"%> </h1>
   
                    <div class="detailBox" >
                        <div class="titleBox">     
                            <div class="form-group">
                                   <form method="post" action="topics.jsp">
                                       <h4>Add new topic :</h4>
                                       Title : <input type="text" name="title" class="form-control">
                                       Description :<textarea name="description"class="form-control" type="text" id="comment"  placeholder="What's on your mind ?">
                                                    </textarea><br>
                                                    <center><input type="submit" value="Post" class="button"></center>
                                   </form>
                            </div>
                        </div>
                    </div>
            <ul id="comments-list" class="comments-list">
                
            <% }
            String sql1 = "SELECT * FROM Topics";
            ResultSet rs = null;
            Connection con = SQLMethods.connect();
            rs = SQLMethods.selectQuery(con, sql1);
            while(rs.next()) { %>
            <li style="margin-left: 70px ;"><a href="showMessages.jsp?id=<%= rs.getInt("id")%>"><%= rs.getString("title") %></a></li>
            <% } %>
            
            </ul>
             </div>
        </div>
    </div>
            <%
            }else{
                 response.sendRedirect("index.jsp");
            }
            
            %>
    </body>
</html>