package com.spring.mvc.dao;

import org.hibernate.criterion.Criterion;

import java.io.Serializable;
import java.util.List;

public interface AbstractDAO <E, I extends Serializable> {

    E findByIdentifier (I id);
    
    void saveOrUpdate (E e);
    
    void delete (E e);
    
    List<E> findByCriteria (Criterion criterion);
    
    List<E> findAllEntity();
}