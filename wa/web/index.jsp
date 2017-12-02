<%-- 
    Document   : index
    Created on : Dec 14, 2016, 3:55:44 PM
    Author     : admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" 
              integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="style.css" >
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="wrap">
                        <p class="form-title">
                            Sign In</p>
                        <form method="post" action="authenticate.jsp" class="login">
                            <input type="text" placeholder="Username" name="username" />
                            <input type="password" placeholder="Password" name="password"/>
                            <input type="submit" value="Submit" class="btn btn-success btn-sm" />
                        </form>
                    </div>
                </div>
            </div>
        </div>        
    </body>
</html>
