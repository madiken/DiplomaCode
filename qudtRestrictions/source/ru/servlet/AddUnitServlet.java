package ru.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ru.Constants;
import ru.helpers.OntologyModelHelper;

import com.hp.hpl.jena.datatypes.DatatypeFormatException;
import com.hp.hpl.jena.datatypes.RDFDatatype;
import com.hp.hpl.jena.datatypes.TypeMapper;
import com.hp.hpl.jena.datatypes.xsd.XSDDatatype;
import com.hp.hpl.jena.ontology.DatatypeProperty;
import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.ObjectProperty;
import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.rdf.model.Literal;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.Resource;
import com.hp.hpl.jena.rdf.model.Statement;
import com.hp.hpl.jena.rdf.model.StmtIterator;

@WebServlet("/AddUnitServlet")
public class AddUnitServlet extends HttpServlet{
	  
	  public static final String NO_RESOURCE_TO_EDIT = "there is no resource with name";
	  public static final String SAME_NAMES_ERROR = "THE MODEL ALREADY HAS RESOURCE NAMED";
	  public static final String TYPE_NOT_DEFINED = "TYPE FOR NEW INSTANCE IS NOT DEFINED";
	  public static final String LOCAL_NAME_NOT_DEFINED = "NEW INSTANCE IDENTIFIER(NAME) IS NOT DEFINED";
	  public static final String ERROR = "error";
	  

	  
	  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	        request.setCharacterEncoding("UTF-8");
		  	OntModel newModel = OntologyModelHelper.getNewModel();
	        String typeLocalName = request.getParameter("class_name");
	        String localName = request.getParameter("unit_instance_name");
	        String ontology = request.getParameter("ontology");
	        
	        if (ontology == null){ 
	        	request.setAttribute(ERROR, "unable to define ontology : null");
	            outputPage("home.jsp", request, response);
	            return;
	            
	        }
	        Constants.ontologies ont = Constants.ontologies.valueOf(ontology);
	        if (ont == null){ 
	        	request.setAttribute(ERROR, "unable to define ontology : " + ontology);
	            outputPage("home.jsp", request, response);
	            return;
	        }
	        
	        //if (typeLocalName == null){ 
	        	
	        	//request.setAttribute(ERROR, TYPE_NOT_DEFINED);
	            //outputPage("qudtclass.jsp?class_name=" + Constants.QUDT_ROOT_UNIT_CLASS_LOCAL_NAME + "&ontology=" + ontology, request, response);
	            //return;
	            
	        //}
	        if (localName == null){ 
	        	request.setAttribute(ERROR, LOCAL_NAME_NOT_DEFINED);
	            outputPage("editunit.jsp?class_name=" + typeLocalName + "&ontology=" + ontology, request, response);
	            return;
	        }
	        
	        String action = request.getParameter("action");
	        if ("delete".equals(action)){
	        	delete(newModel, localName, typeLocalName, ont, request, response);
	        	
	        }
	        
	  }
	  
	  private void delete(OntModel newModel, String localName, String typeLocalName, Constants.ontologies ont,  HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		  String uri = Constants.nameSpaceMap.get(ont) + localName; 
	        Resource resourceToEdit = newModel.getResource(uri);
	        if (!newModel.containsResource(resourceToEdit)) { 
	        	request.setAttribute(ERROR, NO_RESOURCE_TO_EDIT + " " + localName);
	            //forward to creating unit
	        	outputPage("editunit.jsp?class_name=" + typeLocalName + "&ontology=" + ont.toString(), request, response);
	            return;
	        }
		  
		  Individual i = newModel.getIndividual(uri);
		  if (typeLocalName == null){ 
			  typeLocalName = i.getOntClass().getLocalName();
		  } 	
	        	
		  i.remove();
		  request.setAttribute(ERROR, "resource " +  localName + " was succesfully removed from ontology");
          outputPage("qudtclass.jsp?class_name=" + typeLocalName + "&ontology=" + ont.toString(), request, response);
          return;
      
	  }
			
	  public static String validLocalName(String localName){
		  boolean valid = localName.matches("\\w+");
		  return localName.replaceAll("\\s", "_");
	  }
	  
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
	        request.setCharacterEncoding("UTF-8");
	        try {
			  	OntModel newModel = OntologyModelHelper.getNewModel();
		        String typeLocalName = request.getParameter("class_name");
		        String localName = request.getParameter("local_name");
		        String ontology = request.getParameter("ontology");
		        
		        //localName = validLocalName(localName);
		      
		        	
		        if (ontology == null){ 
		        	request.setAttribute(ERROR, "unable to define ontology : null");
		            outputPage("home.jsp", request, response);
		            return;
		            
		        }
		        Constants.ontologies ont = Constants.ontologies.valueOf(ontology);
		        if (ont == null){ 
		        	request.setAttribute(ERROR, "unable to define ontology : " + ontology);
		            outputPage("home.jsp", request, response);
		            return;
		        }
		        
		        if (typeLocalName == null){ 
		        	request.setAttribute(ERROR, TYPE_NOT_DEFINED);
		            outputPage("qudtclass.jsp?class_name=" + Constants.QUDT_ROOT_UNIT_CLASS_LOCAL_NAME + "&ontology=" + ontology, request, response);
		            return;
		            
		        }
		        
		     
		        
		        if ("Submit".equals(request.getParameter("submit"))){
		          	String isEditModeStr = request.getParameter("EDIT_MODE");
		        	boolean isEditMode = Boolean.parseBoolean(isEditModeStr);
		        	if (isEditMode){
		        		editUnit(newModel, localName, typeLocalName, ont, request, response);
		        	}
		        	else addUnit(newModel, localName, typeLocalName, ont, request, response);
			    } else if ("Cancel".equals(request.getParameter("cancel"))){
			    	response.sendRedirect("qudtclass.jsp?class_name=" + typeLocalName + "&ontology=" + ontology);
			        return;
			    }
	        } catch (ServletException e){
	        	e.printStackTrace();
	        }
	        return;
	  }
	  
	  //if not correct exception will be thrown
	  private static void checkDoubleValueCorrect(Literal typedLiteral){
		  if (typedLiteral.getDatatype().equals(XSDDatatype.XSDdouble))
			  typedLiteral.getDouble();
	  }
	  
	  //return correct TypeLiteral if value is ok otherwise null
	  private static Literal getTypedLiteralForPropertyValue(DatatypeProperty prop, String value){
		  OntClass dtCl = prop.getRange().asClass();
		  System.out.println("dt.getURI() " + dtCl.getURI());
		  //if (dt.getURI().equals("http://www.w3.org/2001/XMLSchema#double"))
		  RDFDatatype dt = TypeMapper.getInstance().getTypeByName(dtCl.getURI());
		  Literal typedLiteral = null;
		  try{
			  typedLiteral = OntologyModelHelper.getNewModel().createTypedLiteral(value, dt);
			  //checks only double value
			  checkDoubleValueCorrect(typedLiteral);
			  System.out.println(typedLiteral.getDatatype());
			  System.out.println(typedLiteral.getString());
		  }
		  catch (DatatypeFormatException e){
			  //wrong format of literal
			  return null;
		  }
		  return typedLiteral;
	  }
	  //correctly sets values depending on property type if success return true
	  private static boolean setValue(Resource res, String propUri, String value){
		   System.out.println("%%%%%%%%%%%%%%%%%%");
    	   System.out.println("propUri  " + propUri);
		
    	   System.out.println();
			  		  System.out.println("is datatype " + OntologyModelHelper.isDatatypeProperty(propUri));
		  System.out.println("is object " + OntologyModelHelper.isObjectProperty(propUri));
		  
		  //TODO : there is no check on type of subject yet so if uri is of individual of an inappropriate type the link will be broken
		  if (OntologyModelHelper.isObjectProperty(propUri)){
	    	  ObjectProperty prop = OntologyModelHelper.getOntModel().getObjectProperty(propUri);
	    	  Individual ni = OntologyModelHelper.getNewModel().getIndividual(value);
      		  Individual qi = OntologyModelHelper.getOntModel().getIndividual(value);
      		  //the individual should be either n qudt ontology or in our new ontology
      		  if (ni != null){
      			OntologyModelHelper.getNewModel().add(res, prop, ni);
      			return true;
      		  }else if (qi != null){
      			OntologyModelHelper.getNewModel().add(res, prop, qi);
      			return true;
      		  }
      		  //value must be from qudt ontology or our new ontology
      		  else return false;
		  } else  if (OntologyModelHelper.isDatatypeProperty(propUri)){
			  DatatypeProperty prop = OntologyModelHelper.getOntModel().getDatatypeProperty(propUri);
			  Literal typedLiteral = getTypedLiteralForPropertyValue(prop, value);
			  if (typedLiteral == null)
				  return false;
			  OntologyModelHelper.getNewModel().add(res, prop, typedLiteral);
			  return true;
		  }  else {
			  Property prop = OntologyModelHelper.getProperty(propUri);
			  res.addProperty(prop, value);
			  return true;
		  }
		  
	  }
	  
	  private void editUnit(OntModel newModel, String localName, String typeLocalName, Constants.ontologies ont,  HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		  if ((localName == null)||(localName != null) && (localName.length() == 0)){ 
	        	request.setAttribute(ERROR, LOCAL_NAME_NOT_DEFINED);
	            outputPage("editunit.jsp?class_name=" + typeLocalName + "&ontology=" + ont.toString(), request, response);
	            return;
	        }
		     //add units only into new ontology
	        String uri = Constants.nameSpaceMap.get(ont) + localName; 
	        Resource resourceToEdit = newModel.getResource(uri);
	        if (!newModel.containsResource(resourceToEdit)) { 
	        	request.setAttribute(ERROR, NO_RESOURCE_TO_EDIT + " " + localName);
	            //forward to creating unit
	        	outputPage("editunit.jsp?class_name=" + typeLocalName + "&ontology=" + ont.toString(), request, response);
	            return;
	        }
	        
	        //all properties are accessed through qudt ontology, editable instances are from new ontology
	        List<String> propUris = OntologyModelHelper.getPropertyUriList(ont);
            for (String propuri: propUris) {
            	DatatypeProperty dataprop = OntologyModelHelper.getOntModel().getDatatypeProperty(propuri);
            	ObjectProperty obprop = OntologyModelHelper.getOntModel().getObjectProperty(propuri);
            	
            	String paramName = OntologyModelHelper.getResourceLocalName(OntologyModelHelper.getOntModel(), propuri);
            	String value = request.getParameter(paramName);
            	if ((value!=null) && (!"".equals(value))){
            		StmtIterator it = resourceToEdit.listProperties(OntologyModelHelper.getProperty(propuri));
            		newModel.remove(it.toList());
            		//Statement st = resourceToEdit.getProperty(OntologyModelHelper.getProperty(propuri));
    	        	//if (st != null)
    	        	//	newModel.remove(st);
    	        	if (!setValue(resourceToEdit, propuri, value))
    	        			request.setAttribute(ERROR, " invalid value for property " + propuri);
    	        }
            }
	        
	        //response.sendRedirect("unitinstance.jsp?unit_instance_name=" + resourceToEdit.getLocalName() + "&ontology=" + ont.toString());
            outputPage("unitinstance.jsp?unit_instance_name=" + resourceToEdit.getLocalName() + "&ontology=" + ont.toString(), request, response);
	  }

	  public static String glueLocalName(String name){
		  String [] n = name.split("\\s");
		  StringBuilder res = new StringBuilder();
		  for (int i = 0 ; i < n.length; i++){
			  n[i] = n[i].trim();
			  String b = n[i].substring(0, 1);
			  String e = n[i].substring(1);
			  
			  res.append(b.toUpperCase());
			  res.append(e.toLowerCase());
			  
		  }
		  
		  return res.toString();
	  }
	  
	  private void addUnit(OntModel newModel, String localName, String typeLocalName, Constants.ontologies ont, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		    //add units only into new ontology
		    if ((localName == null)||(localName != null) && (localName.length() == 0)){ 
	        	request.setAttribute(ERROR, LOCAL_NAME_NOT_DEFINED);
	            outputPage("editunit.jsp?class_name=" + typeLocalName + "&ontology=" + ont.toString(), request, response);
	            return;
	        }
	        
		    boolean valid = localName.matches("[\\w\\s]+");
	        if (!valid){
	        	request.setAttribute(ERROR, "invalid local name : for local name field only latin characters are permitted");
	            outputPage("editunit.jsp?class_name=" + typeLocalName, request, response);
	            return;
	        }
	        
	        localName = glueLocalName(localName);
	        
		    String uri = Constants.nameSpaceMap.get(ont) + localName; 
	        Resource resourceWithSameLocalName = newModel.getResource(uri);
	        if (newModel.containsResource(resourceWithSameLocalName)) { 
	        	request.setAttribute(ERROR, SAME_NAMES_ERROR + " " + localName);
	            outputPage("editunit.jsp?class_name=" + typeLocalName, request, response);
	            return;
	        }
	        
	        
		 	//Resource newRes = newModel.createResource(uri);
	        String typeUri = Constants.nameSpaceMap.get(Constants.ontologies.qudt) + typeLocalName;
	        //newRes.addProperty(OntologyModelHelper.getProperty(Constants.PROPERTY_TYPE), typeUri);
	        
	        //add class to our ontology
	        OntClass tt = newModel.createClass(Constants.nameSpaceMap.get(Constants.ontologies.qudt) + typeLocalName);
	        tt.addProperty(OntologyModelHelper.getProperty(Constants.PROPERTY_LABEL), typeUri);
	        Resource newRes = newModel.createIndividual(uri, tt);
			 
	        List<String> propUris = OntologyModelHelper.getPropertyUriList(ont);
            for (String propuri: propUris) {
            	String paramName = OntologyModelHelper.getResourceLocalName(OntologyModelHelper.getOntModel(), propuri);
            	String value = request.getParameter(paramName);
            	//newRes.addProperty(OntologyModelHelper.getProperty(propuri), value);
            	if ((value != null) && (!"".equals(value)))
            		if (!setValue(newRes, propuri, value))
            			request.setAttribute(ERROR, " invalid value for property " + propuri);
            }
	        
            outputPage("unitinstance.jsp?unit_instance_name=" + newRes.getLocalName() + "&ontology=" + ont.toString(), request, response);
	        //response.sendRedirect("unitinstance.jsp?unit_instance_name=" + newRes.getLocalName() + "&ontology=" + ont.toString());
	    
	  }
	  
	  private void outputPage(String pageJSP, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	      RequestDispatcher dispatcher = request.getRequestDispatcher(pageJSP);
	      dispatcher.forward(request, response);
	  }

}







