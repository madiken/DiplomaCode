package com.spring.mvc.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.mvc.dao.Constants_of_SubstanceDAO;
import com.spring.mvc.domainClasses.Constants_of_Substance;
import com.spring.mvc.service.Constants_of_SubstanceService;


@Repository
@Service 
@Transactional(readOnly = true) 
public class Constants_of_SubstanceServiceImpl implements Constants_of_SubstanceService  {

	@Autowired
	private Constants_of_SubstanceDAO constants_of_SubstanceDAO;
	
    public List<Constants_of_Substance> findConstants_of_SubstanceBySubst_id(Long id) {
        return constants_of_SubstanceDAO.findConstants_of_SubstanceBySubst_Id(id);
    }

	@Override
	public List<Constants_of_Substance> findAllConstants_of_Substances() {
		return constants_of_SubstanceDAO.findAllConstants_of_Substances();
	}

}
