package com.spring.mvc.dao;

import java.util.List;

import com.spring.mvc.domainClasses.Constants_of_Substance;

public interface Constants_of_SubstanceDAO {
    
	List<Constants_of_Substance> findConstants_of_SubstanceBySubst_Id(Long id);
	
	List<Constants_of_Substance> findAllConstants_of_Substances();

}
