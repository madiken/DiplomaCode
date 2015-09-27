package com.spring.mvc.service;


import java.util.List;

import com.spring.mvc.domainClasses.Constants_of_Substance;

public interface Constants_of_SubstanceService {
	
	List<Constants_of_Substance> findConstants_of_SubstanceBySubst_id(Long id);
	
	List<Constants_of_Substance> findAllConstants_of_Substances();

}
