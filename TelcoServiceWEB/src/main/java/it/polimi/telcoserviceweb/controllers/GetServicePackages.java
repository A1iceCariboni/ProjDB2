package it.polimi.telcoserviceweb.controllers;

import com.google.gson.Gson;
import it.polimi.telcoserviceejb.entities.ServicePackage;
import it.polimi.telcoserviceejb.exceptions.ServiceException;
import it.polimi.telcoserviceejb.services.ServicePackageService;
import org.thymeleaf.TemplateEngine;
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


@WebServlet("/GetServicePackages")
public class GetServicePackages extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TemplateEngine templateEngine = new TemplateEngine();

    @EJB(name = "it.polimi.telcoserviceejb.entities.ServicePackageService")
    private ServicePackageService servicePackageService;

    public void init() throws ServletException {
        ServletContext servletContext = getServletContext();
        ServletContextTemplateResolver templateResolver = new ServletContextTemplateResolver(servletContext);
        templateResolver.setTemplateMode(TemplateMode.HTML);
        this.templateEngine = new TemplateEngine();
        this.templateEngine.setTemplateResolver(templateResolver);
        templateResolver.setSuffix(".html");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServicePackage servicePackage = null;
        String id_sp = request.getParameter("id_service_package");

            if (id_sp != null && !id_sp.isEmpty()) {
                servicePackage = servicePackageService.getServicePackageById(Integer.parseInt(id_sp));
            }

        System.out.println(servicePackage);

        try {

            System.out.println((new Gson()).toJson(servicePackage));
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().println((new Gson()).toJson(servicePackage));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}