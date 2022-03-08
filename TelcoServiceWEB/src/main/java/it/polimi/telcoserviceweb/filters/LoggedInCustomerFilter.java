package it.polimi.telcoserviceweb.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter({"/GetOrders", "/RetryPayment"})
public class LoggedInCustomerFilter implements Filter {

    private ServletContext context;

    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("LoggedInCustomerFilter: init START");
        Filter.super.init(filterConfig);
        System.out.println("LoggedInCustomerFilter: init END");
    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;
        System.out.println("LoggedInCustomerFilter: doFilter START - " + req.getRequestURI());

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            System.out.println("Unauthorized request");
            res.sendRedirect("index.html");
        } else {
            // pass the request along the filter chain
            filterChain.doFilter(servletRequest, servletResponse);
        }

        System.out.println("LoggedInCustomerFilter: doFilter STOP");
    }

    public void destroy() {
        Filter.super.destroy();
    }

}