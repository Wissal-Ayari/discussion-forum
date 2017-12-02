
<%-- 
    Document   : deleteComment
    Created on : Jan 25, 2017, 4:24:27 PM
    Author     : admin
--%>
<%@page import="javax.xml.transform.stream.StreamResult"%>
<%@page import="java.io.File"%>
<%@page import="javax.xml.transform.Transformer"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@page import="javax.xml.transform.dom.DOMSource"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
       String commentId = request.getParameter("commentId");
       
        DocumentBuilderFactory docFactory =
        DocumentBuilderFactory.newInstance();
        DocumentBuilder docBuilder = 
        docFactory.newDocumentBuilder();
        Document doc = docBuilder.parse("http://localhost:8080/wa/messages.xml");
        
       NodeList nList = doc.getElementsByTagName("message");
       for (int i = 0; i < nList.getLength(); i++) 
        {
            Node nNode = nList.item(i);
            Element eElement = (Element) nNode;
            if(eElement.getAttribute("id").equals(commentId)) {
                eElement.getParentNode().removeChild(eElement);
                break;
            
            }
        }
        
        DOMSource source = new DOMSource(doc);
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        File outputFile = new File("C:\\Users\\wissal\\Documents\\NetBeansProjects\\wa\\web\\messages.xml");
        StreamResult result = new StreamResult(outputFile);
        transformer.transform(source, result);
%>
