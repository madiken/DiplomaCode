<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="
			ru.*,
			ru.servlet.*,
			com.hp.hpl.jena.ontology.*,
			com.hp.hpl.jena.util.iterator.ExtendedIterator,
			java.util.*,
            com.hp.hpl.jena.ontology.OntClass,
            com.hp.hpl.jena.ontology.OntModel,
 		    javax.servlet.jsp.JspWriter,
 		    java.io.IOException;" 
  		%>
	  	<head>
            <%@ include file="header.jsp" %>
        </head>
        <%OntologyModelHelper.getNewModel();//initialize new model from the start%>
        <body>
         
       
		</body>
 </HTML>
