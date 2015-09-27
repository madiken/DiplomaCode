package com.spring.mvc.service;

import java.util.List;

import com.spring.mvc.domainClasses.ExternalResource;

public interface ExternalResourceService {
	
	void deleteExternalResource(ExternalResource er);
	
    void saveExternalResource(ExternalResource er);
    
    List<ExternalResource> getExternalResourcesByUri(String uri);
	
}
