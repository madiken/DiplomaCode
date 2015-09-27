package com.spring.mvc.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.mvc.dao.PredicateDAO;
import com.spring.mvc.domainClasses.Predicate;
import com.spring.mvc.service.PredicateService;


@Repository
@Service 
@Transactional(readOnly = true)
public class PredicateServiceImpl implements PredicateService {
	
	@Autowired
	private PredicateDAO predicateDAO;

	

	@Override
	public Predicate getPredicateById(Long id) {
		return predicateDAO.getPredicateById(id);
	}

}
