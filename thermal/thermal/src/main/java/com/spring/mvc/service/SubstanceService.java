package com.spring.mvc.service;

import java.util.List;
import com.spring.mvc.domainClasses.Substance;

public interface SubstanceService {
	
	Substance findSusbtById (Long subst_id);
	 
	List<Substance> findAllSubstances (); 
	
	List<Substance> findSubstancesByName (String substance);
}
