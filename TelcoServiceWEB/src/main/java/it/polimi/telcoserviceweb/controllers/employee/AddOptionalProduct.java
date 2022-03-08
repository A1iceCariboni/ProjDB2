package it.polimi.telcoserviceweb.controllers.employee;

import it.polimi.telcoserviceejb.entities.Employee;
import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.exceptions.CredentialsException;
import it.polimi.telcoserviceejb.services.EmployeeService;
import it.polimi.telcoserviceejb.services.OptionalProductService;
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

@WebServlet("/AddOptionalProduct")
public class AddOptionalProduct extends HttpServlet {
    private static final long serialVersionUID = 2581016315576984824L;
    private TemplateEngine templateEngine;
    @EJB(name = "it.polimi.expensemanagmentejb.services/OptionalProductService")
    private OptionalProductService opService;

    public AddOptionalProduct() {
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
        String name = null;
        String strFee = null;
        try {
            name = StringEscapeUtils.escapeJava(request.getParameter("name"));
            strFee = StringEscapeUtils.escapeJava(request.getParameter("fee"));
            if (name == null || strFee == null || name.isEmpty() || strFee.isEmpty()) {
                throw new Exception("Missing or empty fields");
            }
            float fee = Float.parseFloat(strFee);
            if (fee >= 0) {
                opService.createOptionalProduct(name, fee);
            } else {
                throw new Exception("Can't insert a negative fee");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
            return;
        }

        String path;
        path = getServletContext().getContextPath() + "/GoToHomeEmp";
        response.sendRedirect(path);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = "/WEB-INF/HomeEmp.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());

        templateEngine.process(path, ctx, response.getWriter());
    }

    public void destroy() {
    }

}



