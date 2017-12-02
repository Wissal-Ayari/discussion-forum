<%-- 
    Document   : deleteComment
    Created on : Jan 25, 2017, 4:24:27 PM
    Author     : admin
--%>
<%@page import="org.w3c.dom.Text"%>
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
        String newComment = request.getParameter("newComment");
        String xml = commentId;
       
        DocumentBuilderFactory docFactory =
        DocumentBuilderFactory.newInstance();
        DocumentBuilder docBuilder = 
        docFactory.newDocumentBuilder();
        Document doc = docBuilder.parse("C:\\Users\\wissal\\Documents\\NetBeansProjects\\wa\\web\\messages.xml");
    
        Element root = doc.getDocumentElement();
        NodeList nList = doc.getElementsByTagName("message");
    
    for (int i = 0; i < nList.getLength(); i++) 
        {/*
             Node nNode = nList.item(i);
            Element eElement = (Element) nNode;
            if(eElement.getAttribute("id").equals(commentId)) {
                Node text = eElement.getFirstChild();
                text.setNodeValue("eeee");
                
                //Node user = personlist.item(0);//********
                //NodeList namelist = text.getChildNodes();
                //Text nametext = (Text)namelist.item(0);
               // nametext.setData(newComment);
                
            //Element text =(Element) user.getNextSibling();
            
            //NodeList namelist = text.getChildNodes();
                //Text nametext = (Text)namelist.item(0);
                //nametext.setData(newComment);
                
            break;
            }*/
            //<text>Using big data to gain insights about your customers is becoming more common these days.</text></message>
            
            Node nNode = nList.item(i);
            Element eElement = (Element) nNode;
            if(eElement.getAttribute("id").equals(commentId)) {
                NodeList personlist = eElement.getChildNodes();
                Element text = (Element)personlist.item(1);//********
                //NodeList namelist = text.getChildNodes();
               // Node nametext = namelist.item(0);
                text.getParentNode().removeChild(text);
                 //Element text = document.createElement("text");
                 
                //nametext.setNodeValue("jc");
                break;
            
            }
                
        }
        
        DOMSource source = new DOMSource(doc);
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        File outputFile = new File("C:\\Users\\wissal\\Documents\\NetBeansProjects\\wa\\web\\messages.xml");
        StreamResult result = new StreamResult(outputFile);
        transformer.transform(source, result);
        out.println(xml);
                
%>
