<%--
    Document   : showMessages
    Created on : Jan 19, 2017, 5:37:03 PM
    Author     : admin
--%>

<%@page import="javax.xml.transform.dom.DOMSource"%>
<%@page import="javax.xml.transform.Transformer"%>
<%@page import="javax.xml.transform.stream.StreamResult"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="java.io.File"%>
<%@page import="com.myPackage.MyHandler"%>
<%@page import="javax.xml.parsers.SAXParser"%>
<%@page import="javax.xml.parsers.SAXParserFactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.myPackage.SQLMethods"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="addComment.css" rel="stylesheet" type="text/css">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="mystyle.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.1.1.min.js"
                integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
                crossorigin="anonymous">
        </script>
        <script>

             $(document).ready(function() {
                $("#submit").click(function() {
                    comment = $("#comment").val();
                    id = $("#hidden_id").val();
                    $.ajax({
                            type : "POST",
                            url : "addComment.jsp",
                            data : "comment=" + comment + "&id=" + id,
                            success : function(data) {
                                $("#newComment").append(data);
                            }
                        });
                });

                $('body').on('click', '#delete', function() {

                    var uid = $(this).next().next().attr("value");
                    $(this).parent().parent().prev().remove();
                    $(this).parent().parent().remove();

                    $.ajax({
                        type: "POST" ,
                        url: "deleteComment.jsp" ,
                        data : "commentId=" + uid,
                        success: function(xml) {

                        }
                    });

                });

                $('body').on('click', '#edit', editComment);
                 
             });

                function editComment(){

                    var uid = $(this).next().attr("value");
                    var divHtml = $(this).prev().prev().text();
                    var editableText = $("<textarea />");
                    editableText.val(divHtml);
                    $(this).prev().prev().replaceWith(editableText);
                    editableText.focus();
                    // setup the blur event for this new textarea
                    editableText.keypress(function (e) {
                        var key = e.which;
                        if(key === 13)  // the enter key code
                         {
                           var html = $(this).val();
                           var viewableText = $("<span id=\"commentText\">");
                           viewableText.html(html);
                           $(this).replaceWith(viewableText);
                                                      
                           $.ajax({

                            type: "POST" ,
                            url: "editComment.jsp" ,
                            data : "commentId=" + uid + "&newComment=" + html,
                            success: function(xml) {
                                alert(xml);
                            }
                    });


                           return false;
                         }
                    });
                }



    </script>

    </head>

    <body>
         <a href="logout.jsp" style=" float : right;" ><img src="logout.png">&nbsp;</a>
        <div class="container">
                <div class="row">
                    <!-- Contenedor Principal -->
                        <div class="comments-container">
                    		<!--<h1>Comentarios <a href="http://creaticode.com">creaticode.com</a></h1>-->
                                <ul id="comments-list" class="comments-list">

        <%
                String sql = "SELECT * FROM Topics WHERE id=" + request.getParameter("id");
                ResultSet rs = null;
                 Connection con = SQLMethods.connect();
                 rs = SQLMethods.selectQuery(con, sql);
                 while(rs.next()) {
                     out.print("<center><h1>" + rs.getString("title") + "</h1>");
                     out.print(rs.getString("description") + "<br><hr>");
                 }

                try {

                     SAXParserFactory factory   = SAXParserFactory.newInstance();
                     SAXParser parser = factory.newSAXParser();
                     MyHandler myHandler = new MyHandler(out, request.getParameter("id"), con,
                     String.valueOf(session.getAttribute("username")));

                     parser.parse("http://localhost:8080/wa/messages.xml", myHandler);

                } catch (Exception e) {
                   e.printStackTrace();
                }
             %>

             <div id="newComment"></div>

                        </div> </ul>
                </div>
        </div>
    <center>
        <div class="detailBox" >
            <div class="titleBox">
             <div class="form-group">
                        <label for="comment"><h1>Add comment :</h1></label><br>
                        <textarea class="form-control" type="text" id="comment" name="comment" placeholder="What's on your mind ?"></textarea>
                        <input type="hidden" id="hidden_id" value="<%= request.getParameter("id") %>">
                    <div class="form-group"> <br>
                    <button id="submit" type="submit" class="button" >Add</button>
                    </div>
             </div>
        </div>
    </center>
    </body>
</html>
