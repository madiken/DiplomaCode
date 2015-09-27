package com.spring.mvc.dao;

import java.util.List;
import com.spring.mvc.domainClasses.Substance;

public interface SubstanceDAO {
	
	void saveSubstance (Substance substance);
    
    List<Substance> findSubstancesByName (String name);
    
    List<Substance> findAllSubstances(); 
    
    Substance findSubstById (Long id);
}