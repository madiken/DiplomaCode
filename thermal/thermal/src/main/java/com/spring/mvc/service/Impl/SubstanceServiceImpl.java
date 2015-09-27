package com.spring.mvc.service.Impl;

import java.util.List;

import com.spring.mvc.domainClasses.Substance;
import com.spring.mvc.dao.SubstanceDAO;
import com.spring.mvc.service.SubstanceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Repository
@Service 
@Transactional(readOnly = true) 
public class SubstanceServiceImpl implements SubstanceService {
	
	@Autowired
	private SubstanceDAO substanceDAO;

    public List<Substance> findSubstancesByName (String substance) {
        return substanceDAO.findSubstancesByName(substance);
    }
    
    public List<Substance> findAllSubstances() {
        return substanceDAO.findAllSubstances();
    }

	public Substance findSusbtById(Long subst_id) {
		return substanceDAO.findSubstById(subst_id);
	}
    
}
