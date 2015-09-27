package ru;

public class Options {
	//todo initialize through java options
	public static final String DOWNLOAD_DIR = "C:/forDownload/";
	
	public static final String UPLOAD_DIR = "C://forUpload//";
	public static final String NEW_ONTOLOGY_FOR_DOWNLOAD_NAME = "qudt_complement.owl";
	public static final String RESTRICTION_ONTOLOGY_FOR_DOWNLOAD_NAME = "thermal_restrictions.owl";
	
	public static final String newModelNameSpace = "http://thermal#";
	public static final String restrictionModelNameSpace = "http://thermal_restriction#";
	
	public static String qudtOntologyPath = null;
	public static String pathToRestrictionModelBase = null;
	
	public static void init(String path){
		if (qudtOntologyPath == null) qudtOntologyPath = path + "/resources";
		if (pathToRestrictionModelBase == null) pathToRestrictionModelBase = path + "/resources";
	}
}
