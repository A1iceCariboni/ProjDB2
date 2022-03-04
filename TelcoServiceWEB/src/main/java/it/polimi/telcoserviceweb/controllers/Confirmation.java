package it.polimi.telcoserviceweb.controllers;

import it.polimi.telcoserviceejb.entities.*;
import it.polimi.telcoserviceejb.exceptions.ProductException;
import it.polimi.telcoserviceejb.exceptions.ServiceException;
import it.polimi.telcoserviceejb.services.*;
import org.apache.commons.lang.StringEscapeUtils;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import javax.ejb.EJB;
import javax.persistence.PersistenceException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
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
        // used in order to change status of the order
        // TODO: check for the owning of the order by the user issuing the payment
        final Map<String, Object> cookies = getOrderInfo(request);
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "You have to be logged to change an order!");
            return;
        }

        try {
            orderService.changeStatus(getIdFromCookie(request), request.getParameter("status_payment"));
        } catch (PersistenceException e) {
            response.sendError(HttpServletResponse.SC_PRECONDITION_FAILED, "Can't create order");
            return;
        }

        String path;
        path = getServletContext().getContextPath() + "/Confirmation";
        response.sendRedirect(path);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /* Accessed if:
         * - cookie order_to_see with id_order
         * - cookies of the partial order
         */
        User user = (User) request.getSession().getAttribute("user");
        Order order;

        try {
            if (user == null) {
                System.out.println("CONFIRMATION: not logged COOKIE");
                // if not logged
                order = generateOrderFromCookies(request);
            } else {
                // if logged
                try {
                    // when user did an order but wasn't logged
                    order = generateOrderFromCookies(request);
                    System.out.println("CONFIRMATION: logged and COOKIE");
                } catch (PersistenceException | IndexOutOfBoundsException e) {
                    // TODO: check for the owning of the order by the user issuing the payment
                    order = getOrderFromIdCookie(request);
                    System.out.println("CONFIRMATION: logged and ID");
                }
            }

            System.out.println(order);
        } catch (ServiceException | PersistenceException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No orders to show");
            return;
        }

        String path = "/WEB-INF/Confirmation.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());

        ctx.setVariable("order", order);

        /*ctx.setVariable("service_package", servicePackage);
        ctx.setVariable("validity_period", validityPeriod);
        ctx.setVariable("optional_products", optionalProducts);
        ctx.setVariable("start_date_subscription", cookies.get("start_date_subscription"));
        ctx.setVariable("total_amount", total_amount);*/
        templateEngine.process(path, ctx, response.getWriter());
    }

    public int getIdFromCookie(HttpServletRequest request){
        final int[] id_order = {0};
        Arrays.stream(request.getCookies()).forEach(cookie -> {
            if ("order_to_see".equals(cookie.getName())) {
                id_order[0] = Integer.parseInt(cookie.getValue());
            }
        });
        return id_order[0];
    }

    public Order getOrderFromIdCookie(HttpServletRequest request) throws PersistenceException, IndexOutOfBoundsException {
        System.out.println("getOrderFromIdCookie");
        return orderService.getOrderById(getIdFromCookie(request));
    }

    public Order generateOrderFromCookies(HttpServletRequest request) throws ServiceException {
        Map<String, Object> cookies = getOrderInfo(request);
        // retrieving data to show order
        User user = (User) request.getSession().getAttribute("user");
        ServicePackage servicePackage = servicePackageService.getServicePackageById((Integer) cookies.get("service_package"));
        ValidityPeriod validityPeriod = validityPeriodService.getValidityPeriodById((Integer) cookies.get("validity_period"));
        List<OptionalProduct> optionalProducts = new ArrayList<>();
        if (cookies.get("optional_products") != null) {
            optionalProducts = ((List<Integer>) cookies.get("optional_products")).stream().map(id -> {
                try {
                    return optionalProductService.getOptionalProductById(id);
                } catch (ProductException e) {
                    e.printStackTrace();
                }
                return null;
            }).collect(Collectors.toList());
        }
        float total_amount = validityPeriod.getMonths() * validityPeriod.getFee();
        for (OptionalProduct op : optionalProducts) {
            total_amount += validityPeriod.getMonths() * op.getMonthlyFee();
        }

        System.out.println("generateOrderFromCookies");
        return new Order(
                total_amount,
                "not_created",
                null,
                0,
                (Date) cookies.get("start_date_subscription"),
                null,
                user,
                servicePackage,
                validityPeriod,
                optionalProducts
        );
    }

    public Map<String, Object> getOrderInfo(HttpServletRequest request) {
        final Map<String, Object> cookies = new HashMap<>();

        // getting the order infos
        Arrays.stream(request.getCookies()).forEach(cookie -> {
            try {
                switch (cookie.getName()) {
                    case "sp":
                        cookies.put("service_package", Integer.parseInt(cookie.getValue()));
                        break;
                    case "vp":
                        cookies.put("validity_period", Integer.parseInt(cookie.getValue()));
                        break;
                    case "op":
                        cookies.put("optional_products", Arrays.stream(cookie.getValue().replaceAll("\\[", "").replaceAll("]", "")
                                .split(", ")).filter(x -> !x.equals("")).map(Integer::parseInt).collect(Collectors.toList()));
                        break;
                    case "sd":
                        DateFormat sourceFormat = new SimpleDateFormat("yyyy-MM-dd");
                        cookies.put("start_date_subscription", sourceFormat.parse(StringEscapeUtils.escapeJava(cookie.getValue())));
                        break;
                }
            } catch (NumberFormatException | ParseException e) {
                e.printStackTrace();
            }
        });
        return cookies;
    }

    public void destroy() {
    }

}