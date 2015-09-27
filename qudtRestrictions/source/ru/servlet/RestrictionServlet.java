package ru.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ru.Constants;
import ru.Utils;
import ru.helpers.OntologyModelHelper;
import ru.helpers.UnitHelper;
import ru.helpers.restriction.NumericValueRestriction;
import ru.helpers.restriction.RestrictionHelper;

@WebServlet("/RestrictionServlet")
public class RestrictionServlet extends HttpServlet{
	public static final String ERROR = "error";
	public static final String MESSAGE = "message";
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		try{	
			String action = request.getParameter("action");
			if (!OntologyModelHelper.isRestrictionOntologyCreated()){
				
			}
			if (action == null){
				request.setAttribute(ERROR, "no action specified");
				outputPage(Constants.HOME_PAGE, request, response);
				return;
			}
			if (action.equals("create")){
				createRestriction(request, response);	
				
				
			} else if (action.equals("delete")){
				deleteRestriction(request, response);
			} else {
				request.setAttribute(ERROR, "unknown action " + action);
				outputPage(Constants.HOME_PAGE, request, response);
				return;
			}
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

	
	/*
	private String prepareName(String uri){
		String []s =uri.split("http:/");
		String result = s[1];
		result = result.replaceAll("/", "_");
		result = result.replaceAll("\\.", "_");
		result = result.replaceAll("#", "_");
		return result;
	}
	
	private String prepareNSUri(String uri){
		int ind = uri.lastIndexOf("/");
		if (ind < uri.length() - 1)
			return uri;
		else if (ind == uri.length() - 1){
			String res = uri.substring(0, uri.length() - 1);
			return res;
		}
		return null;
	}*/
	
	//can create only for quantity kind that is present in current ontologies
	private void createRestriction(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		String quantityKindUri = request.getParameter("quantityKindUri");
		
		if (quantityKindUri == null) {
			request.setAttribute(ERROR, "quantityKindUri must be specified");
			outputPage(Constants.HOME_PAGE, request, response);
			return;
		}
		if (quantityKindUri.isEmpty()){
			request.setAttribute(ERROR, "quantityKindUri must be specified");
			outputPage(Constants.HOME_PAGE, request, response);
			return;
		}
		
		Constants.ontologies quantityKindOnt = Utils.getIndividualOntology(quantityKindUri);
		if (quantityKindOnt == null){
			request.setAttribute(ERROR, "quantityKindUri is invalid");
			outputPage(Constants.HOME_PAGE, request, response);
			return;
		}
		
	    if ("Cancel".equals(request.getParameter("cancel"))){
	    	response.sendRedirect("unitinstance.jsp?unit_instance_name=" + Utils.getLocalName(quantityKindUri) + "&ontology=" + quantityKindOnt.toString());
	    	return;
	    }
    
		String unitUri = request.getParameter("unitUri");
		if (unitUri == null) {
			request.setAttribute(ERROR, "unitUri must be specified");
			outputPage(Constants.HOME_PAGE, request, response);
			return;
		}
		if (unitUri.isEmpty()){
			request.setAttribute(ERROR, "unitUri must be specified");
			outputPage(Constants.HOME_PAGE, request, response);
			return;
		}
		Constants.ontologies unitOnt = Utils.getIndividualOntology(unitUri);
		//TODO go to create_restriction page
		
		Constants.ontologies quantKindOnt = Utils.getIndividualOntology(quantityKindUri);
		
		String pageToGo = "create_restriction.jsp?ontology="+quantKindOnt.toString() +"&quantity_kind_local_name="+Utils.getLocalName(quantityKindUri);		
		
		
		if (unitOnt == null){
			request.setAttribute(ERROR, "unitUri is invalid");

			outputPage(pageToGo, request, response);
			return;
		}
		
		
		if (!UnitHelper.checkIfHasConvMult(OntologyModelHelper.getCommonModel(), unitUri)){
			request.setAttribute(ERROR, "cannot create restriction on this unit : unit " + unitUri + " does not have conversion offset or multiplier");
            outputPage(pageToGo, request, response);
			return;			
		}
		if (!UnitHelper.checkIfUnitIsComparable(OntologyModelHelper.getCommonModel(), quantityKindUri, unitUri)){
			request.setAttribute(ERROR, "cannot create restriction on this unit : unit " + unitUri + " is not applicable to quantity kind " + quantityKindUri);
            outputPage(pageToGo, request, response);
			return;			
		}
		//if there are no restrictions on this quantityKind then create
		//if there are some then check if they are all valid and consistent then create max min from some of them
		List<NumericValueRestriction> restrictions = RestrictionHelper.listRestrictionsWithThisQuantityKind(OntologyModelHelper.getRestrictionModel(), quantityKindUri);
		List<String> reports = new ArrayList<>();
		if (!RestrictionHelper.restrictionsAreCompatible(restrictions, reports)){
			request.setAttribute(ERROR, "cannot create restriction: other restrictions are incompatible : " + Utils.makeReport(reports));
            outputPage(pageToGo, request, response);
			return;
		}
		
		String minStr = null;
		String maxStr = null;
		if (restrictions.size() == 0){
			minStr = request.getParameter("min");
			maxStr = request.getParameter("max");
			
			if ( (((minStr != null)&&(minStr.length() == 0)) || (minStr == null))
			    &&(((maxStr!=null)&&(maxStr.length() == 0)) || (maxStr == null))
			    ){
				request.setAttribute(ERROR, "max or min should be specified");
				outputPage(pageToGo, request, response);
				return;
			}
			if ((minStr != null) && (minStr.length() != 0)){
				if (!Utils.checkIsValidDoubleValue(minStr)){
					request.setAttribute(ERROR, "min is not valid xsd double value");
					outputPage(pageToGo, request, response);
					return;
				}
			}
			if ((maxStr != null) && (maxStr.length() != 0)){
				if (!Utils.checkIsValidDoubleValue(maxStr)){
					request.setAttribute(ERROR, "max is not valid xsd double value");
					outputPage(pageToGo, request, response);
					return;
				}	
			}
		} else {
			NumericValueRestriction r = restrictions.get(0);
			if (r.getMin() != null)
				minStr = Utils.convertToNewUnit(r.getMin(), Utils.getIndividual(r.getUnitUri()), Utils.getIndividual(unitUri)).toString();
			if (r.getMax() != null)
				maxStr = Utils.convertToNewUnit(r.getMax(), Utils.getIndividual(r.getUnitUri()), Utils.getIndividual(unitUri)).toString();
			
		}
//TODO unit convertion		
		
		String restrUri = RestrictionHelper.createUnitQuantityKindValueRangeRestriction(OntologyModelHelper.getRestrictionModel(), minStr, maxStr, quantityKindUri, unitUri);
//GO To new restriction page		
		outputPage("restriction.jsp?local_name=" + Utils.getLocalName(restrUri), request, response);
		return;

		
		
	}
	
	private void deleteRestriction(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		String catcherUri = request.getParameter("catcherUri");
		String quantityKindUri = request.getParameter("quantityKindUri");
		
		if (quantityKindUri == null) {
			request.setAttribute(ERROR, "quantityKindUri must be specified");
			outputPage(Constants.HOME_PAGE, request, response);
			return;
		}
		
		Constants.ontologies quantKindOnt = Utils.getIndividualOntology(quantityKindUri);
		
		String pageToGo = quantKindOnt == null? Constants.HOME_PAGE : "unitinstance.jsp?unit_instance_name=" + Utils.getLocalName(quantityKindUri) + "&ontology="+ quantKindOnt.toString(); 
		if (catcherUri == null) {
			request.setAttribute(ERROR, "catcherUri must be specified");
			outputPage(pageToGo, request, response);
			return;
		}
		
		RestrictionHelper.removeRestriction(OntologyModelHelper.getRestrictionModel(), catcherUri);
		request.setAttribute(MESSAGE, "restriction was removed");
		outputPage(pageToGo, request, response);
		return;
		
	}

	private void outputPage(String pageJSP, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	    RequestDispatcher dispatcher = request.getRequestDispatcher(pageJSP);
	    dispatcher.forward(request, response);
	}
}
