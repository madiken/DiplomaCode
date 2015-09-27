package ru.helpers;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import ru.Constants;
import ru.Constants.ontologies;
import ru.Options;

import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntModelSpec;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.RDFNode;
import com.hp.hpl.jena.rdf.model.Resource;


public class OntologyModelHelper {
	private static OntModel ontModel = null;
	private static OntModel newModel = null;
	private static OntModel restrictionModel = null;

	/*private static void initializeModel()
	{
		newModel = getNewModel();
	}*/
	
	public static OntModel getCommonModel(){
		OntModel ont = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM);
		ont.addSubModel(getNewModel());
		ont.addSubModel(getOntModel());
		ont.addSubModel(getRestrictionModel());
		
		return ont;
	}
	
	public static void loadToModelFromFile(OntModel model, String path_str){
		//String base = new File("").getAbsolutePath();
		File file = new File(path_str);
		Path path = Paths.get(file.getPath());
		model.read(path.toUri().toString(), "RDF/XML");
	}
	
	public static OntModel getOntModel(){
		if (ontModel == null){
			String owlPath = //new File("").getAbsolutePath() + 
					Options.qudtOntologyPath;
			//Path qudt = Paths.get(owlPath, "qudt.owl");
			//Path unit = Paths.get(owlPath, "unit.owl");
			//Path quantity = Paths.get(owlPath, "quantity.owl");
			
			URI qudt = URI.create(owlPath + "/qudt.owl");
			URI unit = URI.create(owlPath + "/unit.owl");
			URI quantity = URI.create(owlPath + "/quantity.owl");
			InputStream input1 = null;
			InputStream input2 = null;
			InputStream input3 = null;
			try {
				input1 = new URL(owlPath + "/qudt.owl").openStream();
				input2 = new URL(owlPath + "/unit.owl").openStream();
				input3 = new URL(owlPath + "/quantity.owl").openStream();
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			ontModel = ModelFactory.createOntologyModel(OntModelSpec.RDFS_MEM_RDFS_INF);
			ontModel.read(input1, "RDF/XML");
			ontModel.read(input2, "RDF/XML");
			ontModel.read(input3, "RDF/XML");
		}
		return ontModel;
	}
	
	
	public static void checkRestrictionModel(){
		if (restrictionModel == null){
			throw new RuntimeException("new ontology does not exist yet!");
		}
	}
	
	public static void checkNewModel(){
		if (newModel == null){
			throw new RuntimeException("new ontology does not exist yet!");
		}
	}
	
	public static void checkOntModel(){
		if (ontModel == null){
			throw new RuntimeException("qudt ontology hasn't been loaded");
		}
	}
	//create clear model for new ontology temporary
	public static OntModel getNewModel(){
		if (newModel == null){
			newModel = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM);
			//this property is used
			//newModel.createObjectProperty("http://data.nasa.gov/qudt/owl/qudt#quantityKind");
			
			//set default namespace
			newModel.setNsPrefix("", Options.newModelNameSpace);
			//add 
			Constants.nameSpaceMap.put(ontologies.new_ontology_unit, newModel.getNsPrefixURI(""));
			Constants.nameSpaceMap.put(ontologies.new_ontology_quantity, newModel.getNsPrefixURI(""));
			Constants.nameSpaceMap.put(ontologies.new_ontology, newModel.getNsPrefixURI(""));
			
		}
		return newModel;
	}
	
	//create clear model for new restriction ontology
	public static OntModel getRestrictionModel(){
		if (restrictionModel == null){
			restrictionModel = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM); //without inference 
			//set default namespace
			restrictionModel.setNsPrefix("", Options.restrictionModelNameSpace);
			//add 
			Constants.nameSpaceMap.put(ontologies.restriction_ontology, restrictionModel.getNsPrefixURI(""));
			//load necessary QUDT classes and properties
			//loadToModelFromFile(restrictionModel, /*new File("").getAbsolutePath() + */Options.pathToRestrictionModelBase);
			//URI re = URI.create(Options.pathToRestrictionModelBase + "/RestrictionOntologyBase.owl");
			InputStream input = null;
			try {
				input = new URL(Options.pathToRestrictionModelBase  + "/RestrictionOntologyBase.owl").openStream();
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			restrictionModel.read(input, "RDF/XML"); 
			
			
		}
		return restrictionModel;
	}
		
	
	static String getNewOntologyDefaultNamespace(){
		checkNewModel();
		return newModel.getNsPrefixURI("");
	}
	
	static String getRestrcitionOntologyDefaultNamespace(){
		checkRestrictionModel();
		return restrictionModel.getNsPrefixURI("");
	}
	
	//all properties are in qudt model
	public static Property getProperty(String uri){
		checkOntModel();
		return ontModel.getProperty(uri);
	}
	
	public static void clearNewOntology(){
		newModel = null;
		newModel = getNewModel();
	}
	
	public static void clearRestrictionOntology(){
		restrictionModel = null;
		restrictionModel = getRestrictionModel();
	}
	
	public static boolean isNewOntologyCreated(){
		return (newModel != null);
	}
	
	public static boolean isRestrictionOntologyCreated(){
		return (restrictionModel != null);
	}
	
	
	public static boolean isDatatypeProperty(String uri){
		checkOntModel();
		return ontModel.getIndividual(uri).getOntClass().getURI().equals(Constants.CLASS_DATATYPE_PROPERTY);
		//return ontModel.getDatatypeProperty(uri)!=null;
	}
	public static boolean isAnnotationProperty(String uri){
		checkOntModel();
		return ontModel.getIndividual(uri).getOntClass().getURI().equals(Constants.CLASS_ANNOTATION_PROPERTY);
		//return ontModel.getDatatypeProperty(uri)!=null;
	}
	public static boolean isObjectProperty(String uri){
		checkOntModel();
		return ontModel.getIndividual(uri).getOntClass().getURI().equals(Constants.CLASS_OBJECT_PROPERTY);
	}
	
	public static String getLiteralProperty(Resource res, String uri){
		return getLiteralProperty(res, uri, true);
	
	}
		
	//all properties are defined in qudt ontologies
	public static String getLiteralProperty(Resource res, String uri, boolean ifToShortenURIResourcesToLocalName){
		//System.out.println("res : " + res.getURI());
		//System.out.println("uri : " + uri);
		
		checkOntModel();
		Property p = ontModel.getProperty(uri);
        
		if (p == null) {
			return "";
		}
		
		if (res.hasProperty(p)){
			RDFNode object = res.getProperty(p).getObject();
			if (object.isLiteral()){
				return object.asLiteral().getString();
			}
			else if ( object.isURIResource() )
				if (ifToShortenURIResourcesToLocalName) return object.asResource().getLocalName();
				else return object.asResource().getURI();
			//return "";
			else throw new RuntimeException("wrong type object");
		}
		return "";
	}
	
	//returns label if exists or local name otherwise
	public static String getResourceName(OntModel model, String propuri){
		Resource prop = model.getResource(propuri);
		String res = getLiteralProperty(prop, Constants.PROPERTY_LABEL);
		if ("".equals(res))
			return prop.getLocalName();
		return res;
	}
	
	public static String getResourceLocalName(OntModel model, String uri){
		Resource res = model.getResource(uri);
		return res.getLocalName();
	}
	
	public static void clearModel(String modelCode){
		if (Constants.ontologies.new_ontology.toString().equals(modelCode))
			clearNewOntology();
		else if (Constants.ontologies.restriction_ontology.toString().equals(modelCode))
			clearRestrictionOntology();
			
	}
	
	public static void main(java.lang.String[] args){
		//getRestrictionModel();
		//getOntModel();
	}
	/*public static void main(java.lang.String[] args){
		System.out.println("!!!");
		initializeModel();
		Resource re = ontModel.getResource("http://data.nasa.gov/qudt/owl/unit#FootPerSecond");
		String l = getLiteralProperty(re, "http://data.nasa.gov/qudt/owl/qudt#quantityKind");
		System.out.println(l);
		StmtIterator it = re.listProperties();
		System.out.println("list props ==================");
		List<Statement> list = it.toList();
		System.out.println(list.size());
		for (Statement st : list){
			 System.out.println(st.getPredicate().getURI() + " " +  (st.getObject().isURIResource()? st.getObject().asResource().getURI() : "ololo"));
		}
		
		System.out.println("=======================");
		String sparqlQueryString = "SELECT ?s ?d {<http://data.nasa.gov/qudt/owl/unit#FootPerSecond> <http://data.nasa.gov/qudt/owl/qudt#quantityKind> ?d  }" ;
	    
		 Query query = QueryFactory.create(sparqlQueryString);
		 QueryExecution qexec = QueryExecutionFactory.create(query, ontModel);
		 ResultSet results = qexec.execSelect();

		 ResultSetFormatter.out(results);
		    
	}*/
	
	
	
	 //get list of properties for units and quantities 
	 public static List<String>  getPropertyUriList(Constants.ontologies ont){
		List<String> propUris = null; 
        if (ont.equals(Constants.ontologies.qudt_unit) || ont.equals(Constants.ontologies.new_ontology_unit)){
        	propUris = Constants.unitPropUris;
        }
        else if (ont.equals(Constants.ontologies.qudt_quantity) || ont.equals(Constants.ontologies.new_ontology_quantity)){
        	propUris = Constants.quantityPropUris;
        }
        
		return propUris;
	 }
}
