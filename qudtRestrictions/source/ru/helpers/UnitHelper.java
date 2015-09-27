package ru.helpers;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import ru.Utils;

import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.query.Query;
import com.hp.hpl.jena.query.QueryExecution;
import com.hp.hpl.jena.query.QueryExecutionFactory;
import com.hp.hpl.jena.query.QueryFactory;
import com.hp.hpl.jena.query.ResultSet;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.Statement;

public class UnitHelper {
	public static List<String> getAllComparableUnits(OntModel ont, String quantityKindUri){
		List<String> res = new ArrayList<>();
		String sparqlQueryString = 
				"PREFIX  owl:  <http://www.w3.org/2002/07/owl#> " +
						"PREFIX  rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> " +
						"PREFIX  rdfs: <http://www.w3.org/2000/01/rdf-schema#> " +
						"PREFIX  list: <http://jena.hpl.hp.com/ARQ/list#> " +
						"PREFIX  qudt: <http://data.nasa.gov/qudt/owl/qudt#> " +
						
						
						"SELECT distinct ?unit " +
						"WHERE " +
						"{ " +
						"  {?unit qudt:quantityKind " + "<" + quantityKindUri + ">. }" +
						"        UNION " +
						
						"	{?q qudt:generalization* ?qg. " +
						"    ?unit	qudt:quantityKind ?q. " +
						"    <" + quantityKindUri + ">" + " qudt:generalization* ?qg. }" +
						"        UNION " +
						"   {?q qudt:generalization* " + " <" + quantityKindUri + ">." +
						"    ?unit	qudt:quantityKind ?q." +
						"   } " +
						"        UNION " +
						"   {" + " <" + quantityKindUri + ">" + " qudt:generalization* ?q." +
						"    ?unit	qudt:quantityKind ?q." +
						"   } " +
						"}";

		Query query = QueryFactory.create(sparqlQueryString);
	    QueryExecution qexec = QueryExecutionFactory.create(query, ont);
	    ResultSet results = qexec.execSelect();
	    
	    
	    while (results.hasNext()){
	    	res.add(results.next().get("unit").toString());
	    }
	    qexec.close();
	    return res;
	}
	
	public static boolean checkIfUnitIsComparable(OntModel ont, String quantityKindUri, String unitUri){
		List<String> allComparable = getAllComparableUnits(ont, quantityKindUri); 
		
		Set<String> c = new HashSet<>();
		c.addAll(allComparable);
		if (!c.contains(unitUri))
			return false;
		return true;
		
	}
	
	
	public static boolean checkIfHasConvMult(OntModel ont, String unitUri){
		Individual ind = ont.getIndividual(unitUri);
		if (ind == null)
			return false;
		Property mult = ont.getProperty("http://data.nasa.gov/qudt/owl/qudt#conversionMultiplier");
		Property offset = ont.getProperty("http://data.nasa.gov/qudt/owl/qudt#conversionOffset");
		
		if ((mult==null) || (offset == null)) 
			throw new RuntimeException("no such property!!");
		Statement multSt = ind.getProperty(mult);
		Statement offsetSt = ind.getProperty(offset);
		
		if ((multSt != null) && (offsetSt != null)){
			if (!multSt.getObject().isLiteral())
				return false;
			if (!offsetSt.getObject().isLiteral())
				return false;
			return (Utils.checkIsValidDoubleValue(multSt.getObject().asLiteral().getString()) && 
					Utils.checkIsValidDoubleValue(offsetSt.getObject().asLiteral().getString()));
		}
			
		return false;
	}
	
	public static void main(String args[]){
		OntModel ont = OntologyModelHelper.getCommonModel();
		System.out.println(checkIfHasConvMult(ont, "http://data.nasa.gov/qudt/owl/unit#Mho"));
	}
}
