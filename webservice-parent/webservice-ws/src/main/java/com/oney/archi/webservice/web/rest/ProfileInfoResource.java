package com.oney.archi.webservice.web.rest;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.oney.archi.webservice.config.JHipsterProperties;

@RestController
@RequestMapping("/api")
public class ProfileInfoResource {

    @Inject
    Environment env;

    @Inject
    private JHipsterProperties jHipsterProperties;

    @RequestMapping("/profile-info")
    public ProfileInfoResponse getActiveProfiles() {
        return new ProfileInfoResponse(env.getActiveProfiles(), getRibbonEnv());
    }

    private String getRibbonEnv() {
        String[] activeProfiles = env.getActiveProfiles();
        String[] displayOnActiveProfiles = jHipsterProperties.getRibbon().getDisplayOnActiveProfiles();

        if (displayOnActiveProfiles != null) {
	        List<String> ribbonProfiles = new ArrayList<>(Arrays.asList(displayOnActiveProfiles));
	        List<String> springBootProfiles = Arrays.asList(activeProfiles);
	        ribbonProfiles.retainAll(springBootProfiles);
	
	        if (!ribbonProfiles.isEmpty()) {
	            return ribbonProfiles.get(0);
	        }
        }
        return null;
    }
}
