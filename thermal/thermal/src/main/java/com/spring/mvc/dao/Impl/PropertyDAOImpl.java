package com.spring.mvc.dao.Impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.mvc.dao.PropertyDAO;
import com.spring.mvc.domainClasses.Property;

@Repository
public class PropertyDAOImpl extends AbstractDAOImpl<Property, String> implements PropertyDAO {

	protected PropertyDAOImpl() {
        super(Property.class);
    }

	@SuppressWarnings("unchecked")
	public List<Property> findPropertyBySubstance(Long subst_id) {
		List<Property> actualProps;
		getCurrentSession().beginTransaction();
    	Criteria cr = getCurrentSession().createCriteria(Property.class, "p");
    	cr.createAlias("p.states", "p_stAlias");
    	cr.createAlias("p_stAlias.environmental_Conditions", "e_csAlias"); 
    	cr.createAlias("e_csAlias.substance", "s_Alias");				   
    	cr.add(Restrictions.eq("s_Alias.id", subst_id));				   
    	cr.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);;
    	actualProps = cr.list();
    	getCurrentSession().getTransaction().commit();
		return actualProps;
	}
}
