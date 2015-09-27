package com.spring.mvc.dao.Impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.mvc.dao.DataDAO;
import com.spring.mvc.domainClasses.Data;

@Repository 
public class DataDAOImpl extends AbstractDAOImpl<Data, String> implements DataDAO {
	
	protected DataDAOImpl() {
        super(Data.class);
    }
	
    @SuppressWarnings("unchecked")
	public List<Data> findDataBySubst_Id(Long subst_id, Long prop_id) {
    	List<Data> thisClass;
    	getCurrentSession().beginTransaction();
    	Criteria cr = getCurrentSession().createCriteria(Data.class);
    	cr.add(Restrictions.eq("property.id", prop_id));
    	cr.createAlias("environmental_Condition", "environmental_conditionAlias");
    	cr.createAlias("environmental_conditionAlias.substance", "substanceAlias");
    	cr.add(Restrictions.eq("substanceAlias.id", subst_id));
    	//cr.add(Restrictions.eq("environmental_Condition.substance.id", subst_id));
    	thisClass = cr.list();
    	getCurrentSession().getTransaction().commit();
    	return thisClass;
    }

    public List<Data> findAllData() {
    	return findAllEntity();
    }   
}
