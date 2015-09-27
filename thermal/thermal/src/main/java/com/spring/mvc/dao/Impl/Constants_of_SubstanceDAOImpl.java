package com.spring.mvc.dao.Impl;

import java.util.List;



import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.mvc.dao.Constants_of_SubstanceDAO;
import com.spring.mvc.domainClasses.Constants_of_Substance;

@Repository
public class Constants_of_SubstanceDAOImpl extends AbstractDAOImpl<Constants_of_Substance, String>
										   implements Constants_of_SubstanceDAO {
	
	protected Constants_of_SubstanceDAOImpl() {
		super (Constants_of_Substance.class);
	}
	
	public List<Constants_of_Substance> findConstants_of_SubstanceBySubst_Id(Long id) {
		
		return findByCriteria(Restrictions.eq("substance.id", id));
	
	}

	public List<Constants_of_Substance> findAllConstants_of_Substances() {
		return findAllEntity();
	};
	
}
