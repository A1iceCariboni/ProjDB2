package it.polimi.telcoserviceweb.controllers;

import it.polimi.telcoserviceejb.entities.*;
import it.polimi.telcoserviceejb.services.*;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/Home")
public class GoToHomePage extends HttpServlet {
    private static final long serialVersionUID = 4305243484881868983L;
    private TemplateEngine templateEngine;

    @EJB(name = "it.polimi.telcoserviceejb.entities.OptionalProductService")
    private OptionalProductService opService;
    @EJB(name = "it.polimi.telcoserviceejb.entities.ValidityPeriodService")
    private ValidityPeriodService validityPeriodService;
    @EJB(name = "it.polimi.telcoserviceejb.entities.ServiceService")
    private ServiceService serviceService;
    @EJB(name = "it.polimi.telcoserviceejb.entities.ServicePackageService")
    private ServicePackageService servicePackageService;
    @EJB(name = "it.polimi.telcoserviceejb.entities.OrderService")
    private OrderService orderService;
    @EJB(name = "it.polimi.telcoserviceejb.entities.UserService")
    private UserService userService;

    public GoToHomePage() {
        super();
    }

    public void init() throws ServletException {
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        this.templateEngine = new TemplateEngine();
        this.templateEngine.setTemplateResolver(templateResolver);
        templateResolver.setSuffix(".html");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        List<Order> suspendedOrders = null;

        if (user != null) {
            try {
                suspendedOrders = orderService.getSuspendedByUser(user.getId());
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Not possible to get data");
            }

        }
        List<OptionalProduct> ops = null;
        List<ValidityPeriod> validityPeriods = null;
        List<Service> services = null;
        List<ServicePackage> servicePackages = null;
        try {
            ops = opService.getAllOptionalProduct();
            validityPeriods = validityPeriodService.getAllValidityPeriod();
            services = serviceService.getAllServices();
            servicePackages = servicePackageService.getAllServicePackage();
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Not possible to get data");
            return;
        }

        // update of the user session attribute
        if (user != null) {
            request.getSession().setAttribute("user", userService.findUserByUsername(user.getUsername()));
            System.out.println(user);
        }

        String path = "/WEB-INF/Home.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("ops", ops);
        ctx.setVariable("val_pers", validityPeriods);
        ctx.setVariable("services", services);
        ctx.setVariable("service_packages", servicePackages);
        ctx.setVariable("suspended", suspendedOrders);
        templateEngine.process(path, ctx, response.getWriter());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    public void destroy() {
    }


}
