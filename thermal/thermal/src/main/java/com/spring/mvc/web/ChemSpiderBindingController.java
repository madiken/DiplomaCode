package com.spring.mvc.web;

import helpers.ChemSpiderInfo;
import helpers.ChemSpiderInfoHelper;
import helpers.Constants;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.mvc.domainClasses.ExternalResource;
import com.spring.mvc.domainClasses.LODDataSource;
import com.spring.mvc.domainClasses.Link;
import com.spring.mvc.domainClasses.Predicate;
import com.spring.mvc.domainClasses.Substance;
import com.spring.mvc.service.ExternalResourceService;
import com.spring.mvc.service.LODDataSourceService;
import com.spring.mvc.service.LinkService;
import com.spring.mvc.service.PredicateService;
import com.spring.mvc.service.SubstanceService;

@Controller
public class ChemSpiderBindingController {
	@Autowired(required=true)
	private SubstanceService substanceService;
	@Autowired(required=true)
	private LinkService linkService;
	@Autowired(required=true)
	private ExternalResourceService externalResourceService;
	@Autowired(required=true)
	private PredicateService predicateService;
	@Autowired(required=true)
	private LODDataSourceService lodDataSourceService;
	
	@RequestMapping(value="/chemspiderbinding/{id}", method=RequestMethod.GET)
	public String listOfChemSpiderSubstances (Model uiModel, @PathVariable(value="id") Long id) {
		Substance subst = substanceService.findSusbtById(id);
		String formula = subst.getSubst_formula();
		List<ChemSpiderInfo> infos = new ArrayList<>();
		try {
			infos.addAll(ChemSpiderInfoHelper.getInfoListByFormula(formula));
		
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		uiModel.addAttribute("chemSpiderInfo", new ChemSpiderInfo());
		uiModel.addAttribute("substance", subst);
		uiModel.addAttribute("infos", infos);
		return "links/bindToChemSpider";
	}
	
	
	@RequestMapping(value="/chemspiderbinding/{id}", method=RequestMethod.POST)
	public String makeBinding (Model uiModel, @PathVariable(value="id") Long id, @ModelAttribute("chemSpiderInfo") ChemSpiderInfo info, @RequestParam String action) {
		Substance subst = substanceService.findSusbtById(id);
		
		if (("Cancel".equals(action)) || (info == null) || (info.getChemSpiderUri() == null ) || (info.getChemSpiderUri().isEmpty()))
			return "redirect:/data/"+subst.getName()+"/"+subst.getId()+"";
		else if ("Bind".equals(action)){
		    //System.out.println("binding!!");
			
			//remove old links and corresponding resources
			List<Link> links = linkService.findLinksBySubstanceAndDatasource(id, Constants.CHEMSPIDER_DATASOURCE);
			for(Link l : links){
				ExternalResource er = l.getExternalResource();
				linkService.deleteLink(l);
				externalResourceService.deleteExternalResource(er);
			}
			Link newLink = new Link();
			
			LODDataSource chemSpider = lodDataSourceService.getLODDataSourceById(Constants.CHEMSPIDER_DATASOURCE);
			ExternalResource er = new ExternalResource();
			er.setUri(info.getChemSpiderUri());
			er.setDatasource(chemSpider);
			externalResourceService.saveExternalResource(er);
			//er.set
			Predicate sameAs = predicateService.getPredicateById(Constants.SAMEAS_PREDICATE);
			newLink.setSubstance(subst);
			newLink.setPredicate(sameAs);
			newLink.setExternalResource(er);
			linkService.saveLink(newLink);
		}
		//return to listOfData
		return "redirect:/data/"+subst.getName()+"/"+subst.getId()+"";
	}
	
	
	
	@RequestMapping(value="/removebinding/{id}", method=RequestMethod.GET)
	public String removeBinding (Model uiModel, @PathVariable(value="id") Long id, @ModelAttribute("chemSpiderInfo") ChemSpiderInfo info) {
		Substance subst = substanceService.findSusbtById(id);
		
		//remove old links
		// TODO : add data source table
		List<Link> links = linkService.findLinksBySubstanceAndDatasource(id, Constants.CHEMSPIDER_DATASOURCE);
		for(Link l : links){
			ExternalResource er = l.getExternalResource();
			linkService.deleteLink(l);
			externalResourceService.deleteExternalResource(er);
		}
			
		//return to listOfData
		return "redirect:/data/"+subst.getName()+"/"+subst.getId()+"";
	}
	
	
}
