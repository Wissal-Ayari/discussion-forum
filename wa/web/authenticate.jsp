<%-- 
    Document   : authenticate
    Created on : Dec 15, 2016, 12:54:05 AM
    Author     : admin
--%>
<%@page import="java.sql.Connection"%>
<%@page import="com.myPackage.SQLMethods" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% String username = request.getParameter("username"); 
           String password = request.getParameter("password");
           
           try {
        
           Connection con = SQLMethods.connect();
           
           if(con == null)
               out.println("Error");
                else { 
                        if(SQLMethods.verifyUser(username, password)) {
                            session.setAttribute("username", SQLMethods.getUserInfo(
                                    username).getString("username"));
                            session.setAttribute("firstName", SQLMethods.getUserInfo(
                                    username).getString("firstName"));
                            session.setAttribute("lastName", SQLMethods.getUserInfo(
                                    username).getString("lastName"));
                            session.setAttribute("role", SQLMethods.getUserInfo(
                                    username).getString("role"));
                            session.setAttribute("id", SQLMethods.getUserInfo(
                                    username).getInt("id"));
                            response.sendRedirect("topics.jsp");
                        }
                        else
                            out.println("User not found");
                }
           }
           catch(Exception e) {
               out.println(e.toString());
           }
            
        %>
    </body>
</html>
