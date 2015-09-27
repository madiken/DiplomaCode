package helpers;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.codec.net.URLCodec;
import org.w3c.dom.Document;

import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntResource;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.Statement;
import com.hp.hpl.jena.util.iterator.ExtendedIterator;


public class ChemSpiderInfoHelper {
	
	private static final URLCodec encoder = new URLCodec();
		
	
	private static String transformFormulaForQuery(String formula){
		Pattern p = Pattern.compile("[a-zA-Z]+[0-9]+");
		Matcher m = p.matcher(formula);
		StringBuilder res = new StringBuilder();
		String str = "";
		while (m.find()){
			str = m.group();
				
			Pattern nums = Pattern.compile("[0-9]+");
			Matcher mnums = nums.matcher(str);
			if (mnums.find()){
				System.out.println("true");
				String numbers = mnums.group();
				String letters = str.substring(0, str.indexOf(numbers));
				String part = letters + "_" + "{" + numbers + "}";
				res.append(part);
			}
		}
		String tail = formula.substring(formula.indexOf(str) + str.length());
		res.append(tail);
		return res.toString();
	}
	

	
	private static String getQueryString(String formula) throws URISyntaxException{
		String q_formula = transformFormulaForQuery(formula);
		
		URI uri;
		uri = new URI(
			    "http", 
			    "rdf.chemspider.com", 
			    "/search/" + q_formula,
			    null);
		
		
		return uri.toString();
	}
	

	
	public static List<ChemSpiderInfo> getInfoListByFormula(String formula) throws URISyntaxException, IOException{
		String url = getQueryString(formula);
		String result = HttpProcessor.sendGet(url);
		
		if ("".equals(result))
			return new ArrayList<ChemSpiderInfo>();
		Document doc = XMLLoader.loadXmlFromString(result);
		if (ChemSpiderXMLHelper.isAtom(doc)){
			return ChemSpiderXMLHelper.getInfoListFromAtomXML(doc);
		} else if (ChemSpiderXMLHelper.isRDF(doc)){
			List<ChemSpiderInfo> resList = new ArrayList<>();
			resList.add(getInfoFromRDFString(result));
			return resList;
		}
		return null;
	}
	
	public static void main(String args[]){
		try{
		for (ChemSpiderInfo i : getInfoListByFormula("N2O")){
			System.out.println(i.getChemSpiderUri());
			System.out.println(i.getChemSpiderURL());
			System.out.println(i.getPictureURL());
			System.out.println(i.getFormula());
			System.out.println(i.getSystematicName());
			System.out.println(i.getChemSpiderId());
		}
		} catch (Exception e ){
			e.printStackTrace();
		}
		//System.out.println(transformFormulaForQuery("N2O"));
	}
	
	private static ChemSpiderInfo getInfoByUriAndModel(String uri, OntModel model){
		ChemSpiderInfo info = new ChemSpiderInfo();
		
		OntClass imageCl = model.getOntClass("http://xmlns.com/foaf/0.1/Image");
		ExtendedIterator<? extends OntResource> it = imageCl.listInstances();
		List<? extends OntResource> imgList =  it.toList();
		it.close();
		String imageUri = null;
		
		for (OntResource r : imgList){
			Property  depicts = model.getProperty("http://xmlns.com/foaf/0.1/depicts");
			if (depicts == null) break;
			Statement dep = r.getProperty(depicts);
			if (dep !=null){
				if ((uri + "#Compound").equals(dep.getObject().asResource().getURI()))
					imageUri = r.getURI();
			}
		}
		
		
		BigInteger id = null;
		Pattern p = Pattern.compile("[0-9]+(\\.rdf)");
		Matcher m = p.matcher(uri);
		if (m.find()){
			String subsec = m.group();
			String s[] = subsec.split("\\.");
			if (s.length > 0)
				id = BigInteger.valueOf(Long.parseLong(s[0]));
		}
		
		uri.indexOf(".rdf");
		String url = uri.replaceFirst("\\.rdf", ".html");
		
		String systematicName = null;
		OntClass synonymCl = model.getOntClass("http://www.polymerinformatics.com/ChemAxiom/ChemDomain.owl#Synonym");
		if (synonymCl != null){
			ExtendedIterator<? extends OntResource> it3 = synonymCl.listInstances();
			if (it3 != null) {
				List<? extends OntResource> slist = it3.toList();
				it3.close();
				if (slist.size() > 0){
					Property hasValue = model.getProperty("http://www.polymerinformatics.com/ChemAxiom/ChemDomain.owl#hasValue");
					systematicName = slist.get(0).getProperty(hasValue).getLiteral().getString();
				}
			}
			
		}
		
		String formula = null;
		OntClass formulaCl = model.getOntClass("http://www.polymerinformatics.com/ChemAxiom/ChemDomain.owl#MolecularFormula");
		if (formulaCl != null){
			ExtendedIterator<? extends OntResource> it3 = formulaCl.listInstances();
			if (it3 != null) {
				List<? extends OntResource> slist = it3.toList();
				it3.close();
				if (slist.size() > 0){
					Property hasValue = model.getProperty("http://www.polymerinformatics.com/ChemAxiom/ChemDomain.owl#hasValue");
					formula = slist.get(0).getProperty(hasValue).getLiteral().getString();
				}
			}
			
		}
		
		info.setFormula(formula);
		info.setSystematicName(systematicName);
		info.setChemSpiderId(id);
		info.setChemSpiderUri(uri);
		info.setChemSpiderURL(url);
		info.setPictureURL(imageUri);
		return info;
	}
	
	public static ChemSpiderInfo getInfoByUri(String uri){
		try{
			final OntModel model = ModelFactory.createOntologyModel();
			model.read(uri);
			ChemSpiderInfo info = getInfoByUriAndModel(uri, model);
			return info;
		} catch (Exception e){
			System.out.println("cannot get rdf");
		}
		return null;
	}
	
	private static ChemSpiderInfo getInfoFromRDFString(String rdf) throws UnsupportedEncodingException{
	
		final OntModel model = ModelFactory.createOntologyModel();
		model.read(new ByteArrayInputStream(rdf.getBytes("UTF-8")), null, "RDF/XML");
		//model.write(System.out);
		
		OntClass docu = model.getOntClass("http://xmlns.com/foaf/0.1/Document");
		if (docu == null)
			return null;
		
		ExtendedIterator<? extends OntResource> it = docu.listInstances();
		List<? extends OntResource> docList =  it.toList();
		if (docList.size() == 0)
			return null;
		String uri = docList.get(0).getURI();

		ChemSpiderInfo info = getInfoByUriAndModel(uri, model);
		return info;
	}
	
	
}
