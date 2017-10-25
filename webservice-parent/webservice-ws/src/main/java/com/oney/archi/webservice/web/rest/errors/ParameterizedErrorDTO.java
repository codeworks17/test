package com.oney.archi.webservice.web.rest.errors;

import java.io.Serializable;

/**
 * DTO for sending a parameterized error message.
 */
public class ParameterizedErrorDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    private final String message;
    private final String[] params;

    public ParameterizedErrorDTO(String message, String[] params) {
        this.message = message;
        if (params!=null){
        	this.params = (String[]) params.clone();
        } else {
        	this.params=null;
        }
    }

    public String getMessage() {
        return message;
    }

    public String[] getParams() {
        return (String[]) params.clone() ;
    }

}
