package com.spring.mvc.service;

import java.util.List;

import com.spring.mvc.domainClasses.Link;

public interface LinkService {
	
	List<Link> findLinksBySubstanceAndDatasource(Long subst_id, Long loddatasource_id);
		
	List<Link> findAllLinks();
	
	void deleteLink(Link link);
	
	void saveLink(Link link);
	
}
