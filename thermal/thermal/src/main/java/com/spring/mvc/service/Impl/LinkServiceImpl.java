package com.spring.mvc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.mvc.dao.LinkDAO;
import com.spring.mvc.domainClasses.Link;
import com.spring.mvc.service.LinkService;


@Repository
@Service 
@Transactional(readOnly = true)
public class LinkServiceImpl implements LinkService {
	
	@Autowired
	private LinkDAO linkDAO;

	public List<Link> findLinksBySubstanceAndDatasource(Long subst_id, Long loddatasource_id) {
		return linkDAO.findLinksBySubstanceAndDatasource(subst_id, loddatasource_id);
	}

	@Override
	public List<Link> findAllLinks() {
		return linkDAO.findAllLinks();
	}

	@Override
	public void deleteLink(Link link) {
		linkDAO.deleteLink(link);
	}
	
	@Override
	public void saveLink(Link link){
		linkDAO.saveLink(link);
	}

	
}
