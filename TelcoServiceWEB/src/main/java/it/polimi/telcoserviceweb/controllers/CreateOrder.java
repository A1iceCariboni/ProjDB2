package it.polimi.telcoserviceweb.controllers;

import it.polimi.telcoserviceejb.entities.User;
import it.polimi.telcoserviceejb.services.*;
import org.apache.commons.lang.StringEscapeUtils;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/CreateOrder")
public class CreateOrder extends HttpServlet {
    private static final long serialVersionUID = 2581016315576984824L;
    private TemplateEngine templateEngine;
    @EJB(name = "it.polimi.telcoserviceejb.entities.OrderService")
    private OrderService orderService;
    @EJB(name = "it.polimi.telcoserviceejb.entities.ServicePackageService")
    private ServicePackageService servicePackageService;
    @EJB(name = "it.polimi.telcoserviceejb.entities.ServiceService")
    private ServiceService serviceService;
    @EJB(name = "it.polimi.telcoserviceejb.entities.ValidityPeriodService")
    private ValidityPeriodService validityPeriodService;
    @EJB(name = "it.polimi.telcoserviceejb.entities.OptionalProductService")
    private OptionalProductService opService;

    public CreateOrder() {
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
        User user = null;
        Integer id_service_package = null;
        Integer id_validity_period = null;
        List<Integer> ids_optional_product = null;
        try {
            System.out.println(request.getParameter("sp"));
            id_service_package = Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("sp")));

            System.out.println(request.getParameter("vp"));
            id_validity_period = Integer.parseInt(StringEscapeUtils.escapeJava(request.getParameter("vp")));

            System.out.println(request.getParameter("ops"));
            if (request.getParameter("ops") == null || request.getParameter("ops").equals("null")) {
                ids_optional_product = new ArrayList<>();
            } else {
                ids_optional_product = Arrays.stream(request.getParameterValues("ops")).map(Integer::parseInt).collect(Collectors.toList());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Empty fields");
            return;
        }

        Cookie c_sp = new Cookie("sp", id_service_package.toString());
        Cookie c_vp = new Cookie("vp", id_validity_period.toString());
        Cookie c_op = new Cookie("op", ids_optional_product.toString());

        response.addCookie(c_sp);
        response.addCookie(c_vp);
        response.addCookie(c_op);

        String path;
        path = getServletContext().getContextPath() + "/Confirmation";
        response.sendRedirect(path);
        // TODO: create order in waiting state? cookie solo per non loggati.
        //  distingui casi in CONFIRMATION e fai fare solo pagamenti in confirmation oppure
        //  redirect alla pagina di login
    }

    public void destroy() {
    }

}