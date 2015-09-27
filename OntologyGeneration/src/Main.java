import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;

import org.mindswap.pellet.jena.PelletReasonerFactory;

import com.hp.hpl.jena.datatypes.xsd.XSDDatatype;
import com.hp.hpl.jena.ontology.AllValuesFromRestriction;
import com.hp.hpl.jena.ontology.DatatypeProperty;
import com.hp.hpl.jena.ontology.ObjectProperty;
import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntModelSpec;
import com.hp.hpl.jena.ontology.SomeValuesFromRestriction;
import com.hp.hpl.jena.ontology.UnionClass;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.RDFList;
import com.hp.hpl.jena.rdf.model.Resource;
import com.hp.hpl.jena.reasoner.ValidityReport;
import com.hp.hpl.jena.reasoner.ValidityReport.Report;


public class Main {
	public static void persistThermalOntology() throws IOException{
	
		OntModel ont = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RULE_INF);
		
		OntClass quantityCl = ont.createClass("http://data.nasa.gov/qudt/owl/qudt#Quantity");
		OntClass quantityKindCl = ont.createClass("http://data.nasa.gov/qudt/owl/qudt#QuantityKind");
		OntClass quantityValueCl = ont.createClass("http://data.nasa.gov/qudt/owl/qudt#QuantityValue");
		// unitCl = ont.createClass("http://data.nasa.gov/qudt/owl/qudt#Unit");
		
		OntClass chemicalSpeciesCl = ont.createClass("http://www.polymerinformatics.com/ChemAxiom/ChemDomain.owl#ChemicalSpecies");
		OntClass stateOfMatterCl = ont.createClass("http://www.polymerinformatics.com/ChemAxiom/ChemAxiomProp.owl#StateOfMatter");
		//OntClass solidStateCl = ont.createClass("http://www.polymerinformatics.com/ChemAxiom/ChemAxiomProp.owl#SolidState");
		//OntClass liquidStateCl = ont.createClass("http://www.polymerinformatics.com/ChemAxiom/ChemAxiomProp.owl#LiquidState");
		//OntClass gaseousStateCl = ont.createClass("http://www.polymerinformatics.com/ChemAxiom/ChemAxiomProp.owl#GaseousState");
		
		ont.setNsPrefix("", "http://umeta.ru/namespaces/thermal#");
		OntClass substanceConstantCl = ont.createClass("http://umeta.ru/namespaces/thermal#SubstanceConstant");
		OntClass propertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#Property");
		//OntClass thermalUnitCl = ont.createClass("http://umeta.ru/namespaces/thermal#ThermalUnit");
		OntClass dataSourceCl = ont.createClass("http://umeta.ru/namespaces/thermal#DataSource");
		OntClass quantityValueFromSourceCl = ont.createClass("http://umeta.ru/namespaces/thermal#QuantityValueFromSource");
		OntClass numericalDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#NumericalData");
		OntClass dataCl = ont.createClass("http://umeta.ru/namespaces/thermal#Data");
		OntClass datasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#Dataset");
		OntClass environmentalConditionsCl = ont.createClass("http://umeta.ru/namespaces/thermal#EnvironmentalConditions");
		OntClass uncertaintyTypeCl = ont.createClass("http://umeta.ru/namespaces/thermal#UncertaintyType");
		
		DatatypeProperty uncertaintyValue = ont.createDatatypeProperty("http://umeta.ru/namespaces/thermal#uncertaintyValue");
		uncertaintyValue.setRange(ont.getOntClass("http://www.w3.org/2001/XMLSchema#double"));
		uncertaintyValue.setDomain(quantityValueCl);
		
		DatatypeProperty version = ont.createDatatypeProperty("http://umeta.ru/namespaces/thermal#version");
		version.setRange(ont.getOntClass("http://www.w3.org/2001/XMLSchema#integer"));
		
		
		propertyCl.addSuperClass(quantityKindCl);
		//thermalUnitCl.addSuperClass(unitCl);
		//ObjectProperty thermalUnit = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#thermalUnit");
		//thermalUnit.setDomain(propertyCl);
		//thermalUnit.setRange(thermalUnitCl);
		
		quantityValueFromSourceCl.addSuperClass(quantityValueCl);
		ObjectProperty dataSource = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#dataSource");
		dataSource.setDomain(quantityValueFromSourceCl);
		dataSource.setRange(dataSourceCl);
		
		numericalDataCl.addSuperClass(quantityCl);
		substanceConstantCl.addSuperClass(quantityCl);
		dataCl.addSuperClass(quantityCl);
		
		ObjectProperty valueQuantity = ont.createObjectProperty("http://data.nasa.gov/qudt/owl/qudt#valueQuantity");
		AllValuesFromRestriction dsRestrAll = ont.createAllValuesFromRestriction(null, valueQuantity, quantityValueFromSourceCl);
		SomeValuesFromRestriction dsRestrExists = ont.createSomeValuesFromRestriction(null, valueQuantity, quantityValueFromSourceCl);
		
		dataCl.addSuperClass(dsRestrAll);
		substanceConstantCl.addSuperClass(dsRestrAll);
		dataCl.addSuperClass(dsRestrExists);
		substanceConstantCl.addSuperClass(dsRestrExists);
		
		
		ObjectProperty substance = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#substance");
		AllValuesFromRestriction resSubst1 = ont.createAllValuesFromRestriction(null, substance, chemicalSpeciesCl);
		AllValuesFromRestriction resSubst2 = ont.createAllValuesFromRestriction(null, substance, chemicalSpeciesCl);
		substanceConstantCl.addSuperClass(resSubst1);
		datasetCl.addSuperClass(resSubst2);
		
		ObjectProperty quantityKind = ont.createObjectProperty("http://data.nasa.gov/qudt/owl/qudt#quantityKind");
		OntClass constantPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#ConstantProperty");
		constantPropertyCl.addSuperClass(propertyCl);
		AllValuesFromRestriction constQuantityKindRestr = ont.createAllValuesFromRestriction(null, quantityKind, constantPropertyCl);
		substanceConstantCl.addSuperClass(constQuantityKindRestr);
		
		OntClass functionalPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#FunctionalProperty");
		functionalPropertyCl.addSuperClass(propertyCl);
		AllValuesFromRestriction funcQuantityKindRestr = ont.createAllValuesFromRestriction(null, quantityKind, functionalPropertyCl);
		dataCl.addSuperClass(funcQuantityKindRestr);
		
		functionalPropertyCl.addDisjointWith(constantPropertyCl);
		
		ObjectProperty uncertaintyType = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#uncertaintyType");
		uncertaintyType.setDomain(quantityValueCl);
		uncertaintyType.setRange(uncertaintyTypeCl);
		

		ObjectProperty dataForConditions = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#dataForConditions");
		dataForConditions.setDomain(numericalDataCl);
		dataForConditions.setRange(uncertaintyTypeCl);
		ObjectProperty numericalData = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#numericalData");
		numericalData.setInverseOf(dataForConditions);
		
		ObjectProperty dataOfDataset = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#dataOfDataset");
		dataForConditions.setDomain(dataCl);
		dataForConditions.setRange(datasetCl);
		ObjectProperty data = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#data");
		data.setInverseOf(dataOfDataset);
		
		
		ObjectProperty environmentalConditionsOfDataset = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#environmentalConditionsOfDataset");
		dataForConditions.setDomain(environmentalConditionsCl);
		dataForConditions.setRange(datasetCl);
		ObjectProperty inEnvironmentalConditions = ont.createObjectProperty("http://umeta.ru/namespaces/thermal#inEnvironmentalConditions");
		inEnvironmentalConditions.setInverseOf(environmentalConditionsOfDataset);
		//------------chemAxiom-----------------------------------------------------------------------
		//-------------states-------------------------------------------------------------------------
		OntClass substanceStateCl = ont.createClass("http://umeta.ru/namespaces/thermal#SubstanceState");
		OntClass onePhaseStateCl = ont.createClass("http://umeta.ru/namespaces/thermal#OnePhaseState");
		OntClass idealGasCl = ont.createClass("http://umeta.ru/namespaces/thermal#IdealGas");
		OntClass multiPhaseStateCl = ont.createClass("http://umeta.ru/namespaces/thermal#MultiPhaseState");
		OntClass liquid_SolidCl = ont.createClass("http://umeta.ru/namespaces/thermal#Liquid_Solid");
		OntClass Liquid_GasCl = ont.createClass("http://umeta.ru/namespaces/thermal#Liquid_Gas");
		OntClass Liquid_Solid_GasCl = ont.createClass("http://umeta.ru/namespaces/thermal#Liquid_Solid_Gas");
		OntClass Solid_GasCl = ont.createClass("http://umeta.ru/namespaces/thermal#Solid_Gas");
		
		RDFList list1 = ont.createList();
		list1 = list1.cons(onePhaseStateCl);
		list1 = list1.cons(multiPhaseStateCl);
		UnionClass un1 = ont.createUnionClass(null, list1);
		substanceStateCl.setEquivalentClass(un1);
		
		RDFList list2 = ont.createList();
		list2 = list2.cons(liquid_SolidCl);
		list2 = list2.cons(Liquid_GasCl);
		list2 = list2.cons(Solid_GasCl);
		list2 = list2.cons(Liquid_Solid_GasCl);
		UnionClass un2 = ont.createUnionClass(null, list2);
		multiPhaseStateCl.setEquivalentClass(un2);
		
		
		RDFList list3 = ont.createList();
		list3 = list3.cons(stateOfMatterCl);
		list3 = list3.cons(idealGasCl);
		UnionClass un3 = ont.createUnionClass(null, list3);
		onePhaseStateCl.setEquivalentClass(un3);
		
		//-----------property 
		//OntClass propertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#Property");
		OntClass multiPhaseStatePropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#MultiPhaseStateProperty");
		
		OntClass liquidSolidPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#LiquidSolidProperty");
		OntClass liquidGasPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#LiquidGasProperty");
		OntClass solidGasPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#SolidGasProperty");
		
		OntClass notLiquidSolidPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#NotLiquidSolidProperty");
		OntClass notLiquidGasPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#NotLiquidGasProperty");
		OntClass notSolidGasPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#NotSolidGasProperty");
		
		liquidSolidPropertyCl.setDisjointWith(notLiquidSolidPropertyCl);
		liquidGasPropertyCl.setDisjointWith(notLiquidGasPropertyCl);
		solidGasPropertyCl.setDisjointWith(notSolidGasPropertyCl);
		
		
		OntClass onePhaseStatePropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#OnePhaseStateProperty");
		
		OntClass liquidPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#LiquidProperty");
		OntClass solidPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#SolidProperty");
		OntClass gasPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#GasProperty");
		OntClass idealGasPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#idealGasProperty");
		
		OntClass notLiquidPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#NotLiquidProperty");
		OntClass notSolidPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#NotSolidProperty");
		OntClass notGasPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#NotGasProperty");
		OntClass notIdealGasPropertyCl = ont.createClass("http://umeta.ru/namespaces/thermal#NotIdealGasProperty");
		
		liquidPropertyCl.setDisjointWith(notLiquidPropertyCl);
		solidPropertyCl.setDisjointWith(notSolidPropertyCl);
		gasPropertyCl.setDisjointWith(notGasPropertyCl);
		idealGasPropertyCl.setDisjointWith(notIdealGasPropertyCl);
		
		propertyCl.addSubClass(multiPhaseStatePropertyCl);
		propertyCl.addSubClass(onePhaseStatePropertyCl);
		
		multiPhaseStatePropertyCl.addSubClass(liquidSolidPropertyCl);
		multiPhaseStatePropertyCl.addSubClass(liquidGasPropertyCl);
		multiPhaseStatePropertyCl.addSubClass(solidGasPropertyCl);
	
		onePhaseStatePropertyCl.addSubClass(liquidPropertyCl);
		onePhaseStatePropertyCl.addSubClass(solidPropertyCl);
		onePhaseStatePropertyCl.addSubClass(gasPropertyCl);
		onePhaseStatePropertyCl.addSubClass(idealGasPropertyCl);
		
		//-------Data
		OntClass multiPhaseStateDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#MultiPhaseStateData");
		OntClass liquidSolidDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#LiquidSolidData");
		OntClass liquidGasDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#LiquidGasData");
		OntClass solidGasDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#SolidGasData");
		multiPhaseStateDataCl.addSubClass(liquidSolidDataCl);
		multiPhaseStateDataCl.addSubClass(liquidGasDataCl);
		multiPhaseStateDataCl.addSubClass(solidGasDataCl);
		
		liquidSolidDataCl.addDisjointWith(liquidGasDataCl);
		liquidSolidDataCl.addDisjointWith(solidGasDataCl);
		liquidGasDataCl.addDisjointWith(solidGasDataCl);
		
		OntClass onePhaseStateDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#OnePhaseStateData");
		OntClass liquidDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#LiquidData");
		OntClass gasDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#GasData");
		OntClass solidDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#SolidData");
		OntClass idealGasDataCl = ont.createClass("http://umeta.ru/namespaces/thermal#IdealGasData");
		onePhaseStateDataCl.addSubClass(liquidDataCl);
		onePhaseStateDataCl.addSubClass(gasDataCl);
		onePhaseStateDataCl.addSubClass(solidDataCl);
		onePhaseStateDataCl.addSubClass(idealGasDataCl);
		
		liquidDataCl.addDisjointWith(solidGasDataCl);
		liquidDataCl.addDisjointWith(gasDataCl);
		liquidDataCl.addDisjointWith(idealGasDataCl);
		solidGasDataCl.addDisjointWith(gasDataCl);
		solidGasDataCl.addDisjointWith(idealGasDataCl);
		gasDataCl.addDisjointWith(idealGasDataCl);
		
		
		multiPhaseStateDataCl.addDisjointWith(onePhaseStateDataCl);
		
		dataCl.addSubClass(multiPhaseStateDataCl);
		dataCl.addSubClass(onePhaseStateDataCl);
		
		AllValuesFromRestriction res1 = ont.createAllValuesFromRestriction(null, quantityKind, liquidSolidPropertyCl);
		liquidSolidDataCl.addSuperClass(res1);
		AllValuesFromRestriction res2 = ont.createAllValuesFromRestriction(null, quantityKind, liquidGasPropertyCl);
		liquidGasDataCl.addSuperClass(res2);
		AllValuesFromRestriction res4 = ont.createAllValuesFromRestriction(null, quantityKind, solidGasPropertyCl);
		solidGasDataCl.addSuperClass(res4);
		
		AllValuesFromRestriction res5 = ont.createAllValuesFromRestriction(null, quantityKind, liquidPropertyCl);
		liquidDataCl.addSuperClass(res5);
		AllValuesFromRestriction res6 = ont.createAllValuesFromRestriction(null, quantityKind, gasPropertyCl);
		gasDataCl.addSuperClass(res6);
		AllValuesFromRestriction res7 = ont.createAllValuesFromRestriction(null, quantityKind, solidPropertyCl);
		solidDataCl.addSuperClass(res7);
		AllValuesFromRestriction res8 = ont.createAllValuesFromRestriction(null, quantityKind, idealGasPropertyCl);
		idealGasDataCl.addSuperClass(res8);
		
		//--------------Dataset
		OntClass multiPhaseStateDatasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#MultiPhaseStateDataset");
		
		OntClass liquidSolidDatasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#LiquidSolidDataset");
		OntClass liquidGasDatasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#LiquidGasDataset");
		OntClass solidGasDatasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#SolidGasDataset");
		
		multiPhaseStateDatasetCl.addSubClass(liquidSolidDatasetCl);
		multiPhaseStateDatasetCl.addSubClass(liquidGasDatasetCl);
		multiPhaseStateDatasetCl.addSubClass(solidGasDatasetCl);
		
		liquidSolidDatasetCl.addDisjointWith(liquidGasDatasetCl);
		liquidSolidDatasetCl.addDisjointWith(solidGasDatasetCl);
		liquidGasDatasetCl.addDisjointWith(solidGasDatasetCl);
		
		OntClass onePhaseStateDatasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#OnePhaseStateDataset");
		
		OntClass liquidDatasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#LiquidDataset");
		OntClass gasDatasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#GasDataset");
		OntClass solidDatasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#SolidDataset");
		OntClass idealGasDatasetCl = ont.createClass("http://umeta.ru/namespaces/thermal#IdealGasDataset");
		
		onePhaseStateDatasetCl.addSubClass(liquidDatasetCl);
		onePhaseStateDatasetCl.addSubClass(gasDatasetCl);
		onePhaseStateDatasetCl.addSubClass(solidDatasetCl);
		onePhaseStateDatasetCl.addSubClass(idealGasDatasetCl);
		
		
		liquidDatasetCl.addDisjointWith(solidGasDatasetCl);
		liquidDatasetCl.addDisjointWith(gasDatasetCl);
		liquidDatasetCl.addDisjointWith(idealGasDatasetCl);
		solidGasDatasetCl.addDisjointWith(gasDatasetCl);
		solidGasDatasetCl.addDisjointWith(idealGasDatasetCl);
		gasDatasetCl.addDisjointWith(idealGasDatasetCl);
		
		onePhaseStateDatasetCl.addDisjointWith(multiPhaseStateDatasetCl);
		datasetCl.addSubClass(onePhaseStateDatasetCl);
		datasetCl.addSubClass(multiPhaseStateDatasetCl);
		
		
		RDFList list4 = ont.createList();
		list4 = list4.cons(liquidDataCl);
		list4 = list4.cons(solidDataCl);
		list4 = list4.cons(liquidSolidDataCl);
		UnionClass un4 = ont.createUnionClass(null, list4);
		
		AllValuesFromRestriction res9 = ont.createAllValuesFromRestriction(null, data, un4);
		liquidSolidDatasetCl.addSuperClass(res9);
		
		RDFList list5 = ont.createList();
		list5 = list5.cons(liquidDataCl);
		list5 = list5.cons(gasDataCl);
		list5 = list5.cons(liquidGasDataCl);
		UnionClass un5 = ont.createUnionClass(null, list5);
		AllValuesFromRestriction res10 = ont.createAllValuesFromRestriction(null, data, un5);
		liquidGasDatasetCl.addSuperClass(res10);
		
		RDFList list6 = ont.createList();
		list6 = list6.cons(solidDataCl);
		list6 = list6.cons(gasDataCl);
		list6 = list6.cons(solidGasDataCl);
		UnionClass un6 = ont.createUnionClass(null, list6);
		AllValuesFromRestriction res11 = ont.createAllValuesFromRestriction(null, data, un6);
		solidGasDatasetCl.addSuperClass(res11);
		
		AllValuesFromRestriction res12 = ont.createAllValuesFromRestriction(null, data, liquidDataCl);
		liquidDatasetCl.addSuperClass(res12);
		
		AllValuesFromRestriction res13 = ont.createAllValuesFromRestriction(null, data, gasDataCl);
		gasDatasetCl.addSuperClass(res13);
		
		AllValuesFromRestriction res14 = ont.createAllValuesFromRestriction(null, data, solidDataCl);
		solidDatasetCl.addSuperClass(res14);
		
		AllValuesFromRestriction res15 = ont.createAllValuesFromRestriction(null, data, idealGasDataCl);
		idealGasDatasetCl.addSuperClass(res15);
		
		FileWriter fw = new FileWriter("./final_checks/thermal_ontology.owl");
	    ont.write( fw, "RDF/XML-ABBREV" );
        fw.close();
        
	}
	

	public static void validate(){
		OntModel ont = ModelFactory.createOntologyModel(PelletReasonerFactory.THE_SPEC);
		
		ont.read("./final_checks/thermal_dump.nt", "RDF/XML");
		ont.read("./final_checks/thermal_ontology.owl", "N-TRIPLE");
		ont.read("./final_checks/thermal_restrictions.owl", "N-TRIPLE"); //property value restrictions
		
		
		ValidityReport rep  = ont.validate();
		System.out.println(rep.isValid());
		Iterator<Report> reps = rep.getReports();
		System.out.println(reps.hasNext());
		while(reps.hasNext()){
			
		System.out.println(reps.next().getDescription());
		}
    }
	
	 
	public static void main(String args[]){
		try{
			persistThermalOntology();
		} catch(Exception e){}
	    validate();
	}
	
	
}
