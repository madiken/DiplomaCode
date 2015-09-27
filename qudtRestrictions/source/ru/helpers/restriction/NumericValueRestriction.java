package ru.helpers.restriction;

import java.io.IOException;


import com.hp.hpl.jena.datatypes.TypeMapper;
import com.hp.hpl.jena.ontology.AllValuesFromRestriction;
import com.hp.hpl.jena.ontology.HasValueRestriction;
import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.ontology.IntersectionClass;
import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.Restriction;
import com.hp.hpl.jena.rdf.model.RDFList;
import com.hp.hpl.jena.rdf.model.Resource;

public class NumericValueRestriction {
	private String catcherUri = null;
	
	private String quantityKindUri = null;
	private String unitUri = null;
	private Double max = null;
	private Double min = null;
	

	
	public NumericValueRestriction(String catcherUri, String quantityKindUri, String unitUri, Double min, Double max){
		this.catcherUri = catcherUri;
		this.quantityKindUri = quantityKindUri;
		this.unitUri = unitUri;
		this.max = max;
		this.min = min;
    }
	
	public String getCatcherUri() {
		return catcherUri;
	}
	public void setCatcherUri(String catcherUri) {
		this.catcherUri = catcherUri;
	}

    public String getQuantityKindUri() {
		return quantityKindUri;
	}
	public void setQuantityKindUri(String quantityKindUri) {
		this.quantityKindUri = quantityKindUri;
	}
	public String getUnitUri() {
		return unitUri;
	}
	public void setUnitUri(String unitUri) {
		this.unitUri = unitUri;
	}
	public Double getMax() {
		return max;
	}
	public void setMax(Double max) {
		this.max = max;
	}
	public Double getMin() {
		return min;
	}
	public void setMin(Double min) {
		this.min = min;
	}
	
	
	
}
