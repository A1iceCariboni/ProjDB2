package it.polimi.telcoserviceweb.filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({"/AddOptionalProduct",
        "/CreateServicePackage",
        "/GetSalesReport",
        "/GoToHomeEmp"})
public class LoggedInEmployeeFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("LoggedInEmployeeFilter: init START");
        Filter.super.init(filterConfig);
        System.out.println("LoggedInEmployeeFilter: init END");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;
        System.out.println("LoggedInEmployeeFilter: doFilter START - " + req.getRequestURI());

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("employee") == null) {
            System.out.println("Unauthorized request!");
            res.sendRedirect(req.getServletContext().getContextPath() + "/CheckLoginEmployee");
        } else {
            // pass the request along the filter chain
            filterChain.doFilter(servletRequest, servletResponse);
        }

        System.out.println("LoggedInEmployeeFilter: doFilter STOP");
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
