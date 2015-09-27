package com.spring.mvc.dao.Impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.mvc.dao.ExternalResourceDAO;
import com.spring.mvc.domainClasses.ExternalResource;
import com.spring.mvc.domainClasses.Link;

@Repository 
public class ExternalResourceDAOImpl extends AbstractDAOImpl<ExternalResource, String> implements ExternalResourceDAO {
	
	protected ExternalResourceDAOImpl() {
        super(ExternalResource.class);
    }
	
       
    public void deleteExternalResource(ExternalResource er){
    	delete(er);
    }
    
    public void saveExternalResource(ExternalResource er){
    	saveOrUpdate(er);
    }


	@SuppressWarnings("unchecked")
	@Override
	public List<ExternalResource> getExternalResourcesByUri(String uri) {
		List<ExternalResource> thisClass;
    	getCurrentSession().beginTransaction();
    	Criteria cr = getCurrentSession().createCriteria(Link.class);
    	cr.add(Restrictions.eq("uri", uri));
    	thisClass = cr.list();
    	getCurrentSession().getTransaction().commit();
    	return thisClass;
	}
}
