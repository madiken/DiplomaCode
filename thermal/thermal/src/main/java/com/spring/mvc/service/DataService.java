package com.spring.mvc.service;

import java.util.List;

import com.spring.mvc.domainClasses.Data;

public interface DataService {
	
	List<Data> findDataBySubst_Id(Long subst_id, Long prop_id);
	
	List<Data> findAllData();
}
