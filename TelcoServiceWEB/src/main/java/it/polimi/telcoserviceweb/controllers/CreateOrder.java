package it.polimi.telcoserviceweb.controllers;

import it.polimi.telcoserviceejb.entities.User;
import it.polimi.telcoserviceejb.exceptions.ServiceException;
import it.polimi.telcoserviceejb.services.*;
import org.apache.commons.lang.NullArgumentException;
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
import java.text.DateFormat;
import java.text.ParseException;
import java.util.*;
import java.util.stream.Collectors;
import java.text.SimpleDateFormat;

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
        User user = (User) request.getSession().getAttribute("user");
        boolean submitted_form = request.getParameter("submittedForm") != null && request.getParameter("submittedForm").equals("true");
        String id_service_package = StringEscapeUtils.escapeJava(request.getParameter("sp"));
        String id_validity_period = StringEscapeUtils.escapeJava(request.getParameter("vp"));
        String ids_optional_product = Arrays.toString(request.getParameterValues("ops")).replaceAll(",", "-").replaceAll(" ", "").replaceAll("\\[", "").replaceAll("]", "");
        String start_date_subscription = StringEscapeUtils.escapeJava(request.getParameter("start_date_subscription"));


        if (user != null) {
            // logged: create order!
            Map<String, Object> cookies;

            // retrieve info
            try {
                if (submitted_form) {
                    // logged and submitted form: retrieve info from form
                    cookies = generateCookieMap(id_service_package, id_validity_period, ids_optional_product, start_date_subscription);
                } else {
                    // logged and no submission: retrieve info from cookies
                    cookies = getOrderInfoCookie(request);
                }

                System.out.println(cookies);
            } catch (ParseException | NumberFormatException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Not able to retrieve order infos");
                return;
            }

            // create order and create view order cookie
            try {
                Integer id_order = orderService.createOrder(
                        "waiting",
                        user.getId(),
                        (Integer) cookies.get("service_package"),
                        (Integer) cookies.get("validity_period"),
                        (List<Integer>) cookies.get("optional_products"),
                        (Date) cookies.get("start_date_subscription")
                );

                makeOrderCookieExpire(request, response);
                response.addCookie(new Cookie("order_to_see", id_order.toString()));
            } catch (ServiceException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Can't create order");
                return;
            }
        } else {
            // not logged: generate cookie if necessary
            if (submitted_form) {
                // not logged and submitted form: create cookies
                System.out.println(id_service_package);
                System.out.println(id_validity_period);
                System.out.println(ids_optional_product);
                System.out.println(start_date_subscription);

                // doesn't verify data because it could be easily manipulated (will be stored in cookies) and
                // because it's checked before issuing the order
                Cookie c_sp = new Cookie("sp", id_service_package);
                Cookie c_vp = new Cookie("vp", id_validity_period);
                Cookie c_op = new Cookie("op", ids_optional_product);
                Cookie c_sd = new Cookie("sd", start_date_subscription);
                Cookie c_id_to_see = new Cookie("order_to_see", "");
                c_id_to_see.setMaxAge(0);

                response.addCookie(c_sp);
                response.addCookie(c_vp);
                response.addCookie(c_op);
                response.addCookie(c_sd);
                response.addCookie(c_id_to_see);
            } else {
                // not logged and no submission: error
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Creating order with no cookies and no submission");
                return;
            }
        }

        String path;
        path = getServletContext().getContextPath() + "/Confirmation";
        response.sendRedirect(path);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    /**
     * makes the sp, vp, op, sd cookies expire (used after the creation of the order)
     */
    public void makeOrderCookieExpire(HttpServletRequest request, HttpServletResponse response) {
        Arrays.stream(request.getCookies()).forEach(cookie -> {
            switch (cookie.getName()) {
                case "sp":
                case "vp":
                case "op":
                case "sd":
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
            }
        });
    }

    /**
     * returns the map of the order info from the cookies
     */
    public Map<String, Object> getOrderInfoCookie(HttpServletRequest request) throws ParseException {
        String[] ids = new String[4];

        // getting the order infos
        Arrays.stream(request.getCookies()).forEach(cookie -> {
            switch (cookie.getName()) {
                case "sp":
                    ids[0] = cookie.getValue();
                    break;
                case "vp":
                    ids[1] = cookie.getValue();
                    break;
                case "op":
                    ids[2] = cookie.getValue();
                    break;
                case "sd":
                    ids[3] = cookie.getValue();
                    break;
            }
        });
        return generateCookieMap(ids[0], ids[1], ids[2], ids[3]);
    }

    /**
     * generates the map of the order info from
     */
    public Map<String, Object> generateCookieMap(String sp, String vp, String op, String sd) throws ParseException, NumberFormatException {
        final Map<String, Object> cookies = new HashMap<>();

        cookies.put("service_package", Integer.parseInt(sp));
        cookies.put("validity_period", Integer.parseInt(vp));
        if (op != null && !op.isEmpty()) {
            cookies.put("optional_products", Arrays.stream(op.replaceAll("\\[", "").replaceAll("]", "")
                    .split("-")).filter(x -> !x.equals("")).map(Integer::parseInt).collect(Collectors.toList()));
        }
        cookies.put("start_date_subscription", (new SimpleDateFormat("yyyy-MM-dd")).parse(StringEscapeUtils.escapeJava(sd)));

        return cookies;
    }

    public void destroy() {
    }

}