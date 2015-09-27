package com.spring.mvc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.mvc.dao.DataDAO;
import com.spring.mvc.domainClasses.Data;
import com.spring.mvc.service.DataService;


@Repository
@Service 
@Transactional(readOnly = true)
public class DataServiceImpl implements DataService {
	
	@Autowired
	private DataDAO dataDAO;

	public List<Data> findDataBySubst_Id(Long subst_id, Long prop_id) {
		return dataDAO.findDataBySubst_Id(subst_id, prop_id);
	}

	public List<Data> findAllData() {
		return dataDAO.findAllData();
	}
	
	
}
