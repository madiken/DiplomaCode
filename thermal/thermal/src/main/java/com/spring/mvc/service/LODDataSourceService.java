package com.spring.mvc.service;

import com.spring.mvc.domainClasses.LODDataSource;
import com.spring.mvc.domainClasses.Link;

public interface LODDataSourceService {
	LODDataSource getLODDataSourceById(Long id);
	void saveLODDataSource(LODDataSource dataSource);
}
