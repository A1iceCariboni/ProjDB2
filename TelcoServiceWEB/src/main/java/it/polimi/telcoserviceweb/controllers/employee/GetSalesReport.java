package it.polimi.telcoserviceweb.controllers.employee;

import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.entities.Service;
import it.polimi.telcoserviceejb.entities.ServicePackage;
import it.polimi.telcoserviceejb.entities.ValidityPeriod;
import it.polimi.telcoserviceejb.exceptions.ReportException;
import it.polimi.telcoserviceejb.services.SalesReportService;
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
import java.util.List;

@WebServlet("/GetSalesReport")
public class GetSalesReport extends HttpServlet {

    private static final long serialVersionUID = 6220881715273361975L;
    private TemplateEngine templateEngine;
    @EJB(name = "it.polimi.expensemanagmentejb.services/ServicePackageService")
    private ServicePackageService servicePackageService;

    @EJB(name = "it.polimi.expensemanagmentejb.services/SalesReportService")
    private SalesReportService salesReportService;


    public GetSalesReport(){super();}

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
        List<ServicePackage> servicePackages = null;
        try {
            servicePackages = servicePackageService.getAllServicePackage();
        }catch(Exception e){
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Not possible to get data");
            return;
        }

        String path = "/WEB-INF/SalesReports.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("service_packages", servicePackages);
        ctx.setVariable("res", 0);

        templateEngine.process(path, ctx, response.getWriter());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String reportType = null;
        Long res = Long.valueOf(0);
        List<ServicePackage> servicePackages = null;

        try {
            servicePackages = servicePackageService.getAllServicePackage();
        }catch(Exception e){
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Not possible to get data");
            return;
        }
        reportType = StringEscapeUtils.escapeJava(request.getParameter("reportType"));

        switch(reportType) {
            case "NumberPurchForPack":
                Integer id = null;
                try {
                    id = Integer.parseInt(request.getParameter("pcks"));
                    if (id == null) {
                        throw new Exception("Missing or empty fields");
                    }
                } catch (Exception e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Empty fields");
                    return;
                }
                try {
                    res = salesReportService.getTotalPurchasePerPackage(id);
                } catch (ReportException e) {
                    response.sendError(HttpServletResponse.SC_PRECONDITION_FAILED, "Not existent service package");
                    return;
                }
            case "NumberPurchForPackAndVP":
                Integer idPurch = null;
                Integer idVP = null;
                try {
                    idPurch = Integer.parseInt(request.getParameter("pcks"));

                    if (idPurch == null) {
                        throw new Exception("Missing or empty fields");
                    }
                } catch (Exception e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Empty fields");
                    return;
                }
        }

        String path = "/WEB-INF/SalesReports.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("res", res);
        ctx.setVariable("service_packages", servicePackages);

        templateEngine.process(path, ctx, response.getWriter());
    }



    public void destory(){}
}
