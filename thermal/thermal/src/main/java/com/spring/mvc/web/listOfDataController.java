package com.spring.mvc.web;

import helpers.ChemSpiderInfo;
import helpers.ChemSpiderInfoHelper;
import helpers.Constants;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.mvc.domainClasses.Constants_of_Substance;
import com.spring.mvc.domainClasses.Data;
import com.spring.mvc.domainClasses.Link;
import com.spring.mvc.domainClasses.Property;
import com.spring.mvc.service.Constants_of_SubstanceService;
import com.spring.mvc.service.DataService;
import com.spring.mvc.service.LinkService;
import com.spring.mvc.service.PropertyService;

@Controller
public class listOfDataController {
	
	@Autowired(required=true)
	private Constants_of_SubstanceService constants_of_substanceService;
	@Autowired(required=true)
	private DataService dataService;
	@Autowired(required=true)
	private PropertyService propertyService;
	@Autowired(required=true)
	private LinkService linkService;
	
	@RequestMapping(value="/data/{subst_name}/{id}", method=RequestMethod.GET)
	public String listOfData (Model uiModel, @PathVariable(value="id") Long id, @PathVariable(value="subst_name") String subst_name) {
		List<Link> links = linkService.findLinksBySubstanceAndDatasource(((long)id), Constants.CHEMSPIDER_DATASOURCE);
		
		
		List<Constants_of_Substance> constants = constants_of_substanceService.findConstants_of_SubstanceBySubst_id((long)id);
		List<Property> props = propertyService.findPropertyBySubstance((long) id);
		
		int size = props.size();
		
		@SuppressWarnings("unchecked")
		ArrayList<Data>[] dates = new ArrayList[size];
		
		for (int i = 0; i<props.size(); i++) {
			
			dates[i] = (ArrayList<Data>) dataService.findDataBySubst_Id((long) id, (long) props.get(i).getId());
		}
		uiModel.addAttribute("links", links);
		uiModel.addAttribute("constants", constants);
		uiModel.addAttribute("subst_name", subst_name);
		uiModel.addAttribute("subst_id", id);
		uiModel.addAttribute("props", props);
		uiModel.addAttribute("dates", dates);
		
		List<ChemSpiderInfo> infos = new ArrayList<>();
		for (Link l : links){
		 infos.add(ChemSpiderInfoHelper.getInfoByUri(l.getExternalResource().getUri()));
		}
		uiModel.addAttribute("infos", infos);
		
		return "data/listOfData";
		
	}
	
}
