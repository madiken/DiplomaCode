package com.spring.mvc.domainClasses;

/**
 * Created by Reist on 03.03.14.
 */

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "constants_of_substance")
public class Constants_of_Substance implements Serializable {

	private static final long serialVersionUID = -7865363875084797118L;
	
	private Long id;
    private Long version;
    private Double uncertainty_value;
    private Double value;

    public Constants_of_Substance(){}

    @Id
    @GeneratedValue(/*strategy = IDENTITY*/)
    @Column(name = "id")
    public Long getId(){
        return this.id;
    }

    public void setId(Long id){
        this.id=id;
    }

    @Version
    @Column(name = "version")
    public Long getVersion(){
        return this.version;
    }

    public void setVersion(Long version){
        this.version=version;
    }

    @Column(name = "uncertainty_value")
    public Double getUncertainty_value(){
        return  this.uncertainty_value;
    }

    public void setUncertainty_value(Double uncertainty_value){
        this.uncertainty_value=uncertainty_value;
    }

    @Column(name = "value")
    public Double getValue(){
        return this.value;
    }

    public void setValue(Double value){
        this.value=value;
    }

    //(substance<--constants_of_substance) 
    private Substance substance;

    @ManyToOne
    @JoinColumn(name = "substance_id")
    public Substance getSubstance(){
        return this.substance;
    }

    public void setSubstance(Substance substance){
        this.substance = substance;
    }

    //(data_source <-- constants_of_substance) 
    private Data_Source data_Source;

    @ManyToOne
    @JoinColumn(name = "data_source_id")

    public Data_Source getData_Source(){
        return  this.data_Source;
    }

    public void setData_Source(Data_Source data_source){
        this.data_Source = data_source;
    }

    ////(property<-- constants_of_substance)
    private Property property;

    @ManyToOne
    @JoinColumn(name = "property_id")

    public Property getProperty(){
        return  this.property;
    }

    public void setProperty(Property property){
        this.property = property;
    }

    ////(uncertainty<-- constants_of_substance) 
    private Uncertainty uncertainty;

    @ManyToOne
    @JoinColumn(name = "uncertainty_id")

    public Uncertainty getUncertainty(){
        return  this.uncertainty;
    }

    public void setUncertainty(Uncertainty uncertainty){
        this.uncertainty = uncertainty;
    }
}
