package it.polimi.telcoserviceweb.controllers.employee;

import it.polimi.telcoserviceejb.entities.ValidityPeriod;
import it.polimi.telcoserviceejb.exceptions.ServiceException;
import it.polimi.telcoserviceejb.services.EmployeeService;
import it.polimi.telcoserviceejb.services.ServicePackageService;
import org.apache.commons.lang.StringEscapeUtils;
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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@WebServlet("/CreateServicePackage")
public class CreateServicePackage extends HttpServlet {
    private static final long serialVersionUID = 2712769104951967691L;
    private TemplateEngine templateEngine;
    @EJB(name = "it.polimi.expensemanagmentejb.services/ServicePackageService")
    private ServicePackageService servicePackageService;

    public CreateServicePackage() {
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = null;
        List<Integer> validity_periods_ids = null;
        List<Integer> optional_products_ids = null;
        List<Integer> services_ids = null;

        try {
            name = StringEscapeUtils.escapeJava(request.getParameter("name"));
            validity_periods_ids = Arrays.stream(request.getParameterValues("vp")).map(Integer::parseInt).collect(Collectors.toList());
            if(request.getParameter("ops") != null) {
                optional_products_ids = Arrays.stream(request.getParameterValues("ops")).map(Integer::parseInt).collect(Collectors.toList());
            }else{
                optional_products_ids = new ArrayList<>();
            }
            services_ids = Arrays.stream(request.getParameterValues("servs")).map(Integer::parseInt).collect(Collectors.toList());

            if (name == null || name.isEmpty() || validity_periods_ids.isEmpty() || services_ids.isEmpty()) {
                throw new Exception("Missing or empty fields");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
            return;
        }

        try {
            servicePackageService.createServicePackage(name, validity_periods_ids, optional_products_ids, services_ids);
        } catch (ServiceException e) {
            response.sendError(HttpServletResponse.SC_PRECONDITION_FAILED, e.getMessage());
            return;
        }

        String path;
        path = getServletContext().getContextPath() + "/GoToHomeEmp";
        response.sendRedirect(path);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path;
        path = getServletContext().getContextPath() + "/GoToHomeEmp";
        response.sendRedirect(path);
    }

    public void destroy() {
    }
}
