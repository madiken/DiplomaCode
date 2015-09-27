<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<%@ page contentType="text/html; charset=UTF-8" %>
<html>


<%@ page language="java" import="
            ru.*,
            ru.helpers.restriction.*,
            ru.helpers.*,
            
            com.hp.hpl.jena.ontology.*,
            com.hp.hpl.jena.util.iterator.ExtendedIterator,
            java.util.*,
            com.hp.hpl.jena.ontology.OntClass,
            com.hp.hpl.jena.ontology.OntModel,
            com.hp.hpl.jena.rdf.model.Resource,
            javax.servlet.jsp.JspWriter,
            java.io.IOException" 
        %>

    <head>
    <%@ include file="header.jsp" %>
    
    </head>
        <%
         String localName = request.getParameter("local_name");
         if (localName == null){
        	 out.print("restriction name is not specified");
        	 return;
         }
         OntModel restModel = OntologyModelHelper.getRestrictionModel();
         String catcherUri = Constants.nameSpaceMap.get(Constants.ontologies.restriction_ontology) + localName;
         NumericValueRestriction restriction = RestrictionHelper.getNumericValueRestriction(restModel, catcherUri);
         %>      
              

    <body>
    <form action="<%=request.getContextPath()%>/RestrictionServlet" method="post">
        <input type="hidden" name="action" value="delete"/>
        <input type="hidden" name="catcherUri" value="<%=catcherUri%>"/>
        <input type="hidden" name="quantityKindUri" value="<%=restriction.getQuantityKindUri()%>"/>
        <input type="submit" value="Delete this restriction"/>
    
    </form>

    <table>
	      <tr>
	        <td>quantityKind :</td>
             
	        <% Constants.ontologies ont = Utils.getIndividualOntology(restriction.getQuantityKindUri());
	           if (ont != null){
	        %>
            <td><a href=<%="unitinstance.jsp?ontology="+ ont.toString() + "&unit_instance_name="+Utils.getLocalName(restriction.getQuantityKindUri()) %>>
                    <%=restriction.getQuantityKindUri()%></a></td> 	        
	        <%} else { %>
	        <td><%=restriction.getQuantityKindUri()%></td>
	        <%} %>
	      </tr>
	      <tr>
            <td>unit :</td>
            <% ont = Utils.getIndividualOntology(restriction.getUnitUri());
               if (ont != null){
            %>
            <td><a href=<%="unitinstance.jsp?ontology="+ ont.toString() + "&unit_instance_name="+Utils.getLocalName(restriction.getUnitUri()) %>>
                    <%=restriction.getUnitUri() %></a></td>             
            <%} else { %>
            <td><%=restriction.getUnitUri() %></td>
            <%} %>
          </tr>
          <tr>
            <td>min :</td>
            <td><%=restriction.getMin()==null? "":restriction.getMin()%></td>
          </tr>
          <tr>
            <td>max :</td>
            <td><%=restriction.getMax()==null? "":restriction.getMax()%></td>
          </tr>
          
      </table>
            
        
       
    </body>
 </html>
