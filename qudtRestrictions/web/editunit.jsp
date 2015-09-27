<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<%@ page language="java" import="
			ru.*,
			ru.helpers.*,
			ru.servlet.*,
			com.hp.hpl.jena.ontology.*,
			com.hp.hpl.jena.util.iterator.ExtendedIterator,
			java.util.*,
            com.hp.hpl.jena.ontology.OntClass,
            com.hp.hpl.jena.ontology.OntModel,
            com.hp.hpl.jena.rdf.model.Resource,
 		    javax.servlet.jsp.JspWriter,
 		    java.io.IOException;" 
  		%>
	  	<%
	  	//we can create and edit only units in our new ontology
	  	OntModel model = OntologyModelHelper.getNewModel();
		
	  	boolean EDIT_MODE = true;
		Resource unitRes = null;
		String instanceName = request.getParameter("unit_instance_name");
		
		String ontology = request.getParameter("ontology");
        if(ontology == null){
            out.print("ontology is not defined");
            return;
        }
        
        Constants.ontologies ont = Constants.ontologies.valueOf(ontology);
        if(ont == null){
            out.print("error defining ontology");
            return;
        }
        
		//only qudt types
		String typeLocalName = null;
		
			
		if(instanceName == null){
        	EDIT_MODE = false; //create mode
        	typeLocalName = request.getParameter("class_name");
            if (typeLocalName == null){
                out.println("cannot create unit without type defined");
                return;
            }
        } else {
        	//edit existing unit
        	String uri = Constants.nameSpaceMap.get(ont) + instanceName;
        	unitRes = model.getResource(uri);
        	typeLocalName = OntologyModelHelper.getLiteralProperty(unitRes, Constants.PROPERTY_TYPE);
        }
	    %>		
			  
	<head>
	</head>
 
	<body>
	
	    <div class="main">
	        <% 
            Object error = request.getAttribute("error");
            if (error != null) { 
          %>
            <span style="color: red;"><%=((String)error).toLowerCase()%></span>
          <%}%>
          <%    
            Object message = request.getAttribute("mesg");
            if (message != null) { 
          %>
            <span style="color: green;"><%=((String)message).toLowerCase()%></span>
          <%}%>
          <br>
			<div class="content_left">
			
			   <form name = "editform" action="<%=request.getContextPath()%>/AddUnitServlet" method="post">
	                    <input type="hidden" name="ontology" value="<%=ont.toString()%>"/>
                        
	                    <input type="hidden" name="class_name" value="<%=typeLocalName%>"/>
	                    <input type="hidden" name="EDIT_MODE" value="<%=EDIT_MODE%>"/>
	                    <% if (EDIT_MODE) {%>
	                    <input type="hidden" name="local_name" value="<%=unitRes.getLocalName()%>"/>
                        <%}%>
                        <table>
	                        <tr>
	                            <td>LocalName:</td>
	                            <%
	                            String requestLocalName = request.getParameter("local_name");
	                            String localName = EDIT_MODE?unitRes.getLocalName(): (requestLocalName == null)?"":requestLocalName;
	                            %>
	                            <% if (!EDIT_MODE){%>
	                               <td><input type="text" size="40" name="local_name" value="<%=localName%>" /></td>
	                            <%} else {%>
	                               <td><%=localName%></td>
                                <%}%>   
	                        </tr>
	                        
	                        <%
			                List<String> propUris = OntologyModelHelper.getPropertyUriList(ont);
			                for (String propuri: propUris) {
			                String paramName = OntologyModelHelper.getResourceLocalName(OntologyModelHelper.getOntModel(), propuri);
			                String requestValue = request.getParameter(paramName);
                            String value = EDIT_MODE?OntologyModelHelper.getLiteralProperty(unitRes, propuri, false):(requestValue == null)?"":requestValue; 
                                	
			                %>
			                    <tr>
			                        <td> <%=OntologyModelHelper.getResourceName(OntologyModelHelper.getOntModel(), propuri)%> </td>
			                        <td><input type="text" size="40" name="<%=paramName%>" value="<%=value%>"/></td>
			                    </tr>
			                
			                <%} %>
	                        
	                        <tr>
	                          <td colspan="2" align="center"><input type="submit" name="submit" value="Submit"/><input type="submit" name="cancel" value="Cancel"/></td>
	                        </tr>
	                    </table>
	                </form>
			
		    
		    </div>
	</BODY>
 </HTML>



