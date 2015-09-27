<%@page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="
            ru.*,
            ru.helpers.*,
            ru.servlet.*,
            com.hp.hpl.jena.ontology.*,
            com.hp.hpl.jena.rdf.model.*,
            com.hp.hpl.jena.util.iterator.ExtendedIterator,
            java.util.*,
            com.hp.hpl.jena.ontology.OntClass,
            com.hp.hpl.jena.ontology.OntModel,
            javax.servlet.jsp.JspWriter,
            java.io.IOException" 
        %>
<div class="header_top"> 
<br>
        <%
       //ugly initialization...
         
          String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
        Options.init(path);
                
          OntologyModelHelper.getNewModel();//initialize new model from the start
          OntologyModelHelper.getOntModel();
          OntologyModelHelper.getRestrictionModel();
          
        %>
        <h3> Ontologies </h3>
        <table>
        <tr>
        <td>
         <h4>New Quantity&Unit Complement Ontology </h4>
        </td>
        <td>        
         <h4>Restriction ontology</h4>
        </td>
        </tr>
        <tr>
        <td>
	        <form action="UploadDownloadFileServlet" method="post" enctype="multipart/form-data">
	            Select file to upload statements to new ontology (complement to QUDT). All statements of current qudt complement ontology will be erased:<input type="file" name="fileName">
	            
	            <br>
	            <input type="hidden" name="ontology" value="<%=Constants.ontologies.new_ontology%>"/>
	            <input type="submit" value="Upload">
	        </form>
	      </td>
	      <td>  
	         <form action="UploadDownloadFileServlet" method="post" enctype="multipart/form-data">
              Select file to upload statements to restriction ontology .  All statements of current restriction ontology will be erased:<input type="file" name="fileName">
              <br>
              <input type="hidden" name="ontology" value="<%=Constants.ontologies.restriction_ontology%>"/>
              <input type="submit" value="Upload">
             </form>
        </td>  
        </tr>
        <tr>
            <td>
			<a href="<%=request.getContextPath()%>/UploadDownloadFileServlet?ontology=<%=Constants.ontologies.new_ontology%>" method="get">Download new ontology</a>
			<br>
			<a href="<%=request.getContextPath()%>/NewOntologyServlet?action=clear&ontology=<%=Constants.ontologies.new_ontology%>">clear current new ontology</a> 
			    <br>
		    </td>
		    <td>	
            <a href="<%=request.getContextPath()%>/UploadDownloadFileServlet?ontology=<%=Constants.ontologies.restriction_ontology%>" method="get">Download restriction ontology</a>
			<br>
			<a href="<%=request.getContextPath()%>/NewOntologyServlet?action=clear&ontology=<%=Constants.ontologies.restriction_ontology%>">clear current restriction ontology</a> 
			<br>
			 <br>
	       </td>
		 </tr>	
		 </table>
		 <hr>
		 <h3>Navigation </h3>
			  <a href="qudtclass.jsp?ontology=<%=Constants.ontologies.qudt_unit%>">Unit class hierarchy</a>
			<br>
			<a href="qudtclass.jsp?ontology=<%=Constants.ontologies.qudt_quantity%>">Quantity kind class hierarchy</a>
		  <hr>
           <% 
            Object error = request.getAttribute("error");
            if (error != null) { 
          %>
            <span style="color: red;"><%=((String)error).toLowerCase()%></span>
            <br>
          <%}%>
          <%    
            Object message = request.getAttribute("mesg");
            if (message != null) { 
          %>
            <span style="color: green;"><%=((String)message).toLowerCase()%></span>
            <br> 
          <%}%>
</div>