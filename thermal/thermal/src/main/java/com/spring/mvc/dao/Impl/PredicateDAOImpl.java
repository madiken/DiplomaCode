package com.spring.mvc.dao.Impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.mvc.dao.PredicateDAO;
import com.spring.mvc.domainClasses.Predicate;

@Repository 
public class PredicateDAOImpl extends AbstractDAOImpl<Predicate, String> implements PredicateDAO {
	
	protected PredicateDAOImpl() {
        super(Predicate.class);
    }
	
    @SuppressWarnings("unchecked")
    public Predicate getPredicateById(Long id){
    	Predicate thisClass;
    	getCurrentSession().beginTransaction();
    	Criteria cr = getCurrentSession().createCriteria(Predicate.class);
    	cr.add(Restrictions.eq("id", id));
    	List<Predicate> crList = cr.list();
    	thisClass = (crList.size()) > 0 ? crList.get(0) : null;
    	getCurrentSession().getTransaction().commit();
    	return thisClass;
    }
    


}
