package ru;

import com.hp.hpl.jena.datatypes.TypeMapper;
import com.hp.hpl.jena.datatypes.xsd.XSDDatatype;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntModelSpec;
import com.hp.hpl.jena.rdf.model.Literal;
import com.hp.hpl.jena.rdf.model.ModelFactory;

public class Test {

	public static void main(String args[]){
	   System.out.println("Hello!");
		System.out.println(XSDDatatype.XSDdouble.equals(TypeMapper.getInstance().getTypeByName("http://www.w3.org/2001/XMLSchema#double")));
		OntModel ont = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RULE_INF);//OntologyModelHelper.getNewModel();
		Literal typedLiteral = ont.createTypedLiteral("1.0e-60", XSDDatatype.XSDdouble);//TypeMapper.getInstance().getTypeByName("http://www.w3.org/2001/XMLSchema#double"));
		Literal typedLiteral2 = ont.createTypedLiteral("1.0e-60", XSDDatatype.XSDdouble);//TypeMapper.getInstance().getTypeByName("http://www.w3.org/2001/XMLSchema#double"));
		
		Double d = typedLiteral.getDouble();	
		Double d2 = typedLiteral2.getDouble();	
		
		System.out.println(d);
		System.out.println(d2);
		
		System.out.println(d.equals(d2));
	
	    
	    
		
	}
}
