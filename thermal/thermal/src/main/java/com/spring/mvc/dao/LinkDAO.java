package com.spring.mvc.dao;

import java.util.List;

import com.spring.mvc.domainClasses.Link;

public interface LinkDAO {
	
    List<Link> findLinksBySubstanceAndDatasource(Long subst_id, Long lodDataSource_id);
    
	List<Link> findAllLinks();
    
    void deleteLink(Link links);
    
    void saveLink(Link link);

}
