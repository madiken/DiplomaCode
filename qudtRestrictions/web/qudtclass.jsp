<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@page import="ru.servlet.NewOntologyServlet"%>
<%@page import="ru.servlet.AddUnitServlet"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<%@ page contentType="text/html; charset=UTF-8" %>
<HTML>
<%@ page language="java" import="
			ru.*,
			ru.helpers.*,
			com.hp.hpl.jena.ontology.*,
			com.hp.hpl.jena.rdf.model.*,
			com.hp.hpl.jena.util.iterator.ExtendedIterator,
			java.util.*,
            com.hp.hpl.jena.ontology.OntClass,
            com.hp.hpl.jena.ontology.OntModel,
 		    javax.servlet.jsp.JspWriter,
 		    java.io.IOException" 
  		%>

    <head>
        <link rel="stylesheet" type="text/css" href="./dhtmlxtree/dhtmlxtree.css">
        <script src="./dhtmlxtree/dhtmlxcommon.js"></script>
        <script src="./dhtmlxtree/dhtmlxtree.js"></script> 
        <script src="./dhtmlxtree/ext/dhtmlxtree_start.js"></script>
        <script src="./dhtmlxtree/ext/dhtmlxtree_json.js"></script>
        <%@ include file="header.jsp" %>
    </head>
 
	  	<%
	  	OntModel model = OntologyModelHelper.getOntModel();
	  	
	  	String ontology = request.getParameter("ontology");
	  	if(ontology == null){
            //out.print("ontology is not defined");
            //return;
	  		ontology = Constants.ontologies.qudt_unit.toString();// by default
        }
	  	
	  	//all qudt classes are defined in qudt ontology 
	  	//this parameter effects only links to instances of dufferent types (units and quantities)
	  	Constants.ontologies ont = Constants.ontologies.valueOf(ontology);
	  	if(ont == null){
            out.print("error defining ontology");
            return;
        }
        
	  	String className = request.getParameter("class_name");
        //default = root of the hierarchy
        if(className == null){
        	if (ont.equals(Constants.ontologies.qudt_unit))
        		   className = Constants.QUDT_ROOT_UNIT_CLASS_LOCAL_NAME;
        	else if (ont.equals(Constants.ontologies.qudt_quantity))
        		   className = Constants.QUDT_ROOT_QUANTITY_KIND_CLASS_LOCAL_NAME;
        	else {
        		out.print("error defining root of the class hierarchy : " + ont.toString());
                return;
        	}
        }
        
        //we have only qudt classes unit or quantity
        String uri = Constants.nameSpaceMap.get(Constants.ontologies.qudt) + className;
        if (model.getOntResource(uri) == null){
        	out.print("error loading resource : wrong url " + uri);
        	return;
        }
        OntClass r = model.getOntResource(uri).asClass(); 
        
        if (!model.containsResource(r)){
             out.print("qudt ontology does not contain resource " + uri);
             return;
        }
        
        //qudt instances
		ExtendedIterator<? extends OntResource> it1 = r.listInstances(true);
		List<? extends OntResource> instances  = it1.toList();
		//TODO add list of new ontology instances
		%>		
		<%!
			public void printNode(OntClass root, JspWriter out, String ontology) throws IOException {
				ExtendedIterator<OntClass> it2 = root.listSubClasses(true);
				List<OntClass> l  = it2.toList();
				String label = OntologyModelHelper.getLiteralProperty(root, Constants.PROPERTY_LABEL);
				 out.println("<li> " + "<a href="+ "qudtclass.jsp?class_name="+ root.getLocalName() + "&ontology=" + ontology + ">" + ("".equals(label)? root.getLocalName():label) + "</a>") ; 
				 out.println("<ul>");
				 for (OntClass  clas : l){
					printNode(clas, out, ontology);
				}
				 out.println("</ul>");
				 out.println("</li> ") ; 
			}
		%>	  

	<body>
        <!-- CREATE NEW OBJECT OF CURRENT CLASS-->
	    <h3>Current QUDT class</h3>
        <%
        String new_ont = ont.equals(Constants.ontologies.qudt_quantity)?Constants.ontologies.new_ontology_quantity.toString(): Constants.ontologies.new_ontology_unit.toString(); 
        %>
	    <a href="editunit.jsp?class_name=<%=r.getLocalName()%>&ontology=<%=new_ont%>">Create new instance of this type</a>
        <br>
        <div  class="dhtmlxTree"  
	        id="treeboxbox_tree"
	        setImagePath="./dhtmlxtree/imgs/"
	        style="width:500px;height:auto; overflow:auto;"> 
		      <%try {
		    	  out.print("<ul>");
		    	  printNode(r, out, ontology);
		          out.print("</ul>");
		      }
		      catch (IOException e){
		        	 out.print("AAA");
		      }%>
	    </div>
		<hr>
		
	    <div class="main">
			 <div class="content_left">
			     <h3>This class direct instances</h3>
			     <h4>Qudt ontology instances</h4>
            
				 <%//print qudt instances 
				 for (OntResource re : instances) {
					 String label = OntologyModelHelper.getLiteralProperty(re, Constants.PROPERTY_LABEL);
				 %>
				    <a href=<%="unitinstance.jsp?unit_instance_name=" + re.getLocalName() + "&ontology=" + ont.toString()%>>
				    <%=OntologyModelHelper.getResourceName(OntologyModelHelper.getOntModel(), re.getURI()) %>
				    </a>
				    <br>
		         <%} %>
				  <%if (OntologyModelHelper.isNewOntologyCreated()) {%>
				  <h4>New ontology instances</h4>
				 
					 <%//print print new ontology instances
					 OntModel newModel = OntologyModelHelper.getNewModel();
					 
					 OntResource unitClassRes = newModel.getOntResource(r.getURI());
					 OntClass unitClass = null;
					 if (unitClassRes != null)
						 unitClass = unitClassRes.asClass();
					 if (unitClass != null){
						 ExtendedIterator<? extends OntResource> it2 = unitClass.listInstances(true);
					     List<? extends OntResource> newOntInstances  = it2.toList();
					        
						 for (OntResource re : newOntInstances) {
		                     String label = OntologyModelHelper.getLiteralProperty(re, Constants.PROPERTY_LABEL); 
		                     new_ont = ont.equals(Constants.ontologies.qudt_quantity)?Constants.ontologies.new_ontology_quantity.toString(): Constants.ontologies.new_ontology_unit.toString();
		                 %>
		                   <a href=<%="unitinstance.jsp?unit_instance_name=" + re.getLocalName() + "&ontology=" + new_ont%>>
		                   <%=OntologyModelHelper.getResourceName(OntologyModelHelper.getNewModel(), re.getURI()) %>
		                   </a>
		                   <br>
		                 <%}
					 }%>
				 
				 <%} %> 
			</div>
			
		
		</div>
	</body>
 </html>
