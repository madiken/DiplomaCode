package com.spring.mvc.domainClasses;

/**
 * Created by Reist on 03.03.14.
 */

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "data")
public class Data implements Serializable{
    
	private static final long serialVersionUID = 2553097840479381281L;
	
	private Long id;
    private Long version;
    private Double uncertainty_value;
    private Double value;
    private State state;
    public Data(){}

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

    //(data_source <-- data) 
    private Data_Source data_Source;

    @ManyToOne
    @JoinColumn(name = "data_source_id")

    public Data_Source getData_Source(){
        return  this.data_Source;
    }

    public void setData_Source (Data_Source data_source){
        this.data_Source = data_source;
    }

  //(state <-- data) 
    @ManyToOne
    @JoinColumn(name = "state_id")

    public State getState(){
        return  this.state;
    }

    public void setState (State state){
        this.state = state;
    }

    
    //(environmental_condition<--data)
    private Environmental_Condition environmental_Condition;

    @ManyToOne
    @JoinColumn(name = "environmentalcondition_id")

    public Environmental_Condition getEnvironmental_Condition(){
        return this.environmental_Condition;
    }

    public void setEnvironmental_Condition(Environmental_Condition environmental_condition){
        this.environmental_Condition = environmental_condition;
    }

    ////(property<-- data)
    private Property property;

    @ManyToOne
    @JoinColumn(name = "property_id")

    public Property getProperty(){
        return  this.property;
    }

    public void setProperty(Property property){
        this.property = property;
    }

    ////(uncertainty<-- data)
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
