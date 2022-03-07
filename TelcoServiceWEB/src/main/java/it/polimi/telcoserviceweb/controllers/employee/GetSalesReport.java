package it.polimi.telcoserviceweb.controllers.employee;

import it.polimi.telcoserviceejb.entities.*;
import it.polimi.telcoserviceejb.exceptions.ReportException;
import it.polimi.telcoserviceejb.services.*;
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
    @EJB(name = "it.polimi.expensemanagmentejb.services/UserService")
    private UserService userService;
    @EJB(name = "it.polimi.expensemanagmentejb.services/OrderService")
    private OrderService orderService;
    @EJB(name = "it.polimi.expensemanagmentejb.services/AlertService")
    private AlertService alertService;
    @EJB(name = "it.polimi.expensemanagmentejb.services/OptionalProductService")
    private OptionalProductService optionalProductService;


    public GetSalesReport() {
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
        // checking if logged as employee
        if(request.getSession().getAttribute("employee") == null){
            response.sendRedirect(request.getServletContext().getContextPath() + "/index.html");
            return;
        }

        List<ServicePackage> servicePackages = null;
        try {
            servicePackages = servicePackageService.getAllServicePackage();
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            return;
        }

        String path = "/WEB-INF/SalesReports.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("service_packages", servicePackages);
        ctx.setVariable("rep_1", 0);
        ctx.setVariable("rep_2", 0);
        ctx.setVariable("rep_3", 0);
        ctx.setVariable("rep_4", 0);
        ctx.setVariable("rep_5", 0);
        loadData(response, ctx);
        templateEngine.process(path, ctx, response.getWriter());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String reportType = null;
        Long rep_1 = 0L;
        Integer rep_2 = 0;
        Double rep_3 = (double) 0, rep_4 = (double) 0, rep_5 = (double) 0;
        List<ServicePackage> servicePackages = null;

        // checking if logged as employee
        if(request.getSession().getAttribute("employee") == null){
            response.sendRedirect(request.getServletContext().getContextPath() + "/index.html");
            return;
        }

        try {
            servicePackages = servicePackageService.getAllServicePackage();
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            return;
        }
        reportType = StringEscapeUtils.escapeJava(request.getParameter("reportType"));

        Integer idPurch = null;
        try {
            idPurch = Integer.parseInt(request.getParameter("sp"));
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "not int id for service package");
            return;
        }
        switch (reportType) {
            case "NumberPurchForPack":
                try {
                    rep_1 = salesReportService.getTotalPurchasePerPackage(idPurch);
                } catch (ReportException e) {
                    response.sendError(HttpServletResponse.SC_PRECONDITION_FAILED, "Not existent service package");
                    return;
                }
                break;
            case "NumberPurchForPackAndVP":
                Integer idVP = null;
                try {
                    idVP = Integer.parseInt(request.getParameter("vp"));
                } catch (Exception e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Empty fields");
                    return;
                }
                try {
                    rep_2 = salesReportService.getTotalPurchasePerPackageAndVP(idPurch, idVP);
                } catch (ReportException e) {
                    response.sendError(HttpServletResponse.SC_PRECONDITION_FAILED, e.getMessage());
                    return;
                }
                break;
            case "ValuePurchForPack":
                try {
                    rep_3 = salesReportService.getValueNoOptionalProducts(idPurch);
                    rep_4 = salesReportService.getValueWithOptionalProducts(idPurch);
                } catch (ReportException e) {
                    response.sendError(HttpServletResponse.SC_PRECONDITION_FAILED, e.getMessage());
                    return;
                }
                break;

            case "AvgOptProd":
                try {
                    rep_5 = salesReportService.getAvgOptProduct(idPurch);
                } catch (ReportException e) {
                    response.sendError(HttpServletResponse.SC_PRECONDITION_FAILED, e.getMessage());
                    return;
                }
                break;
        }

        String path = "/WEB-INF/SalesReports.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("rep_1", rep_1);
        ctx.setVariable("rep_2", rep_2);
        ctx.setVariable("rep_3", rep_3);
        ctx.setVariable("rep_4", rep_4);
        ctx.setVariable("rep_5", rep_5);
        loadData(response, ctx);
        ctx.setVariable("service_packages", servicePackages);

        templateEngine.process(path, ctx, response.getWriter());
    }

    private void loadData(HttpServletResponse response, WebContext ctx) throws IOException {
        try {
            ctx.setVariable("insolvents", userService.getInsolvents());
            System.out.println("Users: " + userService.getInsolvents());
            ctx.setVariable("rejected", orderService.getSuspended());
            ctx.setVariable("alerts", alertService.getAllAlerts());
            ctx.setVariable("bestseller", optionalProductService.getBestSellers());
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Not possible to get data");
        }
    }
}
