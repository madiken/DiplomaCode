package com.spring.mvc.domainClasses;

/**
 * Created by Reist on 03.03.14.
 */

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;
import java.io.Serializable;


@Entity
@Table(name = "data_source")
public class Data_Source implements Serializable {

	private static final long serialVersionUID = 2291242533321876747L;
	
	private Long id;
    private Long version;
    private String name;

    public Data_Source(){}

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

    //(data_source <-- data)
    private Set<Data> dates = new HashSet<Data>();

    @OneToMany(mappedBy = "data_Source", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Data> getDates(){
        return this.dates;
    }

    public void setDates(Set<Data> dates){
        this.dates = dates;
    }

    public  void addData(Data data){
        data.setData_Source(this);
        getDates().add(data);
    }

    public void removeData(Data data){
        getDates().remove(data);
    }

    //(data_source<--constants_of_substance)
    private Set<Constants_of_Substance> constants_of_substances = new HashSet<Constants_of_Substance>();

    @OneToMany(mappedBy = "data_Source", cascade = CascadeType.ALL,
            orphanRemoval = true)

    public Set<Constants_of_Substance> getConstants_of_Substances(){
        return this.constants_of_substances;
    }

    public void setConstants_of_Substances(Set<Constants_of_Substance> constants_of_substances){
        this.constants_of_substances = constants_of_substances;
    }

    public  void addConstants_of_Substance(Constants_of_Substance constants_of_substance){
        constants_of_substance.setData_Source(this);
        getConstants_of_Substances().add(constants_of_substance);
    }

    public void removeConstants_of_Substance(Constants_of_Substance constants_of_substance){
        getConstants_of_Substances().remove(constants_of_substance);
    }

}
