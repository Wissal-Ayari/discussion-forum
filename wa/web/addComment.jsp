<%--
    Document   : addComment
    Created on : Jan 20, 2017, 9:10:33 PM
    Author     : admin
--%>

<%@page import="java.util.UUID"%>
<%@page import="com.myPackage.SQLMethods"%>
<%@page import="javax.xml.transform.stream.StreamResult"%>
<%@page import="java.io.File"%>
<%@page import="javax.xml.transform.Transformer"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@page import="javax.xml.transform.dom.DOMSource"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%
        String comment = request.getParameter("comment");
        String topicId = request.getParameter("id");
        String uniqueID = UUID.randomUUID().toString();
        
        DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
        Document doc = docBuilder.parse("http://localhost:8080/wa/messages.xml");

        Element messages = doc.getDocumentElement();
        Element message = doc.createElement("message");
        message.setAttribute("topic", topicId);
        message.setAttribute("id", uniqueID);
        Element user = doc.createElement("user");
        user.setTextContent(String.valueOf(session.getAttribute("username")));
        Element text = doc.createElement("text");
        text.setTextContent(comment);
        message.appendChild(user);
        message.appendChild(text);
        messages.appendChild(message);

        DOMSource source = new DOMSource(doc);
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        File outputFile = new File("C:\\Users\\wissal\\Documents\\NetBeansProjects\\wa\\web\\messages.xml");
        StreamResult result = new StreamResult(outputFile);
        transformer.transform(source, result);

        String data;
         String beforeUser = "<li><div class=\"comment-main-level\"><!-- Avatar --><div class=\"comment-avatar\"><img src=\"users.png\"> </div>" +
                                    "<!-- Contenedor del Comentario -->" +
                                    "<div class=\"comment-box\">" +
                                    "<div class=\"comment-head\">" +
                                    "<h6 class=\"comment-name by-author\"><a href=\"http://creaticode.com/blog\">";
            String afterUser = "</a></h6><span>hace 20 minutos</span><i class=\"fa fa-reply\"></i><i class=\"fa fa-heart\"></i></div>";
            String beforeText="<div class=\"comment-content\">";
            String afterText="</div></div></div></li>";
            data = beforeUser + "<div id=\"commentUser\"> User : " + session.getAttribute("username") + "</div>"+afterUser+
                    beforeText+"<span id=\"commentText\"> " + comment + "</span>"+
                     "<a href=\"#\" id=\"delete\" ><button id=\"edit\" class=\"btn-danger\" style=\"width : 15%; float: right;\">Delete</button></a>&nbsp;<button id=\"edit\" class=\"btn-primary\" style=\"width : 15%; float: right;\">Edit</button>&nbsp;"+
                             "<input type=\"hidden\" value=\"" + uniqueID + "\">"+afterText;
 
        out.println(data);

    %>
