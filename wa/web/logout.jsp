<%-- 
    Document   : logout
    Created on : Feb 7, 2017, 10:03:00 AM
    Author     : wissal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
        <%
            session.setAttribute("username", null);
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
        %>
</html>
