package it.polimi.telcoserviceweb.controllers.employee;

import it.polimi.telcoserviceejb.entities.OptionalProduct;
import it.polimi.telcoserviceejb.services.OptionalProductService;
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

@WebServlet("/GoToHomeEmp")

public class GoToHomeEmp extends HttpServlet{

    private static final long serialVersionUID = 2440005123337534003L;
    private TemplateEngine templateEngine;

    @EJB(name = "it.polimi.telcoserviceejb.entities.OptionalProductService")
    private OptionalProductService opService;

    public GoToHomeEmp() {
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

        List<OptionalProduct> ops = null;
        try{
            ops = opService.getAllOptionalProduct();
        }catch(Exception e){
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Not possible to get data");
            return;
        }

        String path = "/WEB-INF/HomeEmp.html";
        ServletContext servletContext = getServletContext();
        final WebContext ctx = new WebContext(request, response, servletContext, request.getLocale());
        ctx.setVariable("ops", ops);
        templateEngine.process(path, ctx, response.getWriter());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    public void destroy() {
    }





}