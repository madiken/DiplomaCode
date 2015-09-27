package ru.servlet;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ru.Constants;
import ru.Options;
import ru.helpers.OntologyModelHelper;

import com.hp.hpl.jena.datatypes.xsd.XSDDatatype;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.rdf.model.Literal;

@WebServlet("/NewOntologyServlet")
public class NewOntologyServlet extends HttpServlet{
	public static final String MESSAGE = "mesg";
	public static final String ERROR = "error";
	
	private static final String OK_STATUS = "ontology was succefully written";
	private static final String NO_ONTOLOGY_CREATED = "there is no ontology to manipulate";
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    try {
	    	String ontology = request.getParameter("ontology");
	    	String ontStr = null; 
	    	if (Constants.ontologies.new_ontology.toString().equals(ontology)){
	    		if (!OntologyModelHelper.isNewOntologyCreated()){
					request.setAttribute(ERROR, NO_ONTOLOGY_CREATED);
			        outputPage(Constants.HOME_PAGE, request, response);
			        return;
				}
	    		ontStr = Constants.ontologies.new_ontology.toString(); 
	    		
	    	} else if (Constants.ontologies.restriction_ontology.toString().equals(ontology)){
	    		if (!OntologyModelHelper.isRestrictionOntologyCreated()){
					request.setAttribute(ERROR, NO_ONTOLOGY_CREATED);
			        outputPage(Constants.HOME_PAGE, request, response);
			        return;
				}
	    		ontStr = Constants.ontologies.restriction_ontology.toString();
	    		
	    	}
	    	else {
				request.setAttribute(ERROR, "unknown ontology " +  ontology);
		        outputPage(Constants.HOME_PAGE, request, response);
		        return;
	    	}
	    	
			String action = request.getParameter("action");
			if ("clear".equals(action)){
				OntologyModelHelper.clearModel(ontStr);
				request.setAttribute(MESSAGE, "all statements were erased from " + ontStr);
				outputPage(Constants.HOME_PAGE, request, response);
				return;
			}
			
			else {
				request.setAttribute(ERROR, "unknown action");
				outputPage(Constants.HOME_PAGE, request, response);
				return;
			}
			//if ("persist".equals(action))
			//persistOntology(request, response);
		    
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return;
        
	}
	
	
	
	private void clearOntology(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		OntologyModelHelper.clearNewOntology();
		request.setAttribute(MESSAGE, "new ontology : all statements was erased");
		//forwardBack(request, response);
		outputPage(Constants.HOME_PAGE, request, response);
		return;
	}
	/*
	private void persistOntology(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
			
		request.setCharacterEncoding("UTF-8");
        OntModel newModel = OntologyModelHelper.getNewModel();
        
        String path = Options.DOWNLOAD_DIR;
        File file = new File(path);
        file.getParentFile().mkdirs();
        FileWriter fw = new FileWriter(path);
	    newModel.write( fw, "RDF/XML-ABBREV" );
        fw.close();
        request.setAttribute(PERSIST_ONTOLOGY_MESSAGE, OK_STATUS);
        outputPage(Constants.HOME_PAGE, request, response);
        return;
	}*/
	
	/*private void forwardBack(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
		String referrer = request.getHeader("referer");
		int index = referrer.lastIndexOf(Constants.APP_NAME) + Constants.APP_NAME.length();
		System.out.println("index -" + index );
		referrer = referrer.substring(index);
		System.out.println("test/" + referrer);
		
		response.sendRedirect("test/" + referrer);
		//outputPage(referrer, request, response);
    }*/
	
	private void outputPage(String pageJSP, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	      RequestDispatcher dispatcher = request.getRequestDispatcher(pageJSP);
	      dispatcher.forward(request, response);
	      
	}
	  

}
