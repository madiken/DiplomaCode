package com.spring.mvc.dao.Impl;

import java.util.List;

import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.mvc.domainClasses.Substance;
import com.spring.mvc.dao.SubstanceDAO;;

@Repository 
public class SubstanceDAOImpl extends AbstractDAOImpl<Substance, Long> implements SubstanceDAO {
	
	protected SubstanceDAOImpl() {
        super(Substance.class);
    }

    public void saveSubstance (Substance substance) {
        saveOrUpdate(substance);
    }

    public List<Substance> findSubstancesByName (String name) {
        return findByCriteria(Restrictions.like("name", name, MatchMode.START));
    }
    
    
    public List<Substance> findAllSubstances () {
    	return findAllEntity();
    }

	@Override
	public Substance findSubstById(Long subst_id) {
		return findByIdentifier(subst_id);
	}	
}
