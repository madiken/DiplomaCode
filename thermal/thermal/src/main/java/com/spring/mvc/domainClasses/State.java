package com.spring.mvc.domainClasses;

/**
 * Created by Reist on 03.03.14.
 */

import javax.persistence.*;

import java.util.HashSet;
import java.util.Set;
import java.io.Serializable;

@Entity
@Table(name = "state")
public class State implements Serializable{

	private static final long serialVersionUID = -4419336811507757426L;

	private Long id;
    private Long version;
    private String name;

    public State(){}

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

    @Column(name = "name")
    public String getName(){
        return this.name;
    }

    public void setName(String name){
        this.name=name;
    }

    //(property<-->state)
    private Set<Property> properties = new HashSet<Property>();

    @ManyToMany
    @JoinTable(name = "property_state",
            joinColumns = @JoinColumn(name = "state_id"),
            inverseJoinColumns = @JoinColumn(name = "property_id"))

    public Set<Property> getProperties() {return this.properties;}

    public void setProperties (Set<Property> properties) {
        this.properties = properties;
    }

    //(state<--environmental_condition) 
    private Set <Environmental_Condition> environmental_conditions = new HashSet<Environmental_Condition>();

    @OneToMany(mappedBy = "state", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Environmental_Condition> getEnvironmental_Conditions(){
        return this.environmental_conditions;
    }

    public void setEnvironmental_Conditions(Set<Environmental_Condition> environmental_conditions){
        this.environmental_conditions = environmental_conditions;
    }

    public  void addEnvironmental_Condition(Environmental_Condition environmental_condition){
        environmental_condition.setState(this);
        getEnvironmental_Conditions().add(environmental_condition);
    }

    public void removeEnvironmental_Condition(Environmental_Condition environmental_condition){
        getEnvironmental_Conditions().remove(environmental_condition);
    }
/*
    //(state<--state_child) 
    public Long parent_state_id;
    public Long getParent_State(){
        return this.parent_state_id;
    }

    public void setParent_State(Long parent_state_id){
        this.parent_state_id = parent_state_id;
    }
*/
}
