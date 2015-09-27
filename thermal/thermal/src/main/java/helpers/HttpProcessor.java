package helpers;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import org.w3c.dom.Document;


public class HttpProcessor {
	public static String sendGet(String url) throws IOException  {

 
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
 
		// optional default is GET
		con.setRequestMethod("GET");
 
		//add request header
		//con.setRequestProperty("User-Agent", USER_AGENT);
 
		int responseCode = con.getResponseCode();
		System.out.println("\nSending 'GET' request to URL : " + url);
		System.out.println("Response Code : " + responseCode);
 
		if (responseCode != 200) return "";
		
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();
 
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
 
		//print result
		return response.toString();
    }
	//tests
	public static void main(String args[]){

		 
		String url1 = "http://rdf.chemspider.com//search//Li_%7B2%7DO";
		String url2 = "http://rdf.chemspider.com//search//N_%7B2%7DO";
		String url3 = "http://rdf.chemspider.com//search//234423rd";
		
		try {
			String result = sendGet(url1);
			System.out.println(result);
			Document doc1= XMLLoader.loadXmlFromString(result);
			System.out.println(ChemSpiderXMLHelper.isAtom(doc1));
			System.out.println(ChemSpiderXMLHelper.isRDF(doc1));
			System.out.println("-----------------------------");
		
			Document xml = XMLLoader.loadXmlFromString(result);
			List<ChemSpiderInfo> infos = ChemSpiderXMLHelper.getInfoListFromAtomXML(xml);
			
			for (ChemSpiderInfo i : infos){
				System.out.println(i.getChemSpiderUri());
				System.out.println(i.getChemSpiderURL());
				System.out.println(i.getFormula());
				System.out.println(i.getPictureURL());
				System.out.println(i.getSystematicName());
			System.out.println("---");
			}
			System.out.println(result);
			/*	//result = sendGet(url2);
			 * Document doc2= XMLLoader.loadXmlFromString(result);
			System.out.println(ChemSpiderXMLHelper.isAtom(doc2));
			System.out.println(ChemSpiderXMLHelper.isRDF(doc2));
			ChemSpiderInfo info = ChemSpiderInfoHelper.getInfoFromRDFString(result);
			System.out.println(info.getFormula());
			*/
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
