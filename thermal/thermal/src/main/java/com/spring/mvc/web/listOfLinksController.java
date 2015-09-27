package com.spring.mvc.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.mvc.domainClasses.Link;
import com.spring.mvc.service.LinkService;

@Controller
public class listOfLinksController {
	@Autowired(required=true)
	private LinkService linkService;
	
	@RequestMapping(value="/links", method=RequestMethod.GET)
	public String listOfData (Model uiModel){//, @PathVariable(value="subst_id") Long id) {
		
		List<Link> links = linkService.findAllLinks();
	
		uiModel.addAttribute("links", links);
		return "links/listOfLinks";
		
	}
	
}
