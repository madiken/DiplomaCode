package com.spring.mvc.domainClasses;

/**
 * Created by Reist on 03.03.14.
 */

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "environmental_condition")
public class Environmental_Condition implements Serializable{

	private static final long serialVersionUID = -9173938487173264085L;
	
	private Long id;
    private Long version;
    private String text_description;

    public Environmental_Condition(){}

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

    @Column(name = "text_description")
    public String getName(){
        return this.text_description;
    }

    public void setName(String text_description){
        this.text_description=text_description;
    }

    //(substance<--environmental_condition) 
    private Substance substance;

    @ManyToOne
    @JoinColumn(name = "substance_id")
    public Substance getSubstance(){
        return this.substance;
    }

    public void setSubstance(Substance substance){
        this.substance = substance;
    }

    //(state<--environmental_condition) 
    private State state;

    @ManyToOne
    @JoinColumn(name = "state_id")

    public State getState(){
        return  this.state;
    }

    public void setState(State state){
        this.state = state;
    }

    //(environmental_condition<--data) 
    private Set<Data> dates = new HashSet<Data>();

    @OneToMany(mappedBy = "environmental_Condition", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Data> getDates(){
        return this.dates;
    }

    public void setDates(Set<Data> dates){
        this.dates = dates;
    }

    public  void addData(Data data){
        data.setEnvironmental_Condition(this);
        getDates().add(data);
    }

    public void removeData(Data data){
        getDates().remove(data);
    }

    //(environmental_condition<--numerical_date) 
    private Set<Numerical_Data> numerical_dates = new HashSet<Numerical_Data>();

    @OneToMany(mappedBy = "environmental_Condition", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Numerical_Data> getNumerical_Dates(){
        return this.numerical_dates;
    }

    public void setNumerical_Dates(Set<Numerical_Data> numerical_dates){
        this.numerical_dates = numerical_dates;
    }

    public  void addNumerical_Data(Numerical_Data numerical_data){
        numerical_data.setEnvironmental_Condition(this);
        getNumerical_Dates().add(numerical_data);
    }

    public void removeNumerical_Data(Numerical_Data numerical_data)
    {
        getNumerical_Dates().remove(numerical_data);
    }
}
