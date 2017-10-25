package com.oney.archi.webservice.web.filter;

import java.io.IOException;
import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.MDC;


/**
 * Cleanup MDC after a request ends.
 */
public class MDCFilter
    implements Filter
{
    private final AtomicLong seq = new AtomicLong();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException
    {
        // Nothing to do
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException
    {
        MDC.clear(); // Not really necessary, but better safe that sorry

        insertIntoMDC(request);
        try {
            chain.doFilter(request, response);
        } finally {
            MDC.clear();
        }
    }

    private void insertIntoMDC(ServletRequest request)
    {
        MDC.put("req.sequence", String.valueOf(seq.incrementAndGet()));

        if(request instanceof HttpServletRequest) {
            HttpServletRequest httpReq = (HttpServletRequest)request;
            MDC.put("req.clientHost", httpReq.getRemoteHost());

            HttpSession session = httpReq.getSession(false);
            if(session != null) {
                MDC.put("req.session", session.getId());
            }
        }
    }

    @Override
    public void destroy()
    {
        // Nothing to do
    }
}
