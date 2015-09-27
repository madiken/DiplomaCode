package com.spring.mvc.service.Impl;

import helpers.Constants;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.mvc.dao.LODDataSourceDAO;
import com.spring.mvc.domainClasses.LODDataSource;
import com.spring.mvc.service.LODDataSourceService;


@Repository
@Service 
@Transactional(readOnly = true)
public class LODDataSourceServiceImpl implements LODDataSourceService {
	
	@Autowired
	private LODDataSourceDAO LODDataSourceDAO;

	@Override
	public LODDataSource getLODDataSourceById(Long id) {
		return LODDataSourceDAO.getLODDataSourceById(id);
	}
	
	@Override
	public
	void saveLODDataSource(LODDataSource dataSource){
		LODDataSourceDAO.saveLODDataSource(dataSource);
	}

}
