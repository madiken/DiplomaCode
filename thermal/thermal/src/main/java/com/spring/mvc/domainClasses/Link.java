package com.spring.mvc.domainClasses;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "links")
public class Link implements Serializable{
    
	private static final long serialVersionUID = -8115935662536639185L;
	private Long id;
   
    public Link(){}

    @Id
    @GeneratedValue(/*strategy = IDENTITY*/)
    @Column(name = "id")
    public Long getId(){
        return this.id;
    }

    public void setId(Long id){
        this.id=id;
    }


    //(substance <-- links) 
    private Substance substance;

    @ManyToOne
    @JoinColumn(name = "substance_id")

    public Substance getSubstance(){
        return  this.substance;
    }

    public void setSubstance (Substance substance){
        this.substance = substance;
    }

    
    ////(property<-- links)
    private Property property;

    @ManyToOne
    @JoinColumn(name = "property_id")

    public Property getProperty(){
        return  this.property;
    }

    public void setProperty(Property property){
        this.property = property;
    }

    ////(dimension<-- links)
    private Dimension dimension;

    @ManyToOne
    @JoinColumn(name = "dimension_id")

    public Dimension getDimension(){
        return  this.dimension;
    }

    public void setDimension(Dimension dimension){
        this.dimension = dimension;
    }
    
////(property<-- links)
    private Predicate predicate;

    @ManyToOne
    @JoinColumn(name = "predicate_id")

    public Predicate getPredicate(){
        return  this.predicate;
    }

    public void setPredicate(Predicate predicate){
        this.predicate = predicate;
    }
    
////(external_resource<-- links)
    private ExternalResource externalResource;

    @ManyToOne
    @JoinColumn(name = "external_resource_id")

    public ExternalResource getExternalResource(){
        return  this.externalResource;
    }

    public void setExternalResource(ExternalResource externalResource){
        this.externalResource = externalResource;
    }

}
