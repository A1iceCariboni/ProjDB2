package it.polimi.telcoserviceweb.controllers;

import it.polimi.telcoserviceejb.entities.User;
import it.polimi.telcoserviceejb.exceptions.RegistrationException;
import it.polimi.telcoserviceejb.services.UserService;
import org.apache.commons.lang.StringEscapeUtils;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.WebContext;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ServletContextTemplateResolver;

import javax.ejb.EJB;
import javax.persistence.NonUniqueResultException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CheckRegistration")
public class CheckRegistration extends HttpServlet {
    private static final long serialVersionUID = 3962998716934933850L;
    private TemplateEngine templateEngine;

    @EJB(name = "it.polimi.telcoserviceejb.services/UserService")
    private UserService userService;

    public CheckRegistration(){ super(); }

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
        // obtain and escape params
        String usrn = null;
        String email = null;
        String pwd = null;
        try {
            usrn = StringEscapeUtils.escapeJava(request.getParameter("username"));
            email = StringEscapeUtils.escapeJava(request.getParameter("email"));
            pwd = StringEscapeUtils.escapeJava(request.getParameter("pwd"));
            if (usrn == null || pwd == null || email == null || email.isEmpty() || usrn.isEmpty() || pwd.isEmpty()) {
                throw new Exception("Missing or empty credential value");
            }

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing credential value");
            return;
        }
        try {
            userService.createUser(usrn, email, pwd);
        } catch (RegistrationException e) {
            e.printStackTrace();
            ServletContext servletContext = getServletContext();
            final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
            ctx.setVariable("errorMsg", "Username already taken");
            String path = "/index.html";
            templateEngine.process(path, ctx, response.getWriter());
            return;
        }

        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("msg", "Ok now you can login");
        String path = "/index.html";
        templateEngine.process(path, ctx, response.getWriter());


    }
    public void destroy() {
    }

}
