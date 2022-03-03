package it.polimi.telcoserviceweb.controllers;

import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.entities.ServicePackage;
import it.polimi.telcoserviceejb.entities.User;
import it.polimi.telcoserviceejb.entities.ValidityPeriod;
import it.polimi.telcoserviceejb.exceptions.ProductException;
import it.polimi.telcoserviceejb.exceptions.ServiceException;
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
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/Confirmation")
public class Confirmation extends HttpServlet {
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
    private OptionalProductService optionalProductService;

    public Confirmation() {
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
            id_service_package = Integer.parseInt(Arrays.stream(request.getCookies())
                    .filter(cookie -> cookie.getName().equals("sp")).collect(Collectors.toList()).get(0).getValue());
            id_validity_period = Integer.parseInt(Arrays.stream(request.getCookies())
                    .filter(cookie -> cookie.getName().equals("vp")).collect(Collectors.toList()).get(0).getValue());
            ids_optional_product = Arrays.stream(Arrays.stream(request.getCookies())
                            .filter(cookie -> cookie.getName().equals("op")).collect(Collectors.toList()).get(0).getValue()
                            .replaceAll("\\[", "").replaceAll("]", "").split(", ")).filter(x -> !x.equals(""))
                    .map(Integer::parseInt).collect(Collectors.toList());

            user = (User) request.getSession().getAttribute("user");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Empty fields");
            return;
        }

        if (user == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "You have to be logged to make an order!");
            return;
        }

        try {
            orderService.createOrder(request.getParameter("status_payment"), user.getId(), id_service_package, id_validity_period, ids_optional_product);
        } catch (ServiceException e) {
            response.sendError(HttpServletResponse.SC_PRECONDITION_FAILED, "Can't create order");
            return;
        }

        String path;
        path = getServletContext().getContextPath() + "/Confirmation";
        response.sendRedirect(path);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = null;
        Integer id_service_package = null;
        Integer id_validity_period = null;
        List<Integer> ids_optional_product = null;

        // getting the order infos
        id_service_package = Integer.parseInt(Arrays.stream(request.getCookies())
                .filter(cookie -> cookie.getName().equals("sp")).collect(Collectors.toList()).get(0).getValue());
        id_validity_period = Integer.parseInt(Arrays.stream(request.getCookies())
                .filter(cookie -> cookie.getName().equals("vp")).collect(Collectors.toList()).get(0).getValue());
        ids_optional_product = Arrays.stream(Arrays.stream(request.getCookies())
                        .filter(cookie -> cookie.getName().equals("op")).collect(Collectors.toList()).get(0).getValue()
                        .replaceAll("\\[", "").replaceAll("]", "").split(", ")).filter(x -> !x.equals(""))
                .map(Integer::parseInt).collect(Collectors.toList());

        user = (User) request.getSession().getAttribute("user");


        String path = "/WEB-INF/Confirmation.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        try {
            ServicePackage servicePackage = servicePackageService.getServicePackageById(id_service_package);
            ValidityPeriod validityPeriod = validityPeriodService.getValidityPeriodById(id_validity_period);
            List<OptionalProduct> optionalProducts = ids_optional_product.stream().map(id -> {
                try {
                    return (OptionalProduct) optionalProductService.getOptionalProductById(id);
                } catch (ProductException e) {
                    e.printStackTrace();
                }
                return (OptionalProduct) null;
            }).collect(Collectors.toList());
            Integer total_amount = validityPeriod.getMonths() * (
                    validityPeriod.getFee() +
                            optionalProducts.stream().map(OptionalProduct::getMonthlyFee).reduce(0, Integer::sum)
            );

            // TODO add date of subscription
            ctx.setVariable("service_package", servicePackage);
            ctx.setVariable("validity_period", validityPeriod);
            ctx.setVariable("optional_products", optionalProducts);
            ctx.setVariable("total_amount", total_amount);
        } catch (ServiceException e) {
            e.printStackTrace();
        }
        templateEngine.process(path, ctx, response.getWriter());
    }

    public void destroy() {
    }

}