package com.spring.mvc.service;

import java.util.List;

import com.spring.mvc.domainClasses.Property;

public interface PropertyService {
	
	List<Property> findPropertyBySubstance(Long subst_id);
	
}
