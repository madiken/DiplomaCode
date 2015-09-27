package com.spring.mvc.dao.Impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.mvc.dao.LinkDAO;
import com.spring.mvc.domainClasses.Link;

@Repository 
public class LinkDAOImpl extends AbstractDAOImpl<Link, String> implements LinkDAO {
	
	protected LinkDAOImpl() {
        super(Link.class);
    }
	
    @SuppressWarnings("unchecked")
    public List<Link> findLinksBySubstanceAndDatasource(Long subst_id, Long lodDataSource_id){
    	List<Link> thisClass;
    	getCurrentSession().beginTransaction();
    	Criteria cr = getCurrentSession().createCriteria(Link.class);
    	cr.add(Restrictions.eq("substance.id", subst_id));
    	cr.createAlias("externalResource", "externalResourceAlias");
    	cr.createAlias("externalResourceAlias.datasource", "dataSourceAlias");
    	cr.add(Restrictions.eq("dataSourceAlias.id", lodDataSource_id));
    	thisClass = cr.list();
    	getCurrentSession().getTransaction().commit();
    	return thisClass;
    }
    
    public List<Link> findAllLinks() {
    	return findAllEntity();
    }
    
    public void deleteLink(Link link){
    	delete(link);
    }
    
    public void saveLink(Link link){
    	saveOrUpdate(link);
    }
}
