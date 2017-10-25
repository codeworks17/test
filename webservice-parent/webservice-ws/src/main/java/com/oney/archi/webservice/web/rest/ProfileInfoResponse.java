package com.oney.archi.webservice.web.rest;

/**
 * 
 * @author gekarpinski
 *
 */
class ProfileInfoResponse {

	private String[] activeProfiles;
	private String ribbonEnv;

	/**
	 * 
	 * @param activeProfiles
	 * @param ribbonEnv
	 */
	ProfileInfoResponse(String[] activeProfiles, String ribbonEnv) {
		this.activeProfiles = activeProfiles;
		this.ribbonEnv = ribbonEnv;
	}

	/**
	 * 
	 * @return
	 */
	public String[] getActiveProfiles() {
		return activeProfiles;
	}

	/**
	 * 
	 * @param activeProfiles
	 */
	public void setActiveProfiles(String[] activeProfiles) {
		this.activeProfiles = activeProfiles;
	}

	/**
	 * 
	 * @return
	 */
	public String getRibbonEnv() {
		return ribbonEnv;
	}

	/**
	 * 
	 * @param ribbonEnv
	 */
	public void setRibbonEnv(String ribbonEnv) {
		this.ribbonEnv = ribbonEnv;
	}
	
}