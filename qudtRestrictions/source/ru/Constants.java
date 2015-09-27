package ru;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Constants {
	
	static public String HOME_PAGE = "qudtclass.jsp?ontology=qudt_unit";
	
	public enum ontologies {
		new_ontology_quantity,
		new_ontology_unit,
		qudt,
		qudt_quantity, 
		qudt_unit,
		rdfs,
		restriction_ontology,
		new_ontology
	}
	
	public static Map<ontologies, String> nameSpaceMap = new HashMap<>();
	public static List<String> unitPropUris = new ArrayList<>();
	public static List<String> quantityPropUris = new ArrayList<>();
	
	

	/*public static final String NAMESPACE_QUDT = "http://data.nasa.gov/qudt/owl/qudt#";
	public static final String NAMESPACE_QUDT_UNIT = "http://data.nasa.gov/qudt/owl/unit#";
	public static final String NAMESPACE_QUDT_QUANTITY = "http://data.nasa.gov/qudt/owl/quantity#";
	public static final String NAMESPACE_SHORT_DEFAULT = "";
	 */
	public static final String PROPERTY_LABEL = "http://www.w3.org/2000/01/rdf-schema#label";
	public static final String PROPERTY_TYPE = "http://www.w3.org/1999/02/22-rdf-syntax-ns#type";
	
	//unitPropUris
	public static final String PROPERTY_CONVERSION_MULTIPLIER = "http://data.nasa.gov/qudt/owl/qudt#conversionMultiplier";
	public static final String PROPERTY_CONVERSION_OFFSET = "http://data.nasa.gov/qudt/owl/qudt#conversionOffset";
	public static final String PROPERTY_QUANTITY_KIND = "http://data.nasa.gov/qudt/owl/qudt#quantityKind";
	public static final String PROPERTY_SYMBOL = "http://data.nasa.gov/qudt/owl/qudt#symbol";
	public static final String PROPERTY_ABBREVIATION = "http://data.nasa.gov/qudt/owl/qudt#abbreviation";
	
	
	//quantityPropUris
	public static final String PROPERTY_DESCRIPTION = "http://data.nasa.gov/qudt/owl/qudt#description";
	public static final String PROPERTY_GENERALIZATION = "http://data.nasa.gov/qudt/owl/qudt#generalization";
	
	
	public static final String CLASS_OBJECT_PROPERTY = "http://www.w3.org/2002/07/owl#ObjectProperty";
	public static final String CLASS_DATATYPE_PROPERTY = "http://www.w3.org/2002/07/owl#DatatypeProperty";
	
	public static final String CLASS_QUANTITY_KIND = "http://data.nasa.gov/qudt/owl/qudt#QuantityKind";
	public static final String CLASS_UNIT = "http://data.nasa.gov/qudt/owl/qudt#Unit";
	public static final String CLASS_ANNOTATION_PROPERTY = "http://www.w3.org/2002/07/owl#AnnotationProperty";
	
	
	public static final String PROPERTY_CONVERSTION_MULTIPLIER = "http://data.nasa.gov/qudt/owl/qudt#conversionMultiplier";
	public static final String PROPERTY_CONVERSTION_OFFSET = "http://data.nasa.gov/qudt/owl/qudt#conversionOffset";
	
	
	
	static {
		nameSpaceMap.put(ontologies.qudt, "http://data.nasa.gov/qudt/owl/qudt#");
		nameSpaceMap.put(ontologies.qudt_quantity, "http://data.nasa.gov/qudt/owl/quantity#");
		nameSpaceMap.put(ontologies.qudt_unit, "http://data.nasa.gov/qudt/owl/unit#");
		nameSpaceMap.put(ontologies.rdfs, "http://www.w3.org/2000/01/rdf-schema#");
		
		unitPropUris.add(PROPERTY_CONVERSION_MULTIPLIER);
		unitPropUris.add(PROPERTY_CONVERSION_OFFSET);
		unitPropUris.add(PROPERTY_QUANTITY_KIND);
		unitPropUris.add(PROPERTY_SYMBOL);
		unitPropUris.add(PROPERTY_ABBREVIATION);
		unitPropUris.add(PROPERTY_LABEL);
		
		quantityPropUris.add(PROPERTY_LABEL);
		quantityPropUris.add(PROPERTY_GENERALIZATION);
		quantityPropUris.add(PROPERTY_DESCRIPTION);
	}
	
	public static final String QUDT_ROOT_UNIT_CLASS_LOCAL_NAME = "PhysicalUnit";		
	public static final String QUDT_ROOT_QUANTITY_KIND_CLASS_LOCAL_NAME = "QuantityKind";		
}
