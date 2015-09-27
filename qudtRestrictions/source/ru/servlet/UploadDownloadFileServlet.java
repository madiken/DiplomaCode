package ru.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import ru.Constants;
import ru.Options;
import ru.helpers.OntologyModelHelper;

import com.hp.hpl.jena.ontology.OntModel;

@WebServlet("/UploadDownloadFileServlet")
public class UploadDownloadFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ServletFileUpload uploader = null;
	
    public static final String MESSAGE = "mesg";
    public static final String ERROR = "error";
    
    public static final String OK_UPLOAD_STATUS = "ontology was uploaded and loaded to new ontology";
    public static final String LOAD_ONTOLOGY_ERROR = "error loading ontology";
    public static final String UPLOAD_ERROR = "error uploading file";
   private static final String NO_ONTOLOGY_CREATED = "there is no ontology to manipulate";
	
    @Override
	public void init() throws ServletException{
		DiskFileItemFactory fileFactory = new DiskFileItemFactory();
		File filesDir = new File(Options.UPLOAD_DIR);//getServletContext().getAttribute("FILES_DIR_FILE");
		if (!filesDir.exists())
			filesDir.mkdirs();
		fileFactory.setRepository(filesDir);
		uploader = new ServletFileUpload(fileFactory);
		uploader.setSizeMax(1024*1024*100);
		System.out.println("initialization in servlet!!!");
	}
	
	private void persistOntology(String filePath, OntModel ont) throws IOException{
		//OntModel newModel = OntologyModelHelper.getNewModel();
        File file = new File(filePath);
        file.getParentFile().mkdirs();
        FileWriter fw = new FileWriter(filePath);
        ont.write( fw, "RDF/XML-ABBREV" );
        fw.close();
        return;
	}
    //download new ontology: persist new ontology, then download
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//check ontology to download
		String ontologyCode = request.getParameter("ontology");
		if (ontologyCode == null){
			request.setAttribute(ERROR, "no ontology specified ");
			outputPage(Constants.HOME_PAGE, request, response);
			return;
		}
		OntModel ont = null;
		String fileName = null;
		if (Constants.ontologies.new_ontology.toString().equals(ontologyCode)){
    		if (!OntologyModelHelper.isNewOntologyCreated()){
				request.setAttribute(ERROR, NO_ONTOLOGY_CREATED);
		        outputPage(Constants.HOME_PAGE, request, response);
		        return;
			}
    		ont = OntologyModelHelper.getNewModel();
    		fileName = Options.NEW_ONTOLOGY_FOR_DOWNLOAD_NAME;
    	} else if (Constants.ontologies.restriction_ontology.toString().equals(ontologyCode)){
    		if (!OntologyModelHelper.isRestrictionOntologyCreated()){
				request.setAttribute(ERROR, NO_ONTOLOGY_CREATED);
		        outputPage(Constants.HOME_PAGE, request, response);
		        return;
			}
    		ont = OntologyModelHelper.getRestrictionModel();
    		fileName = Options.RESTRICTION_ONTOLOGY_FOR_DOWNLOAD_NAME;
    	}
    	else {
			request.setAttribute(ERROR, "unknown ontology " +  ontologyCode);
	        outputPage(Constants.HOME_PAGE, request, response);
	        return;
    	}
		//###############################################################
		
		String filePath = Options.DOWNLOAD_DIR + fileName;
		persistOntology(filePath, ont);
		// DOWNLOAD
		//String fileName = request.getParameter("fileName");
		if(filePath == null || filePath.equals("")){
			throw new ServletException("File Name can't be null or empty");
		}
		File file = new File(filePath);
		if(!file.exists()){
			throw new ServletException("File doesn't exists on server.");
		}
		System.out.println("File location on server::"+file.getAbsolutePath());
		ServletContext ctx = getServletContext();
		InputStream fis = new FileInputStream(file);
		String mimeType = ctx.getMimeType(file.getAbsolutePath());
		response.setContentType(mimeType != null? mimeType:"application/octet-stream");
		response.setContentLength((int) file.length());
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

		ServletOutputStream os  = response.getOutputStream();
		byte[] bufferData = new byte[1024];
		int read=0;
		while((read = fis.read(bufferData))!= -1){
			os.write(bufferData, 0, read);
		}
		os.flush();
		os.close();
		fis.close();
		System.out.println("File downloaded at client successfully");
		request.setAttribute(MESSAGE, "new ontology was persisted succefully");
		response.setHeader("Refresh", "3; URL=\"" + Constants.HOME_PAGE + "\"");
		outputPage(Constants.HOME_PAGE, request, response);
		return;
	}

	//upload and load to new model
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		OntModel ont = null; //OntologyModelHelper.getNewModel();
		String fileName = null;
		if(!ServletFileUpload.isMultipartContent(request)){
			throw new ServletException("Content type is not multipart/form-data");
		}

		//response.setContentType("text/html");
		//PrintWriter out = response.getWriter();
		//out.write("<html><head></head><body>");
		
		File file = null;
		String ontologyCode = null;
		try {
			List<FileItem> fileItemsList = uploader.parseRequest(request);
			Iterator<FileItem> fileItemsIterator = fileItemsList.iterator();
			while(fileItemsIterator.hasNext()){
				
				FileItem fileItem = fileItemsIterator.next();
				
				System.out.println("fileItem.getFieldName() " + fileItem.getFieldName());
				System.out.println("FieldName="+fileItem.getFieldName());
				System.out.println("FileName="+fileItem.getName());
				System.out.println("ContentType="+fileItem.getContentType());
				System.out.println("Size in bytes="+fileItem.getSize());

				if (fileItem.getFieldName().equals("fileName")){
					fileName = fileItem.getName();
					file = new File(Options.UPLOAD_DIR + fileName);
					System.out.println("Absolute Path at server="+file.getAbsolutePath());
					fileItem.write(file);
				} else if (fileItem.getFieldName().equals("ontology")){
					ontologyCode = new String(fileItem.get());
				}
				
				
				
			}
			
			//ckeck ontology 
			//check ontology to download
			if (ontologyCode == null){
				request.setAttribute(ERROR, "no ontology specified ");
				outputPage(Constants.HOME_PAGE, request, response);
				return;
			}
			if (Constants.ontologies.new_ontology.toString().equals(ontologyCode)){
	    		if (!OntologyModelHelper.isNewOntologyCreated()){
					request.setAttribute(ERROR, NO_ONTOLOGY_CREATED);
			        outputPage(Constants.HOME_PAGE, request, response);
			        return;
				}
//clear current ontology
	    		OntologyModelHelper.clearNewOntology();
	    		ont = OntologyModelHelper.getNewModel();
	    		fileName = Options.NEW_ONTOLOGY_FOR_DOWNLOAD_NAME;
	    	} else if (Constants.ontologies.restriction_ontology.toString().equals(ontologyCode)){
	    		if (!OntologyModelHelper.isRestrictionOntologyCreated()){
					request.setAttribute(ERROR, NO_ONTOLOGY_CREATED);
			        outputPage(Constants.HOME_PAGE, request, response);
			        return;
				}
//clear current ontology
	    		OntologyModelHelper.clearRestrictionOntology();
	    		ont = OntologyModelHelper.getRestrictionModel();
	    		fileName = Options.RESTRICTION_ONTOLOGY_FOR_DOWNLOAD_NAME;
	    	}
	    	else {
				request.setAttribute(ERROR, "unknown ontology " +  ontologyCode);
		        outputPage(Constants.HOME_PAGE, request, response);
		        return;
	    	}
			//###############################################################	
			
			
			//load to new ontology
			try{
				OntologyModelHelper.loadToModelFromFile(ont, file.getAbsolutePath());
			}
			catch (Exception e){
				request.setAttribute(ERROR, LOAD_ONTOLOGY_ERROR);
				outputPage(Constants.HOME_PAGE, request, response);
				return;
			}
			request.setAttribute(MESSAGE, OK_UPLOAD_STATUS);
	        outputPage(Constants.HOME_PAGE, request, response);
	        return;
			
		} catch (FileUploadException e) {
			request.setAttribute(ERROR, UPLOAD_ERROR);
			outputPage(Constants.HOME_PAGE, request, response);
			return;
		} catch (Exception e) {
			request.setAttribute(ERROR, UPLOAD_ERROR);
			outputPage(Constants.HOME_PAGE, request, response);
			return;
		}
	}
	
	private void outputPage(String pageJSP, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	      RequestDispatcher dispatcher = request.getRequestDispatcher(pageJSP);
	      dispatcher.forward(request, response);
	      
	}

}