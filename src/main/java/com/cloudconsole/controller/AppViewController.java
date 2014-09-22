package com.cloudconsole.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AppViewController {
	
private static final Logger logger = LoggerFactory.getLogger(AppViewController.class);
	
	@RequestMapping(value = "/appView", method = RequestMethod.GET)
	public String appView(Locale locale, Model model){
		logger.info("CloudFoundry APP View INFO.", locale);
		
		
		
		return "appView";
	}

}