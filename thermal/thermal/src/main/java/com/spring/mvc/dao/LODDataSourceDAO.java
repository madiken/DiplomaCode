package com.spring.mvc.dao;

import com.spring.mvc.domainClasses.LODDataSource;

public interface LODDataSourceDAO {
	
	LODDataSource getLODDataSourceById(Long id);
	void saveLODDataSource(LODDataSource dataSource);
}