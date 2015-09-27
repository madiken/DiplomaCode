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
    <%//@ include file="header.jsp" %>
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
    </head>
        <%
         String quantityKindLocalName = request.getParameter("quantity_kind_local_name");
         String quantityKindOntology = request.getParameter("ontology");
        
         if (quantityKindLocalName == null){
             out.print("quantityKindLocalName is not specified");
             return;
         }
         
         if (quantityKindOntology == null){
             out.print("quantityKindOntology is not specified");
             return;
         }
         
         Constants.ontologies ont = null;
         String nsPrefix = null;
         if (quantityKindOntology.equals(Constants.ontologies.new_ontology_quantity.toString())){
             ont = Constants.ontologies.new_ontology_quantity;
             nsPrefix = Constants.nameSpaceMap.get(Constants.ontologies.new_ontology_quantity);
         }    
         else if (quantityKindOntology.equals(Constants.ontologies.qudt_quantity.toString())){
             ont = Constants.ontologies.qudt_quantity;
             nsPrefix = Constants.nameSpaceMap.get(Constants.ontologies.qudt_quantity);
         }
         String quantityKindUri = nsPrefix + quantityKindLocalName;
         List<NumericValueRestriction> restrList = RestrictionHelper.listRestrictionsWithThisQuantityKind(OntologyModelHelper.getRestrictionModel(), quantityKindUri);
         
         List<String> comparableUnitsUri = UnitHelper.getAllComparableUnits(OntologyModelHelper.getCommonModel(), quantityKindUri);
         //out.print(quantityKindOntology);
         %>      
              

    <body>
    <table>
    <form action="<%=request.getContextPath()%>/RestrictionServlet" method="post">
      <tr><td>  <input type="hidden" name="action" value="create"/> </td></tr>
      <tr><td>  <input type="hidden" name="quantityKindUri" value="<%=quantityKindUri%>"> 
      <tr><td>  <select name="unitUri" "> 
            <% for (String unitUri : comparableUnitsUri){%>
            <option value="<%=unitUri%>"> <%=unitUri%></option>
            <% } %>
        </select></td></tr>
        <% if (restrList.size() == 0){%>
        <tr><td>    <input name="min">min value</input> </td></tr>
        <tr><td>    <input name="max">max value</input> </td></tr>
        <% }%>
        <tr><td>  <input type="submit" name="submit" value="Submit"/><input type="submit" name="cancel" value="Cancel"/> </td></tr>
    </form>
    </table>
    </body>
 </html>
