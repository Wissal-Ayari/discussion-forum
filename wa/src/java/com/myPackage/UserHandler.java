/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myPackage;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/**
 *
 * @author admin
 */
public class UserHandler {
    
    public static DefaultHandler newHandler() {
        
        DefaultHandler handler = new DefaultHandler() {

   boolean btopic = false;
	boolean buser = false;
	boolean btext = false;

	public void startElement(String uri, String localName,String qName,
                Attributes attributes) throws SAXException {

		System.out.println("Start Element :" + qName);

		if (qName.equalsIgnoreCase("TOPIC")) {
			btopic = true;
		}

		if (qName.equalsIgnoreCase("USER")) {
			buser = true;
		}

		if (qName.equalsIgnoreCase("TEXT")) {
			btext = true;
		}

		

	}

	public void endElement(String uri, String localName,
		String qName) throws SAXException {

		System.out.println("End Element :" + qName);

	}

	public void characters(char ch[], int start, int length) throws SAXException {

		if (btopic) {
			System.out.println("First Name : " + new String(ch, start, length));
			btopic = false;
		}

		if (buser) {
			System.out.println("Last Name : " + new String(ch, start, length));
			buser = false;
		}

		if (btext) {
			System.out.println("Nick Name : " + new String(ch, start, length));
			btext = false;
		}

	}


               
        };
        return handler;
}
}
    
                
