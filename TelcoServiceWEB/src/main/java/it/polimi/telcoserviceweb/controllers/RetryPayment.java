package it.polimi.telcoserviceweb.controllers;


import org.thymeleaf.TemplateEngine;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RetryPayment")
public class RetryPayment extends HttpServlet {
    private static final long serialVersionUID = 3959138934394928201L;
    private TemplateEngine templateEngine;

    private CookieManager cookieManager = new CookieManager();
    public RetryPayment(){super();}


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
        Integer id = Integer.parseInt(request.getParameter("idorder"));

        cookieManager.makeOrderCookieExpire(request, response);
        response.addCookie(new Cookie("order_to_see", id.toString()));

        String path;
        path = getServletContext().getContextPath() + "/Confirmation";
        response.sendRedirect(path);
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public void destroy() {
    }
}
