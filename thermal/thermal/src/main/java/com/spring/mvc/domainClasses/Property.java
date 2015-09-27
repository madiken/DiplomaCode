package com.spring.mvc.domainClasses;

/**
 * Created by Reist on 03.03.14.
 */

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;
import java.io.Serializable;

@Entity
@Table(name = "property")
public class Property implements Serializable {

	private static final long serialVersionUID = 1381200751654777669L;

	private Long id;
    private Long version;
    private String name;
    private String prop_designation;

    public Property(){}

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

    @Column(name = "prop_designation")
    public String getProp_designation(){
        return this.prop_designation;
    }

    public void setProp_designation(String prop_designation){
        this.prop_designation=prop_designation;
    }

    //(dimension <-- property) 
    private Dimension dimension;

    @ManyToOne
    @JoinColumn(name = "dimension_id")

    public Dimension getDimension(){
        return  this.dimension;
    }

    public void setDimension(Dimension dimension){
        this.dimension = dimension;
    }

    //(property<-->state)
    private Set<State> states = new HashSet<State>();

    @ManyToMany
    @JoinTable(name = "property_state",
               joinColumns = @JoinColumn(name = "property_id"),
               inverseJoinColumns = @JoinColumn(name = "state_id"))

    public Set<State> getStates() {return this.states;}

    public void setStates (Set<State> states) {this.states = states;}

    //(property<--constants_of_substance) 
    
    private Set<Constants_of_Substance> constants_of_substances
            = new HashSet<Constants_of_Substance>();

    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Constants_of_Substance> getConstants_of_Substances(){
        return this.constants_of_substances;
    }
    public void setConstants_of_Substances(Set<Constants_of_Substance> constants_of_substances){



        this.constants_of_substances = constants_of_substances;
    }

    public  void addConstants_of_Substance(Constants_of_Substance constants_of_substance){
        constants_of_substance.setProperty(this);
        getConstants_of_Substances().add(constants_of_substance);
    }

    public void removeConstants_of_Substance(Constants_of_Substance constants_of_substance){
        getConstants_of_Substances().remove(constants_of_substance);
    }

    //(property <-- data)

    private Set<Data> dates = new HashSet<Data>();

    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Data> getDates(){
        return this.dates;
    }

    public void setDates(Set<Data> dates){
        this.dates = dates;
    }

    public  void addData(Data data){
        data.setProperty(this);
        getDates().add(data);
    }

    public void removeData(Data data){
        getDates().remove(data);
    }

    //(property <-- numerical_data)

    private Set<Numerical_Data> numerical_dates = new HashSet<Numerical_Data>();

    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Numerical_Data> getNumerical_Dates(){
        return this.numerical_dates;
    }

    public void setNumerical_Dates(Set<Numerical_Data> numerical_dates){
        this.numerical_dates = numerical_dates;
    }

    public  void addNumerical_Data(Numerical_Data numerical_data){
        numerical_data.setProperty(this);
        getNumerical_Dates().add(numerical_data);
    }

    public void removeNumerical_dataData(Numerical_Data numerical_data)
    {
        getNumerical_Dates().remove(numerical_data);
    }
}
