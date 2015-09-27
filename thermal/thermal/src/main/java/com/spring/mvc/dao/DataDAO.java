package com.spring.mvc.dao;

import java.util.List;

import com.spring.mvc.domainClasses.Data;

public interface DataDAO {
	
    List<Data> findDataBySubst_Id(Long subst_id, Long prop_id);
    
    List<Data> findAllData();

}
