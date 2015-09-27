package ru;

import java.util.ArrayList;
import java.util.List;

import ru.helpers.OntologyModelHelper;

import com.hp.hpl.jena.datatypes.DatatypeFormatException;
import com.hp.hpl.jena.datatypes.xsd.XSDDatatype;
import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.query.Query;
import com.hp.hpl.jena.query.QueryExecution;
import com.hp.hpl.jena.query.QueryExecutionFactory;
import com.hp.hpl.jena.query.QueryFactory;
import com.hp.hpl.jena.query.ResultSet;
import com.hp.hpl.jena.rdf.model.Literal;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.Resource;

public class Utils {
	
	//checks only double value
	public static boolean checkIsValidDoubleValue(String value){
		Literal typedLiteral= null;
		try{
			typedLiteral = OntologyModelHelper.getNewModel().createTypedLiteral(value, XSDDatatype.XSDdouble);
			typedLiteral.getDouble();
		}
		catch (DatatypeFormatException e){
			//wrong format of literal
			return false;
		}
		return true;
	}
	
	public static String getLocalName(String uri){
		String res = "";
		OntModel m = OntologyModelHelper.getCommonModel();
		Resource ind = m.getOntResource(uri);
		if (ind != null)
			res = ind.getLocalName();
		
		return res;
	}
	
	public static Individual getIndividual(String uri){
		OntModel m = OntologyModelHelper.getCommonModel();
		Individual res = m.getIndividual(uri);
		return res;
	}
	
	public static boolean isOfType(String uri, String typeUri){
		OntModel ont = OntologyModelHelper.getCommonModel();
		String sparqlQueryString = 
				"PREFIX  owl:  <http://www.w3.org/2002/07/owl#> " +
						"PREFIX  rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> " +
						"PREFIX  rdfs: <http://www.w3.org/2000/01/rdf-schema#> " +
						"PREFIX  list: <http://jena.hpl.hp.com/ARQ/list#> " +
						"PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> " +
						"SELECT  distinct ?type " +
						"WHERE " +
						"  { " +
						"  {"+ "<" + uri+ ">" + " rdf:type " + "<"+ typeUri + ">" + ".}" +//<http://data.nasa.gov/qudt/owl/qudt#QuantityKind>.}" +
								"UNION " +
						"  {"+ "<" + uri+ ">" + " rdf:type ?type." +
						"	?type rdfs:subClassOf "+ "<"+ typeUri + ">.}" +
						"} " ;
	    Query query = QueryFactory.create(sparqlQueryString);
	    QueryExecution qexec = QueryExecutionFactory.create(query, ont);
	    ResultSet results = qexec.execSelect();
	    //ResultSetFormatter.out(results);
	    
	    
	    if (results.hasNext()){
	    	return true;
		}
	    qexec.close();
	    return false; 
	
	}
	
	public static List<String> getAllTypes(String uri, String highClassUri){
		
		OntModel ont = OntologyModelHelper.getCommonModel();
		String sparqlQueryString = 
				"PREFIX  owl:  <http://www.w3.org/2002/07/owl#> " +
						"PREFIX  rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> " +
						"PREFIX  rdfs: <http://www.w3.org/2000/01/rdf-schema#> " +
						"PREFIX  list: <http://jena.hpl.hp.com/ARQ/list#> " +
						"PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> " +
						"SELECT  distinct ?type " +
						"WHERE " +
						"  { " +
						"  {"+ "<" + uri+ ">" + " rdf:type ?type." +
								"FILTER ( ?type=<"+ highClassUri +">) } " +
								"UNION " +
						"  {"+ "<" + uri+ ">" + " rdf:type ?type." +
						"	?type rdfs:subClassOf* "+ "<"+ highClassUri + ">.}" +
						"} " ;
	    Query query = QueryFactory.create(sparqlQueryString);
	    QueryExecution qexec = QueryExecutionFactory.create(query, ont);
	    ResultSet results = qexec.execSelect();
	    //ResultSetFormatter.out(results);
	    
	    List<String> result = new ArrayList<>();
	    while (results.hasNext()){
	    	result.add(results.next().get("type").asResource().getURI());
		}
	    qexec.close();
	    return result;
	
		
	}
	
	public static void main(String args[]){
		System.out.println(getAllTypes("http://data.nasa.gov/qudt/owl/unit#JoulePerMole", "http://data.nasa.gov/qudt/owl/qudt#PhysicalUnit"));
	}
	
	public static boolean isQuantityKind(String uri){
		return isOfType(uri, Constants.CLASS_QUANTITY_KIND);
	}
	
	public static boolean isUnit(String uri){
		return isOfType(uri, Constants.CLASS_UNIT);
	}
	//return null if individual does not belong to qudt or new_ontology
	public static Constants.ontologies getIndividualOntology(String uri){
		Resource qudtInd = OntologyModelHelper.getOntModel().getIndividual(uri);
		Resource newOntInd = OntologyModelHelper.getNewModel().getIndividual(uri);
		
		
		if (qudtInd != null){
			if (isQuantityKind(uri))
				return Constants.ontologies.qudt_quantity;
			else if (isUnit(uri))
				return Constants.ontologies.qudt_unit;
			
		} else if (newOntInd != null){
			if (isQuantityKind(uri))
				return Constants.ontologies.new_ontology_quantity;
			else if (isUnit(uri))
				return Constants.ontologies.new_ontology_unit;
		}
		return null;
	}
	
	/*public static void main(String args[]){
		String uri = "http://data.nasa.gov/qudt/owl/quantity#LengthTemperature";
		System.out.println(getIndividualOntology("http://data.nasa.gov/qudt/owl/quantity#LengthTemperature"));
		Resource qudtInd = OntologyModelHelper.getOntModel().getResource(uri);
		System.out.println(qudtInd!=null);
		
	}*/
	
	//operation is not safe
	public static Double convertToBaseUnit(Double value, Individual unit){
		Property multiplier = OntologyModelHelper.getOntModel().getProperty(Constants.PROPERTY_CONVERSION_MULTIPLIER);
		Property offset = OntologyModelHelper.getOntModel().getProperty(Constants.PROPERTY_CONVERSION_OFFSET);
		return (value* unit.getProperty(multiplier).getObject().asLiteral().getDouble() + unit.getProperty(offset).getObject().asLiteral().getDouble());
	}
	//operation is not safe
	public static Double convertToNewUnit(Double value, Individual unit, Individual newUnit){
		Double baseValue = convertToBaseUnit(value, unit);
		Property multiplier = OntologyModelHelper.getOntModel().getProperty(Constants.PROPERTY_CONVERSION_MULTIPLIER);
		Property offset = OntologyModelHelper.getOntModel().getProperty(Constants.PROPERTY_CONVERSION_OFFSET);
		return (baseValue - newUnit.getProperty(offset).getObject().asLiteral().getDouble())/ newUnit.getProperty(multiplier).getObject().asLiteral().getDouble();
	}
	
	public static String makeReport(List<String> reps){
		StringBuilder sb = new StringBuilder();
		for (String r : reps){
			sb.append(r + ";<br>");
		}
		return sb.toString();
	}

}
