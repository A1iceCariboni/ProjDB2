package it.polimi.telcoserviceweb.controllers.employee;

import it.polimi.telcoserviceejb.entities.Employee;
import it.polimi.telcoserviceejb.entities.User;
import it.polimi.telcoserviceejb.exceptions.CredentialsException;
import it.polimi.telcoserviceejb.services.EmployeeService;
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


@WebServlet("/CheckLoginEmployee")
public class CheckLoginEmployee extends HttpServlet {
    private static final long serialVersionUID = -5933785467919537880L;
    private TemplateEngine templateEngine;
    @EJB(name = "it.polimi.expensemanagmentejb.services/EmployeeService")
    private EmployeeService empService;

    public CheckLoginEmployee() {
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
        // obtain and escape params
        String usrn = null;
        String pwd = null;
        try {
            usrn = StringEscapeUtils.escapeJava(request.getParameter("username"));
            pwd = StringEscapeUtils.escapeJava(request.getParameter("pwd"));
            if (usrn == null || pwd == null || usrn.isEmpty() || pwd.isEmpty()) {
                throw new Exception("Missing or empty credential value");
            }

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing credential value");
            return;
        }
        Employee emp;
        try {
            emp = empService.checkCredentials(usrn, pwd);
        } catch (CredentialsException | NonUniqueResultException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Could not check credentials");
            return;
        }

        String path;
        if (emp == null) {
            ServletContext servletContext = getServletContext();
            final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
            ctx.setVariable("errorMsg", "Incorrect username or password");
            path = "/WEB-INF/LoginEmployee.html";
            templateEngine.process(path, ctx, response.getWriter());
        } else {
            request.getSession().setAttribute("user", emp);
            path = getServletContext().getContextPath() + "/GoToHomeEmp";
            response.sendRedirect(path);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = "/WEB-INF/LoginEmployee.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());

        templateEngine.process(path, ctx, response.getWriter());
    }

    public void destroy() {
    }

}

