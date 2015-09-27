package com.spring.mvc.domainClasses;

import javax.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "predicates")
public class Predicate implements Serializable{

	private static final long serialVersionUID = 8315357487369551773L;
	private Long id;
    private String name;   
    public Predicate(){}

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
