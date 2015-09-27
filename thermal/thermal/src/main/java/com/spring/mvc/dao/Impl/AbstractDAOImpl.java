package com.spring.mvc.dao.Impl;

import com.spring.mvc.dao.AbstractDAO;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Repository
public abstract class AbstractDAOImpl<E, I extends Serializable> implements AbstractDAO <E,I> {

    private Class<E> entityClass;
    
    protected AbstractDAOImpl(Class<E> entityClass) {
        this.entityClass = entityClass;
    }
    
    @Autowired
    private SessionFactory sessionFactory;
    
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }
    
    
    @Transactional
    public void saveOrUpdate(E e) {
    	getCurrentSession().beginTransaction();
        getCurrentSession().saveOrUpdate(e);
        getCurrentSession().getTransaction().commit();
    }

    @Transactional
    public void delete(E e) {
    	getCurrentSession().beginTransaction();
        getCurrentSession().delete(e);
        getCurrentSession().getTransaction().commit();
    }

    
    @SuppressWarnings("unchecked")
    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public E findByIdentifier(I id) {
    	E obj;
    	getCurrentSession().beginTransaction();
        obj = (E) getCurrentSession().get(entityClass, id);
        getCurrentSession().getTransaction().commit();
        return obj;
    }
	 
    @SuppressWarnings("unchecked")
	@Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<E> findByCriteria(Criterion criterion) {
    	List<E> thisClass;
    	getCurrentSession().beginTransaction();
        Criteria criteria = getCurrentSession().createCriteria(entityClass);
        criteria.add(criterion);
        thisClass = criteria.list();
        getCurrentSession().getTransaction().commit();
        return thisClass;
    }
    
    @SuppressWarnings("unchecked")
	@Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<E> findAllEntity() {
    	List<E> thisClass;
    	getCurrentSession().beginTransaction();
        Criteria criteria = getCurrentSession().createCriteria(entityClass);
        thisClass = criteria.list();
        getCurrentSession().getTransaction().commit();
        System.out.println("findAllEntity");
        for (E e : thisClass){
        	System.out.println(e);
        }
        System.out.println(thisClass.size());
        return thisClass;
    }    
}