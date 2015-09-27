package com.spring.mvc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.mvc.dao.ExternalResourceDAO;
import com.spring.mvc.domainClasses.ExternalResource;
import com.spring.mvc.service.ExternalResourceService;

@Repository
@Service 
@Transactional(readOnly = true)
public class ExternalResourceServiceImpl implements ExternalResourceService {

	@Autowired
	private ExternalResourceDAO externalResourceDAO;
	
	public void deleteExternalResource(ExternalResource er){
		externalResourceDAO.deleteExternalResource(er);
	}
	
    public void saveExternalResource(ExternalResource er){
    	externalResourceDAO.saveExternalResource(er);
    }
    
    public List<ExternalResource> getExternalResourcesByUri(String uri){
    	return externalResourceDAO.getExternalResourcesByUri(uri);
    }
    
}
