<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<%@ page contentType="text/html; charset=UTF-8" %>
<html>


<%@ page language="java" import="
			ru.helpers.*,
			ru.helpers.restriction.*,
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
	  	String instanceName = request.getParameter("unit_instance_name");
		String ontology = request.getParameter("ontology");
		if(ontology == null){
        	out.print("ontology is not defined");
        	return;
        }
		if(instanceName == null){
        	out.print("empty unit instance name");
        	return;
        }
		Constants.ontologies ont = Constants.ontologies.valueOf(ontology);
        String uri = Constants.nameSpaceMap.get(ont) + instanceName;
        Resource res = null;
        //qudt instance
        OntModel model = null;
        if (ont.equals(Constants.ontologies.qudt_unit) || ont.equals(Constants.ontologies.qudt_quantity)){
        	model = OntologyModelHelper.getOntModel();
        	
        }
        //new ontology instance
        else if (ont.equals(Constants.ontologies.new_ontology_unit) || ont.equals(Constants.ontologies.new_ontology_quantity)){
        	model = OntologyModelHelper.getNewModel();
        }
        res = model.getResource(uri);
        if (!model.containsResource(res)){
            out.print("new model does not contain unit " + uri);
            return;
        } 
        
        %>		
			  

    <body>
        <h4>Current Instance</h4>
	    <%if (ont.equals(Constants.ontologies.new_ontology_unit) || ont.equals(Constants.ontologies.new_ontology_quantity)){ %>
	       <a href="editunit.jsp?unit_instance_name=<%=res.getLocalName()%>&ontology=<%=ont.toString()%>">edit</a>
	       <br>
           <a href="<%=request.getContextPath()%>/AddUnitServlet?unit_instance_name=<%=res.getLocalName()%>&ontology=<%=ont.toString()%>&action=delete">remove</a>
        <%} %>
        <div class="main">
			<div class="content_left"> 
			<table>
                    <%
                    String qudt_ont = null;
                    String typeRootUri = null;
                    if (ont.equals(Constants.ontologies.new_ontology_quantity) || ont.equals(Constants.ontologies.qudt_quantity)){
                    	qudt_ont = Constants.ontologies.qudt_quantity.toString();
                    	typeRootUri = "http://data.nasa.gov/qudt/owl/qudt#QuantityKind";
                    }	
                    else if (ont.equals(Constants.ontologies.new_ontology_unit) || ont.equals(Constants.ontologies.qudt_unit)){
                        qudt_ont = Constants.ontologies.qudt_unit.toString();
                        typeRootUri = "http://data.nasa.gov/qudt/owl/qudt#PhysicalUnit";   
                    }
                    
                    %>
                    <%
                    List<String> types = Utils.getAllTypes(uri, typeRootUri);
                    for (String t : types){
                    %>
                    <tr>
                        <td> type </td>
                        <td> <a href="qudtclass.jsp?class_name=<%=Utils.getLocalName(t) + "&ontology=" + qudt_ont %>"><%=Utils.getLocalName(t)%></a></td>
                    </tr>    
                    <%} %>
                
				<tr>
					<td> uri </td>
			 		<td> <% out.println(res.getURI());%></td>
			 	</tr>
			 	<%
			 	List<String> propUris = OntologyModelHelper.getPropertyUriList(ont);
		        for (String propuri: propUris) {
		        	//if (Constants.PROPERTY_QUANTITY_KIND.equals(propuri)){
		        		StmtIterator it2 = res.listProperties(OntologyModelHelper.getProperty(propuri));
		        		List<Statement> li2 = it2.toList();
		        		if (li2.size() == 0){
		        			//print empty slot
		        		%>
		        		<tr>
                            <td> <%=OntologyModelHelper.getResourceName(OntologyModelHelper.getOntModel(), propuri)%> </td>
                            <td> </td>
                        </tr> 
                        <%
		        		}
		        		else 
		        		for (int i = 0; i < li2.size(); i++){
		        		    RDFNode r = li2.get(i).getObject();
		        		    String val = null;
		        		    
		        		    if (r.isURIResource()) {
		        		    	val = r.asResource().getURI();
		        		    	//if quantity kind - get link to corresponding quantity kind
	                            if (propuri.equals(Constants.PROPERTY_QUANTITY_KIND) || propuri.equals(Constants.PROPERTY_GENERALIZATION)){
	                                
	                            	String r_ontology = null;
	                                String r_localName = null;
	                                
	                                r_ontology = Utils.getIndividualOntology(val).toString();
	                                r_localName = Utils.getLocalName(val);
	                                if (r_ontology != null){ 
	                                %>
	                                <tr>
	                                    <td> <%=OntologyModelHelper.getResourceName(OntologyModelHelper.getOntModel(), propuri)%> </td>
	                                    <td> <a href="unitinstance.jsp?ontology=<%=r_ontology%>&unit_instance_name=<%=r_localName%>"><% out.println(r_localName);%></a></td>
	                                </tr>
	                                <% 
	                                } else {
	                                    %>
	                                        <tr>
	                                            <td> <%=OntologyModelHelper.getResourceName(OntologyModelHelper.getOntModel(), propuri)%> </td>
	                                            <td> <% out.println(val);//OntologyModelHelper.getLiteralProperty(res, propuri));%></td>
	                                        </tr>
	                                    <%      
	                                }
	                                
	                            }
		        		    }
		        		     else {
		        		    	 if (r.isLiteral())
		                                val = r.asLiteral().getLexicalForm();
		        		    	 else val = r.toString();       
		        		     
		        	
		        %>
					 	    <tr>
		                        <td> <%=OntologyModelHelper.getResourceName(OntologyModelHelper.getOntModel(), propuri)%> </td>
		                        <td> <% out.println(val);//OntologyModelHelper.getLiteralProperty(res, propuri));%></td>
		                    </tr>
                
			 	<%          }   
			 	      }
			 	} %>
			</table>    
		
			<%
			if (ont.equals(Constants.ontologies.new_ontology_quantity) || ont.equals(Constants.ontologies.qudt_quantity)){
				
				List<NumericValueRestriction> list =  RestrictionHelper.listRestrictionsWithThisQuantityKind(OntologyModelHelper.getRestrictionModel(), uri);
			    %>
			     <a href="create_restriction.jsp?quantity_kind_local_name=<%=instanceName%>&ontology=<%=ontology%>">Create restriction for this quantity kind</a>
            
		         <table>
                 <tr>
                     <td><h4>Restrictions on this quantity kind :</h4></td>
                 </tr>
        	   
			     <%for (NumericValueRestriction c : list){ 
			    	 
			     %>
			        <tr>
			           <td>
			           <a href="restriction.jsp?local_name=<%=Utils.getLocalName(c.getCatcherUri())%>">Restriction for value in unit <%=c.getUnitUri()%></a>
			           </td>
			        </tr>
			     <%}%>
			   </table>
			  
			<%
			
			List<String> allComparableUnits = UnitHelper.getAllComparableUnits(OntologyModelHelper.getCommonModel(), uri);
			                   
               %>
               <table>
                <tr>
                    <td><h4>Units applicable to this quantity kind:</h4></td>
                </tr>
              
               <% 
               
               for (String unitUri : allComparableUnits){
                   Constants.ontologies unitont = Utils.getIndividualOntology(unitUri);
                   
                   %>
                   <tr>
                      <td> 
                         <a href="unitinstance.jsp?unit_instance_name=<%=Utils.getLocalName(unitUri)%>&ontology=<%=unitont.toString()%>"><%=Utils.getLocalName(unitUri)%></a>  
                      </td>
                   </tr>
                   <%
               }
               %></table><% 
			
			} 
			%>
			</div>
		
		</div>
	</BODY>
 </HTML>
