package ru.helpers.restriction;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import ru.Constants;
import ru.Utils;
import ru.helpers.OntologyModelHelper;
import ru.helpers.UnitHelper;

import com.hp.hpl.jena.datatypes.TypeMapper;
import com.hp.hpl.jena.ontology.AllValuesFromRestriction;
import com.hp.hpl.jena.ontology.HasValueRestriction;
import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.IntersectionClass;
import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.Restriction;
import com.hp.hpl.jena.query.Query;
import com.hp.hpl.jena.query.QueryExecution;
import com.hp.hpl.jena.query.QueryExecutionFactory;
import com.hp.hpl.jena.query.QueryFactory;
import com.hp.hpl.jena.query.ResultSet;
import com.hp.hpl.jena.rdf.model.Literal;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.RDFList;
import com.hp.hpl.jena.rdf.model.RDFNode;
import com.hp.hpl.jena.rdf.model.Resource;
import com.hp.hpl.jena.rdf.model.Statement;
import com.hp.hpl.jena.rdf.model.StmtIterator;

public class RestrictionHelper {
	static private String prepareName(String uri){
		String []s = uri.split("http:/");
		String result = s[1];
		result = result.replaceAll("/", "_");
		result = result.replaceAll("\\.", "_");
		result = result.replaceAll("#", "_");
		return result;
	}
	
	static private String prepareNSUri(String uri){
		int ind = uri.lastIndexOf("/");
		if (ind < uri.length() - 1)
			return uri;
		else if (ind == uri.length() - 1){
			String res = uri.substring(0, uri.length() - 1);
			return res;
		}
		return null;
	}
	
	public static String createUnitQuantityKindValueRangeRestriction( OntModel ont, String min, String max, String quantityKindUri, String unitUri) throws IOException{
		String catcherSuffix = "catcher";
		String validatorSuffix = "validator";
		
		String ontologyNS = prepareNSUri(Constants.nameSpaceMap.get(Constants.ontologies.restriction_ontology));
		String qnp = prepareName(quantityKindUri);
		String unp = prepareName(unitUri);
		//System.out.println(unp);
		//System.out.println(qnp);
	    String restrictionUri = ontologyNS + qnp + "_" + unp;
	   // System.out.println(restrictionUri);
		OntClass catcher = ont.createClass(restrictionUri + catcherSuffix);
		OntClass validator = ont.createClass(restrictionUri + validatorSuffix);
	
	//QUDT class!
		validator.addSuperClass(ont.getOntClass("http://data.nasa.gov/qudt/owl/qudt#QuantityValue")); //restriction cardinality 1 on numericValue
		catcher.addSuperClass(validator);
	
		//create restriction on numericValue value
		OntClass dt = ont.createClass();
		//OntClass dt = ont.getOntClass("http://www.w3.org/2000/01/rdf-schema#Datatype");
		dt.addProperty(ont.getProperty("http://www.w3.org/2002/07/owl#onDatatype"), ont.getResource("http://www.w3.org/2001/XMLSchema#double"));
		
		Resource range = ont.createResource(restrictionUri+ "_range");
		
		if ((min != null) && (min.length()!=0) && (Utils.checkIsValidDoubleValue(min))) 
		    range.addProperty(ont.getProperty("http://www.w3.org/2001/XMLSchema#minInclusive"), ont.createTypedLiteral(min.toString(), TypeMapper.getInstance().getTypeByName("http://www.w3.org/2001/XMLSchema#double")));
		if ((max != null) &&(min.length()!=0) && (Utils.checkIsValidDoubleValue(max)))
			range.addProperty(ont.getProperty("http://www.w3.org/2001/XMLSchema#maxInclusive"), ont.createTypedLiteral(max.toString(), TypeMapper.getInstance().getTypeByName("http://www.w3.org/2001/XMLSchema#double")));
		
		//ugly code
		Resource list1 = ont.createIndividual(ont.getOntClass("http://www.w3.org/1999/02/22-rdf-syntax-ns#List"));
		list1.addProperty(ont.getProperty("http://www.w3.org/1999/02/22-rdf-syntax-ns#first"), range);
		list1.addProperty(ont.getProperty("http://www.w3.org/1999/02/22-rdf-syntax-ns#rest"), ont.getResource("http://www.w3.org/1999/02/22-rdf-syntax-ns#nil"));//list2);
		
		dt.addProperty(ont.getProperty("http://www.w3.org/2002/07/owl#withRestrictions"), list1);
	//QUDT property!
		Restriction res4 = ont.createAllValuesFromRestriction(null, ont.getProperty("http://data.nasa.gov/qudt/owl/qudt#numericValue"), dt);
		
		validator.addSuperClass(res4);
	 
		//restriction on unit and quantityKind of Quantity
	//QUDT property!
		//unit restriction
		HasValueRestriction unit_restriction = ont.createHasValueRestriction(null, ont.getProperty("http://data.nasa.gov/qudt/owl/qudt#unit"), ont.getResource(unitUri));
		
	//QUDT property!
		HasValueRestriction quantityKind_restriction = ont.createHasValueRestriction(null, ont.getProperty("http://data.nasa.gov/qudt/owl/qudt#quantityKind"), ont.getResource(quantityKindUri));
		RDFList quantity_quantityKindRestr_inters_list = ont.createList();
	//QUDT class!		
		quantity_quantityKindRestr_inters_list = quantity_quantityKindRestr_inters_list.cons(ont.getOntClass("http://data.nasa.gov/qudt/owl/qudt#Quantity"));
		quantity_quantityKindRestr_inters_list = quantity_quantityKindRestr_inters_list.cons(quantityKind_restriction);
		
		IntersectionClass quantity_quantityKindRestr_inters = ont.createIntersectionClass(null, quantity_quantityKindRestr_inters_list);
	
	//QUDT property!
		AllValuesFromRestriction valueQuantityRestriction = ont.createAllValuesFromRestriction(null, ont.getProperty("http://data.nasa.gov/qudt/owl/qudt#valueQuantity"), quantity_quantityKindRestr_inters);
		
		RDFList unit_quantityKind_list = ont.createList();
		unit_quantityKind_list = unit_quantityKind_list.cons(unit_restriction);
		unit_quantityKind_list = unit_quantityKind_list.cons(valueQuantityRestriction);
	
		//result unit quantity kind restriction
		OntClass unit_quantityKind = ont.createIntersectionClass(null, unit_quantityKind_list);
		
		catcher.addEquivalentClass(unit_quantityKind);
		return catcher.getURI();
	}
	
	public static List<String> getAllCatcherUrisByQuantityKind(OntModel ont, String quantityKindUri){
		List<String> res = new ArrayList<>();
		String sparqlQueryString = 
				"PREFIX  owl:  <http://www.w3.org/2002/07/owl#> " +
						"PREFIX  rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> " +
						"PREFIX  rdfs: <http://www.w3.org/2000/01/rdf-schema#> " +
						"PREFIX  list: <http://jena.hpl.hp.com/ARQ/list#> " +
						"SELECT  ?catcher " + 
						"WHERE " +
						"  {?catcher owl:equivalentClass ?root. " +
						"   ?root owl:intersectionOf ?rootRe. " +
						"   ?rootRe list:member ?valQuantRe. " +
						"   ?valQuantRe owl:onProperty <http://data.nasa.gov/qudt/owl/qudt#valueQuantity>. " +
						"   ?valQuantRe owl:allValuesFrom ?quantityRoot." +
						"   ?quantityRoot owl:intersectionOf ?quantityRe. " +
						"   ?quantityRe list:member ?quantityKindRe." +
						"   ?quantityRe list:member <http://data.nasa.gov/qudt/owl/qudt#Quantity>." +
						"   ?quantityKindRe owl:onProperty <http://data.nasa.gov/qudt/owl/qudt#quantityKind>." +
						"   ?quantityKindRe owl:hasValue  " +
						"<" + quantityKindUri + ">" +
						
						"} " ;
	    Query query = QueryFactory.create(sparqlQueryString);
	    QueryExecution qexec = QueryExecutionFactory.create(query, ont);
	    ResultSet results = qexec.execSelect();
	    System.out.println("rownum " + results.getRowNumber());
	    while (results.hasNext()){
	    	res.add(results.next().get("catcher").toString());
	    }
	    qexec.close();
	    return res;
	    //ResultSetFormatter.out(results);
	
	}
	

	private static void nodeRemove(OntModel ont, RDFNode node){
		List<RDFNode> nodesToRemove = new ArrayList<>();
		nodesToRemove.add(node);
		
		int count = 0;
		while(count != nodesToRemove.size()){
			StmtIterator iter = nodesToRemove.get(count).asResource().listProperties();
			List<Statement> stList = iter.toList();
			//System.out.println("removing " + nodesToRemove.get(count).asResource());
			//System.out.println("props :-------");
			for (Statement st : stList){
				Property p = st.getPredicate();
				if (p.getURI().equals("http://www.w3.org/1999/02/22-rdf-syntax-ns#type")||
						p.getURI().equals("http://www.w3.org/2002/07/owl#onProperty")||
						p.getURI().equals("http://www.w3.org/2002/07/owl#maxCardinality")||
						p.getURI().equals("http://www.w3.org/2002/07/owl#minCardinality")||
						p.getNameSpace().equals("http://data.nasa.gov/qudt/owl/qudt#")
						)
					continue;
				RDFNode n = st.getObject();
				if (!n.isResource())
					continue;
				if (node.isURIResource() && (!"http://thermal#".equals(node.asResource().getNameSpace()))){
					continue;
				}
				//System.out.println("adding " + node.asResource().getURI());
				//System.out.println(p.getURI());
				
				nodesToRemove.add(n);
			}
			//System.out.println("-----------");
			StmtIterator iter2 = nodesToRemove.get(count).asResource().listProperties();
			ont.remove(iter2.toList());
			iter2.close();
			
			count++;
		}
	}
	
	
	public static void removeRestriction(OntModel ont, String catcherUri){
		System.out.println("catcher to remove " + catcherUri);
		OntClass catcher = ont.getOntClass(catcherUri);
		//there is nothing to remove
		if (catcher == null) {
			System.out.println("null");
			return;
		}
		
		nodeRemove(ont, catcher);
	}
	
	public static String queryUnitByCatcher(OntModel ont, String catcherUri){
		String sparqlQueryString = 
				"PREFIX  owl:  <http://www.w3.org/2002/07/owl#> " +
						"PREFIX  rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> " +
						"PREFIX  rdfs: <http://www.w3.org/2000/01/rdf-schema#> " +
						"PREFIX  list: <http://jena.hpl.hp.com/ARQ/list#> " +
						"SELECT distinct ?unit " +
						"WHERE " +
						"  {"+ "<" + catcherUri+ ">" + " owl:equivalentClass ?root. " +
						"   ?root owl:intersectionOf ?rootRe. " +
						"   ?rootRe list:member ?UnitRe." +
						"   ?UnitRe owl:onProperty <http://data.nasa.gov/qudt/owl/qudt#unit>." +
						"   ?UnitRe owl:hasValue ?unit " +
						"} " ;
	    Query query = QueryFactory.create(sparqlQueryString);
	    QueryExecution qexec = QueryExecutionFactory.create(query, ont);
	    ResultSet results = qexec.execSelect();
	    //if (results.getRowNumber() != 1) 
	    //	throw new RuntimeException(" wrong number of units for restriction :" + results.getRowNumber());
	    String unit = "";
	    if (results.hasNext())
	    	unit =  results.nextSolution().get("unit").toString(); 
	    qexec.close();
	    
	    return unit; 
	}

	public static Double queryMaxByCatcher(OntModel ont, String catcherUri){
		String sparqlQueryString = 
				"PREFIX  owl:  <http://www.w3.org/2002/07/owl#> " +
						"PREFIX  rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> " +
						"PREFIX  rdfs: <http://www.w3.org/2000/01/rdf-schema#> " +
						"PREFIX  list: <http://jena.hpl.hp.com/ARQ/list#> " +
						"PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> " +
						"SELECT  distinct ?range ?max " +
						"WHERE " +
						"  {"+ "<" + catcherUri+ ">" + " rdfs:subClassOf ?validator. " +
						"   ?validator rdfs:subClassOf ?numvalRe. " +
						"   ?numvalRe owl:onProperty <http://data.nasa.gov/qudt/owl/qudt#numericValue>. " +
						"   ?numvalRe owl:allValuesFrom ?dtRe." +
						"   ?dtRe owl:onDatatype <http://www.w3.org/2001/XMLSchema#double>. " +
						"   ?dtRe owl:withRestrictions ?reList. " +
						"   ?reList list:member ?range. " +
						"   ?range xsd:maxInclusive ?max. " +
						"} " ;
	    Query query = QueryFactory.create(sparqlQueryString);
	    QueryExecution qexec = QueryExecutionFactory.create(query, ont);
	    ResultSet results = qexec.execSelect();
	    //ResultSetFormatter.out(results);
	    
	    Double max = null;
	    if (results.hasNext()){
	    	RDFNode range = results.next().get("range");
	    	Statement st = range.asResource().getProperty(OntologyModelHelper.getRestrictionModel().getProperty("http://www.w3.org/2001/XMLSchema#maxInclusive"));
	    	Literal l = st.getObject().asLiteral();
	    	max = l.getDouble();	
		}
	    qexec.close();
	    return max; 
	
	}

	public static Double queryMinByCatcher(OntModel ont, String catcherUri){
		String sparqlQueryString = 
				"PREFIX  owl:  <http://www.w3.org/2002/07/owl#> " +
						"PREFIX  rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> " +
						"PREFIX  rdfs: <http://www.w3.org/2000/01/rdf-schema#> " +
						"PREFIX  list: <http://jena.hpl.hp.com/ARQ/list#> " +
						"PREFIX xsd: <http://www.w3.org/2001/XMLSchema#> " +
						"SELECT  distinct ?range ?min " +
						"WHERE " +
						"  {"+ "<" + catcherUri+ ">" + " rdfs:subClassOf ?validator. " +
						"   ?validator rdfs:subClassOf ?numvalRe. " +
						"   ?numvalRe owl:onProperty <http://data.nasa.gov/qudt/owl/qudt#numericValue>. " +
						"   ?numvalRe owl:allValuesFrom ?dtRe." +
						"   ?dtRe owl:onDatatype <http://www.w3.org/2001/XMLSchema#double>. " +
						"   ?dtRe owl:withRestrictions ?reList. " +
						"   ?reList list:member ?range. " +
						"   ?range xsd:minInclusive ?min. " +
						"} " ;
	    Query query = QueryFactory.create(sparqlQueryString);
	    QueryExecution qexec = QueryExecutionFactory.create(query, ont);
	    ResultSet results = qexec.execSelect();
	 //   ResultSetFormatter.out(results);
	    Double min = null;
	    if (results.hasNext()){
	    	RDFNode range = results.next().get("range");
	    	Statement st = range.asResource().getProperty(OntologyModelHelper.getRestrictionModel().getProperty("http://www.w3.org/2001/XMLSchema#minInclusive"));
	    	Literal l = st.getObject().asLiteral();
	    	min = l.getDouble();	
		}
	    qexec.close();
	    return min;
	}
	
	public static String queryQuantityKindUriByCatcher(OntModel ont, String catcherURI){
		String sparqlQueryString = 
				"PREFIX  owl:  <http://www.w3.org/2002/07/owl#> " +
						"PREFIX  rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> " +
						"PREFIX  rdfs: <http://www.w3.org/2000/01/rdf-schema#> " +
						"PREFIX  list: <http://jena.hpl.hp.com/ARQ/list#> " +
						"SELECT  ?qua " +
						"WHERE " +
						"  {" +"<"+ catcherURI + ">"+" owl:equivalentClass ?root. " +
						"   ?root owl:intersectionOf ?rootRe. " +
						"   ?rootRe list:member ?valQuantRe. " +
						"   ?valQuantRe owl:onProperty <http://data.nasa.gov/qudt/owl/qudt#valueQuantity>. " +
						"   ?valQuantRe owl:allValuesFrom ?quantityRoot." +
						"   ?quantityRoot owl:intersectionOf ?quantityRe. " +
						"   ?quantityRe list:member ?quantityKindRe." +
						"   ?quantityRe list:member <http://data.nasa.gov/qudt/owl/qudt#Quantity>." +
						"   ?quantityKindRe owl:onProperty <http://data.nasa.gov/qudt/owl/qudt#quantityKind>." +
						"   ?quantityKindRe owl:hasValue ?qua " +
						"} " ;
	    Query query = QueryFactory.create(sparqlQueryString);
	    QueryExecution qexec = QueryExecutionFactory.create(query, ont);
	    ResultSet results = qexec.execSelect();
	    String res = "";
	    if (results.hasNext()){
	    	res = results.next().get("qua").toString();
	    }
	    qexec.close();
	    return res;
	    //ResultSetFormatter.out(results);
	
	}
	

    public static NumericValueRestriction getNumericValueRestriction(OntModel ont, String catcherUri){
    	String unit = queryUnitByCatcher(ont, catcherUri);
    	Double min = queryMinByCatcher(ont, catcherUri);
    	Double max = queryMaxByCatcher(ont, catcherUri);
    	String quantityKindUri  = queryQuantityKindUriByCatcher(ont, catcherUri);
    	
    	if ((unit == null) || (quantityKindUri == null))
    		throw new RuntimeException("wrong catcherUri");
    	
    	NumericValueRestriction restr = new NumericValueRestriction(catcherUri, quantityKindUri, unit, min, max);
    	return restr;
    }
    
	public static List<NumericValueRestriction> listRestrictionsWithThisQuantityKind(OntModel ont, String quantityKindUri){
		List<NumericValueRestriction> result = new ArrayList<>();
		//without checking if this is quantity kind
		List<String> catchers = getAllCatcherUrisByQuantityKind(ont, quantityKindUri);
		for (String c : catchers){
			result.add(getNumericValueRestriction(ont, c));
		}
		return result;
	}
	
	//if unit does not exist or do not have offset and multiplier or is not comparable with this quantity kind return false
	//otherwise return true
	public static boolean restrictionIsValid(NumericValueRestriction restr, List<String> reports){
		String unitUri = restr.getUnitUri();
		String quantityKind = restr.getQuantityKindUri();
		
		if (unitUri == null){
			reports.add( unitUri + " is null ");
			return false;
		}
		if (quantityKind == null){
			reports.add( quantityKind + " is null ");
			return false;
		}
		if (Utils.getIndividual(unitUri) == null){
			reports.add( unitUri + " does not exists; ");
			return false;
		}
		if (!Utils.isUnit(unitUri)){
			reports.add("\n" + unitUri + " is not defined as qudt:Unit ");
			return false;
		}
		
		boolean iscomp = UnitHelper.checkIfUnitIsComparable(OntologyModelHelper.getCommonModel(), restr.getQuantityKindUri(), unitUri);
		if (!iscomp) {
			reports.add(unitUri + " is not appliable to " + restr.getQuantityKindUri());
			return false;
		}
		
		boolean hasMultAndOffset = UnitHelper.checkIfHasConvMult(OntologyModelHelper.getCommonModel(), unitUri);
		if (!hasMultAndOffset) {
			reports.add(unitUri + " does not have conversion multiplier or conversion offset ");
			return false;
		}
		
		return true;
		
	}
	
	
	
	//checks if each restriction is valid in current model and if they are all compatible with each other
	public static boolean restrictionsAreCompatible(List<NumericValueRestriction> restrictionList, List<String> reports){
		if (restrictionList.size() == 0)
			return true;
        boolean valid = true;		
		for (NumericValueRestriction restr : restrictionList){
			valid = restrictionIsValid(restr, reports);
		}
		if (!valid)
			return false;
		
		System.out.println("RESTRICTIONS ARE VALID!!!!!!");
		//now all units exist and have conversion multiplier and offset
		NumericValueRestriction r1 = restrictionList.get(0);
		Individual unit = Utils.getIndividual(r1.getUnitUri());
		Double minBase = restrictionList.get(0).getMin(); 
		if (minBase!=null)	
			minBase = Utils.convertToBaseUnit(minBase, unit);
		Double maxBase = restrictionList.get(0).getMax();
		if (maxBase != null)
			maxBase = Utils.convertToBaseUnit(maxBase, unit);
		
		boolean compatible = true;
		for (NumericValueRestriction r : restrictionList){
			unit = Utils.getIndividual(r.getUnitUri());
			Double min = r.getMin();
			Double max = r.getMax();
			
			if (((min == null) && (minBase != null))
			|| ((min != null) && (minBase == null))){
				compatible = false;
				reports.add(r1.getUnitUri() + " restriction is incompatible with " + unit.getURI() +" restriction : min values are incompatible");
			}
				
			if (((max == null) && (maxBase != null))
					|| ((max != null) && (maxBase == null))){
						compatible = false;
						reports.add(r1.getUnitUri() + " restriction is incompatible with " + unit.getURI() +" restriction : min values are incompatible");
					}	
			
			
			if (min!= null){
				Double minB = Utils.convertToBaseUnit(min, unit);
				if (!minB.equals(minBase)){
					compatible = false;
					reports.add(r1.getUnitUri() + " restriction is incompatible with " + unit.getURI() +" restriction : min values are incompatible");
				}
			}
			
			if (max!= null){
				Double maxB = Utils.convertToBaseUnit(max, unit);
				if (!maxB.equals(maxBase)){
					compatible = false;
					reports.add(r1.getUnitUri() + " restriction is incompatible with " + unit.getURI() +" restriction : max values are incompatible");
				}
			}
		}
				
		return compatible;
		
	}
	

}
