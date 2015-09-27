package com.spring.mvc.dao;

import java.util.List;

import com.spring.mvc.domainClasses.ExternalResource;

public interface ExternalResourceDAO {
	void deleteExternalResource(ExternalResource er);
	
    void saveExternalResource(ExternalResource er);
    
    List<ExternalResource> getExternalResourcesByUri(String uri);
}
