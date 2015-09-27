package com.spring.mvc.dao.Impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.mvc.dao.LODDataSourceDAO;
import com.spring.mvc.domainClasses.LODDataSource;

@Repository 
public class LODDataSourceDAOImpl extends AbstractDAOImpl<LODDataSource, String> implements LODDataSourceDAO {
	
	protected LODDataSourceDAOImpl() {
        super(LODDataSource.class);
    }
	
    @SuppressWarnings("unchecked")
    public LODDataSource getLODDataSourceById(Long id){
    	LODDataSource thisClass;
    	getCurrentSession().beginTransaction();
    	Criteria cr = getCurrentSession().createCriteria(LODDataSource.class);
    	cr.add(Restrictions.eq("id", id));
    	List<LODDataSource> crList = cr.list();
    	thisClass = (crList.size()) > 0 ? crList.get(0) : null;
    	getCurrentSession().getTransaction().commit();
    	return thisClass;
    }

	@Override
	public void saveLODDataSource(LODDataSource dataSource) {
		saveOrUpdate(dataSource);
	}

}
