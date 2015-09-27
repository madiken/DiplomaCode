package com.spring.mvc.web;

import com.spring.mvc.domainClasses.Substance;
import com.spring.mvc.service.SubstanceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class listOfSubstanceController {
	
	@Autowired(required=true)
	private SubstanceService substanceService;
	
	@RequestMapping(value="/substances", method=RequestMethod.GET)
	public String listOfSubstance (Model uiModel) {
		
		List <Substance> substances = substanceService.findAllSubstances();
		System.out.println("list of substances controller");
		System.out.println(substances.size());
		uiModel.addAttribute("subtances", substances);
		
		return "substances/listOfSubstance";
		
	}	
}

