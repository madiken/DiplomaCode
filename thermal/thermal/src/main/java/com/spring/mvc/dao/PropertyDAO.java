package com.spring.mvc.dao;

import java.util.List;
import com.spring.mvc.domainClasses.Property;

public interface PropertyDAO {
	
	List<Property> findPropertyBySubstance(Long subst_id);

}
