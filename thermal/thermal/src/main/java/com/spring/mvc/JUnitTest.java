package com.spring.mvc;

import com.spring.mvc.domainClasses.Constants_of_Substance;
import com.spring.mvc.domainClasses.Data;
import com.spring.mvc.domainClasses.Property;
import com.spring.mvc.domainClasses.Substance;
import com.spring.mvc.service.Constants_of_SubstanceService;
import com.spring.mvc.service.DataService;
import com.spring.mvc.service.PropertyService;
import com.spring.mvc.service.SubstanceService;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:META-INF/spring/root-context.xml",
		"classpath:META-INF/hibernate.cfg.xml"})

public class JUnitTest {
	
	@Autowired
    private SubstanceService substanceService;
	@Autowired
    private Constants_of_SubstanceService constants_of_substanceService;
	@Autowired
	private DataService dataService;
	@Autowired
	private PropertyService propertyService;
	
    //test for get all substances
	@Test
    public void testSearchALLSubstance() throws Exception {
        List<Substance> substances = substanceService.findAllSubstances();
        assertEquals(9, substances.size());
        for (int i = 0; i < substances.size(); i++) {
        	//System.out.println(substances.get(i).getId());     
        }
    }
    
    @Test
    public void testSearchSubstanceByName() throws Exception {
        List<Substance> substances = substanceService.findSubstancesByName("Ozone");
        assertEquals(2, substances.size());
        assertEquals("Ozone", substances.iterator().next().getName());
    }
    
    @Test
    public void testGetSusbtanceById () throws Exception {
    	Substance subst = substanceService.findSusbtById((long)30);
    	System.out.println(subst);
    	System.out.println("_________________");
    }
    
    //test for get all constants of substance
    @Test
    public void testSearchALLConstants() throws Exception {
        List<Constants_of_Substance> constants = constants_of_substanceService.findAllConstants_of_Substances();
        assertEquals(21, constants.size());
        for (int i = 0; i < constants.size(); i++) {
        	System.out.println(constants.get(i).getUncertainty().getName()+" "+constants.get(i).getId());	
        }
    }
    
  	@Test
    public void testSearchConstantsBySubst_id() throws Exception {
    	List<Constants_of_Substance> constants = constants_of_substanceService.findConstants_of_SubstanceBySubst_id((long) 30);
    	for (int i = 0; i<constants.size(); i++) {
    		System.out.println(constants.get(i).getProperty().getProp_designation()+" "+constants.get(i).getValue());
    	}
    }
  	
    //test for get Oxygen data
  	@Test
  	public void testSearchDataBySubst_id() throws Exception {
    	List<Data> dates = dataService.findDataBySubst_Id((long) 30, (long) 14);
    	for (int i = 0; i<dates.size(); i++) {
    		System.out.println(dates.get(i).getValue());
    	}
    }
  	
  	//test for get Property
  	@Test
  	public void testSearchPropertyBySubst_id() throws Exception {
  		List<Property> props = propertyService.findPropertyBySubstance((long) 30);
  		
  		int size = props.size();
		
		@SuppressWarnings("unchecked")
		ArrayList<Data>[] dates = new ArrayList[size];
		
		for (int i = 0; i<size; i++) {
			dates[i] = (ArrayList<Data>) dataService.findDataBySubst_Id((long) 30, (long) props.get(i).getId());
		}
		
		for (int i = 0; i<size-1; i++) {
			
			System.out.println(dates[i].get(0).getProperty().getProp_designation() + " " + dates[i+1].get(0).getData_Source().getName());
			for (int j = 0; j < dates[i].size(); j++){
				System.out.println(dates[i].get(j).getValue() + " " + dates[i+1].get(j).getValue());
  			}
  		}
  	}
}
