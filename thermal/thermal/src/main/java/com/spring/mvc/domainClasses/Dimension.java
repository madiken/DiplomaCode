package com.spring.mvc.domainClasses;

import javax.persistence.*;
import java.util.Set;
import java.util.HashSet;
import java.io.Serializable;

/**
 * Created by Reist on 03.03.14.
 */
@Entity
@Table(name = "dimension")
public class Dimension implements Serializable{

	private static final long serialVersionUID = -4329677546383375890L;
	
	private Long id;
    private Long version;
    private String name;

    public Dimension(){}

    @Id
    @GeneratedValue(/*strategy = IDENTITY*/)
    @Column(name = "id")
    public Long getId(){
        return this.id;
    }

    public void setId(Long id){
        this.id = id;
    }

    @Version
    @Column(name = "version")
    public Long getVersion(){
        return this.version;
    }

    public void setVersion(Long version){
        this.version = version;
    }

    @Column(name = "name")
    public String getName(){
        return this.name;
    }

    public void setName(String name){
        this.name = name;
    }

    //(dimension <-- property) 
    private Set <Property> properties = new HashSet<Property>();

    @OneToMany(mappedBy = "dimension", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Property> getProperties(){
        return this.properties;
    }

    public void setProperties(Set<Property> properties){
        this.properties = properties;
    }

    public  void addProperty(Property property){
        property.setDimension(this);
        getProperties().add(property);
    }

    public void removeProperty(Property property){
        getProperties().remove(property);
    }
}
