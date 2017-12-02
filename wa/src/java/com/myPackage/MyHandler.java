/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author admin
 */

package com.myPackage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.jsp.JspWriter;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class MyHandler extends DefaultHandler
{
  private int stepCount, totalAge;
  private JspWriter out;
  private String topicId;
  private String xmlTopicId;
  private boolean user;
  private boolean text;
  Connection con;
  String username;
  String comUsername;
  String commentId;
  
  public MyHandler(JspWriter out, String topicId, Connection con, String username)
  {
    this.out = out;
    this.topicId = topicId;
    this.con = con;
    this.username = username;
  }

  public void startDocument() throws SAXException
  {
//    try 
//    {
//      out.write(++stepCount + ". Start of document<br>");      
//    }
//    catch (IOException e) 
//    {
//      throw new SAXException(e);
//    }    
  } // end of startDocument()

  public void endDocument() throws SAXException
  {
//    try 
//    {
//      out.write(++stepCount + ". End of document<p>");
//      out.write("The total of all ages in the XML document is <b><i>"
//                + totalAge + "</i></b>");
//    }
//    catch (IOException e) 
//    {
//      throw new SAXException(e);
//    }    
  } // end of endDocument()

  public void startElement(String namespaceURI, String localName,
                           String qName, Attributes attrs)
      throws SAXException
  {
    if (qName.equals("message")) 
    {
        xmlTopicId = attrs.getValue("topic");
        commentId = attrs.getValue("id");
        
    }
    
    if ( qName.equals("user")) 
    {
      user = true;
    }
    
    if ( qName.equals("text")) 
    {
      text = true;
    }
    
//    try 
//    {
//      out.write(++stepCount + ". Start of element: <b>" + qName + "</b>");
//
//      int numberOfAttributes = attrs.getLength();
//
//      if ( numberOfAttributes > 0 ) 
//      {
//        out.write(". Attributes: <ul>");
//      } // end of if ()
//      else 
//        out.write("<br>");
//      
//      for ( int i=0; i<numberOfAttributes; i++) 
//      {
//        out.write("<li>" + attrs.getQName(i) + " = "
//                  + attrs.getValue(i) + "</li>");
//      } // end of for ()
//        
//      if ( numberOfAttributes > 0 ) 
//      {
//        out.write("</ul>");
//      }
//    }
//    catch (IOException e) 
//    {
//      throw new SAXException(e);
//    }    
  } // end of startElement()

  public void endElement(String namespaceURI, String localName, String qName)
      throws SAXException
  {
    if (qName.equals("message")) 
    {
        
        
    }
    
    if ( qName.equals("user")) 
    {
      user = false;
    }
    
    if ( qName.equals("text")) 
    {
      text = false;
    }
    
    
    
  } // end of endElement()

  @Override
  public void characters(char[] chars, int start, int length) throws SAXException
 {            
            String beforeUser = "<li><div class=\"comment-main-level\"><!-- Avatar --><div class=\"comment-avatar\"><img src=\"users.png\"> </div>" +
                                    "<!-- Contenedor del Comentario -->" +
                                    "<div class=\"comment-box\">" +
                                    "<div class=\"comment-head\">" +
                                    "<h6 class=\"comment-name by-author\"><a href=\"http://creaticode.com/blog\">";
            String afterUser = "</a></h6><span>hace 20 minutos</span><i class=\"fa fa-reply\"></i><i class=\"fa fa-heart\"></i></div>";
            String beforeText="<div class=\"comment-content\">";
            String afterText="</div></div></li>";
            

    if (user && xmlTopicId.equals(topicId)) {
        try {
            comUsername = new String(chars, start, length);
            out.write(beforeUser+"<div id=\"commentUser\"> User : " + new String(chars, start, length) + "</div>"+afterUser);
        } catch (IOException ex) {
            Logger.getLogger(MyHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        user = false;
    }
    
    if (text && xmlTopicId.equals(topicId)) {
        try {        
            String output = beforeText+"<span id=\"commentText\">" + new String(chars, start, length) + "</span>";
            ResultSet userInfo = SQLMethods.getUserInfo(username);
            
            if(userInfo.getString("role").equals("admin")) 
                if(username.equals(comUsername))
                    out.write(output + "<a href=\"#\" id=\"delete\" ><button id=\"edit\" class=\"btn-danger\" style=\"width : 15%; float: right;\">Delete</button></a>&nbsp;<button id=\"edit\" class=\"btn-primary\" style=\"width : 15%; float: right;\">Edit</button>&nbsp;"
                    + "<input type=\"hidden\" value=\"" + commentId + "\">"+afterText);
                else
                    out.write(output + "<a href=\"#\" id=\"delete\"><button id=\"edit\" class=\"btn-danger\" style=\"width : 15%; float: right;\">Delete</button></a><br><br></div>"
                            + "<input type=\"hidden\" value=\"" + commentId + "\">"+afterText);
            else
                if(username.equals(comUsername))
                    out.write(output + "<a href=\"#\" id=\"delete\"><button id=\"edit\" class=\"btn-danger\" style=\"width : 15%; float: right;\">Delete</button></a> &nbsp;<button id=\"edit\" class=\"btn-primary\" style=\"width : 15%; float: right;\">Edit</button>"
                            + "<input type=\"hidden\" value=\"" + commentId + "\">"+afterText);
                else
                    out.write(output + "<br>"+afterText);
                
        } catch (IOException | SQLException ex) {
            Logger.getLogger(MyHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
	text = false;
    }

    
    
  } // end of characters()
} // end of class MyHandler
