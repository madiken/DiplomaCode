package com.spring.mvc.domainClasses;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "lod_datasource")
public class LODDataSource implements Serializable{
	private static final long serialVersionUID = -4027164333149001901L;
	private Long id;
	private String name;
	

    public LODDataSource(){}

    @Id
    @GeneratedValue(/*strategy = IDENTITY*/)
    @Column(name = "id")
    public Long getId(){
        return this.id;
    }

    public void setId(Long id){
        this.id=id;
    }
    
    @Column(name = "name")
    public String getName(){
        return this.name;
    }

    public void setName(String name){
        this.name=name;
    }
}
