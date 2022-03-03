package it.polimi.telcoserviceweb.controllers;

import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.entities.Service;
import it.polimi.telcoserviceejb.entities.ServicePackage;
import it.polimi.telcoserviceejb.entities.ValidityPeriod;
import it.polimi.telcoserviceejb.services.OptionalProductService;
import it.polimi.telcoserviceejb.services.ServicePackageService;
import it.polimi.telcoserviceejb.services.ServiceService;
import it.polimi.telcoserviceejb.services.ValidityPeriodService;
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


//TODO per order inserire solo id_user , id_service_package, id_validity_period, star_date_subscription
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
        List<OptionalProduct> ops = null;
        List<ValidityPeriod> validityPeriods = null;
        List<Service> services = null;
        List<ServicePackage> servicePackages = null;
        try{
            ops = opService.getAllOptionalProduct();
            validityPeriods = validityPeriodService.getAllValidityPeriod();
            services = serviceService.getAllServices();
            servicePackages = servicePackageService.getAllServicePackage();
        }catch(Exception e){
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Not possible to get data");
            return;
        }

        String path = "/WEB-INF/Home.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("ops", ops);
        ctx.setVariable("val_pers", validityPeriods);
        ctx.setVariable("services", services);
        ctx.setVariable("service_packages", servicePackages);
        templateEngine.process(path, ctx, response.getWriter());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    public void destroy() {
    }



}
