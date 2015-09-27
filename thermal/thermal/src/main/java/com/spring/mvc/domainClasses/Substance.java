package com.spring.mvc.domainClasses;

/**
 * Created by Reist on 03.03.14.
 */

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

//import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Table(name = "substance")
public class Substance {
    private Long id;
    private Long version;
    private String name;
    private String subst_formula;

    public Substance(){}

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

    @Column(name = "subst_formula")
    public String getSubst_formula(){
        return this.subst_formula;
    }

    public void setSubst_formula(String subst_formula){
        this.subst_formula=subst_formula;
    }

    //(substance<--environmental_condition) 
    private Set<Environmental_Condition> environmental_Conditions
            = new HashSet<Environmental_Condition>();

    @OneToMany(mappedBy = "substance", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Environmental_Condition> getEnvironmental_Conditions(){
        return this.environmental_Conditions;
    }
    public void setEnvironmental_Conditions(Set<Environmental_Condition> environmental_Conditions){
        this.environmental_Conditions = environmental_Conditions;
    }

    public  void addEnvironmental_Condition(Environmental_Condition environmental_Conditon){
        environmental_Conditon.setSubstance(this);
        getEnvironmental_Conditions().add(environmental_Conditon);
    }

    public void removeEnvironmental_Condition(Environmental_Condition environmental_Conditon){
        getEnvironmental_Conditions().remove(environmental_Conditon);
    }

    //(substance<--constants_of_substance) 
    private Set<Constants_of_Substance> constants_of_substances
            = new HashSet<Constants_of_Substance>();

    @OneToMany(mappedBy = "substance", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Constants_of_Substance> getConstants_of_Substances(){
        return this.constants_of_substances;
    }
    public void setConstants_of_Substances(Set<Constants_of_Substance> constants_of_substances){
        this.constants_of_substances = constants_of_substances;
    }

    public  void addConstants_of_Substance(Constants_of_Substance constants_of_substance){
        constants_of_substance.setSubstance(this);
        getConstants_of_Substances().add(constants_of_substance);
    }

    public void removeConstants_of_Substance(Constants_of_Substance constants_of_substance){
        getConstants_of_Substances().remove(constants_of_substance);
    }

}
