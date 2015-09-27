package com.spring.mvc.domainClasses;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "external_resources")
public class ExternalResource implements Serializable{
    
	private static final long serialVersionUID = 5720928972894070387L;
	private Long id;     
    private String uri;
    public ExternalResource(){}

    @Id
    @GeneratedValue(/*strategy = IDENTITY*/)
    @Column(name = "id")
    public Long getId(){
        return this.id;
    }

    public void setId(Long id){
        this.id=id;
    }

    
    @Column(name = "uri")
    public String getUri(){
        return this.uri;
    }

    public void setUri(String uri){
        this.uri=uri;
    }
    
    
//(lod_datasource<-- external_resource)
    private LODDataSource datasource;

    @ManyToOne
    @JoinColumn(name = "lod_datasource_id")

    public LODDataSource getDatasource(){
        return  this.datasource;
    }

    public void setDatasource(LODDataSource datasource){
        this.datasource = datasource;
    }

}
