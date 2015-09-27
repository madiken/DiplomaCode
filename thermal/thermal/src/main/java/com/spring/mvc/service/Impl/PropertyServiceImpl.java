package com.spring.mvc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.mvc.dao.PropertyDAO;
import com.spring.mvc.domainClasses.Property;
import com.spring.mvc.service.PropertyService;

@Repository
@Service 
@Transactional(readOnly = true)
public class PropertyServiceImpl implements PropertyService{
	
	@Autowired
	private PropertyDAO propertyDAO;

	public List<Property> findPropertyBySubstance(Long subst_id) {
		return propertyDAO.findPropertyBySubstance(subst_id);
	}	
}
